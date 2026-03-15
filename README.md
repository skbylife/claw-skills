# Claw Academy — Essential Skills Bundle

Official skill repository for [Claw Academy](https://claw-academy.ai). No rate limits. Always available.

## Install All Essential Skills (One Command)

```bash
curl -fsSL https://claw-academy.ai/install-skills.sh | bash
```

Or clone and run locally:
```bash
git clone https://github.com/skbylife/claw-skills.git
bash claw-skills/install.sh
```

## Essential Skills Bundle (17 skills)

| Category | Skills |
|----------|--------|
| Browser/Automation | agent-browser |
| Content/Research | summarize, xurl, weather |
| AI/System | self-improving, self-evolving-skill, skill-creator, skill-scanner, skill-guard |
| OpenClaw Ecosystem | openclaw-backup, openclaw-shield, openclaw-ops-guardrails |
| Tools | notion, himalaya, local-whisper |
| File Management | file-organizer-zh |
| Other | healthcheck |

## Why This Repo?

- ✅ No rate limits (unlike direct clawhub installs)
- ✅ Curated and tested by Claw Academy
- ✅ Always in sync with latest stable versions
- ✅ MIT licensed — free to use and modify

## Add Individual Skill

```bash
# Copy skill folder directly
cp -r claw-skills/skills/self-improving ~/.openclaw/workspace/skills/
```

## Update Skills

```bash
git pull  # get latest versions
bash install.sh  # reinstall updated skills
```

---

Made with 🦞 by [Claw Academy](https://claw-academy.ai)
