# kazaneko.dev

Source of [kazaneko.dev](https://kazaneko.dev), my personal site: a technical
blog and a record of my path into system administration, my home setup and
my homelab.

Static site built with [Hugo](https://gohugo.io/). No JavaScript, no cookies,
no tracking, no external fonts or CDNs.

## Who made what

**The site and this repository were built by Claude** (Anthropic's AI). I am
not a web developer or a designer, and that part is not what this site is
about: the theme, templates, CSS and deploy workflow were written by Claude,
with me deciding what I wanted.

**Every article is written by me, without the help of AI.** The words in
`content/` are mine.

## Run it locally

You need Hugo **0.151.0** (the standard edition is enough, "extended" is not
required).

```bash
hugo version          # check that Hugo is installed
hugo server           # serve the site on http://localhost:1313
```

English is at http://localhost:1313/, Italian at http://localhost:1313/it/.
`hugo server` reloads the page every time a file is saved. Stop it with `Ctrl+C`.

To build the final site (into `public/`, which Git ignores):

```bash
hugo --minify
```

## Publish

Push to `main`. GitHub Actions builds and publishes the site to GitHub Pages
on its own (`.github/workflows/deploy.yml`). Progress shows in the repo's
**Actions** tab.

## Write a post

```bash
hugo new content content/en/blog/post-name.md   # creates the file from a template
hugo server -D                                  # preview, drafts included
```

When the post is ready, remove `draft: true` from the top of the file.
An Italian translation goes in `content/it/blog/` with the same file name.

## File map

| File / folder | What it is for |
|---|---|
| `hugo.toml` | Configuration: title, URL, languages, top menu |
| `content/en/` | Pages and posts in English (main language). `_index.md` is the home page |
| `content/it/` | Italian translations, same file names as English |
| `layouts/_default/baseof.html` | The skeleton shared by every page (head, header, main, footer) |
| `layouts/_default/single.html` | A single page or post |
| `layouts/_default/list.html` | A list of pages (e.g. /blog, /setup) |
| `layouts/index.html` | The home page: `whoami`, latest posts, the top of `now` (up to the `<!--more-->` line) |
| `layouts/partials/` | Reused pieces: `head.html`, `header.html` (prompt + menu), `footer.html`, `post-list.html` (`ls -lt` style list), `tags.html` |
| `layouts/taxonomy.html`, `layouts/term.html` | The tag pages |
| `layouts/_default/rss.xml` | The RSS feed (posts only, full text) |
| `archetypes/blog.md` | Template for new posts |
| `static/css/style.css` | The only CSS file. Colors are variables at the top |
| `static/fonts/` | The JetBrains Mono font and its license (OFL) |
| `i18n/en.yaml`, `i18n/it.yaml` | Fixed interface text. The interface stays in English in both languages, so the two files match |
| `layouts/404.html` | The "page not found" page |
| `static/favicon.svg` | The icon shown in the browser tab |

