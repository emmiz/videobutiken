drop database a11emmjo;

create database a11emmjo;

use a11emmjo;

CREATE TABLE videobutik(
	namn VARCHAR(30),
	adress VARCHAR(30),
	tel VARCHAR(15),
	PRIMARY KEY(namn)
) ENGINE=INNODB;

CREATE TABLE utgivare(
	namn VARCHAR(30),
	tel VARCHAR(15),
	PRIMARY KEY(namn)
) ENGINE=INNODB;

CREATE TABLE kund(
	pNr VARCHAR(11),
	namn VARCHAR(30),
	tel VARCHAR(15),
	omdöme VARCHAR(150),
	PRIMARY KEY(pNr)
) ENGINE=INNODB;

CREATE TABLE inkassofirma(
	tel VARCHAR(15),
	namn VARCHAR(30) NOT NULL,
	stad VARCHAR(20),
	PRIMARY KEY(tel)
) ENGINE=INNODB;

CREATE TABLE anstalld(
	aNr CHAR(5),
	namn VARCHAR(30) NOT NULL,
	lon INT(5),
	chef CHAR(5),		--Denna har samma typ som aNr eftersom det är aNr från samma tabell som kommer att länkas hit.
	PRIMARY KEY(aNr),
	FOREIGN KEY(chef) REFERENCES anstalld(aNr)
) ENGINE=INNODB;

CREATE TABLE kampanj(
	namn VARCHAR(30),
	veckoNr INT(2),
	aNr CHAR(5),
	PRIMARY KEY(namn),
	FOREIGN KEY(aNr) REFERENCES anstalld(aNr)
) ENGINE=INNODB;

CREATE TABLE jobbar(
	butiksnamn VARCHAR(30),
	aNr CHAR(5),
	PRIMARY KEY(butiksnamn,aNr),
	FOREIGN KEY(butiksnamn) REFERENCES videobutik(namn),
	FOREIGN KEY(aNr) REFERENCES anstalld(aNr)
) ENGINE=INNODB;

CREATE TABLE film(
	titel VARCHAR(50),
	langd INT(3),
	kategori VARCHAR(20),
	utgivarNamn VARCHAR(30),
	PRIMARY KEY(titel),
	FOREIGN KEY(utgivarNamn) REFERENCES utgivare(namn)
) ENGINE=INNODB;

CREATE TABLE filmEx(
	exNr CHAR(3),
	typ VARCHAR(7),
	pris INT(2),
	butiksnamn VARCHAR(30),
	titel VARCHAR(50),
	PRIMARY KEY(exNr,butiksnamn,titel),
	FOREIGN KEY(butiksnamn) REFERENCES videobutik(namn),
	FOREIGN KEY(titel) REFERENCES film(titel)
) ENGINE=INNODB;

CREATE TABLE ingar(
	kampanjnamn VARCHAR(30),
	filmtitel VARCHAR(50),
	PRIMARY KEY(kampanjnamn,filmtitel),
	FOREIGN KEY(kampanjnamn) REFERENCES kampanj(namn),
	FOREIGN KEY(filmtitel) REFERENCES film(titel)
) ENGINE=INNODB;

CREATE TABLE hylla(
	hyllNr CHAR(3),
	butiksnamn VARCHAR(30),
	PRIMARY KEY(hyllNr,butiksnamn),
	FOREIGN KEY(butiksnamn) REFERENCES videobutik(namn)
) ENGINE=INNODB;

CREATE TABLE finns(
	hyllNr CHAR(3),
	butiksnamn VARCHAR(30),
	exNr CHAR(3),
	agarbutik VARCHAR(30),
	filmtitel VARCHAR(50),
	PRIMARY KEY(hyllNr,butiksnamn,exNr,agarbutik,filmtitel),
	FOREIGN KEY(hyllNr,butiksnamn) REFERENCES hylla(hyllNr,butiksnamn),
	FOREIGN KEY(exNr,agarbutik,filmtitel) REFERENCES filmEx(exNr,butiksnamn,titel)
) ENGINE=INNODB;

CREATE TABLE uthyrning(
	utDatum datetime,
	aterDatum datetime NOT NULL,
	tillbaka datetime,
	pNr VARCHAR(11),
	exNr CHAR(3),
	agarbutik VARCHAR(30),
	filmtitel VARCHAR(50),
	inkassoTel VARCHAR(15),
	PRIMARY KEY(utDatum,pNr,exNr,agarbutik,filmtitel,inkassoTel),
	FOREIGN KEY(pNr) REFERENCES kund(pNr),
	FOREIGN KEY(exNr,agarbutik,filmtitel) REFERENCES filmEx(exNr,butiksnamn,titel),
	FOREIGN KEY(inkassoTel) REFERENCES inkassofirma(tel)
) ENGINE=INNODB;


insert into videobutik(namn,adress,tel) values('Vipp-video','Skaragatan 5, Lidköping','0510-12345');
insert into videobutik(namn,adress,tel) values('Axvallsgrillen','Granstigen 7, Axvall','0511-14745');
insert into videobutik(namn,adress,tel) values('Åkes Video','Marumsgatan 23, Skara','0511-27345');
insert into videobutik(namn,adress,tel) values('All-Video','Källegatan 2, Skara','0511-54115');
insert into videobutik(namn,adress,tel) values('Hemmavideo','Storgatan 33, Skövde','0500-50045');

insert into anstalld(aNr,namn,lon,chef) values('31366','Bosse Lindqvist','36000',NULL);			-- Chef på Vipp-video.
insert into anstalld(aNr,namn,lon,chef) values('87231','Biff Lindström','8420','31366');
insert into anstalld(aNr,namn,lon,chef) values('38065','Angela Bly','23000',NULL);			-- Chef på Axvallsgrillen.
insert into anstalld(aNr,namn,lon,chef) values('66633','Ulf Bertilsson','13465','38065');
insert into anstalld(aNr,namn,lon,chef) values('57440','Annika Bengtsson','34200',NULL);		-- Chef på Hemmavideo
insert into anstalld(aNr,namn,lon,chef) values('35440','Robert Persson','28100',NULL);			-- Chef på All-Video
insert into anstalld(aNr,namn,lon,chef) values('21157','Åke Edvinsson','21700',NULL);			-- Chef på Åkes Video
insert into anstalld(aNr,namn,lon,chef) values('21158','Test Testsson','11500',38065);

insert into jobbar(butiksnamn,aNr) values('Vipp-video','31366');					-- Bosse Lindqvist
insert into jobbar(butiksnamn,aNr) values('Vipp-video','87231');					-- Biff Lindström
insert into jobbar(butiksnamn,aNr) values('Axvallsgrillen','38065');					-- Angela Bly
insert into jobbar(butiksnamn,aNr) values('Axvallsgrillen','66633');					-- Ulf Bertilsson
insert into jobbar(butiksnamn,aNr) values('Hemmavideo','57440');					-- Annika Bengtsson
insert into jobbar(butiksnamn,aNr) values('All-Video','35440');						-- Robert Persson
insert into jobbar(butiksnamn,aNr) values('Åkes Video','21157');					-- Åke Edvinsson

insert into kampanj(namn,veckoNr,aNr) values('Vinterruset','48','66633');
insert into kampanj(namn,veckoNr,aNr) values('Sommarrullen','26','87231');
insert into kampanj(namn,veckoNr,aNr) values('Halloween','44','21157');
insert into kampanj(namn,veckoNr,aNr) values('Påskägg','14','21157');
insert into kampanj(namn,veckoNr,aNr) values('Sweethearts','7','38065');

insert into utgivare(namn,tel) values('Östproduktion','0978-54321');
insert into utgivare(namn,tel) values('Vaniljrelease','0687-23472');
insert into utgivare(namn,tel) values('Film i Väst','0520-357400');
insert into utgivare(namn,tel) values('Svensk Film','08-353535');
insert into utgivare(namn,tel) values('Warner Bros','08-220000');

insert into film(titel,langd,kategori,utgivarNamn) values('Sigges Sommar','97','romantik','Östproduktion');
insert into film(titel,langd,kategori,utgivarNamn) values('Hårda puckar','62','sport','Östproduktion');
insert into film(titel,langd,kategori,utgivarNamn) values('Mopedjakten','84','action','Vaniljrelease');
insert into film(titel,langd,kategori,utgivarNamn) values('Festival','73','komedi','Film i Väst');
insert into film(titel,langd,kategori,utgivarNamn) values('Omen III','95','skräck','Warner Bros');
insert into film(titel,langd,kategori,utgivarNamn) values('November rain','81','drama','Warner Bros');
insert into film(titel,langd,kategori,utgivarNamn) values('Pippi Långstrump på de sju haven','53','tecknat','Svensk Film');

insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('111','DVD','48','Axvallsgrillen','Sigges Sommar');
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('122','DVD','48','Axvallsgrillen','Sigges Sommar');
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('133','DVD','48','Axvallsgrillen','Sigges Sommar');
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('442','Bluray','78','Axvallsgrillen','Sigges Sommar');		-- ? Vem äger filmen ?
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('443','Bluray','78','Axvallsgrillen','Sigges Sommar');		-- ? Vem äger filmen ?
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('671','VHS','29','Vipp-video','Hårda puckar');			-- ? Vem äger filmen ?
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('900','DVD','35','Vipp-video','Mopedjakten');
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('901','DVD','35','Vipp-video','Mopedjakten');
insert into filmEx(exNr,typ,pris,butiksnamn,titel) values('902','DVD','35','Vipp-video','Mopedjakten');

insert into hylla(hyllNr,butiksnamn) values('114','Axvallsgrillen');
insert into hylla(hyllNr,butiksnamn) values('115','Axvallsgrillen');								-- ? Vart står hyllan ?
insert into hylla(hyllNr,butiksnamn) values('114','Vipp-video');
-- insert into hylla(hyllNr,butiksnamn) values('','');
-- insert into hylla(hyllNr,butiksnamn) values('','');

insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('114','Axvallsgrillen','111','Axvallsgrillen','Sigges Sommar');
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('114','Axvallsgrillen','122','Axvallsgrillen','Sigges Sommar');
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('114','Axvallsgrillen','133','Axvallsgrillen','Sigges Sommar');
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('115','Axvallsgrillen','442','Axvallsgrillen','Sigges Sommar');	-- ? Stämmer ägaren ?
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('115','Axvallsgrillen','443','Axvallsgrillen','Sigges Sommar');	-- ? Stämmer ägaren ?
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('114','Vipp-video','900','Vipp-video','Mopedjakten');		-- ? Stämmer exNr?
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('114','Vipp-video','901','Vipp-video','Mopedjakten');		-- ? Stämmer exNr?
insert into finns(hyllNr,butiksnamn,exNr,agarbutik,filmtitel) values('114','Vipp-video','902','Vipp-video','Mopedjakten');		-- ? Stämmer exNr?

insert into kund(pNr,namn,tel,omdöme) values('920128-5884','Josse Björk',NULL,'Pålitlig');						-- ? Tel ?
insert into kund(pNr,namn,tel,omdöme) values('670723-5835','Björn Bark','0788-883212','Stamkund');
insert into kund(pNr,namn,tel,omdöme) values('780419-5945','Karin Andersson','0511-252142','Ofta sen');
insert into kund(pNr,namn,tel,omdöme) values('911025-6004','Matilda Rosenqvist','0707-352565','Pålitlig');
insert into kund(pNr,namn,tel,omdöme) values('860619-3576','Nicklas Bengtsson','0707-113145','Slarver');
insert into kund(pNr,namn,tel,omdöme) values('8112241234','Rudolf Andersson','0707-571919','Ny');
insert into kund(pNr,namn,tel,omdöme) values('87112112345','Oscar Bengtsson','0707-447192','Ny');

insert into inkassofirma(tel,namn,stad) values('0533-34577','Inkasso AB','Stöpen');
insert into inkassofirma(tel,namn,stad) values('00326-573892','Grå & Trist','Varola');
insert into inkassofirma(tel,namn,stad) values('0511-77400','Torpeden','Skara');
insert into inkassofirma(tel,namn,stad) values('011-220000','Help','Emmaboda');
-- insert into inkassofirma(tel,namn,stad) values('','','');

insert into uthyrning(utDatum,aterDatum,tillbaka,pNr,exNr,agarbutik,filmtitel,inkassoTel) values('2012-01-12 18:01:00','2012-01-13 18:00:00','2012-01-13 17:59:00','920128-5884','442','Axvallsgrillen','Sigges Sommar','00326-573892');	-- ? Påhittat återdatum ?
insert into uthyrning(utDatum,aterDatum,tillbaka,pNr,exNr,agarbutik,filmtitel,inkassoTel) values('2012-02-16 12:34:00','2012-02-20 18:00:00',NULL,'670723-5835','671','Vipp-video','Hårda puckar','0533-34577');
insert into uthyrning(utDatum,aterDatum,tillbaka,pNr,exNr,agarbutik,filmtitel,inkassoTel) values('2012-01-12 17:00:00','2012-01-16 18:00:00','2012-01-13 17:59:00','670723-5835','442','Axvallsgrillen','Sigges Sommar','00326-573892');	-- Detta är inte en möjlig rad då filmen hyrs ut samtidigt som ovan, utan ett medvetet fel!
insert into uthyrning(utDatum,aterDatum,tillbaka,pNr,exNr,agarbutik,filmtitel,inkassoTel) values('2012-04-19 15:01:23','2012-04-24 18:00:00','2012-04-30 16:23:15','780419-5945','900','Vipp-video','Mopedjakten','0533-34577');
insert into uthyrning(utDatum,aterDatum,tillbaka,pNr,exNr,agarbutik,filmtitel,inkassoTel) values('2012-05-08 19:57:12','2012-05-12 18:00:00','2012-05-10 12:13:27','860619-3576','902','Vipp-video','Mopedjakten','0511-77400');

insert into ingar(kampanjnamn,filmtitel) values('Sweethearts','Sigges Sommar');
insert into ingar(kampanjnamn,filmtitel) values('Halloween','Omen III');
insert into ingar(kampanjnamn,filmtitel) values('Sommarrullen','Festival');
insert into ingar(kampanjnamn,filmtitel) values('Påskägg','Pippi Långstrump på de sju haven');
insert into ingar(kampanjnamn,filmtitel) values('Vinterruset','Mopedjakten');


-- 1. Hämta staden som inkassofirman med nummer 00326573892 kommer ifrån.

	-- Detta tar jag reda på genom att kolla i tabellen som innehåller all info om inkassofirmor och sedan kontrollerar värdet för attributet stad på samma rad som värdet på attributet tel är 00326573892.
	-- OBS! Då jag använt bindestreck i telnr i tabellen lägger jag till det i frågan för att få ut mitt svar.

	SELECT stad
	FROM inkassofirma
	WHERE tel='00326-573892';

-- 2. Hämta namn på videobutiken som den anställde med anställningsnummer 31366 arbetar på.

	-- Detta tar jag reda på genom att kolla i tabellen jobbar och sedan kontrollerar jag värdet för attributet butiksnamn på raden där attributet aNr är 31366.

	SELECT butiksnamn
	FROM jobbar
	WHERE aNr='31366';

-- 3. Hämta namn och telefonnummer på den utgivare som ger ut filmen Sigges Sommar.

	-- Detta tar jag reda på genom att JOINA tabellerna utgivare och film.

	SELECT utgivare.namn, utgivare.tel
	FROM utgivare, film
	WHERE film.titel='Sigges Sommar' AND film.utgivarNamn=utgivare.namn;

-- 4. Hämta namnet på videobutiken där den som ansvarar för kampanjen Vinterruset arbetar.

	-- Först plockar jag fram raden i tabellen kampanj där namn är Vinterruset och då får jag fram anställningsnr på den som är ansvarig. Sedan JOINAR jag tabellerna kampanj och jobbar och får då fram raden som säger att samma anställningsnr som tidigare jobbar på... 

	SELECT jobbar.butiksnamn
	FROM kampanj,jobbar
	WHERE kampanj.namn='Vinterruset' AND kampanj.aNr=jobbar.aNr;

-- 5. Hämta namnet på kampanjen där filmen Hårda puckar ingår.

	-- För att få fram detta frågar jag tabellen ingar nedanstående fråga, men eftersom Hårda puckar inte ingår i en kampanj kommer inget svar att ges.
	-- OBS! Jag har dock testat med en annan film så att frågan fungerar.

	SELECT kampanjnamn
	FROM ingar
	WHERE filmtitel='Hårda puckar';

-- 6. Hämta filmexemplaren som kostar exakt lika mycket att hyra. (Tips: skapa instanser av samma tabell och jämför dess pris.)

	-- För att få fram detta måste jag skapa en ny temptabell av filmEx och sedan JOINA den med filmEx-tabellen. Därefter måste jag plocka fram alla rader som har samma värde på attributet pris. Tillsist måste jag plocka bort alla rader som har exakt samma nycklar. Eftersom nycklarna är unika för sin rad tas alla dubletter mellan tabellerna bort.

	SELECT filmEx.exNr,filmEx.titel
	FROM filmEx,  filmEx temp
	WHERE filmEx.pris=temp.pris AND NOT(filmEx.exNr=temp.exNr AND filmEx.butiksnamn=temp.butiksnamn AND filmEx.titel=temp.titel);

-- 7. Hämta namn och personnummer för de kunder som inte lämnat åter sina filmer.

	-- Jag JOINAR tabellerna uthyrning och kund och de rader som innehåller ett NULL-värde på attributet tillbaka skrivs sedan ut.

	SELECT kund.pNr,kund.namn
	FROM uthyrning,kund
	WHERE uthyrning.tillbaka IS NULL AND uthyrning.pNr=kund.pNr;

-- 8. Hämta namn och personnummer för de kunder som inte lämnat tillbaka en film efter 10 dagar från uthyrningsdatum räknat.

	-- Precis som ovan JOINAR jag uthyrning och kund och tar sedan fram de rader där det skiljer mer än 10 dgr mellan tillbakadatumet och uthyrningsdatumet.

	SELECT kund.pNr,kund.namn
	FROM uthyrning,kund
	WHERE DATEDIFF(uthyrning.tillbaka,uthyrning.utDatum)>10 AND uthyrning.pNr=kund.pNr;

-- 9. Visa alla kunder som inte hyrt någon film.

	-- Jag JOINAR tabellerna kund och uthyrning och plockar sedan ut alla rader där pNr i uthyrning och kund inte matchar.

	SELECT kund.pNr,kund.namn
	FROM kund
	WHERE NOT EXISTS(SELECT * FROM uthyrning WHERE uthyrning.pNr=kund.pNr);

-- 10. Lista de kunder som någon gång hyrt en film.

	-- Jag JOINAR tabellerna kund och uthyrning och plockar sedan ut alla rader där pNr i uthyrning och kund matchar. Eftersom Björn Bark kommer att listas 2 ggr iom att han har hyrt film 2 ggr så lägger jag till DISTINCT för att ta bort dublettrader.
	-- OBS! Då detta är en tolkningsfråga, tolkar jag den som motsatsen till frågan ovan.

	SELECT DISTINCT kund.pNr,kund.namn
	FROM kund,uthyrning
	WHERE uthyrning.pNr=kund.pNr;

-- 11. Lista de kunder som har hyrt exakt 2 filmer. (Tips: använd count.)

	-- Först JOINAR jag tabellerna uthyrning och kund precis som ovan och sedan grupperar jag varje rad med samma pNr i en grupp. Därefter kontrollerar jag om gruppen innehåller 2 rader. Gör den det skrivs pNr och namn ut på den person som ingår i gruppen.

	SELECT kund.pNr,kund.namn
	FROM uthyrning,kund
	WHERE kund.pNr=uthyrning.pNr
	GROUP BY uthyrning.pNr
	HAVING (COUNT(uthyrning.pNr)=2);

-- 12. Lista alla anställda och sortera namnet i omvänd ordning (Z först, A sist.)

	-- Jag skriver ut alla rader i tabellen anstalld (eftersom WHERE inte finns med, sorteras inget bort) och listar sedan raderna sorterade i fallande ordning (DESC istället ASC som är stigande) utifrån värdet i attributet namn.
	
	SELECT *
	FROM anstalld
	ORDER BY namn DESC;

-- 13. Hämta det genomsnittliga uthyrningspriset för samtliga uthyrningsexemplar.

	-- Jag kör AVG() på pris som är det jag vill beräkna medelvärdet på i tabellen filmEx.
	
	SELECT AVG(pris)
	FROM filmEx;

-- 14. Hämta meddellönen för de anställda på respektive videobutik. (Tips: använd Group by.)

	-- Jag JOINAR anstalld och jobbar och plockar ut de rader där anställd pch jobbar har samma pNr. Jag grupperar sedan efter butiksnamnet och skriver ut varje butik och dess anställdas medellön.

	SELECT jobbar.butiksnamn,AVG(anstalld.lon)
	FROM anstalld,jobbar
	WHERE anstalld.aNr=jobbar.aNr
	GROUP BY jobbar.butiksnamn;
	
-- 15. Hämta medelkostnaden för varje kund som lämnat åter samtliga av sina filmer. (Tips: använd Not exists och is null.)

	-- Först tar jag fram alla kunder som hyrt en film. Sedan alla som inte har några NULL på återlämningstid. Därefter medelvärdet på de filmer som kunden hyrt.

	-- Först JOINAR jag kund och uthyrning för att ta fram alla kunder som alls har hyrt en film. Sedan tar jag bort alla de kunder som inte har lämnat tillbaka ALLA sin filmer. Till sist JOINAR jag de rader jag har kvar i uthyrningstabellen med filmEx grupperar dem på pNr för att få fram medelvärdet för var kund som svar.

	SELECT kund.pNr,kund.namn,AVG(filmEx.pris)
	FROM kund,uthyrning,filmEx
	WHERE kund.pNr=uthyrning.pNr AND NOT EXISTS (SELECT * FROM uthyrning WHERE kund.pNr=uthyrning.pNr AND uthyrning.tillbaka IS NULL) AND uthyrning.exNr=filmEx.exNr
	GROUP BY kund.pNr;

-- 16. Hämta telefonnumret för de inkassofirmor som krävt in filmer från lika många uthyrningar som inkassofirman med telefonnummer 00326573892. (Tips: använd select count(*) = select count(*)).

	-- Först använder jag select count(*) för att ta fram hur många rader som uppfyller villkoret med rätt telnr. Därefter jämför jag detta mot en ny select count(*) som först JOINAR inkassofirma och uthyrning och sedan räknar alla rader som inte har det givna telnr, och om dessa får samma resultat är villkoret sant.

	SELECT inkassofirma.namn,inkassofirma.tel
	FROM inkassofirma
	WHERE ((SELECT COUNT(*) FROM uthyrning WHERE uthyrning.inkassoTel='00326-573892')=(SELECT COUNT(*) FROM uthyrning WHERE inkassofirma.tel=uthyrning.inkassoTel AND uthyrning.inkassoTel!='00326-573892'));

-- 17. Tanken är att ett filmexemplar inte kan bli uthyrd vid två tillfällen under samma tidsintervall. Undersök därför om det finns tidsintervall där ett filmexemplar har blivit uthyrt flera gånger under samma tidsintervall.

	-- Då tipset var att använda sig utav en tempmapp tittade jag först tillbaka på uppgift 6 och konstaterade att jag måste använda NOT för att plocka bort jämförelsen mellan identiska rader med hjälp av alla primärnycklar så jag skrev en NOT(). Därefter ritade jag upp de möjliga alternativen som skulle resultera i det jag sökte på ett papper. Sedan skrev jag de 4 olika alternativen i varsin parentes med ett OR emellan som alltså undersökte varje alternativ jag ville testa och omgav detta tillslut med en parentes. Till sist skrev jag en AND som bad om de rader där exNr och ägarbutiken var detsamma så att jag skulle se att det gällde en unik film som alltså hyrts ut samtidigt till flera.

	SELECT uthyrning.*
	FROM uthyrning, uthyrning temp
	WHERE NOT(uthyrning.utDatum=temp.utDatum AND uthyrning.pNr=temp.pNr AND uthyrning.exNr=temp.exNr AND uthyrning.agarbutik=temp.agarbutik AND uthyrning.filmtitel=temp.filmtitel AND uthyrning.inkassoTel=temp.inkassoTel)
	AND ((temp.utDatum<=uthyrning.utDatum AND temp.tillbaka>uthyrning.utDatum)
	OR (temp.utDatum<uthyrning.tillbaka AND temp.tillbaka>=uthyrning.tillbaka)
	OR (temp.utDatum<=uthyrning.utDatum AND temp.tillbaka>=uthyrning.tillbaka)
	OR (temp.utDatum>=uthyrning.utDatum AND temp.tillbaka<=uthyrning.tillbaka))
	AND uthyrning.exNr=temp.exNr AND uthyrning.agarbutik=temp.agarbutik;

-- 18. Hämta all information om inkassofirmor som kommer från en stad som börjar på “E”.

	-- Villkoret som är att staden skall börja med E tas fram med LIKE och wildcardet % som lägger till 0-fler tecken efter E. Om någon stad i tabellen inkassofirma börja med E skrivs alltså all information i den raden ut.

	SELECT *
	FROM inkassofirma
	WHERE inkassofirma.stad LIKE 'E%';

-- 19. Hämta namn och adress för de kunder som angivit ett personnummer som inte är på formen XXXXXXXXXX där X är en siffra mellan 0 och 9. (Tips: använd rlike eller regxp.)

	-- Då jag inte angivit några adresser för mina kunder väljer jag att istället lista tel. 

	-- Jag använder mig av regexp() som kontrollerar att strängen börjar(^), innehåller(+) och avslutas($) med en siffra. Sedan använder jag length() för att se till att strängen är exakt 10 tecken. Om villkoret är sant för pNr i tabellen kund, listas namn och tel.

	SELECT kund.namn,kund.tel
	FROM kund
	WHERE NOT(kund.pNr REGEXP('^[0-9]+$') AND LENGTH(kund.pNr)=10);

-- 20. Hämta namn och telefonnummer för den kund som har hyrt den dyraste filmen. (Tips: använd max().)

	-- Jag börjar med att JOINA tabellerna uthyrning,filmEx och kund med varandra. Därefter väljer jag ut de rader som har samma pris som det högsta priset i tabellen filmEx vilket räknas ut med hjälp av max() och som dessutom finns med både i tabellen filmEx och uthyrning..

	SELECT kund.namn,kund.tel
	FROM kund,uthyrning,filmEx
	WHERE uthyrning.exNr=filmEx.exNr AND kund.pNr=uthyrning.pNr AND filmEx.pris=(SELECT MAX(filmEx.pris) FROM filmEx,uthyrning WHERE filmEx.exNr=uthyrning.exNr);

-- 21. Hämta namnet på kunden som senast hyrde filmen Sataythai på Vipp‐video.

	-- Jag börjar med att JOINA tabellerna kund och uthyrning. Sedan väljer jag ut de rader där filmtiteln är den efterfrågade och uthyrningsdatumet är det senaste, dvs. det högsta, vilket tas fram med max().

	SELECT kund.namn
	FROM kund,uthyrning
	WHERE kund.pNr=uthyrning.pNr AND uthyrning.filmtitel='Sataythai' AND uthyrning.utDatum=(SELECT MAX(uthyrning.utDatum) FROM uthyrning);

-- 22. Lista de uthyrningar som skett den senaste veckan. (Tips: använd curdate() eller liknande.)

	-- Jag använder date_sub() för att dra av 7 dagar från dagens datum som anges som curdate() och om uthyrningsdatumet är större än datumet för 7 dgr sedan så listas den raden.

	SELECT *
	FROM uthyrning
	WHERE uthyrning.utDatum > date_sub(curdate(), interval 7 day);

-- 23. Höj lönen för alla anställda med en månadslön mellan 10000 och 12000 kr med 22%.

	-- Jag uppdaterar tabellen anställd och där kolumnen lön har ett värde mellan 10000 och 12000 så sätter jag lönen till att bli 22% högre.
	
	UPDATE anstalld
	SET anstalld.lon=anstalld.lon*1.22
	WHERE anstalld.lon>=10000 AND anstalld.lon<=12000;

-- 24. Ta bort exemplaret med nummer 442.

	-- Jag använder kommandot DELETE FROM på exemplartabellen och väljer att ta bort exnr 442. Detta kommer dock inte att fungera eftersom att exNr som i detta fall är en primärnyckel, även är en foreignkey i bl.a. tabellen finns. För att det skall fungera måste alla hänvisningar till det du vill radera, plockas bort.
	
	DELETE FROM filmEx
	WHERE filmEx.exNr='442';

-- 25. Ta bort den anställde med anställningsnummer 31366.

	-- Jag använder kommandot DELETE FROM på anställdtabellen och väljer att ta bort anställningsnummer 31366. Detta kommer dock inte att fungera eftersom att aNr som i detta fall är en primärnyckel, även är en foreignkey i samma tabell då den hänvisar till den chef som den anställde har. För att det skall fungera måste alla hänvisningar till det du vill radera, plockas bort.

	DELETE FROM anstalld
	WHERE anstalld.aNr='31366';