#!/usr/bin/env bash
set -euo pipefail

echo "[npm-export-import] Starting..."
exec gunicorn \
  --bind 0.0.0.0:8099 \
  --workers 2 \
  --threads 4 \
  --worker-class gthread \
  --timeout 300 \
  --access-logfile - \
  --error-logfile - \
  npm_export_import:app
