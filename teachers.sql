CREATE DATABASE Stypendia


CREATE TABLE Osoby
(Pesel INT PRIMARY KEY,
Imie CHAR(20) NOT NULL, CHECK (Imie COLLATE Latin1_General_CS_AS LIKE '[A-Z]%'),
Nazwisko CHAR(20) NOT NULL, CHECK (Nazwisko COLLATE Latin1_General_CS_AS LIKE '[A-Z]%'),
Data_urodzenia DATE NOT NULL);


CREATE TABLE Adresy
(ID_adresu INT IDENTITY(1000, 10) PRIMARY KEY,
Ulica CHAR(15) NOT NULL,
Kod_pocztowy CHAR(7) NOT NULL,
Miejscowość CHAR(20) NOT NULL);


CREATE TABLE Uczelnie
(ID_uczelni INT IDENTITY(1,1) PRIMARY KEY,
Typ CHAR(20) NOT NULL,
Ulica CHAR(15) NOT NULL,
Kod_pocztowy CHAR(7) NOT NULL,
Miejscowość CHAR(20) NOT NULL,
Miejsce_w_rankingu TINYINT NULL UNIQUE,
Adres_uczelni INT REFERENCES Adresy (ID_adresu) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Studenci
(Indeks INT NOT NULL UNIQUE CHECK (LEN(Indeks)=6),
Rok_studiow TINYINT NOT NULL,
Srednia FLOAT(5) NOT NULL,
Czy_powtarzal_rok BIT NOT NULL,
Kierunek CHAR(30) NOT NULL CHECK (LEN(Kierunek)>=3),
Pesel INT REFERENCES Osoby ON DELETE CASCADE ON UPDATE CASCADE PRIMARY KEY,
ID_uczelni INT REFERENCES Uczelnie(ID_uczelni));


CREATE TABLE Opiekunowie
(Zawod CHAR(16) NULL,
Dochod_netto MONEY NULL,
Pesel INT REFERENCES Osoby ON DELETE CASCADE ON UPDATE CASCADE PRIMARY KEY,
Pesel_podopiecznego INT REFERENCES Studenci);


CREATE TABLE Wnioski
(Zgoda BIT NULL,
Data_złozenia DATE NOT NULL,
Indeks INT REFERENCES Studenci(Indeks),
ID_wniosku INT IDENTITY(50,10) UNIQUE NOT NULL,
PRIMARY KEY (Indeks, ID_wniosku));


CREATE TABLE Fundacje
(ID_fundacji INT IDENTITY(1,1) PRIMARY KEY,
Data_założenia DATE NULL,
Ulica CHAR(15) NOT NULL,
Kod_pocztowy CHAR(7) NOT NULL,
Miejscowość CHAR(20) NOT NULL,
Adres_fundacji INT REFERENCES Adresy (ID_adresu) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Stypendia
(ID_stypendium INT IDENTITY(200,10) PRIMARY KEY,
 ID_wniosku INT REFERENCES Wnioski(ID_wniosku) UNIQUE NOT NULL,
Potwierdzenie BIT NOT NULL CHECK (Potwierdzenie=0 OR Potwierdzenie=1),
Typ_stypendium CHAR(12) NOT NULL,
ID_fundacji INT REFERENCES Fundacje(ID_fundacji));


CREATE TABLE Wpłaty
(ID_wpłaty INT IDENTITY(50,10) PRIMARY KEY,
Data_wpłaty DATE NOT NULL,
Wysokość_wpłaty MONEY NOT NULL CHECK (Wysokość_wpłaty>=100 AND Wysokość_wpłaty<=2640),
ID_stypendium INT REFERENCES Stypendia(ID_stypendium));




INSERT INTO Osoby
VALUES ('6734582', 'Paweł', 'Wilczur', '1989-09-12'),
('5744582', 'Tymoteusz', 'Tajon', '1987-10-05'),
('2364582', 'Alicja', 'Błędowska', '1999-12-12'),
('7544582', 'Vanessa', 'Bankow', '1996-07-13'),
('3454582', 'Maksymilian', 'Panicz', '2001-05-13'),
('8754582', 'Sara', 'Andegaweńska', '1999-01-01'),
('6754582', 'Wojciech', 'Dobrzycki', '1964-08-01'),
('3434582', 'Henryk', 'Wall', '1995-04-11'),
('2254582', 'Joanna', 'Florek', '2000-03-19'),
('4534582', 'Marek', 'Taneczny', '1987-02-10'),
('7364582', 'Agata', 'Harkness', '1970-09-12'),
('6543545', 'Henryk', 'Rogers', '1987-10-05'),
('8435431', 'Alicja', 'Binko', '1999-12-12'),
('7544581', 'Weronika', 'Putnicka', '1996-07-13'),
('3454581', 'Robert', 'Milik', '2001-04-13'),
('8754581', 'Liwia', 'Andegaweńska', '1999-01-01'),
('6754581', 'Wojciech', 'Karoń', '1964-08-01'),
('3434581', 'Adam', 'Strojeczny', '1995-10-11'),
('2254581', 'Katarzyna', 'Kuczyńska', '2000-03-19'),
('4534581', 'Mirek', 'Takor', '1987-02-10');


INSERT INTO Adresy
VALUES ('Główna', '82-320', 'Milejewo'), 
('Warowna', '12-310', 'Miestno'), 
('Bobra', '82-310', 'Elblag'),
('Bratnia', '82-310', 'Elblag'),
('Natanielska', '83-320', 'Milejewo'),
('Dobra', '12-310', 'Miestno');


INSERT INTO Fundacje
VALUES ('1950-05-05', 'Główna', '82-320', 'Milejewo', '1000'),
('1966-07-08', 'Warowna', '12-310', 'Miestno', '1010');


INSERT INTO Uczelnie  
VALUES ('Uniwersytet', 'Bobra', '82-310', 'Elblag', '2', '1020'), 
('Politechnika', 'Natanielska', '83-320', 'Milejewo', '1', '1040'),
('Politechnika', 'Bratnia', '83-310', 'Elblag', '4', '1030'),
('Szkoła Wyższa', 'Dobra', '12-310', 'Miestno', '3', '1050');


INSERT INTO Studenci
VALUES ('456432', '1', '4.5', '0', 'Informatyka', (SELECT Pesel FROM Osoby WHERE Imie = 'Sara'), '1'),
('582345', '1', '3.5', '1', 'Astrologia', (SELECT Pesel FROM Osoby WHERE Imie = 'Wojciech' AND Nazwisko = 'Dobrzycki'), '3'),
('523436', '5', '4.7', '0', 'Medycyna', (SELECT Pesel FROM Osoby WHERE Imie = 'Henryk' AND Nazwisko = 'Wall'), '4'),
('564366', '3', '4.0', '0', 'Robotyka', (SELECT Pesel FROM Osoby WHERE Imie = 'Joanna'), '4'),
('657432', '2', '4.0', '0', 'Medycyna', (SELECT Pesel FROM Osoby WHERE Imie = 'Marek'), '4'),
('324543', '2', '3.0', '0', 'Robotyka', (SELECT Pesel FROM Osoby WHERE Imie = 'Paweł'), '2'),
('544546', '2', '4.1', '0', 'Informatyka', (SELECT Pesel FROM Osoby WHERE Imie = 'Tymoteusz'), '1'),
('646456', '3', '3.5', '0', 'Astrologia', (SELECT Pesel FROM Osoby WHERE Imie = 'Alicja' AND Nazwisko = 'Błędowska'), '2');


INSERT INTO Opiekunowie
VALUES ('Piekarz', '2000', (SELECT Pesel FROM Osoby WHERE Imie = 'Paweł'), '8754582'),
('Nauczyciel', '2400', (SELECT Pesel FROM Osoby WHERE Imie = 'Tymoteusz'), '8754582'),
('Policjant', '3000', (SELECT Pesel FROM Osoby WHERE Imie = 'Alicja' AND Nazwisko = 'Binko'), '6754582'),
('Nauczyciel', '2400', (SELECT Pesel FROM Osoby WHERE Imie = 'Vanessa'), '6754582'),
('Data Engineer', '3000', (SELECT Pesel FROM Osoby WHERE Imie = 'Maksymilian'), '3434582'),
('Pilkarz', '2000', (SELECT Pesel FROM Osoby WHERE Imie = 'Henryk' AND Nazwisko = 'Rogers'), '2254582'),
('Malarz', '2400', (SELECT Pesel FROM Osoby WHERE Imie = 'Agata'), '4534582'),
('Policjant', '3000', (SELECT Pesel FROM Osoby WHERE Imie = 'Adam'), '6734582'),
('Kucharz', '2400', (SELECT Pesel FROM Osoby WHERE Imie = 'Wojciech' AND Nazwisko = 'Karoń'), '5744582'),
('Lekarz', '3000', (SELECT Pesel FROM Osoby WHERE Imie = 'Mirek'), '2364582');


INSERT INTO Wnioski
VALUES ('1', '2011-05-05', '456432'),
('1', '2011-05-05', '582345'),
('1', '2011-05-05', '523436'),
('1', '2011-05-05', '564366'),
('0', '2011-05-05', '646456');


INSERT INTO Stypendia
VALUES ('50', '1', 'Socjalne', '2'),
('60', '1', 'Rektora', '2'),
('70', '1', 'Socjalne', '1'),
('80', '1', 'Zapomoga', '1');


INSERT INTO Wpłaty
VALUES ('2011-05-06', '1050', '200'),
('2011-06-06', '1040', '200'),
('2011-07-06', '1000', '200'),
('2011-05-07', '2000', '210'),
('2011-06-08', '2000', '210'),
('2011-07-06', '2300', '210'),
('2011-05-06', '1300', '220'),
('2011-06-06', '1500', '220'),
('2011-07-06', '1400', '220'),
('2011-05-06', '500', '230'),
('2011-06-06', '550', '230'),
('2011-07-06', '600', '230');



SELECT * FROM Osoby
SELECT * FROM Opiekunowie
SELECT * FROM Studenci
SELECT * FROM Wnioski
SELECT * FROM Stypendia
SELECT * FROM Wpłaty
SELECT * FROM Uczelnie
SELECT * FROM Fundacje
SELECT * FROM Adresy


UPDATE Adresy SET Miejscowość = 'Kraków' WHERE Miejscowość = 'Miestno'

UPDATE Osoby SET Nazwisko = 'Dobrzycka' WHERE Imie = 'Sara' AND Nazwisko = 'Andegaweńska'

DELETE FROM Adresy WHERE Ulica = 'Natanielska'


SELECT Studenci.indeks, Imie, Rok_studiow, Srednia, Kierunek, Wnioski.ID_wniosku, Stypendia.ID_stypendium
FROM Studenci, Wnioski, Stypendia, Wpłaty, Osoby
WHERE Studenci.Czy_powtarzal_rok='0' AND Studenci.Indeks = Wnioski.Indeks AND Wnioski.ID_wniosku = Stypendia.ID_wniosku 
AND Stypendia.ID_stypendium = Wpłaty.ID_stypendium AND Studenci.Pesel = Osoby.Pesel
ORDER BY Studenci.Indeks DESC
    
	



DROP TABLE Wpłaty
DROP TABLE Stypendia
DROP TABLE Fundacje
DROP TABLE Wnioski
DROP TABLE Opiekunowie
DROP TABLE Studenci
DROP TABLE Osoby
DROP TABLE Uczelnie
DROP TABLE Adresy
