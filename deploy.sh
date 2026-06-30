#!/usr/bin/env bash
set -euo pipefail

OWNER="fe-fkugland"
REPO="fahrgemeinschaften-karte"

cd "$(dirname "$0")"

# git init (idempotent)
if [ ! -d .git ]; then
  git init -b main
fi

git add -A
git commit -m "Initial commit: Fahrgemeinschaften Karte" || echo "(nothing to commit)"

# Repo erstellen (falls noch nicht da) und pushen
if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  echo "Repo existiert schon — push..."
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO.git"
  git push -u origin main
else
  gh repo create "$OWNER/$REPO" --public --source=. --remote=origin --push
fi

# GitHub Pages aktivieren (main branch, root)
echo "Aktiviere GitHub Pages..."
gh api -X POST "repos/$OWNER/$REPO/pages" \
  -f "source[branch]=main" -f "source[path]=/" 2>/dev/null \
  || echo "(Pages evtl. schon aktiv)"

echo ""
echo "==> Fertig! URL: https://$OWNER.github.io/$REPO/"
echo "    (1-2 Min warten, bis Pages live ist)"
