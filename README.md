# Banco de Dados db_revenda_marlon

## Descrição
Este projeto contém o schema SQL para o banco de dados db_revenda_marlon, que modela um sistema de revenda de roupas no estilo de um e-commerce. O banco inclui 6 tabelas, com uma tabela de ligação com chave primária composta, restrições adequadas, duas views para facilitar consultas e 10 registros inseridos por tabela.

## Estrutura do Banco de Dados
- **Banco**: db_revenda_marlon
- **Tabelas**:
  - endereco: Armazena informações de endereços dos clientes (CEP, cidade, UF, bairro, rua).
  - clientes: Gerencia dados dos clientes (CPF, email, telefone, nome, endereço).
  - produtos: Contém detalhes dos produtos (nome, cor, tamanho, descrição, imagem).
  - preco: Registra preços dos produtos com data de início e fim.
  - carrinho: Gerencia itens no carrinho dos clientes (preço, cliente, quantidade, data de adição).
  - carrinho_produtos: Tabela de ligação com chave primária composta (carrinho_id, produto_id).
  - metodo_pagamento: Armazena métodos de pagamento (cartão de crédito, boleto, Pix) usando ENUM, com detalhes de cartão.

## Restrições
- Campos obrigatórios (NOT NULL) em colunas críticas como cep, nome, email, valor.
- Campos únicos (UNIQUE) em cpf, email, telefone.
- Restrições CHECK para garantir valores válidos (ex.: valor > 0, tamanho em 'pp', 'p', 'm', 'g', 'gg').
- Valores padrão (DEFAULT) para datas (ex.: current_date).
- Chaves estrangeiras para relacionar tabelas (ex.: id_endereco, id_preco, id_cliente).
- Chave primária composta em carrinho_produtos (carrinho_id, produto_id).

## Como Usar
1. Execute o arquivo schema.sql em um SGBD PostgreSQL para criar o banco, tabelas, views e inserir os dados de exemplo.
2. Consulte as views com:
   select * from view_carrinho_cliente;
   select * from view_cliente_endereco;
3. As views são úteis para telas de carrinho de compras e gerenciamento de clientes.

## Observações
- O banco foi projetado para PostgreSQL devido ao uso do tipo ENUM.
- Os inserts fornecem dados de exemplo para testes.
- A tabela carrinho_produtos garante a relação entre carrinhos e produtos, permitindo rastreamento detalhado.
