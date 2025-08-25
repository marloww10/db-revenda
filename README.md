# Banco de Dados db_revenda_marlon

## Descrição
Este projeto contém o SQL para o banco de dados db_revenda_marlon, que modela um sistema de revenda de roupas no estilo de um e-commerce. O banco inclui 6 tabelas, com uma tabela de ligação com chave primária composta, restrições adequadas, duas views para facilitar consultas e 10 registros inseridos por tabela.

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

## Observações
- Os inserts foram feitos por ia, o resto foi a mão.


<img width="951" height="747" alt="image" src="https://github.com/user-attachments/assets/93dedde1-629a-43a3-becc-bc596733a68c" />
