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
('70', '1', 'Socjalne', '2'),
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
