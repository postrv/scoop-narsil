# Scoop Bucket for narsil-mcp

Official Scoop bucket for [narsil-mcp](https://github.com/postrv/narsil-mcp) - a blazingly fast MCP server for code intelligence.

## Installation

```powershell
scoop bucket add narsil https://github.com/postrv/scoop-narsil
scoop install narsil-mcp
```

## Usage

```powershell
narsil-mcp --repos C:\path\to\your\project
```

For full usage instructions:
```powershell
narsil-mcp --help
```

## Configuration with AI Assistants

### Claude Desktop

Add to `%APPDATA%\Claude\claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "narsil-mcp": {
      "command": "narsil-mcp",
      "args": ["--repos", "C:\\path\\to\\your\\projects"]
    }
  }
}
```

### VS Code with Copilot

Create `.vscode\mcp.json` in your workspace:

```json
{
  "servers": {
    "narsil-mcp": {
      "command": "narsil-mcp",
      "args": ["--repos", "${workspaceFolder}"]
    }
  }
}
```

### Cursor

Create `.cursor\mcp.json` in your project:

```json
{
  "mcpServers": {
    "narsil-mcp": {
      "command": "narsil-mcp",
      "args": ["--repos", "."]
    }
  }
}
```

## Updating

```powershell
scoop update
scoop update narsil-mcp
```

## Uninstalling

```powershell
scoop uninstall narsil-mcp
scoop bucket rm narsil
```

## Supported Platforms

- Windows 10 or later
- x86_64 (64-bit)

## Auto-Updates

This bucket includes an **autoupdate** configuration. Scoop's Excavator bot will automatically detect new releases from GitHub and update the manifest with new download URLs and SHA256 checksums.

## Documentation

See the [main repository](https://github.com/postrv/narsil-mcp) for full documentation, including:
- All 76 available MCP tools
- Advanced features (call graphs, security scanning, supply chain analysis)
- LSP integration
- Remote repository support

## Troubleshooting

If installation fails:

1. Update Scoop: `scoop update`
2. Check manifest: `scoop checkver narsil-mcp`
3. Report issues at https://github.com/postrv/scoop-narsil/issues

## License

This bucket is licensed under MIT OR Apache-2.0, same as narsil-mcp itself.
