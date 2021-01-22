CREATE TABLE pracownik (
	id bigint primary key auto_increment NOT NULL,
    imie varchar(50) NOT NULL,
    nazwisko varchar(50) NOT NULL,
    stanowisko varchar(200) NOT NULL,
    data_urodzenia date NOT NULL,
    wyplata double NOT NULL
);

INSERT INTO pracownik (imie, nazwisko, stanowisko, data_urodzenia, wyplata) 
VALUES ('Anna', 'Abacka', 'Sekretarka', '1992-05-11', 3000.50),
('Jan', 'Zyga', 'Developer', '1980-09-12', 8000.50),
('Maria', 'Bratek', 'UI', '1988-09-16', 6000.50),
('Genowefa', 'Pigwa', 'Developer', '1996-09-14', 5000.00),
('Marcin', 'Mala', 'Developer', '1985-09-14', 9000.00),
('Nadia', 'Kot', 'Menager','1980-09-14', 15000.00);

UPDATE pracownik SET data_urodzenia='1996-09-14' WHERE id=13;

SELECT * FROM pracownik ORDER BY nazwisko;

SELECT * FROM pracownik WHERE stanowisko='Developer';

SELECT * FROM pracownik WHERE EXTRACT(YEAR FROM data_urodzenia) < 1990;

UPDATE pracownik SET wyplata=wyplata+(wyplata*10/100) WHERE stanowisko='Menager';

SELECT * FROM pracownik ORDER BY data_urodzenia DESC;
DELETE FROM pracownik ORDER BY data_urodzenia DESC LIMIT 1;

DROP TABLE pracownik;


CREATE TABLE stanowisko (
	id_st bigint primary key auto_increment NOT NULL UNIQUE,
    stanowisko varchar(50),
    opis varchar(200),
    wyplata decimal
);

INSERT INTO stanowisko (stanowisko, opis, wyplata) 
VALUES ('Sekretarka', 'opis aaa', 3000.50),
('Developer', 'opis bb', 8000.50),
('UI', 'opis cc', 6000.50),
('Developer', 'opis ddd', 5000.00),
('Developer', 'opis eeee', 9000.00),
('Menager','opis ffff', 15000.00);


CREATE TABLE adres(
	id_ad bigint primary key auto_increment NOT NULL UNIQUE,
    adres varchar(50),
    kod_pocztowy varchar(6) CHECK(kod_pocztowy LIKE '__-__'),
    miejscowosc varchar(50)
);

INSERT INTO adres (adres, kod_pocztowy, miejscowosc) 
VALUES ('Wiejska 13', '05-500', 'Warszawa'),
('Jasminowa 16', '00-100', 'Krakow'),
('Konopowa 10', '04-400', 'Gdansk'),
('Mila 2', '02-500', 'Katowice'),
('Spacerowa 40', '05-550','Warszawa'),
('Kazimierza 80','00-100', 'Krakow');


CREATE TABLE pracownik (
	id_pr bigint primary key auto_increment NOT NULL UNIQUE,
    imie varchar(50),
    nazwisko varchar(50),
    id_ad bigint,
    id_st bigint,
	FOREIGN KEY (id_ad) REFERENCES adres (id_ad) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (id_st) REFERENCES stanowisko (id_st) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO pracownik (imie, nazwisko) 
VALUES ('Anna', 'Abacka'),
('Jan', 'Zyga'),
('Maria', 'Bratek'),
('Marcin', 'Maly'),
('Genowefa', 'Pigwa'),
('Nadia','Kot');

UPDATE pracownik SET id_ad=1  WHERE id_pr=1;
UPDATE pracownik SET id_ad=2  WHERE id_pr=2;
UPDATE pracownik SET id_ad=3  WHERE id_pr=3;
UPDATE pracownik SET id_ad=4  WHERE id_pr=4;
UPDATE pracownik SET id_ad=5  WHERE id_pr=5;
UPDATE pracownik SET id_ad=6  WHERE id_pr=6;

UPDATE pracownik SET id_st=1  WHERE id_pr=1;
UPDATE pracownik SET id_st=2  WHERE id_pr=2;
UPDATE pracownik SET id_st=3  WHERE id_pr=3;
UPDATE pracownik SET id_st=4  WHERE id_pr=4;
UPDATE pracownik SET id_st=5  WHERE id_pr=5;
UPDATE pracownik SET id_st=6  WHERE id_pr=6;

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc,s.stanowisko,s.opis,s.wyplata FROM pracownik p
JOIN adres a ON p.id_ad=a.id_ad
JOIN stanowisko s ON p.id_st=s.id_st;

SELECT SUM(s.wyplata)
FROM pracownik p
JOIN stanowisko s ON p.id_st=s.id_st;

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_ad=a.id_ad WHERE kod_pocztowy LIKE '00-100';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_ad=a.id_ad WHERE kod_pocztowy LIKE '00-%';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_ad=a.id_ad WHERE kod_pocztowy LIKE '[0-9]%-100';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_ad=a.id_ad WHERE kod_pocztowy LIKE '[0-9]_-_00';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_ad=a.id_ad WHERE kod_pocztowy LIKE '[0-9][0-9]-___';

SELECT p.imie, p.nazwisko,a.adres,a.kod_pocztowy,a.miejscowosc FROM pracownik p JOIN adres a ON p.id_ad=a.id_ad WHERE kod_pocztowy LIKE '0_-1%';