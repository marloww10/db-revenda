create database db_revenda_marlon;

create table endereco (
    endereco_id serial primary key,
    cep char(8) not null,
    cidade varchar(30) not null,
    uf varchar(2) not null,
    bairro varchar(60) not null,
    rua varchar(60) not null
);

create table clientes (
    cliente_id serial primary key,
    cpf char(11) not null unique,
    email varchar(100) not null unique,
    telefone varchar(15) not null unique,
    nome varchar(100) not null,
    id_endereco int references endereco(endereco_id)
);

create table produtos (
    produto_id serial primary key,
    nome_produto varchar(50) not null,
    cor varchar(20),
    tamanho varchar(10) check(tamanho in ('pp', 'p', 'm', 'g', 'gg')),
    descricao text not null,
    imagem bytea
);

create table preco (
    preco_id serial primary key,
    id_produto integer references produtos(produto_id),
    valor numeric(10,2) not null check(valor > 0),
    data_inicio date default current_date,
    data_fim date
);

create table carrinho (
    carrinho_id serial primary key,
    id_preco int references preco(preco_id),
    id_cliente int references clientes(cliente_id),
    quantidade int not null default 1 check(quantidade > 0),
    data_adicao date default current_date
);

create table carrinho_produtos (
    carrinho_id int not null references carrinho(carrinho_id),
    produto_id int not null references produtos(produto_id),
    primary key (carrinho_id, produto_id)
);

create type tipo_pagamento as enum ('cartao_credito', 'boleto', 'pix');
create table metodo_pagamento (
    pagamento_id serial primary key,
    metodos tipo_pagamento,
    nome_titular varchar(100),
    numero_cartao varchar(16),
    validade_cartao char(5),
    data_cadastro date default current_date
);

create view view_carrinho_cliente as
select c.carrinho_id, cl.nome, p.nome_produto, pr.valor, c.quantidade
from carrinho c
join clientes cl on c.id_cliente = cl.cliente_id
join preco pr on c.id_preco = pr.preco_id
join produtos p on pr.id_produto = p.produto_id;

create view view_cliente_endereco as
select cl.cliente_id, cl.nome, cl.email, e.cep, e.cidade, e.uf
from clientes cl
join endereco e on cl.id_endereco = e.endereco_id;

insert into endereco (cep, cidade, uf, bairro, rua) values ('12345678', 'sao paulo', 'sp', 'centro', 'rua a');
insert into endereco (cep, cidade, uf, bairro, rua) values ('23456789', 'rio de janeiro', 'rj', 'copacabana', 'rua b');
insert into endereco (cep, cidade, uf, bairro, rua) values ('34567890', 'belo horizonte', 'mg', 'savassi', 'rua c');
insert into endereco (cep, cidade, uf, bairro, rua) values ('45678901', 'curitiba', 'pr', 'batel', 'rua d');
insert into endereco (cep, cidade, uf, bairro, rua) values ('56789012', 'porto alegre', 'rs', 'moinhos', 'rua e');
insert into endereco (cep, cidade, uf, bairro, rua) values ('67890123', 'salvador', 'ba', 'barra', 'rua f');
insert into endereco (cep, cidade, uf, bairro, rua) values ('78901234', 'recife', 'pe', 'boa viagem', 'rua g');
insert into endereco (cep, cidade, uf, bairro, rua) values ('89012345', 'fortaleza', 'ce', 'meireles', 'rua h');
insert into endereco (cep, cidade, uf, bairro, rua) values ('90123456', 'brasilia', 'df', 'asa sul', 'rua i');
insert into endereco (cep, cidade, uf, bairro, rua) values ('01234567', 'manaus', 'am', 'centro', 'rua j');

insert into clientes (cpf, email, telefone, nome, id_endereco) values ('12345678901', 'joao@email.com', '11987654321', 'joao silva', 1);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('23456789012', 'maria@email.com', '21987654321', 'maria oliveira', 2);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('34567890123', 'pedro@email.com', '31987654321', 'pedro santos', 3);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('45678901234', 'ana@email.com', '41987654321', 'ana souza', 4);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('56789012345', 'lucas@email.com', '51987654321', 'lucas ferreira', 5);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('67890123456', 'julia@email.com', '61987654321', 'julia costa', 6);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('78901234567', 'rafael@email.com', '71987654321', 'rafael almeida', 7);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('89012345678', 'fernanda@email.com', '81987654321', 'fernanda rodrigues', 8);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('90123456789', 'marcos@email.com', '91987654321', 'marcos lima', 9);
insert into clientes (cpf, email, telefone, nome, id_endereco) values ('01234567890', 'patricia@email.com', '92987654321', 'patricia mendes', 10);

insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('camiseta estampada', 'azul', 'm', 'camiseta com estampa floral', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('calca jeans', 'preto', 'g', 'calca jeans slim', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('vestido longo', 'vermelho', 'p', 'vestido longo elegante', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('jaqueta couro', 'marrom', 'm', 'jaqueta de couro sintetico', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('saia plissada', 'rosa', 'pp', 'saia plissada midi', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('blusa manga longa', 'branca', 'g', 'blusa de tecido leve', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('bermuda cargo', 'verde', 'm', 'bermuda com bolsos laterais', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('camisa social', 'azul claro', 'p', 'camisa social slim fit', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('calca legging', 'preto', 'm', 'legging de alta compressao', null);
insert into produtos (nome_produto, cor, tamanho, descricao, imagem) values ('sueter lã', 'cinza', 'gg', 'sueter de lã quente', null);

insert into preco (id_produto, valor, data_inicio) values (1, 49.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (2, 99.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (3, 129.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (4, 199.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (5, 79.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (6, 59.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (7, 89.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (8, 109.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (9, 69.90, '2025-08-01');
insert into preco (id_produto, valor, data_inicio) values (10, 149.90, '2025-08-01');

insert into carrinho (id_preco, id_cliente, quantidade) values (1, 1, 2);
insert into carrinho (id_preco, id_cliente, quantidade) values (2, 2, 1);
insert into carrinho (id_preco, id_cliente, quantidade) values (3, 3, 1);
insert into carrinho (id_preco, id_cliente, quantidade) values (4, 4, 3);
insert into carrinho (id_preco, id_cliente, quantidade) values (5, 5, 2);
insert into carrinho (id_preco, id_cliente, quantidade) values (6, 6, 1);
insert into carrinho (id_preco, id_cliente, quantidade) values (7, 7, 2);
insert into carrinho (id_preco, id_cliente, quantidade) values (8, 8, 1);
insert into carrinho (id_preco, id_cliente, quantidade) values (9, 9, 1);
insert into carrinho (id_preco, id_cliente, quantidade) values (10, 10, 2);

insert into carrinho_produtos (carrinho_id, produto_id) values (1, 1);
insert into carrinho_produtos (carrinho_id, produto_id) values (2, 2);
insert into carrinho_produtos (carrinho_id, produto_id) values (3, 3);
insert into carrinho_produtos (carrinho_id, produto_id) values (4, 4);
insert into carrinho_produtos (carrinho_id, produto_id) values (5, 5);
insert into carrinho_produtos (carrinho_id, produto_id) values (6, 6);
insert into carrinho_produtos (carrinho_id, produto_id) values (7, 7);
insert into carrinho_produtos (carrinho_id, produto_id) values (8, 8);
insert into carrinho_produtos (carrinho_id, produto_id) values (9, 9);
insert into carrinho_produtos (carrinho_id, produto_id) values (10, 10);

insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('cartao_credito', 'joao silva', '1234567890123456', '12/27');
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('pix', null, null, null);
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('boleto', null, null, null);
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('cartao_credito', 'maria oliveira', '2345678901234567', '11/26');
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('pix', null, null, null);
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('boleto', null, null, null);
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('cartao_credito', 'pedro santos', '3456789012345678', '10/28');
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('pix', null, null, null);
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('boleto', null, null, null);
insert into metodo_pagamento (metodos, nome_titular, numero_cartao, validade_cartao) values ('cartao_credito', 'ana souza', '4567890123456789', '09/27');

-- consulta com like
select * from produtos where nome_produto like '%camiseta%';

-- explain da consulta com like
explain select * from produtos where nome_produto like '%camiseta%';

-- criar indice para a coluna nome_produto
create index idx_nome_produto on produtos(nome_produto);

-- refazer consulta com like e explain
select * from produtos where nome_produto like '%camiseta%';
explain select * from produtos where nome_produto like '%camiseta%';

-- alterar coluna cor de varchar para int
alter table produtos alter column cor type int using (case cor when 'azul' then 1 when 'preto' then 2 when 'vermelho' then 3 when 'marrom' then 4 when 'rosa' then 5 when 'branca' then 6 when 'verde' then 7 when 'azul claro' then 8 when 'cinza' then 9 else 0 end);

-- alterar coluna quantidade de int para varchar
alter table carrinho alter column quantidade type varchar(10);

-- criar usuario marlon com todas as permissoes
create user marlon with password 'senha123';
grant all privileges on database db_revenda_marlon to marlon;
grant all on all tables in schema public to marlon;

-- criar usuario colega com permissao de select na tabela clientes
create user colega with password 'senha123';
grant select on clientes to colega;

-- consultas e explains com usuario colega
set session authorization colega;
select * from clientes where nome like '%joao%';
explain select * from clientes where nome like '%joao%';
create index idx_nome_clientes on clientes(nome);
select * from clientes where nome like '%joao%';
explain select * from clientes where nome like '%joao%';
alter table clientes alter column nome type int using (case when nome = 'joao silva' then 1 else 0 end);
alter table carrinho alter column quantidade type int using (quantidade::int);
reset session authorization;

-- consultas com joins (4 grupos, cada um com inner, left e right join)
-- consulta 1: clientes e endereco
select cl.nome, e.cidade from clientes cl inner join endereco e on cl.id_endereco = e.endereco_id;
select cl.nome, e.cidade from clientes cl left join endereco e on cl.id_endereco = e.endereco_id;
select cl.nome, e.cidade from clientes cl right join endereco e on cl.id_endereco = e.endereco_id;

-- consulta 2: carrinho e clientes
select c.carrinho_id, cl.nome from carrinho c inner join clientes cl on c.id_cliente = cl.cliente_id;
select c.carrinho_id, cl.nome from carrinho c left join clientes cl on c.id_cliente = cl.cliente_id;
select c.carrinho_id, cl.nome from carrinho c right join clientes cl on c.id_cliente = cl.cliente_id;

-- consulta 3: carrinho e preco
select c.carrinho_id, p.valor from carrinho c inner join preco p on c.id_preco = p.preco_id;
select c.carrinho_id, p.valor from carrinho c left join preco p on c.id_preco = p.preco_id;
select c.carrinho_id, p.valor from carrinho c right join preco p on c.id_preco = p.preco_id;

-- consulta 4: produtos e preco
select pr.nome_produto, p.valor from produtos pr inner join preco p on pr.produto_id = p.id_produto;
select pr.nome_produto, p.valor from produtos pr left join preco p on pr.produto_id = p.id_produto;
select pr.nome_produto, p.valor from produtos pr right join preco p on pr.produto_id = p.id_produto;

-- atualizar registros com colunas null
update produtos set imagem = null where produto_id in (1, 2, 3);
update metodo_pagamento set numero_cartao = null, validade_cartao = null where metodos = 'pix';

-- reexecutar consultas com join
select cl.nome, e.cidade from clientes cl inner join endereco e on cl.id_endereco = e.endereco_id;
select cl.nome, e.cidade from clientes cl left join endereco e on cl.id_endereco = e.endereco_id;
select cl.nome, e.cidade from clientes cl right join endereco e on cl.id_endereco = e.endereco_id;
select c.carrinho_id, cl.nome from carrinho c inner join clientes cl on c.id_cliente = cl.cliente_id;
select c.carrinho_id, cl.nome from carrinho c left join clientes cl on c.id_cliente = cl.cliente_id;
select c.carrinho_id, cl.nome from carrinho c right join clientes cl on c.id_cliente = cl.cliente_id;
select c.carrinho_id, p.valor from carrinho c inner join preco p on c.id_preco = p.preco_id;
select c.carrinho_id, p.valor from carrinho c left join preco p on c.id_preco = p.preco_id;
select c.carrinho_id, p.valor from carrinho c right join preco p on c.id_preco = p.preco_id;
select pr.nome_produto, p.valor from produtos pr inner join preco p on pr.produto_id = p.id_produto;
select pr.nome_produto, p.valor from produtos pr left join preco p on pr.produto_id = p.id_produto;
select pr.nome_produto, p.valor from produtos pr right join preco p on pr.produto_id = p.id_produto;
