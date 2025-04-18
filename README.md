# Cursor Settings

This repository contains my Cursor editor settings, keybindings, and snippets.

## Directory Structure

- `cursor/User/`: Contains the main configuration files
  - `settings.json`: User settings
  - `keybindings.json`: Keyboard shortcuts
  - `snippets/`: Custom code snippets
- `user_rules.txt`: Custom AI instructions/user rules
- `sync_user_rules.sh`: Script to export/import user rules

## Setup

The files are linked from their original locations:
- Original location: `~/Library/Application Support/Cursor/User/`
- Symlinked to this repository 

## Installation on a New Machine

To use these settings on another machine after cloning this repository:

1. Ensure Cursor is installed on the new machine
2. Backup your existing settings (if needed):
   ```bash
   cp ~/Library/Application\ Support/Cursor/User/settings.json ~/Library/Application\ Support/Cursor/User/settings.json.bak
   cp ~/Library/Application\ Support/Cursor/User/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json.bak
   cp -r ~/Library/Application\ Support/Cursor/User/snippets ~/Library/Application\ Support/Cursor/User/snippets.bak
   ```

3. Create symbolic links:
   ```bash
   ln -sf /path/to/cloned/repo/cursor_settings/cursor/User/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
   ln -sf /path/to/cloned/repo/cursor_settings/cursor/User/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
   ln -sf /path/to/cloned/repo/cursor_settings/cursor/User/snippets ~/Library/Application\ Support/Cursor/User/snippets
   ```
   (Replace `/path/to/cloned/repo/` with the actual path to where you cloned this repository)

4. Import user rules (AI instructions):
   ```bash
   ./sync_user_rules.sh import
   ```

5. Restart Cursor to apply the settings 

## Syncing User Rules

The `user_rules.txt` file contains your custom AI instructions that control how the Cursor AI responds to your queries. To sync these rules:

- Export rules from current machine: `./sync_user_rules.sh export`
- Import rules on another machine: `./sync_user_rules.sh import`

These rules are stored in the SQLite database at `~/Library/Application Support/Cursor/User/globalStorage/state.vscdb` under the key `aicontext.personalContext`. 