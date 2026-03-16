---
name: browser
description: Automate web browser interactions using natural language via CLI commands. Use when the user asks to browse websites, navigate web pages, extract data from websites, take screenshots, fill forms, click buttons, or interact with web applications.
allowed-tools: Bash
---

# Browser Automation

Automate browser interactions using Stagehand CLI with Claude.

## Commands

```bash
browser navigate <url>
browser act "<action>"
browser extract "<instruction>"
browser screenshot
browser close
```

## Quick Example

```bash
browser navigate https://example.com
browser act "click the Sign In button"
browser extract "get the page title"
browser close
```
