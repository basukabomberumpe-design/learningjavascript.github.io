#!/usr/bin/env bash
set -euo pipefail

# Navigate to the repo folder containing this script.
cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d .git ]; then
  echo "Error: this folder is not a git repository." >&2
  exit 1
fi

REMOTE="${2:-origin}"
BRANCH="${3:-$(git branch --show-current)}"
MESSAGE="${1:-Update from thing.sh}"

if [ -z "$BRANCH" ]; then
  BRANCH="main"
fi

# Stage all changes in the repo.
git add .

# Commit if there are changes.
if [ -n "$(git status --porcelain)" ]; then
  git commit -m "$MESSAGE"
else
  echo "No changes to commit."
fi

# Push to the selected remote and branch.
git push "$REMOTE" "$BRANCH"
