
CREATE TABLE IF NOT EXISTS public.pessoa
(
    id_pessoa integer NOT NULL DEFAULT nextval('pessoa_id_pessoa_seq'::regclass),
    nome character varying(100) COLLATE pg_catalog."default" NOT NULL,
    cpf character varying(14) COLLATE pg_catalog."default" NOT NULL,
    telefone character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT pessoa_pkey PRIMARY KEY (id_pessoa),
    CONSTRAINT pessoa_cpf_key UNIQUE (cpf)
)

CREATE TABLE IF NOT EXISTS public.produto
(
    id_produto integer NOT NULL DEFAULT nextval('produto_id_produto_seq'::regclass),
    descricao character varying(100) COLLATE pg_catalog."default" NOT NULL,
    valor_venda numeric(10,2) NOT NULL,
    CONSTRAINT produto_pkey PRIMARY KEY (id_produto)
)

CREATE TABLE IF NOT EXISTS public.servico
(
    id_servico integer NOT NULL DEFAULT nextval('servico_id_servico_seq'::regclass),
    descricao character varying(100) COLLATE pg_catalog."default" NOT NULL,
    valor_atual numeric(10,2) NOT NULL,
    CONSTRAINT servico_pkey PRIMARY KEY (id_servico)
)

CREATE TABLE IF NOT EXISTS public.especialidade
(
    id_especialidade integer NOT NULL DEFAULT nextval('especialidade_id_especialidade_seq'::regclass),
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT especialidade_pkey PRIMARY KEY (id_especialidade)
)

CREATE TABLE IF NOT EXISTS public.cliente
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_cliente_seq'::regclass),
    id_pessoa integer NOT NULL,
    data_cadastro date DEFAULT CURRENT_DATE,
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente),
    CONSTRAINT fk_pessoa_cli FOREIGN KEY (id_pessoa)
        REFERENCES public.pessoa (id_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.funcionario
(
    id_funcionario integer NOT NULL DEFAULT nextval('funcionario_id_funcionario_seq'::regclass),
    id_pessoa integer NOT NULL,
    cargo character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT funcionario_pkey PRIMARY KEY (id_funcionario),
    CONSTRAINT fk_pessoa_func FOREIGN KEY (id_pessoa)
        REFERENCES public.pessoa (id_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.veterinario
(
    id_veterinario integer NOT NULL DEFAULT nextval('veterinario_id_veterinario_seq'::regclass),
    id_funcionario integer NOT NULL,
    crmv character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT veterinario_pkey PRIMARY KEY (id_veterinario),
    CONSTRAINT veterinario_crmv_key UNIQUE (crmv),
    CONSTRAINT fk_func_vet FOREIGN KEY (id_funcionario)
        REFERENCES public.funcionario (id_funcionario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.veterinario_especialidade
(
    id_veterinario integer NOT NULL,
    id_especialidade integer NOT NULL,
    CONSTRAINT veterinario_especialidade_pkey PRIMARY KEY (id_veterinario, id_especialidade),
    CONSTRAINT fk_esp_vet FOREIGN KEY (id_especialidade)
        REFERENCES public.especialidade (id_especialidade) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_vet_esp FOREIGN KEY (id_veterinario)
        REFERENCES public.veterinario (id_veterinario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.animal
(
    id_animal integer NOT NULL DEFAULT nextval('animal_id_animal_seq'::regclass),
    id_cliente integer NOT NULL,
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    especie character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT animal_pkey PRIMARY KEY (id_animal),
    CONSTRAINT fk_cliente_animal FOREIGN KEY (id_cliente)
        REFERENCES public.cliente (id_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.pagamento
(
    id_pagamento integer NOT NULL DEFAULT nextval('pagamento_id_pagamento_seq'::regclass),
    id_atendimento integer NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    status character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT pagamento_pkey PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pag_atend FOREIGN KEY (id_atendimento)
        REFERENCES public.atendimento (id_atendimento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.atendimento
(
    id_atendimento integer NOT NULL DEFAULT nextval('atendimento_id_atendimento_seq'::regclass),
    id_funcionario integer NOT NULL,
    id_cliente integer NOT NULL,
    id_animal integer NOT NULL,
    id_veterinario integer,
    data_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT atendimento_pkey PRIMARY KEY (id_atendimento),
    CONSTRAINT fk_atend_animal FOREIGN KEY (id_animal)
        REFERENCES public.animal (id_animal) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_atend_cli FOREIGN KEY (id_cliente)
        REFERENCES public.cliente (id_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_atend_func FOREIGN KEY (id_funcionario)
        REFERENCES public.funcionario (id_funcionario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_atend_vet FOREIGN KEY (id_veterinario)
        REFERENCES public.veterinario (id_veterinario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.atendimento_produto
(
    id_atendimento integer NOT NULL,
    id_produto integer NOT NULL,
    quantidade integer NOT NULL,
    valor_venda numeric(10,2) NOT NULL,
    CONSTRAINT atendimento_produto_pkey PRIMARY KEY (id_atendimento, id_produto),
    CONSTRAINT fk_atend_prod FOREIGN KEY (id_produto)
        REFERENCES public.produto (id_produto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_prod_atend FOREIGN KEY (id_atendimento)
        REFERENCES public.atendimento (id_atendimento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.atendimento_servico
(
    id_atendimento integer NOT NULL,
    id_servico integer NOT NULL,
    quantidade integer NOT NULL,
    valor_venda numeric(10,2) NOT NULL,
    CONSTRAINT atendimento_servico_pkey PRIMARY KEY (id_atendimento, id_servico),
    CONSTRAINT fk_atend_serv FOREIGN KEY (id_servico)
        REFERENCES public.servico (id_servico) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_serv_atend FOREIGN KEY (id_atendimento)
        REFERENCES public.atendimento (id_atendimento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

