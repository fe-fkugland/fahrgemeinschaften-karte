#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
git add -A
git commit -m "Update Fahrgemeinschaften" || echo "(nothing to commit)"
git push origin main
echo ""
echo "==> Push fertig! https://fe-fkugland.github.io/fahrgemeinschaften-karte/"
