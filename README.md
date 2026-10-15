# Tee Sheet

Carlo's Mon–Fri time-block planner. Installable app (PWA) for phone and laptop, synced through Supabase, hosted on GitHub Pages.

## Files
- `index.html` — the app
- `config.js` — Supabase project URL and anon key
- `schema.sql` — database tables and privacy rules (run once in Supabase)
- `seed.json` — starter task list
- `manifest.webmanifest`, `sw.js`, `icons/` — what makes it installable and work offline

## Setup
1. **Supabase:** create a project, then SQL Editor → paste `schema.sql` → Run.
2. **Keys:** Project Settings → API → copy the Project URL and the anon/publishable key into `config.js`.
3. **Auth redirect:** Authentication → URL Configuration → set Site URL to the GitHub Pages address.
4. **GitHub Pages:** repo Settings → Pages → Deploy from branch `main`, folder `/ (root)`.
5. Open the Pages address, create your account, confirm the email, sign in, then Projects → **Load my starter tasks**.

## Install
- **Laptop (Chrome/Edge):** the install icon in the address bar, or the app's **Install app** link at the bottom.
- **iPhone (Safari):** Share → Add to Home Screen.
- **Android (Chrome):** menu → Install app / Add to Home screen.

## Changing the schedule
The weekly blocks live in the `SCHED` section near the top of the script in `index.html`.

## Projects and schedule
Projects live in the `projects` table and each weekday's three project blocks (11:00, 1:00, 3:15) in the `days` table.
- In the app: Projects → **+ New project**; Week → **Edit schedule**.
- From Claude: with the Supabase connector, ask in any chat ("New project: … put it on Wednesday 1 PM").
