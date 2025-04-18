#!/bin/bash

# Define script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DB_PATH="$HOME/Library/Application Support/Cursor/User/globalStorage/state.vscdb"
RULES_FILE="$SCRIPT_DIR/user_rules.txt"

# Function to export user rules
export_rules() {
  echo "Exporting user rules from $DB_PATH"
  sqlite3 "$DB_PATH" "SELECT value FROM ItemTable WHERE key = 'aicontext.personalContext';" > "$RULES_FILE"
  echo "User rules exported to $RULES_FILE"
}

# Function to import user rules
import_rules() {
  if [ ! -f "$RULES_FILE" ]; then
    echo "Rules file not found: $RULES_FILE"
    exit 1
  fi
  
  echo "Importing user rules to $DB_PATH"
  
  # Read the rules file content
  RULES_CONTENT=$(cat "$RULES_FILE")
  
  # Escape single quotes in SQL
  RULES_CONTENT_ESCAPED=$(echo "$RULES_CONTENT" | sed "s/'/''/g")
  
  # Update or insert the rules
  sqlite3 "$DB_PATH" "INSERT OR REPLACE INTO ItemTable (key, value) VALUES ('aicontext.personalContext', '$RULES_CONTENT_ESCAPED');"
  
  echo "User rules imported successfully"
}

# Main execution
case "$1" in
  export)
    export_rules
    ;;
  import)
    import_rules
    ;;
  *)
    echo "Usage: $0 {export|import}"
    echo "  export: Export user rules from Cursor to $RULES_FILE"
    echo "  import: Import user rules from $RULES_FILE to Cursor"
    exit 1
    ;;
esac

exit 0 