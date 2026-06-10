# CLAUDE.md — NPM Export Import App

This file gives Claude Code context for working in this repository.

## What This Repo Is

A Home Assistant app repository maintained by **SlopSync-Labs** containing a single app:
**NPM Export Import** — a tool for exporting and importing Nginx Proxy Manager configuration.

## Repository Layout

```text
/
├── repository.yaml          # HA repository manifest (name, url, maintainer)
├── LICENSE                  # MIT, copyright SlopSync-Labs
├── README.md
├── CLAUDE.md                # This file
├── .markdownlint.json       # Markdown linting config
├── assets/                  # Design files and screenshots
└── npm-export-import/       # Production app (three variants below)
  ├── npm-export-import/         # Stable release
  │ ├── config.json            # HA app manifest (required)
  │ ├── Dockerfile             # Container definition (required)
  │ ├── run.sh                 # Entrypoint script (required)
  │ ├── README.md              # App documentation
  │ └── npm_export_import.py   # Application code
  ├── npm-export-import-beta/    # Beta channel (independent source)
  │ └── (same structure as stable)
  └── npm-export-import-dev/     # Dev channel (independent source)
    └── (same structure as stable)
```

## Three Independent Variants

Each variant (stable, beta, dev) has its own complete copy of the source code.
They diverge intentionally as development progresses:

```
npm-export-import-dev/  →  npm-export-import-beta/  →  npm-export-import/
(active development)        (pre-release testing)         (stable)
```

All three are discoverable in the HA app store and installable side-by-side for
testing purposes.

## App Manifest (`config.json`) Key Fields

| Field | Notes |
| --- | --- |
| `name` | Human-readable display name |
| `slug` | Machine identifier — must match directory name |
| `version` | Semver string; all three variants share the same version |
| `arch` | Always include `["amd64", "aarch64", "armv7"]` |
| `startup` | `"services"` for long-running apps |
| `boot` | `"auto"` to start on HA boot |
| `stage` | `"experimental"` for beta/dev, omit for stable |

## Conventions

- **Slugs**: lowercase, alphanumeric, hyphens or underscores only
- **Base images**: `python:3.x-alpine` or `ghcr.io/home-assistant/<arch>-base`
- **Versioning**: semver — bump patch for fixes, minor for new features, major for
  breaking changes. All three variants keep the same version number
- **Multi-arch**: support amd64, aarch64, and armv7 as declared in config.json

## What NOT to Do

- Do not manually edit the config.json `version` field without updating all three
  variants (stable, beta, dev)
- Do not create separate workflows for each variant — HA builds all three locally
  from their Dockerfile
- Do not hardcode architecture-specific paths in `run.sh` — keep scripts portable

## Key External References

- [Home Assistant App Development Docs](https://developers.home-assistant.io/docs/add-ons)
- [HA App Config Reference](https://developers.home-assistant.io/docs/add-ons/configuration)
- [Base Images (ghcr.io/home-assistant)](https://github.com/home-assistant/docker-base)
