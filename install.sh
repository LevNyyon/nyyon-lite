#!/usr/bin/env bash
# Nyyon Lite installer. Installs the skill and links the /nyyon-* commands.
# Idempotent: run again any time to update. Override the skill location with
# NYYON_LITE_DIR, or the commands location with NYYON_LITE_CMDDIR.
set -euo pipefail

REPO="https://github.com/LevNyyon/nyyon-lite.git"
DEST="${NYYON_LITE_DIR:-$HOME/.claude/skills/nyyon-lite}"
CMDDIR="${NYYON_LITE_CMDDIR:-$HOME/.claude/commands}"

if [ -d "$DEST/.git" ]; then
  echo "Updating $DEST"
  git -C "$DEST" pull --ff-only
else
  echo "Cloning into $DEST"
  git clone --depth 1 "$REPO" "$DEST"
fi

mkdir -p "$CMDDIR"
ln -sf "$DEST"/commands/*.md "$CMDDIR"/

echo "Nyyon Lite installed."
echo "  skill:    $DEST"
echo "  commands: linked into $CMDDIR (/nyyon-gateways, /nyyon-tools, ...)"
