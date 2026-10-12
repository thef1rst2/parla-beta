#!/bin/bash
# Installs (or updates) Parla on this Mac.
#
#   curl -fsSL https://raw.githubusercontent.com/thef1rst2/parla-beta/main/install.sh | bash
#
# Downloads the latest release, puts Parla in Applications and opens it. Files downloaded this
# way aren't flagged as "from the internet", so macOS opens Parla without the "unidentified
# developer" dance. Set PARLA_ZIP=/path/to/Parla.zip to install a local build instead.
set -euo pipefail

REPO="thef1rst2/parla-beta"
say() { printf '\033[1m%s\033[0m\n' "$*"; }
fail() { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || fail "Parla is a Mac app."
major="$(sw_vers -productVersion | cut -d. -f1)"
(( major >= 14 )) || fail "Parla needs macOS 14 (Sonoma) or newer. This Mac has $(sw_vers -productVersion)."

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

if [[ -n "${PARLA_ZIP:-}" ]]; then
  cp "$PARLA_ZIP" "$work/Parla.zip"
else
  say "Finding the latest Parla…"
  url="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
    | grep -o '"browser_download_url": *"[^"]*\.zip"' | head -1 | sed 's/.*"\(https[^"]*\)"/\1/')"
  [[ -n "$url" ]] || fail "Couldn't find a Parla release. Check your internet connection and try again."
  say "Downloading $(basename "$url")…"
  curl -fL --progress-bar "$url" -o "$work/Parla.zip"
fi

ditto -x -k "$work/Parla.zip" "$work/unzipped"
app="$(find "$work/unzipped" -maxdepth 2 -name 'Parla.app' -type d | head -1)"
[[ -n "$app" ]] || fail "The download didn't contain Parla.app."

# /Applications if we can write there, else the user's own Applications folder.
dest="${PARLA_DEST:-/Applications}"
if [[ ! -w "$dest" ]]; then dest="$HOME/Applications"; mkdir -p "$dest"; fi

if [[ -z "${PARLA_DEST:-}" ]] && pgrep -x Parla >/dev/null; then
  say "Closing the running Parla…"
  osascript -e 'quit app "Parla"' >/dev/null 2>&1 || true
  sleep 1
  pkill -x Parla 2>/dev/null || true
fi

rm -rf "$dest/Parla.app"
ditto "$app" "$dest/Parla.app"
xattr -dr com.apple.quarantine "$dest/Parla.app" 2>/dev/null || true

version="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$dest/Parla.app/Contents/Info.plist" 2>/dev/null || echo "")"
if [[ -n "${PARLA_NO_OPEN:-}" ]]; then say "Parla ${version} is in $dest."; exit 0; fi
say "Parla ${version} is in $dest. Opening it now. Have fun! 🇮🇹"
open "$dest/Parla.app"
