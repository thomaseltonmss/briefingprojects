# Briefing de Projeto

Formulário para clientes preencherem antes do início de um projeto. As respostas são gravadas na tabela `briefings` do Supabase (projeto **Briefing Project**).

- `index.html` — o formulário (HTML único, sem build). As perguntas ficam no array `STEPS` no início do script.
- `supabase/schema.sql` — estrutura da tabela e regras de acesso (clientes só enviam; só o dono lê).

Para ver as respostas: painel do Supabase → Table Editor → `briefings`.
