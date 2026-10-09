# Windows Developer Readability Setup
# Run in PowerShell. Existing VS Code settings are backed up.

$ErrorActionPreference = "Stop"

$settingsDir = Join-Path $env:APPDATA "Code\User"
$settingsFile = Join-Path $settingsDir "settings.json"

New-Item -ItemType Directory -Force -Path $settingsDir | Out-Null

if (Test-Path $settingsFile) {
    $backupFile = "$settingsFile.bak.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Copy-Item $settingsFile $backupFile
    Write-Host "Backup created: $backupFile" -ForegroundColor Green
}

$settings = @'
{
  "window.zoomLevel": 1,
  "workbench.colorTheme": "Gruvbox Dark Hard",
  "workbench.iconTheme": "material-icon-theme",
  "editor.fontFamily": "'JetBrains Mono', Consolas, monospace",
  "editor.fontSize": 20,
  "editor.lineHeight": 32,
  "editor.fontWeight": "400",
  "editor.fontLigatures": true,
  "editor.minimap.enabled": false,
  "editor.lineNumbers": "relative",
  "editor.cursorWidth": 2,
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.smoothScrolling": true,
  "editor.padding.top": 16,
  "editor.padding.bottom": 16,
  "editor.guides.bracketPairs": "active",
  "editor.bracketPairColorization.enabled": true,
  "editor.stickyScroll.enabled": true,
  "editor.wordWrap": "off",
  "terminal.integrated.fontFamily": "'JetBrains Mono', Consolas, monospace",
  "terminal.integrated.fontSize": 18,
  "terminal.integrated.lineHeight": 1.3,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.cursorBlinking": false,
  "terminal.integrated.scrollback": 10000,
  "terminal.integrated.minimumContrastRatio": 4.5,
  "debug.console.fontSize": 16,
  "scm.inputFontSize": 16,
  "markdown.preview.fontSize": 18,
  "breadcrumbs.enabled": true,
  "workbench.tree.indent": 18,
  "explorer.compactFolders": false,
  "editor.minimap.autohide": "always",
  "files.autoSave": "onFocusChange",
  "editor.formatOnSave": true,
  "editor.renderWhitespace": "selection",
  "editor.detectIndentation": true,
  "editor.tabSize": 4,
  "workbench.startupEditor": "none"
}
'@

# Validate before writing
$settings | ConvertFrom-Json | Out-Null
Set-Content -Path $settingsFile -Value $settings -Encoding utf8

Write-Host "`nVS Code settings updated successfully." -ForegroundColor Green

# Open Windows display settings for system-wide scaling
Start-Process "ms-settings:display"

Write-Host @"

Recommended Windows display settings:
1. Open Scale and layout.
2. Set Scale to 125% (or 120% if available).
3. Keep your display resolution at Recommended.
4. Install JetBrains Mono and the Gruvbox Dark Hard /
   Material Icon Theme extensions in VS Code if needed.
5. Run Developer: Reload Window in VS Code.

"@ -ForegroundColor Cyan
