-- insert to, update, delete

USE world;

CREATE TEMPORARY TABLE demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    voto INT
);

INSERT INTO demo (nome, voto) VALUES ('Marco Rossi', 28);

SELECT * FROM demo;

INSERT INTO
    demo (nome, voto)
VALUES ('Giulia Bianchi', 30),
    ('Luca Verdi', 24),
    ('Elena Neri', 29);

SELECT * FROM demo;

UPDATE demo

SET nome = 'Giulia de Bianchi', voto = 29 WHERE id = 2;

SELECT * FROM demo WHERE id = 2;

UPDATE demo

SET voto = voto + 1 WHERE voto < 30 AND id > 0;

SELECT * FROM demo;

DELETE FROM demo WHERE id = 3;

DELETE FROM demo WHERE id > 0;

drop table demo;