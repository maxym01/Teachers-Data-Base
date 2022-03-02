SELECT * FROM Osoby
SELECT * FROM Opiekunowie
SELECT * FROM Studenci
SELECT * FROM Wnioski
SELECT * FROM Stypendia
SELECT * FROM Wpłaty
SELECT * FROM Uczelnie
SELECT * FROM Fundacje
SELECT * FROM Adresy


--1)Sporządź zestawienie studentów (malejąco po indeksie), którzy posiadają średnią ponad 4.0 i nie powtarzają roku oraz sumę ich wysokości wypłat

SELECT Studenci.indeks, Imie, Rok_studiow, Srednia, Kierunek, Wnioski.ID_wniosku, Stypendia.ID_stypendium
    FROM Studenci, Wnioski, Stypendia, Osoby
    WHERE Studenci.Czy_powtarzal_rok='0'
    AND Studenci.Indeks = Wnioski.Indeks 
    AND Wnioski.ID_wniosku = Stypendia.ID_wniosku 
    AND Studenci.Pesel = Osoby.Pesel
    ORDER BY Studenci.Indeks DESC

 SELECT Stypendia.ID_stypendium, SUM(Wysokość_wpłaty) AS "Suma wpłat"
        FROM Stypendia JOIN Wpłaty
        ON Stypendia.ID_stypendium = Wpłaty.ID_stypendium
        GROUP BY Stypendia.ID_stypendium

--opcja dla create view, która nie działa z powodu erroru: CREATE VIEW statement needs to be the only statement in the query batch. Prawdopodobnie jest to kwestia ograniczenia poprzednich zapytań, które wpływają na składnię, prawidłowa struktura:

GO
CREATE VIEW Zestawienie
        AS SELECT Stypendia.ID_stypendium, SUM(Wysokość_wpłaty)
        FROM Stypendia JOIN Wpłaty
        ON Stypendia.ID_stypendium = Wpłaty.ID_stypendium
        GROUP BY Stypendia.ID_stypendium
        WITH CHECK OPTION;

GO
SELECT*
FROM Zestawienie 
DROP VIEW Zestawienie 

--2)Sporządź tabelę, która pokazuje jakie fundacje wypłacają jak duże kwoty stypendiów (średnia).

SELECT Fundacje.ID_fundacji, Data_założenia, Typ_stypendium, Stypendia.ID_stypendium, AVG(Wysokość_wpłaty) AS "Średnia mieśięczna wypłata"
        FROM Fundacje, Stypendia, Wpłaty
        WHERE Fundacje.ID_fundacji = Stypendia.ID_fundacji
        AND Wpłaty.ID_stypendium = Stypendia.ID_stypendium
        GROUP BY Fundacje.ID_fundacji, Data_założenia, Typ_stypendium, Stypendia.ID_stypendium
        ORDER BY ID_fundacji

--3)Uporządkuj uczelnie (malejąco) według ilości studentów uczęszczających do nich i posiadających stypendium socjalne. Obok zestawienie uczelni wg miejsca w rankingu, aby zobaczyć pewną korelację między dwoma faktami.
        
SELECT Uczelnie.ID_uczelni, Typ, COUNT(Uczelnie.ID_uczelni) AS "Liczba_studentów_ze_stypendium"
    FROM Studenci, Uczelnie
    WHERE Studenci.ID_uczelni = Uczelnie.ID_uczelni
    AND EXISTS
        (SELECT Typ_stypendium
        FROM Stypendia, wnioski
        WHERE Typ_stypendium = 'Socjalne'
        AND Wnioski.Indeks = Studenci.Indeks
        AND Stypendia.ID_wniosku = Wnioski.ID_wniosku)
    GROUP BY Uczelnie.ID_uczelni, Typ
    ORDER BY Liczba_studentów_ze_stypendium DESC

SELECT Uczelnie.ID_uczelni, Typ, Miejsce_w_rankingu
FROM Uczelnie
ORDER BY Miejsce_w_rankingu

--4)Zestaw sume zarobkow opiekuna/opiekunów wobec przyznawanego świadectwa

SELECT Imie AS "Imię studenta", Studenci.Indeks, SUM(Dochod_netto) AS "Suma dochodu", Wysokość_wpłaty, Data_wpłaty
    FROM Osoby, Opiekunowie, Studenci, Wpłaty
    WHERE Osoby.Pesel = Studenci.Pesel
    AND Opiekunowie.Pesel_podopiecznego = Studenci.Pesel
    AND EXISTS
        (SELECT*
        FROM Stypendia, wnioski
        WHERE Wnioski.Indeks = Studenci.Indeks
        AND Stypendia.ID_wniosku = Wnioski.ID_wniosku
        AND Wpłaty.ID_stypendium = Stypendia.ID_stypendium)
    GROUP BY Imie, Studenci.Indeks, Wysokość_wpłaty, Data_wpłaty

--5)Sporządź zestawienie wszystkich stypendiów, które otrzymują studenci uczelni XXX, dla każdego studenta podaj sumę wszystkich stypendiów, które otrzymuje. Wyniki uporządkuj rosnąco (kwotami).

SELECT Uczelnie.ID_uczelni, Studenci.Indeks, Typ_stypendium, Wysokość_wpłaty, Data_wpłaty
    FROM Uczelnie, Studenci, Stypendia, Wnioski, Wpłaty
    WHERE Studenci.ID_uczelni = Uczelnie.ID_uczelni
    AND Wnioski.Indeks = Studenci.Indeks
    AND Stypendia.ID_wniosku = Wnioski.ID_wniosku
    AND Wpłaty.ID_stypendium = Stypendia.ID_stypendium
    ORDER BY Wysokość_wpłaty, Stypendia.ID_stypendium

--6)Ranking fundacji pod względem liczby sponsorowanych stypendiów

SELECT Fundacje.ID_fundacji, Fundacje.Data_założenia, COUNT(Stypendia.ID_fundacji) AS "Ilość_stypendiów"
FROM Fundacje JOIN Stypendia
ON Fundacje.ID_fundacji = Stypendia.ID_fundacji
GROUP BY Fundacje.ID_fundacji, Fundacje.Data_założenia
ORDER BY Ilość_stypendiów DESC

--7)Sporządź zestawienie wniosków o przyznanie stypendiów, które złożyli studenci uczelni XXX, w przypadku których dochód opiekuna netto wynosi mniej niż 3000 zł. Podaj informacje o dacie złożenia wniosku, czy wniosek został rozpatrzony pozytywnie, o nr. Indeksu studenta, roku studiów, czy powtarzał rok oraz o jego średniej ocen.

SELECT ID_wniosku, Wnioski.Data_złozenia, Wnioski.Zgoda, Studenci.Indeks, Rok_studiow, Czy_powtarzal_rok, Srednia, Uczelnie.ID_uczelni, Typ, Opiekunowie.Dochod_netto
    FROM Wnioski, Studenci, Opiekunowie, Uczelnie
    WHERE Studenci.ID_uczelni = Uczelnie.ID_uczelni
    AND Wnioski.Indeks = Studenci.Indeks
    AND Opiekunowie.Pesel_podopiecznego = Studenci.Pesel
    AND Dochod_netto < 3000
    ORDER BY ID_wniosku

