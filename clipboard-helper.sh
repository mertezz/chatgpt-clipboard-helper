#!/usr/bin/env bash

py_files=$(git ls-files '*.py') # include Git-indexed files

output=""
for f in $py_files; do
  content=$(cat "$f")
  output+="\n[$f]\n$content\n"
done

printf "%b" "$output" | pbcopy

echo "Copied to clipboard."

