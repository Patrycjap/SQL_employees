CREATE TABLE pracownik (
	id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    stanowisko VARCHAR(200) NOT NULL,
    data_urodzenia DATE NOT NULL,
    wyplata DOUBLE NOT NULL
);

INSERT INTO pracownik (imie, nazwisko, stanowisko, data_urodzenia, wyplata) 
VALUES ('Anna', 'Abacka', 'Sekretarka', '1992-05-11', 3000.50),
('Jan', 'Zyga', 'Developer', '1980-09-12', 8000.50),
('Maria', 'Bratek', 'UI', '1988-09-16', 6000.50),
('Genowefa', 'Pigwa', 'Developer', '1996-09-14', 5000.00),
('Marcin', 'Mala', 'Developer', '1985-09-14', 9000.00),
('Nadia', 'Kot', 'Menager','1980-09-14', 15000.00);

SELECT * FROM pracownik ORDER BY nazwisko;
SELECT * FROM pracownik WHERE stanowisko='Developer';
SELECT * FROM pracownik WHERE EXTRACT(YEAR FROM data_urodzenia) <= 1990;
UPDATE pracownik SET wyplata=wyplata+(wyplata*1,1) WHERE stanowisko='Menager';
SELECT * FROM pracownik ORDER BY data_urodzenia DESC;
DELETE FROM pracownik ORDER BY data_urodzenia DESC LIMIT 1;
DROP TABLE pracownik;



CREATE TABLE stanowisko (
	id_stanowisko BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    stanowisko VARCHAR(50),
    opis VARCHAR(200),
    wyplata DECIMAL
);

INSERT INTO stanowisko (stanowisko, opis, wyplata) 
VALUES ('Sekretarka', 'opis aaa', 3000.50),
('Developer', 'opis bb', 8000.50),
('UI', 'opis cc', 6000.50),
('Developer', 'opis ddd', 5000.00),
('Developer', 'opis eeee', 9000.00),
('Menager','opis ffff', 15000.00);


CREATE TABLE adres(
	id_adres BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    adres VARCHAR(50),
    kod_pocztowy VARCHAR(6) CHECK(kod_pocztowy LIKE '__-__'),
    miejscowosc VARCHAR(50)
);

INSERT INTO adres (adres, kod_pocztowy, miejscowosc) 
VALUES ('Wiejska 13', '05-500', 'Warszawa'),
('Jasminowa 16', '00-100', 'Krakow'),
('Konopowa 10', '04-400', 'Gdansk'),
('Mila 2', '02-500', 'Katowice'),
('Spacerowa 40', '05-550','Warszawa'),
('Kazimierza 80','00-100', 'Krakow');

CREATE TABLE pracownik (
	id_pracownik BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    id_adres BIGINT,
    id_stanowisko BIGINT,
	FOREIGN KEY (id_adres) REFERENCES adres (id_adres) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (id_stanowisko) REFERENCES stanowisko (id_stanowisko) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO pracownik (imie, nazwisko) 
VALUES ('Anna', 'Abacka'),
('Jan', 'Zyga'),
('Maria', 'Bratek'),
('Marcin', 'Maly'),
('Genowefa', 'Pigwa'),
('Nadia','Kot');

UPDATE pracownik SET id_adres=1  WHERE id_pracownik=1;
UPDATE pracownik SET id_adres=2  WHERE id_pracownik=2;
UPDATE pracownik SET id_adres=3  WHERE id_pracownik=3;
UPDATE pracownik SET id_adres=4  WHERE id_pracownik=4;
UPDATE pracownik SET id_adres=5  WHERE id_pracownik=5;
UPDATE pracownik SET id_adres=6  WHERE id_pracownik=6;

UPDATE pracownik SET id_stanowisko=1  WHERE id_pracownik=1;
UPDATE pracownik SET id_stanowisko=2  WHERE id_pracownik=2;
UPDATE pracownik SET id_stanowisko=3  WHERE id_pracownik=3;
UPDATE pracownik SET id_stanowisko=4  WHERE id_pracownik=4;
UPDATE pracownik SET id_stanowisko=5  WHERE id_pracownik=5;
UPDATE pracownik SET id_stanowisko=6  WHERE id_pracownik=6;

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc,s.stanowisko,s.opis,s.wyplata FROM pracownik p
JOIN adres a ON p.id_adres=a.id_adres
JOIN stanowisko s ON p.id_stanowisko=s.id_stanowisko;

SELECT SUM(s.wyplata)
FROM pracownik p
JOIN stanowisko s ON p.id_stanowisko=s.id_stanowisko;

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_adres=a.id_adres WHERE kod_pocztowy LIKE '00-100';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_adres=a.id_adres WHERE kod_pocztowy LIKE '00-%';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_adres=a.id_adres WHERE kod_pocztowy LIKE '[0-9]%-100';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_adres=a.id_adres WHERE kod_pocztowy LIKE '[0-9]_-_00';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_adres=a.id_adres WHERE kod_pocztowy LIKE '[0-9][0-9]-___';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_adres=a.id_adres WHERE kod_pocztowy LIKE '0_-1%';