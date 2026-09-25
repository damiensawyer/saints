# Licensing: St. Josemaría Escrivá writings

Research notes (2026-09-26) on whether Escrivá's writings (as published on
[escriva.org](https://escriva.org)) can be bundled in an MIT / permissively
licensed TUI app on GitHub.

## Short answer

**No — not without permission.** The app *code* can be MIT, but the *content*
cannot be redistributed under MIT (or any license) without the copyright
holder's authorisation.

## Why

- **Still in copyright.** Escrivá died 1975. Spain applies life + 80 for authors
  who died before 1987, so protection runs to ~2055 (~2045 in life + 70
  countries).
- **escriva.org legal notice:** texts and images "cannot be reproduced by any
  means or process whatsoever without the authorization of copyright holders."
- **Rights holder:** Fundación Studium has administered the copyright to his
  works outside Spain, in all languages, since 2001.
- **Translations** (e.g. English editions from Scepter etc.) carry their own
  separate translation copyright.
- Unlike Bible TUI apps, which typically ship public-domain texts (KJV, WEB),
  there is no public-domain equivalent here.

## Options

1. **Ask permission (recommended).** Contact Fundación Studium. They actively
   promote wide distribution (escriva.org is free to read), so a free,
   non-commercial, attributed app has a reasonable chance. Get it in writing and
   include the grant in the repo.
2. **Ship code only.** MIT app with no bundled content; fetches from escriva.org
   at runtime (or imports user-supplied files) and caches locally. Grey area:
   scraping may conflict with site terms, and redistributing the cache would be
   infringement. Fine for personal use; ask before publishing.
3. **Personal use only.** Scrape into a private, gitignored data directory and
   never publish it.

Plan: pursue 1, build 2 in the meantime so the app works either way.

## Contacts

- **Fundación Studium** — C/ Castelló, 115, 2º, 28006 Madrid, Spain —
  info@studium-foundation.org
- **St. Josemaria Institute (US)** — 4340 Cross Street, Suite 1, Downers Grove,
  IL 60515, USA — info@stjosemaria.org — 630-541-9742

## Sources

- [escriva.org legal notice](https://escriva.org/fr/page/legal/)
- [St. Josemaria Institute — Copyrights & Permissions](https://stjosemaria.org/copyrights-and-permissions/)
- [escriva.org contact](https://escriva.org/en/page/contact/)
