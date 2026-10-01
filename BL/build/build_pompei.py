#!/usr/bin/env python3
"""
build_pompei.py
Typesets 'History of the Sanctuary of Pompei' into an elegant A5 Catholic devotional volume using Typst.
"""

import os
import re
import subprocess
import sys
from pathlib import Path

BUILD_DIR = Path(__file__).parent.resolve()
ROOT_DIR = BUILD_DIR.parent
MD_FILE = ROOT_DIR / "History Of The Sanctuary Of Pompei: Dedicated To The Most Blessed Virgin Of The Rosary.md"
LAYOUT_FILE = BUILD_DIR / "layout.typ"
OUTPUT_TYP = BUILD_DIR / "book.typ"
OUTPUT_PDF = ROOT_DIR / "History Of The Sanctuary Of Pompei - Dedicated To The Most Blessed Virgin Of The Rosary.pdf"

def run_pandoc(text: str) -> str:
    res = subprocess.run(
        ["pandoc", "-f", "gfm", "-t", "typst"],
        input=text,
        text=True,
        capture_output=True,
        check=True,
    )
    return res.stdout

def make_short_title(c_num: str, title: str) -> str:
    if "A Fifth Sign" in title:
        return f"{c_num} · A Fifth Sign from Heaven"
    if "Giovannina Muti" in title:
        return f"{c_num} · The First Apparition"
    if "First Feast" in title:
        return f"{c_num} · The First Feast"
    if "Second Renovation" in title:
        return f"{c_num} · Second Renovation of the Picture"
    # Split by em-dash or colon
    parts = re.split(r"\s*[—–-]{1,3}\s*|:\s*", title)
    t = parts[0].strip()
    return f"{c_num} · {t}"

def format_preliminary(t: str) -> str:
    # Format Preceding Editions
    t = re.sub(
        r"== The Preceding Editions of the History of the Sanctuary of Pompei\s*\n<([^>]+)>",
        r"""#pagebreak(weak: true)
#heading(level: 2, outlined: true)[The Preceding Editions]
<\1>
#set page(header: running-head([The Preceding Editions]))
#align(center)[
  #v(8mm)
  #text(size: 15pt, weight: 600, fill: ink)[The Preceding Editions\\ of the History of the Sanctuary of Pompei]
  #v(4mm)
  #box(width: 28mm, height: 0.5pt, fill: hair)
  #v(6mm)
]""",
        t,
    )

    # Format Introduction
    t = re.sub(
        r"== Introduction\s*\n<([^>]+)>",
        r"""#pagebreak(weak: true)
#heading(level: 2, outlined: true)[Introduction]
<\1>
#set page(header: running-head([Introduction]))
#align(center)[
  #v(8mm)
  #text(size: 15pt, weight: 600, fill: ink)[Introduction]
  #v(4mm)
  #box(width: 28mm, height: 0.5pt, fill: hair)
  #v(6mm)
]""",
        t,
    )
    return t

def format_main(t: str) -> str:
    # 1. Book Part titles
    def replace_book(match):
        book_num = match.group(1).strip()
        book_title = match.group(2).strip()
        label = match.group(3).strip()
        return f"""#pagebreak(to: "odd")
#heading(level: 1, outlined: true)[Book {book_num}: {book_title}]
<{label}>
#align(center)[
  #v(22%)
  #text(size: 16pt, fill: gold)[†]
  #v(8mm)
  #text(size: 11pt, fill: accent, tracking: 0.26em, weight: 600)[#smallcaps[Book {book_num}]]
  #v(4mm)
  #text(size: 21pt, weight: 600, fill: ink)[{book_title}]
  #v(8mm)
  #box(width: 36mm, height: 0.7pt, fill: gold)
]
#pagebreak()
"""

    t = re.sub(
        r"= Book ([^:]+):\s*(.*?)\s*\n<([^>]+)>",
        replace_book,
        t,
    )

    # 2. Chapter titles
    def replace_chapter(match):
        chap_num = match.group(1).strip()
        chap_title = match.group(2).strip()
        label = match.group(3).strip()
        short_title = make_short_title(chap_num, chap_title)
        return f"""#pagebreak(weak: true)
#heading(level: 2, outlined: true)[{chap_num}: {chap_title}]
<{label}>
#set page(header: running-head([{short_title}]))
#align(center)[
  #v(8mm)
  #text(size: 9.5pt, fill: accent, tracking: 0.24em, weight: 600)[#smallcaps[{chap_num}]]
  #v(2.5mm)
  #text(size: 15pt, weight: 600, fill: ink)[{chap_title}]
  #v(4mm)
  #box(width: 28mm, height: 0.5pt, fill: hair)
  #v(6mm)
]"""

    t = re.sub(
        r"== (Chapter [IVXLCDM]+):\s*(.*?)\s*\n<([^>]+)>",
        replace_chapter,
        t,
    )

    # 3. Section titles
    def replace_section(match):
        sec_title = match.group(1).strip()
        label = match.group(2).strip()
        return f"""#v(14pt, weak: true)
#heading(level: 3, outlined: false)[{sec_title}]
<{label}>
#block(width: 100%, above: 12pt, below: 10pt)[
  #text(size: 10.5pt, weight: 600, fill: accent)[#smallcaps[{sec_title}]]
  #v(2pt)
  #line(length: 22mm, stroke: 0.5pt + hair)
]"""

    t = re.sub(
        r"=== (§ \d+\.\s*.*?)\s*\n<([^>]+)>",
        replace_section,
        t,
    )

    return t

def main():
    if not MD_FILE.exists():
        print(f"Error: Markdown file not found at {MD_FILE}", file=sys.stderr)
        sys.exit(1)

    print(f"Reading {MD_FILE.name}...")
    with open(MD_FILE, "r", encoding="utf-8") as f:
        md_text = f.read()

    # Split into preliminary and main
    preceding_pos = md_text.find("## The Preceding Editions")
    book_first_pos = md_text.find("# Book First")

    if preceding_pos == -1 or book_first_pos == -1:
        print("Error: Could not find structural markers in markdown", file=sys.stderr)
        sys.exit(1)

    prelim_md = md_text[preceding_pos:book_first_pos].strip()
    main_md = md_text[book_first_pos:].strip()

    print("Converting preliminary matter via pandoc...")
    prelim_typ = run_pandoc(prelim_md)
    prelim_typ = format_preliminary(prelim_typ)

    print("Converting main content via pandoc...")
    main_typ = run_pandoc(main_md)
    main_typ = format_main(main_typ)

    print(f"Reading template {LAYOUT_FILE.name}...")
    with open(LAYOUT_FILE, "r", encoding="utf-8") as f:
        layout = f.read()

    full_typ = layout.replace("$PRELIMINARY$", prelim_typ).replace("$CONTENT$", main_typ)

    print(f"Writing {OUTPUT_TYP.name}...")
    with open(OUTPUT_TYP, "w", encoding="utf-8") as f:
        f.write(full_typ)

    print(f"Compiling with Typst to {OUTPUT_PDF.name}...")
    subprocess.run(
        ["typst", "compile", str(OUTPUT_TYP), str(OUTPUT_PDF)],
        check=True,
    )

    print("Done! PDF generated successfully.")
    print(f"File: {OUTPUT_PDF}")

if __name__ == "__main__":
    main()
