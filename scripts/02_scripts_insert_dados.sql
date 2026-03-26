
-- 1. Pessoas e Especialidades
INSERT INTO Pessoa (Nome, CPF, Telefone) VALUES ('Carlos Silva', '123.456. 789-00');
INSERT INTO Pessoa (Nome, CPF, Telefone) VALUES ('Ana Souza', '987.654.321-11', '69 97777-1111');
INSERT INTO Especialidade (Nome) VALUES ('Cirurgia'), ('Dermatologia');

-- 2. Funcionários e Veterinários
INSERT INTO Funcionario (ID Pessoa, Cargo) VALUES (1, 'Veterinário Senior');
INSERT INTO Veterinario (ID_Funcionario, CRMV) VALUES (1, 'CRMV-RO 1234');

-- 3. Clientes e Animais
INSERT INTO Cliente (ID_Pessoa) VALUES (2);
INSERT INTO Animal (ID_Cliente, Nome, Especie) VALUES (1, 'Thor', 'Cão');

-- 4. Serviços e Produtos
INSERT INTO Servico (Descricao, Valor_Atual) VALUES ('Consulta Geral', 150.00);
INSERT INTO Produto (Descricao, Valor_Venda) VALUES ('Vacina V10', 85.00);

