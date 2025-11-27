CREATE DATABASE lookme;

USE lookme;

-- TABELAS SEM CHAVES ESTRANGEIRAS

CREATE TABLE tbl_porte (
    porte_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_porte VARCHAR(10) NOT NULL
);

CREATE TABLE tbl_raca (
    raca_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_raca VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_especie (
    especie_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_especie VARCHAR(10) NOT NULL
);

CREATE TABLE tbl_idade (
    idade_id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_sexo (
    sexo_id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(10) NOT NULL
);

CREATE TABLE tbl_usuario (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11),
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
	foto_url VARCHAR(200) NOT NULL,
    senha VARCHAR(200) NOT NULL
);

CREATE TABLE tbl_animal (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    temperamento VARCHAR(500),
    informacoes_veterinarias VARCHAR(800),
    descricao VARCHAR(1000),
    adaptabilidade VARCHAR(500),
    foto_url VARCHAR(200) NOT NULL,
    status_adocao BOOLEAN NOT NULL,
    status_castracao BOOLEAN NOT NULL,
    porte_id INT NOT NULL,
    raca_id INT NOT NULL,
    especie_id INT NOT NULL,
    idade_id INT NOT NULL,
    sexo_id INT NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (porte_id) REFERENCES tbl_porte(porte_id),
    FOREIGN KEY (raca_id) REFERENCES tbl_raca(raca_id),
    FOREIGN KEY (especie_id) REFERENCES tbl_especie(especie_id),
    FOREIGN KEY (idade_id) REFERENCES tbl_idade(idade_id),
    FOREIGN KEY (sexo_id) REFERENCES tbl_sexo(sexo_id),
    FOREIGN KEY (usuario_id) REFERENCES tbl_usuario(usuario_id)
);

-- TABELAS COM FKs QUE DEPENDEM DE tbl_usuario E tbl_animal

CREATE TABLE tbl_endereco_usuario (
    endereco_usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES tbl_usuario(usuario_id)
);

CREATE TABLE tbl_endereco_animal (
    endereco_animal_id INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf VARCHAR(2),
    cep VARCHAR(9) NOT NULL,
    animal_id INT NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES tbl_animal(animal_id)
);

-- TABELAS RELACIONADAS A ADOÇÃO / FAVORITOS

CREATE TABLE tbl_pedido_adocao (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    status_pedido VARCHAR(20) NOT NULL,
    data_solicitacao DATE NOT NULL,
    usuario_id INT NOT NULL,
    animal_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES tbl_usuario(usuario_id),
    FOREIGN KEY (animal_id) REFERENCES tbl_animal(animal_id)
);

CREATE TABLE tbl_favoritos (
    favorito_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    animal_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES tbl_usuario(usuario_id),
    FOREIGN KEY (animal_id) REFERENCES tbl_animal(animal_id)
);

CREATE TABLE tbl_historico_adocao (
    historico_adocao_id INT AUTO_INCREMENT PRIMARY KEY,
    data_adocao DATE NOT NULL,
    usuario_id INT NOT NULL,
    animal_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES tbl_usuario(usuario_id),
    FOREIGN KEY (animal_id) REFERENCES tbl_animal(animal_id)
);

--  TABELA DE NOTIFICAÇÕES

CREATE TABLE tbl_notificacao (
    notificacao_id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(500) NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    data_notificacao DATE NOT NULL,
    usuario_id INT NOT NULL,
    pedido_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES tbl_usuario(usuario_id),
    FOREIGN KEY (pedido_id) REFERENCES tbl_pedido_adocao(pedido_id)
);

-- INSERTS TBL_PORTE

INSERT INTO tbl_porte (nome_porte) VALUES
('Pequeno'),
('Médio'),
('Grande');

select * from tbl_porte;

-- INSERTS TBL_RACA

INSERT INTO tbl_raca (nome_raca) VALUES
('SRD'),
('Labrador'),
('Shih-tzu'),
('Persa'),
('Siamês');

select * from tbl_raca;

-- INSERTS TBL_ESPECIE

INSERT INTO tbl_especie (nome_especie) VALUES
('Cão'),
('Gato');

select * from tbl_especie;

-- INSERTS TBL_IDADE

INSERT INTO tbl_idade (descricao) VALUES
('Filhote'),
('Adulto'),
('Idoso');

select * from tbl_idade;

-- INSERTS TBL_SEXO

INSERT INTO tbl_sexo (descricao) VALUES
('Macho'),
('Fêmea');

select * from tbl_sexo;

-- INSERTS TBL_USUARIO

INSERT INTO tbl_usuario (nome, cpf, data_nascimento, telefone, email, foto_url, senha) VALUES
('Mariana Silva', '12345678900', '1990-05-20', '(11)90000-1000', 'mariana@gmail.com', 'mariana@gmail.com', 'senha123'),
('João Pereira', '98765432100', '1985-10-12', '(21)98888-2222', 'joao@gmail.com', 'mariana@gmail.com', '12345abc'),
('Luana Bomfim', '45678912300', '2007-03-14', '(71)97777-3333', 'luana@gmail.com', 'mariana@gmail.com', 'minhasenha');

select * from tbl_usuario;

-- INSERTS TBL_ANIMAL

INSERT INTO tbl_animal (
    nome, temperamento, informacoes_veterinarias, descricao, adaptabilidade,
    foto_url, status_adocao, status_castracao,
    porte_id, raca_id, especie_id, idade_id, sexo_id, usuario_id
) VALUES
-- 1) Cachorro pequeno, filhote, energético
('Bolt',
 'Muito ativo, brincalhão e sociável.',
 'Vermifugado e com 1ª dose de vacina.',
 'Filhote cheio de energia, ótimo para famílias e apartamentos.',
 'Adapta-se bem a espaços pequenos.',
 'https://site.com/fotos/bolt.jpg',
 FALSE,
 TRUE,
 1,  -- porte pequeno
 2,  -- labrador
 1,  -- cão
 1,  -- filhote
 1,  -- macho
 1   -- usuário: Mariana
),

-- 2) Gata adulta, temperamento calmo
('Misty',
 'Calma, independente e carinhosa.',
 'Castrada e com vacinas atualizadas.',
 'Gata adulta que prefere ambientes tranquilos.',
 'Adapta-se bem a casas silenciosas.',
 'https://site.com/fotos/misty.jpg',
 FALSE,
 TRUE,
 1,  -- porte pequeno
 4,  -- persa
 2,  -- gato
 2,  -- adulto
 2,  -- fêmea
 2   -- usuário: João
),

-- 3) Cachorro grande, idoso e dócil
('Thor',
 'Dócil, tranquilo e muito companheiro.',
 'Necessita acompanhamento veterinário semestral.',
 'Cachorro idoso, ideal para famílias calmas.',
 'Prefere locais maiores e rotina estável.',
 'https://site.com/fotos/thor.jpg',
 TRUE,
 FALSE,
 3,  -- porte grande
 1,  -- vira-lata
 1,  -- cão
 3,  -- idoso
 1,  -- macho
 3   -- usuário: Luana
);

select * from tbl_animal;

-- INSERTS TBL_ENDERECO_USUARIO

INSERT INTO tbl_endereco_usuario (
    logradouro, numero, bairro, cidade, uf, cep, usuario_id
) VALUES
('Rua das Flores', '120', 'Centro', 'São Paulo', 'SP', '01010-000', 1),
('Av. Atlântica', '450', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021-001', 2),
('Rua Bahia', '88', 'Pituba', 'Salvador', 'BA', '41830-160', 3);

-- INSERTS TBL_ENDERECO_ANIMAL

INSERT INTO tbl_endereco_animal (
    logradouro, numero, bairro, cidade, uf, cep, animal_id
) VALUES
('Rua das Acácias', '35', 'Jardins', 'São Paulo', 'SP', '01420-030', 1),  -- Bolt
('Rua Aurora', '210', 'Lapa', 'São Paulo', 'SP', '01210-050', 2),        -- Misty
('Estrada Velha', '900', 'Cajazeiras', 'Salvador', 'BA', '41330-000', 3); -- Thor

-- INSERTS TBL_PEDIDO_ADOCAO

INSERT INTO tbl_pedido_adocao (
    data_solicitacao, status_pedido, animal_id, usuario_id
) VALUES
('2025-11-20', 'Pendente', 1, 2),  -- João pediu adoção do Bolt
('2025-11-21', 'Aprovado', 2, 1),  -- Mariana adotou a Misty
('2025-11-21', 'Recusado', 3, 2);  -- João tentou adotar o Thor
