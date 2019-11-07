1935179

SELECT score FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE official_title = 'Mud'

SELECT score FROM rating WHERE rating.movie = '1935179'

INSERT INTO rating values(date '2019-11-05', 'Tripadvisor', '1935179', 10, 100, 3.4)

SELECT MAX (score) FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE official_title = 'Mud'

SELECT MIN (score) FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE official_title = 'Mud'

Se vado al cinema e cerco Mud o mud e mi da due risultati diversi è un problema, decidiamo che facciamo o tutto minuscolo o tutto maiuscolo

SELECT MAX (score) FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE LOWER(official_title) = LOWER('MUD')

Un'altra magagna sono gli spazi, se scrivo " mud" non me lo prende, uso la funzione trim che toglie gli spazi, facendo così faccio che sia il valore del database sia ciò che cerco sia tutto minuscolo e senza spazi.
Bisogna ricordarsi che trim toglie gli spazi solo all'inizio o alla fine, se scrivo "Harry_potter" o "Harry__Potter" sono diversi 

SELECT MAX (score) FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE TRIM(LOWER(official_title)) = TRIM(LOWER(' MUD'))

Altri operatori sono:
AVERAGE - per fare la media 
...

Inoltre bisogna ricordarsi i casting ai valori speciali.

Tutto questo va benissimo, noi però dobbiamo definire una procedura che prende in ingresso il valore di un film e restituisce il suo valore massimo 


SELECT MAX (score) FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE TRIM(LOWER(official_title)) = TRIM(LOWER(' M U D'))

fUNZIONE

CREATE OR REPLACE FUNCTION getscore(varchar(200)) RETURNS numeric AS
$$
DECLARE 
top_rating rating.score%TYPE;
BEGIN
SELECT max(score) INTO top_rating FROM movie INNER JOIN rating ON movie.id = rating.movie WHERE trim(lower(official_title)) = trim(lower($1));
RETURN top_rating;
END;
$$
LANGUAGE plpgsql;


