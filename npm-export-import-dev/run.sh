#!/usr/bin/env bash
set -euo pipefail

echo "[npm-export-import] Starting..."

# Read port from config.json
PORT=$(python3 -c "import json; print(json.load(open('/app/config.json')).get('ingress_port', 8099))")

exec gunicorn \
  --bind 0.0.0.0:${PORT} \
  --workers 2 \
  --threads 4 \
  --worker-class gthread \
  --timeout 300 \
  --access-logfile - \
  --error-logfile - \
  npm_export_import:app
