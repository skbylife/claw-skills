#!/usr/bin/env bash
# Claw Academy — Essential Skills Bundle Installer
# Installs the recommended skills for OpenClaw users
# Usage: curl -fsSL https://claw-academy.ai/install-skills.sh | bash

set -euo pipefail

REPO="https://raw.githubusercontent.com/skbylife/claw-skills/main"
SKILLS_DIR="${OPENCLAW_WORKSPACE:-$HOME/.openclaw/workspace}/skills"
BRANCH="main"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ESSENTIAL_SKILLS=(
  "agent-browser"
  "summarize"
  "xurl"
  "weather"
  "self-improving"
  "self-evolving-skill"
  "skill-creator"
  "skill-scanner"
  "skill-guard"
  "openclaw-backup"
  "openclaw-shield"
  "openclaw-ops-guardrails"
  "notion"
  "himalaya"
  "local-whisper"
  "file-organizer-zh"
  "healthcheck"
)

echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║   Claw Academy — Essential Skills    ║"
echo "  ║   🦞 Powered by claw-academy.ai      ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

mkdir -p "$SKILLS_DIR"

INSTALLED=0
SKIPPED=0
FAILED=0

for skill in "${ESSENTIAL_SKILLS[@]}"; do
  if [ -d "$SKILLS_DIR/$skill" ] && [ -f "$SKILLS_DIR/$skill/SKILL.md" ]; then
    echo -e "  ${YELLOW}⊙${NC} $skill — already installed, skipping"
    ((SKIPPED++)) || true
    continue
  fi

  # Fetch manifest to discover files
  MANIFEST_URL="$REPO/skills/$skill/_meta.json"
  META=$(curl -sf "$MANIFEST_URL" 2>/dev/null || echo "")

  if [ -z "$META" ]; then
    # Minimal install: just SKILL.md
    SKILL_URL="$REPO/skills/$skill/SKILL.md"
    if curl -sf "$SKILL_URL" -o /dev/null 2>/dev/null; then
      mkdir -p "$SKILLS_DIR/$skill"
      curl -sf "$SKILL_URL" -o "$SKILLS_DIR/$skill/SKILL.md"
      echo -e "  ${GREEN}✓${NC} $skill"
      ((INSTALLED++)) || true
    else
      echo -e "  ${RED}✗${NC} $skill — not available (try: clawhub install $skill)"
      ((FAILED++)) || true
    fi
    continue
  fi

  # Full install: download all files listed in _meta.json
  mkdir -p "$SKILLS_DIR/$skill"
  echo "$META" > "$SKILLS_DIR/$skill/_meta.json"

  # Extract files array from meta and download each
  FILES=$(echo "$META" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    files = d.get('files', ['SKILL.md'])
    print('\n'.join(files))
except:
    print('SKILL.md')
" 2>/dev/null || echo "SKILL.md")

  SUCCESS=true
  while IFS= read -r file; do
    [ -z "$file" ] && continue
    FILE_URL="$REPO/skills/$skill/$file"
    TARGET="$SKILLS_DIR/$skill/$file"
    mkdir -p "$(dirname "$TARGET")"
    if ! curl -sf "$FILE_URL" -o "$TARGET" 2>/dev/null; then
      SUCCESS=false
    fi
  done <<< "$FILES"

  if $SUCCESS; then
    echo -e "  ${GREEN}✓${NC} $skill"
    ((INSTALLED++)) || true
  else
    echo -e "  ${RED}✗${NC} $skill — partial install"
    ((FAILED++)) || true
  fi
done

echo ""
echo "  ─────────────────────────────────────"
echo -e "  ${GREEN}✓ Installed:${NC} $INSTALLED   ${YELLOW}⊙ Skipped:${NC} $SKIPPED   ${RED}✗ Failed:${NC} $FAILED"
echo ""

if [ "$FAILED" -gt 0 ]; then
  echo "  ⚠ Some skills couldn't be installed. Try running:"
  echo "    clawhub install <skill-name>"
fi

echo "  Skills installed to: $SKILLS_DIR"
echo ""
