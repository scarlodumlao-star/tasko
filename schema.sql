-- Tee Sheet database setup. Run once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  project text not null,
  text text not null,
  ord double precision not null default 0,
  done boolean not null default false,
  done_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.inbox (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  text text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.waiting (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  text text not null,
  project text not null default '',
  follow_up date,
  created_at timestamptz not null default now()
);

create table if not exists public.someday (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  text text not null,
  created_at timestamptz not null default now()
);

-- Each signed-in user only ever sees and changes their own rows.
alter table public.tasks   enable row level security;
alter table public.inbox   enable row level security;
alter table public.waiting enable row level security;
alter table public.someday enable row level security;

drop policy if exists own_rows on public.tasks;
drop policy if exists own_rows on public.inbox;
drop policy if exists own_rows on public.waiting;
drop policy if exists own_rows on public.someday;
create policy own_rows on public.tasks   for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy own_rows on public.inbox   for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy own_rows on public.waiting for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy own_rows on public.someday for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Live sync between phone and laptop.
alter publication supabase_realtime add table public.tasks, public.inbox, public.waiting, public.someday;
