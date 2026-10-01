#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# build.sh
# Typesets 'History of the Sanctuary of Pompei' into an A5 Catholic book
# using Pandoc and Typst.
# ─────────────────────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
PDF_FILE="$ROOT_DIR/History Of The Sanctuary Of Pompei - Dedicated To The Most Blessed Virgin Of The Rosary.pdf"

echo "=== Building 'History of the Sanctuary of Pompei' ==="

# Check requirements
for cmd in pandoc typst python3; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command '$cmd' is not installed or not in PATH." >&2
    exit 1
  fi
done

# Run Python builder
python3 "$SCRIPT_DIR/build_pompei.py"

if [[ -f "$PDF_FILE" ]]; then
  SIZE=$(du -h "$PDF_FILE" | cut -f1)
  PAGES=$(pdfinfo "$PDF_FILE" 2>/dev/null | grep -i "Pages:" | awk '{print $2}' || echo "N/A")
  echo "=== Build Succeeded! ==="
  echo "Output: $PDF_FILE"
  echo "Pages:  $PAGES"
  echo "Size:   $SIZE"
else
  echo "Error: PDF output was not created." >&2
  exit 1
fi
