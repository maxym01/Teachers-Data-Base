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


DROP TABLE Wpłaty
DROP TABLE Stypendia
DROP TABLE Fundacje
DROP TABLE Wnioski
DROP TABLE Opiekunowie
DROP TABLE Studenci
DROP TABLE Osoby
DROP TABLE Uczelnie
DROP TABLE Adresy
