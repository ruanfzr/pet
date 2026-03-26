
-- 1. UPDATE: Atualizar o telefone de uma pessoa específica
UPDATE public.pessoa 
SET telefone = '(11) 98888-8888' 
WHERE cpf = '123.456.789-00';

-- 2. UPDATE: Dar um aumento de 10% no valor de todos os serviços
UPDATE public.servico 
SET valor_atual = valor_atual * 1.10;

-- 3. DELETE: Tentar remover um animal (Cuidado: só funciona se não houver atendimentos para ele)
DELETE FROM public.animal 
WHERE nome = 'Rex' AND id_cliente = 1;

-- 4. DELETE: Remover um pagamento pendente de teste
DELETE FROM public.pagamento 
WHERE status = 'Pendente' AND valor_total < 10.00;