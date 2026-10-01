#set document(
  title: "History of the Sanctuary of Pompei",
  author: "Blessed Bartolo Longo",
  keywords: ("Pompei", "Virgin of the Rosary", "Bartolo Longo", "Catholic", "Sanctuary", "Our Lady of the Rosary"),
)

// ── Palette ───────────────────────────────────────────────────────────────
#let ink      = rgb("#221d18")   // Warm charcoal
#let ink-soft = rgb("#5e564c")   // Subdued secondary ink
#let accent   = rgb("#801d1d")   // Pompeian crimson
#let gold     = rgb("#9a783e")   // Antique gold
#let hair     = rgb("#ded6c8")   // Hairline rule
#let paper    = rgb("#fdfcf7")   // Warm cream paper

#let serif = ("Libertinus Serif", "Source Serif 4", "Liberation Serif")
#let mono  = ("IBM Plex Mono", "DejaVu Sans Mono")

#let body-size = 10.5pt
#let body-leading = 0.74em

// ── Helpers ───────────────────────────────────────────────────────────────
#let cross(size: 14pt, fill: gold) = text(size: size, fill: fill)[†]

#let divider() = block(width: 100%, above: 14pt, below: 14pt)[
  #grid(
    columns: (1fr, auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    line(length: 100%, stroke: 0.5pt + hair),
    circle(radius: 1.5pt, fill: gold),
    line(length: 100%, stroke: 0.5pt + hair),
  )
]

#let horizontalrule = divider

#let running-head(odd-text) = context {
  let p = here().page()
  let opening = query(heading).any(h => h.location().page() == p and h.level <= 2)
  if not opening {
    if calc.even(p) {
      align(center)[
        #text(size: 8pt, fill: ink-soft, tracking: 0.14em)[
          #smallcaps[History of the Sanctuary of Pompei]
        ]
      ]
    } else {
      align(center)[
        #text(size: 8pt, fill: ink-soft, tracking: 0.14em)[
          #smallcaps[#odd-text]
        ]
      ]
    }
  }
}

// ── Page Geometry ─────────────────────────────────────────────────────────
#set page(
  paper: "a5",
  margin: (top: 18mm, bottom: 18mm, inside: 16mm, outside: 13mm),
  fill: paper,
)

#set text(
  font: serif,
  size: body-size,
  fill: ink,
  lang: "en",
  hyphenate: true,
  number-type: "old-style",
)

#set par(
  justify: true,
  leading: body-leading,
  spacing: 1.05em,
  first-line-indent: 0em,
)

// ── Headings ──────────────────────────────────────────────────────────────
#show heading.where(level: 1): it => none
#show heading.where(level: 2): it => none
#show heading.where(level: 3): it => none

// ── Footnotes ─────────────────────────────────────────────────────────────
#set footnote.entry(
  separator: line(length: 30%, stroke: 0.5pt + hair),
  clearance: 8pt,
  gap: 0.6em,
  indent: 0em,
)
#show footnote.entry: set text(size: 8pt, fill: ink-soft)
#show footnote.entry: set par(leading: 0.62em, justify: true)

// ── Block quotes ──────────────────────────────────────────────────────────
#show quote.where(block: true): it => block(
  width: 100%,
  above: 12pt,
  below: 12pt,
  inset: (left: 12pt, right: 6pt),
  stroke: (left: 1.2pt + gold),
)[
  #set text(size: 0.94em, style: "italic", fill: ink-soft)
  #set par(justify: true, first-line-indent: 0em, leading: 0.70em, spacing: 0.8em)
  #it.body
]

// ── Inline styling ────────────────────────────────────────────────────────
#show strong: it => text(weight: 600, fill: ink, it.body)
#show emph: it => text(style: "italic", it.body)
#show link: it => text(fill: accent, it)

// ── Table of Contents ─────────────────────────────────────────────────────
#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(text(fill: accent, size: 10.5pt, it))
}
#show outline.entry.where(level: 2): it => {
  v(3pt, weak: true)
  text(fill: ink, size: 9.5pt, it)
}

// ── Cover Page (Page 1) ───────────────────────────────────────────────────
#place(center + horizon,
  rect(width: 100% + 16mm, height: 100% + 20mm, stroke: 0.8pt + gold, fill: none),
)
#place(center + horizon,
  rect(width: 100% + 12mm, height: 100% + 16mm, stroke: 0.4pt + hair, fill: none),
)

#align(center)[
  #v(20mm)
  #text(size: 26pt, fill: gold)[†]
  #v(8mm)
  #box(width: 35mm, height: 0.6pt, fill: gold)
  #v(10mm)
  #text(size: 21pt, weight: 700, tracking: 0.08em, hyphenate: false)[#smallcaps[History of the\ Sanctuary of Pompei]]
  #v(4.5mm)
  #text(size: 11pt, style: "italic", fill: accent)[Dedicated to the Most Blessed Virgin of the Rosary]
  #v(10mm)
  #box(width: 35mm, height: 0.6pt, fill: gold)
  #v(14mm)
  #text(size: 11pt, tracking: 0.22em, weight: 600)[#smallcaps[Blessed Bartolo Longo]]
  #v(24mm)
  #text(size: 8.5pt, fill: gold, tracking: 0.26em)[#smallcaps[Valle di Pompei · 1895]]
]

// ── Front Matter ──────────────────────────────────────────────────────────
#pagebreak(to: "odd")
#set page(
  numbering: none,
  header: none,
  footer: none,
)

// Half-Title (Page 3)
#align(center + horizon)[
  #text(size: 16pt, weight: 600, fill: ink, tracking: 0.12em, hyphenate: false)[#smallcaps[History of the Sanctuary\ of Pompei]]
]

#pagebreak(to: "odd")

// Title Page (Page 5)
#align(center + horizon)[
  #cross(size: 20pt)
  #v(6mm)
  #text(size: 22pt, weight: 700, fill: ink, tracking: 0.08em, hyphenate: false)[#smallcaps[History of the Sanctuary\ of Pompei]]
  #v(3.5mm)
  #text(size: 11pt, style: "italic", fill: accent)[Dedicated to the Most Blessed Virgin of the Rosary]
  #v(8mm)
  #box(width: 32mm, height: 0.6pt, fill: gold)
  #v(8mm)
  #text(size: 12pt, weight: 600, fill: ink)[By Blessed Bartolo Longo]
  #v(1.5mm)
  #text(size: 8.5pt, fill: ink-soft, style: "italic")[Founder of the Sanctuary of Pompei and of the Charitable Works]
  #v(18mm)
  #text(size: 8.5pt, fill: ink-soft)[
    Valle di Pompei\
    Editing School of Typography of Bartolo Longo\
    1895
  ]
]

#pagebreak()

// Imprimatur / Notice (Page 6)
#align(center + horizon)[
  #text(size: 9pt, style: "italic", fill: ink-soft)[
    With Ecclesiastical Approval\
    All Rights Reserved\
    #v(6mm)
    #cross(size: 12pt, fill: hair)\
    #v(6mm)
    English translation originally published at Valle di Pompei, 1895.\
    Typeset in Typst with Libertinus Serif, liturgical crimson, and antique gold.
  ]
]

// ── Table of Contents (Page 7) ────────────────────────────────────────────
#pagebreak(to: "odd")
#set page(
  numbering: "i",
  header: none,
  footer: context [
    #align(center)[#text(size: 9pt, fill: ink-soft, number-type: "old-style")[#counter(page).display("i")]]
  ],
)
#counter(page).update(7)

#align(center)[
  #v(8mm)
  #text(size: 11pt, fill: accent, tracking: 0.24em, weight: 600)[#smallcaps[Table of Contents]]
  #v(4mm)
  #box(width: 28mm, height: 0.5pt, fill: hair)
  #v(8mm)
]

#outline(title: none, depth: 2, indent: 1.5em)

// ── Preliminary Matter ────────────────────────────────────────────────────
$PRELIMINARY$

// ── Main Matter ───────────────────────────────────────────────────────────
#pagebreak(to: "odd")
#set page(
  numbering: "1",
  footer: context [
    #align(center)[
      #text(size: 9pt, fill: ink-soft, number-type: "old-style")[
        #counter(page).display("1")
      ]
    ]
  ],
)
#counter(page).update(1)

$CONTENT$

// ── Colophon / Finis ───────────────────────────────────────────────────────
#pagebreak(to: "odd")
#set page(header: none, footer: none, numbering: none)
#align(center + horizon)[
  #cross(size: 20pt)
  #v(8mm)
  #text(size: 15pt, fill: ink, tracking: 0.3em)[#smallcaps[Finis]]
  #v(6mm)
  #box(width: 32mm, height: 0.6pt, fill: gold)
  #v(6mm)
  #text(size: 9pt, style: "italic", fill: ink-soft)[
    Laus Deo Virgini-que Pompeiæ\
    #v(4mm)
    History of the Sanctuary of Pompei\
    Dedicated to the Most Blessed Virgin of the Rosary\
    By Blessed Bartolo Longo (1841–1926)
  ]
  #v(8mm)
  #text(size: 8pt, fill: ink-soft)[
    Typeset in Typst with Libertinus Serif\
    Format: A5 (148 × 210 mm)
  ]
]
