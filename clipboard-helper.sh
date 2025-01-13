#!/usr/bin/env bash

# Check if the path to the Git repository is provided
if [ -z "$1" ]; then
  echo "Error: Path to the Git repository is required."
  echo "Usage: $0 <path-to-git-repo>"
  exit 1
fi

# Navigate to the specified Git repository path
repo_path="$1"
if [ ! -d "$repo_path/.git" ]; then
  echo "Error: The specified path is not a valid Git repository."
  exit 1
fi

cd "$repo_path" || {
  echo "Error: Failed to navigate to the Git repository."
  exit 1
}

# List and process Python files in the repository
py_files=$(git ls-files '*.py') # include Git-indexed files

if [ -z "$py_files" ]; then
  echo "No Python files found in the repository."
  exit 0
fi

output=""
for f in $py_files; do
  content=$(cat "$f")
  output+="\n[$f]\n$content\n"
done

printf "%b" "$output" | pbcopy

echo "Copied to clipboard."
