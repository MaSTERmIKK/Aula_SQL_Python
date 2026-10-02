-- ==============================================================================
-- SLIDE 034 - Esercizio sui comandi SQL: GROUP BY, ORDER BY e INSERT INTO
-- Tabella: Libri (Schema: libreria)
-- ==============================================================================
-- Creazione tabella (per prove pratiche)
CREATE DATABASE IF NOT EXISTS libreria;

USE libreria;

DROP TABLE IF EXISTS Libri;

CREATE TABLE Libri (
    id INT PRIMARY KEY,
    titolo VARCHAR(100),
    autore VARCHAR(100),
    genere VARCHAR(50),
    prezzo DECIMAL(5, 2),
    anno_pubblicazione INT
);
-- 1) Inserimento dati (INSERT INTO)
-- Inserire almeno 6 nuovi libri con generi e autori diversi, pubblicati in anni differenti
INSERT INTO
    Libri (id, titolo, autore, genere, prezzo, anno_pubblicazione)
VALUES (1, 'Il Nome della Rosa', 'Umberto Eco', 'Giallo', 16.50, 1980),
    (2, '1984', 'George Orwell', 'Fantascienza', 12.00, 1949),
    (3, 'Il Signore degli Anelli', 'J.R.R. Tolkien', 'Fantasy', 25.00, 1954),
    (4, 'La ragazza del treno', 'Paula Hawkins', 'Giallo', 13.00, 2015),
    (5, 'Sottomissione', 'Michel Houellebecq', 'Narrativa', 15.00, 2015),
    (6, 'Il Problema dei Tre Corpi', 'Liu Cixin', 'Fantascienza', 14.50, 2016);

-- 2) Aggregazione e raggruppamento (GROUP BY)
-- Mostrare per ogni genere: numero totale libri e prezzo medio, ordinato per genere ASC
SELECT
    genere,
    COUNT(*) AS TotaleLibri,
    ROUND(AVG(prezzo), 2) AS PrezzoMedio
FROM Libri
GROUP BY
    genere
ORDER BY genere ASC;
-- 3) Ordinamento risultati (ORDER BY)
-- Elencare i libri pubblicati dopo il 2010 ordinati per anno DESC e, a parità di anno, prezzo ASC
SELECT
    titolo,
    autore,
    genere,
    anno_pubblicazione,
    prezzo
FROM Libri
WHERE
    anno_pubblicazione > 2010
ORDER BY anno_pubblicazione DESC, prezzo ASC;

-- ==============================================================================
-- SLIDE 039 - Esercizio sui comandi SQL: SELECT TOP(n) - AS - MIN/MAX/AVG/SUM
-- Tabella: Vendite (Schema: negozio)
-- ==============================================================================

-- Si consideri una tabella chiamata Vendite con la seguente struttura, almeno 20 elementi generati:

CREATE DATABASE IF NOT EXISTS negozio;

USE negozio;

DROP TABLE IF EXISTS Vendite;

Vendite (
    id INT,
    prodotto VARCHAR(100),
    categoria VARCHAR(50),
    quantita INT,
    prezzo_unitario DECIMAL(6, 2),
    data_vendita DATE
)

--20 elementi
INSERT INTO
    Vendite (id, prodotto, categoria, quantita, prezzo_unitario, data_vendita)
VALUES (1, 'Laptop Pro 15', 'Elettronica', 2, 1299.99, '2024-01-10'),
    (2, 'Mouse Wireless', 'Accessori', 5, 24.50, '2024-01-12'),
    (3, 'Tastiera Meccanica', 'Accessori', 3, 79.90, '2024-01-15'),
    (4, 'Monitor 27 Pollici', 'Elettronica', 1, 249.00, '2024-01-18'),
    (5, 'Scrivania Regolabile', 'Arredamento', 1, 350.00, '2024-01-20'),
    (6, 'Sedia Ergonomica', 'Arredamento', 2, 189.90, '2024-01-22'),
    (7, 'Cuffie Bluetooth', 'Audio', 4, 59.99, '2024-01-25'),
    (8, 'Soundbar TV', 'Audio', 2, 149.00, '2024-02-01'),
    (9, 'Smartphone 5G', 'Elettronica', 3, 799.00, '2024-02-03'),
    (10, 'Cover Protettiva', 'Accessori', 10, 12.99, '2024-02-05'),
    (11, 'Lampada LED Smart', 'Arredamento', 6, 29.90, '2024-02-08'),
    (12, 'Webcam HD', 'Accessori', 3, 45.00, '2024-02-10'),
    (13, 'Cassa Portatile', 'Audio', 5, 39.50, '2024-02-14'),
    (14, 'Tablet 10 Pollici', 'Elettronica', 2, 329.00, '2024-02-17'),
    (15, 'Supporto Monitor', 'Accessori', 4, 34.90, '2024-02-20'),
    (16, 'Libreria Modulare', 'Arredamento', 1, 120.00, '2024-02-22'),
    (17, 'Auricolari TWS', 'Audio', 8, 29.99, '2024-02-25'),
    (18, 'Zaino Porta PC', 'Accessori', 3, 49.90, '2024-02-27'),
    (19, 'Stampante Multifunzione', 'Elettronica', 1, 159.00, '2024-03-01'),
    (20, 'Microfono USB', 'Audio', 2, 85.00, '2024-03-05');
-- 1. Totale vendite per categoria (quanti scontrini staccati per ogni reparto)
SELECT categoria, COUNT(*) AS TotaleVendite
FROM Vendite
GROUP BY
    categoria;
-- 2. Prezzo medio dei prodotti venduti per categoria
SELECT categoria, ROUND(AVG(prezzo_unitario), 2) AS PrezzoMedio
FROM Vendite
GROUP BY
    categoria;
-- 3. Quanti pezzi totali sono stati venduti per ogni singolo prodotto
SELECT prodotto, SUM(quantita) AS QuantitaTotale
FROM Vendite
GROUP BY
    prodotto
ORDER BY QuantitaTotale DESC;
-- 4. Il prezzo più alto e il prezzo più basso registrati nella tabella
SELECT
    MAX(prezzo_unitario) AS PrezzoPiuAlto,
    MIN(prezzo_unitario) AS PrezzoPiuBasso
FROM Vendite;
-- 5. Numero totale complessivo di vendite registrate nel foglio
SELECT COUNT(*) AS TotaleRigheTabella FROM Vendite;
-- 6. I 5 articoli più costosi in catalogo
SELECT DISTINCT
    prodotto,
    prezzo_unitario
FROM Vendite
ORDER BY prezzo_unitario DESC
LIMIT 5;
-- 7. I 3 articoli che hanno venduto meno pezzi in assoluto (i "fanalini di coda")
SELECT prodotto, SUM(quantita) AS PezziVenduti
FROM Vendite
GROUP BY
    prodotto
ORDER BY PezziVenduti ASC
LIMIT 3;

-- ==============================================================================
-- SLIDE 046 - Esercizio sui comandi SQL: WILDCHARACTER / IN / BETWEEN
-- Tabella: Clienti
-- ==============================================================================

-- Si consideri una tabella chiamata Clienti con la seguente struttura, almeno 20 dati inseriti:

-- Creazione tabella Clienti
CREATE TABLE Clienti (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    cognome VARCHAR(100),
    email VARCHAR(100),
    eta INT,
    citta VARCHAR(100)
);

-- Inserimento di 20 record
INSERT INTO
    Clienti (id, nome, cognome, email, eta, citta)
VALUES (1, 'Alessandro', 'Rossi', 'alessandro.rossi@gmail.com', 34, 'Roma'),
    (2, 'Anna', 'Verdi', 'anna.verdi@yahoo.it', 28, 'Milano'),
    (3, 'Marco', 'Bianchi', 'marco.b@gmail.com', 40, 'Torino'),
    (4, 'Andrea', 'Conti', 'andrea.conti@outlook.com', 22, 'Genova'),
    (5, 'Giulia', 'Russo', 'giulia.russo@gmail.com', 31, 'Napoli'),
    (6, 'Antonio', 'Gallo', 'antonio.g@libero.it', 45, 'Roma Termini'),
    (7, 'Beatrice', 'Fonti', 'beatrice.f@gmail.com', 38, 'Bologna'),
    (8, 'Alberto', 'Costa', 'alberto.costa@gmail.com', 52, 'Verona'),
    (9, 'Chiara', 'Serra', 'chiara.serra@gmail.com', 30, 'Firenze'),
    (10, 'Davide', 'Greco', 'davide.greco@hotmail.com', 29, 'San Romano'),
    (11, 'Alice', 'Mazza', 'alice.mazza@gmail.com', 36, 'Palermo'),
    (12, 'Federico', 'Villa', 'federico.v@gmail.com', 41, 'Catania'),
    (13, 'Alessia', 'Piras', 'alessia.piras@tiscali.it', 25, 'Cagliari'),
    (14, 'Lorenzo', 'Ferri', 'lorenzo.ferri@gmail.com', 39, 'Bari'),
    (15, 'Matteo', 'Rinaldi', 'matteo.r@gmail.com', 33, 'ROMA'),
    (16, 'Angelo', 'Leone', 'angelo.leone@outlook.it', 48, 'Venezia'),
    (17, 'Sara', 'Longo', 'sara.longo@gmail.com', 27, 'Trieste'),
    (18, 'Arturo', 'Parodi', 'arturo.p@gmail.com', 35, 'Romagnano al Monte'),
    (19, 'Elena', 'Monti', 'elena.monti@virgilio.it', 37, 'Perugia'),
    (20, 'Adriano', 'Testa', 'adriano.testa@gmail.com', 30, 'Ancona');

-- 1. Clienti con email su dominio Gmail (@gmail.com)
SELECT * FROM Clienti WHERE email LIKE '%@gmail.com';

-- 2. Clienti con il nome che inizia con la lettera 'A'
SELECT * FROM Clienti WHERE nome LIKE 'A%';

-- 3. Clienti con cognome lungo ESATTAMENTE 5 lettere (5 trattini bassi)
SELECT * FROM Clienti WHERE cognome LIKE '_____';

-- 4. Clienti con età compresa tra 30 e 40 anni (estremi inclusi)
SELECT *
FROM Clienti
WHERE
    eta BETWEEN 30 AND 40
ORDER BY eta ASC;

-- 5. Clienti che abitano in una città che contiene la parola 'roma' (es. Roma, Guidonia Montecelio...)
SELECT * FROM Clienti WHERE citta LIKE '%roma%';

-- ==============================================================================
-- SLIDE 54/55- Esercizio sui comandi SQL:JOIN - INNER JOIN / LEFT JOIN / RIGHT JOIN / FULL JOIN
-- Tabella:  CLIENTI e ORDINI
-- ==============================================================================

--Si considerino le seguenti due tabelle  con 20 dati l’una:

Clienti (
    id INT,
    nome VARCHAR(100),
    città VARCHAR(100)
) Ordini (
    id INT,
    id_cliente INT,
    data_ordine DATE,
    importo DECIMAL(7, 2)
)

CREATE DATABASE IF NOT EXISTS negozio;

USE negozio;

DROP TABLE IF EXISTS Clienti;

CREATE TABLE Clienti (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    cognome VARCHAR(100),
    email VARCHAR(100),
    eta INT,
    citta VARCHAR(100)
);

-- Inserimento di 20 record
INSERT INTO
    Clienti (id, nome, citta)
VALUES ('1', 'Mario', 'Roma'),
    ('2', 'Anna', 'Milano'),
    ('3', 'Marco', 'Torino'),
    ('4', 'Giulia', 'Firenze'),
    ('5', 'Luca', 'Napoli'),
    ('6', 'Sara', 'Bologna'),
    ('7', 'Davide', 'Torino'),
    ('8', 'Chiara', 'Firenze'),
    ('9', 'Simone', 'Napoli'),
    ('10', 'Elena', 'Bologna'),
    ('11', 'Francesco', 'Roma'),
    ('12', 'Alessia', 'Milano'),
    ('13', 'Roberto', 'Torino'),
    ('14', 'Simona', 'Firenze'),
    ('15', 'Andrea', 'Napoli'),
    ('16', 'Martina', 'Bologna'),
    ('17', 'Alessandro', 'Roma'),
    ('18', 'Federica', 'Milano'),
    ('19', 'Giorgio', 'Torino'),
    ('20', 'Laura', 'Firenze');

INSERT INTO
    Ordini (id, id_cliente, data_ordine, importo)
VALUES ('1', '1', '2024-01-15', 100.00),
    ('2', '2', '2024-01-15', 200.00),
    ('3', '3', '2024-01-15', 300.00),
    ('4', '4', '2024-01-15', 400.00),
    ('5', '5', '2024-01-15', 500.00),
    ('6', '6', '2024-01-15', 600.00),
    ('7', '7', '2024-01-15', 700.00),
    ('8', '8', '2024-01-15', 800.00),
    ('9', '9', '2024-01-15', 900.00),
    ('10', '10', '2024-01-15', 1000.00),
    ('11', '11', '2024-01-15', 1100.00),
    ('12', '12', '2024-01-15', 1200.00),
    ('13', '13', '2024-01-15', 1300.00),
    ('14', '14', '2024-01-15', 1400.00),
    ('15', '15', '2024-01-15', 1500.00),
    ('16', '16', '2024-01-15', 1600.00),
    ('17', '17', '2024-01-15', 1700.00),
    ('18', '18', '2024-01-15', 1800.00),
    ('19', '19', '2024-01-15', 1900.00),
    ('20', '20', '2024-01-15', 2000.00);

-- 1. Clienti Attivi (INNER JOIN + GROUP BY): chi ha speso e quanto
SELECT
    c.id AS IdCliente,
    c.nome,
    c.cognome,
    COUNT(o.id) AS NumeroOrdini,
    SUM(o.importo) AS TotaleSpeso
FROM Clienti_Ordini c
    INNER JOIN Ordini o ON c.id = o.id_cliente
GROUP BY
    c.id,
    c.nome,
    c.cognome;
-- 2. Clienti Inattivi (LEFT JOIN con WHERE o.id IS NULL): chi non ha mai comprato nulla
SELECT c.id, c.nome, c.cognome, c.email
FROM Clienti_Ordini c
    LEFT JOIN Ordini o ON c.id = o.id_cliente
WHERE
    o.id IS NULL;
-- 3. Ordini Orfani (RIGHT JOIN con WHERE c.id IS NULL): acquisti senza cliente associato
SELECT o.id AS IdOrdine, o.data_ordine, o.importo, o.id_cliente
FROM Clienti_Ordini c
    RIGHT JOIN Ordini o ON c.id = o.id_cliente
WHERE
    c.id IS NULL;