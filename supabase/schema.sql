-- Tabela de briefings do projeto Supabase "Briefing Project"
-- (já aplicada em https://ojftqnrxkrphzsloyeoc.supabase.co — mantida aqui como referência)

create table public.briefings (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  status text not null default 'novo' check (status in ('novo','em_analise','aprovado','arquivado')),
  cliente_nome text not null check (char_length(cliente_nome) between 2 and 200),
  cliente_email text not null check (cliente_email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' and char_length(cliente_email) <= 200),
  cliente_telefone text check (char_length(cliente_telefone) <= 40),
  empresa text check (char_length(empresa) <= 200),
  projeto_nome text check (char_length(projeto_nome) <= 200),
  tipo_projeto text check (char_length(tipo_projeto) <= 100),
  orcamento text check (char_length(orcamento) <= 100),
  prazo text check (char_length(prazo) <= 100),
  respostas jsonb not null default '{}'::jsonb check (pg_column_size(respostas) <= 200000)
);

create index briefings_created_at_idx on public.briefings (created_at desc);
create index briefings_status_idx on public.briefings (status);

alter table public.briefings enable row level security;

-- Clientes (anônimos) só podem ENVIAR um briefing.
create policy "clientes podem enviar briefing"
  on public.briefings for insert
  to anon, authenticated
  with check (status = 'novo');

-- Só o dono lê e atualiza.
create policy "dono le briefings"
  on public.briefings for select
  to authenticated
  using ((select auth.jwt() ->> 'email') = 'designer.thomaselton@gmail.com');

create policy "dono atualiza briefings"
  on public.briefings for update
  to authenticated
  using ((select auth.jwt() ->> 'email') = 'designer.thomaselton@gmail.com')
  with check ((select auth.jwt() ->> 'email') = 'designer.thomaselton@gmail.com');

revoke all on public.briefings from anon;
grant insert on public.briefings to anon;
grant select, insert, update on public.briefings to authenticated;
