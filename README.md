# Briefing de Projeto

Formulário para clientes preencherem antes do início de um projeto. As respostas são gravadas na tabela `briefings` do Supabase (projeto **Briefing Project**).

- `briefing_project/index.html` — o formulário (HTML único, sem build). As perguntas ficam no array `STEPS` no início do script.
- `supabase/schema.sql` — estrutura da tabela e regras de acesso (clientes só enviam; só o dono lê).

- `admin/index.html` — painel de administração (`/admin`): login com e-mail e senha (Supabase Auth), lista de empresas e respostas por etapa. Só o e-mail definido nas políticas RLS consegue ler.

Para criar o acesso: painel do Supabase → Authentication → Users → Add user, com o e-mail `designer.thomaselton@gmail.com` e uma senha (marque *Auto Confirm User*).
