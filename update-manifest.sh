#!/bin/bash
#
# Helper script to update bucket/narsil-mcp.json with new version and SHA256 checksum
#
# Usage: ./update-manifest.sh v1.1.2
#

set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: ./update-manifest.sh v1.1.2"
  exit 1
fi

REPO="postrv/narsil-mcp"
MANIFEST="bucket/narsil-mcp.json"

echo "Updating manifest for $VERSION..."

# Fetch SHA256 from GitHub releases
echo ""
echo "Fetching SHA256 checksum from GitHub releases..."

echo -n "  Windows (x86_64)... "
WIN_SHA=$(curl -fsSL "https://github.com/$REPO/releases/download/$VERSION/narsil-mcp-$VERSION-x86_64-pc-windows-msvc.zip.sha256" | awk '{print $1}')
echo "$WIN_SHA"

echo ""
echo "Creating updated manifest..."

# Create backup
cp "$MANIFEST" "${MANIFEST}.bak"

# Update version (remove 'v' prefix)
VERSION_NUM="${VERSION#v}"

# Use jq if available, otherwise use sed
if command -v jq &> /dev/null; then
  echo "Using jq for JSON manipulation..."

  # Update with jq
  jq --arg version "$VERSION_NUM" \
     --arg url "https://github.com/$REPO/releases/download/$VERSION/narsil-mcp-$VERSION-x86_64-pc-windows-msvc.zip" \
     --arg hash "$WIN_SHA" \
     '.version = $version | .architecture."64bit".url = $url | .architecture."64bit".hash = $hash' \
     "$MANIFEST" > "${MANIFEST}.tmp"

  mv "${MANIFEST}.tmp" "$MANIFEST"
else
  echo "jq not found, using sed (may be less reliable)..."

  # Update version
  sed -i '' "s/\"version\": \".*\"/\"version\": \"$VERSION_NUM\"/" "$MANIFEST"

  # Update URL
  sed -i '' "s|/download/v[^/]*/|/download/$VERSION/|g" "$MANIFEST"

  # Update SHA256
  sed -i '' "s/\"hash\": \".*\"/\"hash\": \"$WIN_SHA\"/" "$MANIFEST"
fi

echo ""
echo "✅ Manifest updated successfully!"
echo ""
echo "Changes:"
git diff "$MANIFEST"

echo ""
echo "To publish:"
echo "  1. Review changes above"
echo "  2. git add bucket/narsil-mcp.json"
echo "  3. git commit -m \"chore: update to $VERSION\""
echo "  4. git push"
echo ""
echo "To restore backup if needed:"
echo "  mv ${MANIFEST}.bak $MANIFEST"
echo ""
echo "Note: Excavator workflow will auto-update this manifest every 6 hours."
