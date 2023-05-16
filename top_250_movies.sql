

-- Everything
ALTER TABLE `miniproject`.`top_250_movies` 
CHANGE COLUMN `starring` `cast` TEXT NULL DEFAULT NULL ;

SELECT *
FROM
    top_250_movies;


-- Update table -- For Reference
ALTER TABLE top_250_movies
ADD COLUMN cast VARCHAR(255),
ADD COLUMN genre VARCHAR(255);

UPDATE top_250_movies
SET casting = CONCAT_WS(', ', cast1, cast2),
    genre = CONCAT_WS(', ', NULLIF(genre1, ''), NULLIF(genre2, ''), NULLIF(genre3, ''));

ALTER TABLE top_250_movies
DROP COLUMN cast1,
DROP COLUMN cast2,
DROP COLUMN genre1,
DROP COLUMN genre2,
DROP COLUMN genre3;

UPDATE top_250_movies
SET cast = REPLACE(cast, ', ', ',');
	


-- Count occurence of each genre

SELECT genre,
       COUNT(*) AS genre_count,
       FORMAT((COUNT(*) / (SELECT COUNT(*) FROM top_250_movies)) * 100, 2) AS occurence_in_250movies,
       ROUND(AVG(rating), 2) AS avg_rating
FROM (
  SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genre, ',', numbers.n), ',', -1)) AS genre
  FROM (
    SELECT genre,
           CASE WHEN LENGTH(genre) - LENGTH(REPLACE(genre, ',', '')) + 1 > 1
                THEN 1 + LENGTH(genre) - LENGTH(REPLACE(genre, ',', ''))
                ELSE 1
           END AS genre_count
    FROM top_250_movies
  ) AS movies
  CROSS JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
  ) AS numbers
  WHERE genre_count >= numbers.n
) AS genre_counts
GROUP BY genre
ORDER BY genre_count DESC;

-- Modified GENRE version of the above with for functionality -- GREAT!!!
SELECT 
    genre,
    COUNT(*) AS genre_count,
    FORMAT((COUNT(*) / (SELECT COUNT(*) FROM top_250_movies)) * 100, 2) AS occurrence_in_250movies,
    ROUND(AVG(rating), 2) AS avg_rating
FROM (
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genre, ',', numbers.n), ',', -1)) AS genre,
        rating
    FROM top_250_movies
    CROSS JOIN (
        SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
    ) AS numbers
    WHERE LENGTH(genre) - LENGTH(REPLACE(genre, ',', '')) + 1 >= numbers.n
) AS cast_counts
GROUP BY genre
ORDER BY genre_count DESC;




-- Count occurence of each cast 
DROP TABLE IF EXISTS temp_table;
SELECT 
    cast,
    COUNT(*) AS cast_count,
    FORMAT((COUNT(*) / (SELECT COUNT(*) FROM top_250_movies)) * 100, 2) AS occurence_in_250movies
FROM (
  SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', numbers.n), ',', -1)) AS cast,
			ROUND(AVG(rating), 2) AS avg_rating
  FROM (
    SELECT cast,
           CASE WHEN LENGTH(cast) - LENGTH(REPLACE(cast, ',', '')) + 1 > 1
                THEN 1 + LENGTH(cast) - LENGTH(REPLACE(cast, ',', ''))
                ELSE 1
           END AS cast_count
    FROM top_250_movies
  ) AS movies
  CROSS JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
  ) AS numbers
  WHERE cast_count >= numbers.n
) AS cast_counts
GROUP BY cast
ORDER BY cast_count DESC;

-- Modified CAST version of the above with for functionality -- GREAT!!!
SELECT 
    cast,
    COUNT(*) AS cast_count,
    FORMAT((COUNT(*) / (SELECT COUNT(*) FROM top_250_movies)) * 100, 2) AS occurrence_in_250movies,
    ROUND(AVG(rating), 2) AS avg_rating
FROM (
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', numbers.n), ',', -1)) AS cast,
        rating
    FROM top_250_movies
    CROSS JOIN (
        SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
    ) AS numbers
    WHERE LENGTH(cast) - LENGTH(REPLACE(cast, ',', '')) + 1 >= numbers.n
) AS cast_counts
GROUP BY cast
ORDER BY cast_count DESC;






-- Directors who have more than 4 high rating movies
SELECT director, count(director) as cnt_dir 
FROM top_250_movies
GROUP BY director
-- HAVING count(director) > 4
ORDER BY cnt_dir DESC
LIMIT 10;

-- Best movies of X director

SELECT director, title, rating, cast, genre
FROM top_250_movies
WHERE director IN (
    SELECT t.director
    FROM (
        SELECT COUNT(director) AS cnt_dir, director
        FROM top_250_movies
        GROUP BY director
        HAVING COUNT(director) > 2
    ) AS t
)
GROUP BY director
ORDER BY COUNT(director) DESC
LIMIT 10;

-- Average ratings of Directors who have the most high-rating movies
SELECT 
    t.director, 
    COUNT(director) as cnt_dir, 
    ROUND(AVG(t.rating), 2) AS avg_rating
FROM
    (SELECT director, rating FROM top_250_movies
    WHERE director IN (SELECT director FROM top_250_movies
						GROUP BY director
						HAVING COUNT(director) >=1)) AS t
GROUP BY t.director
ORDER BY avg_rating DESC
LIMIT 10;

-- Best movies of X actor
SELECT *
FROM top_250_movies
WHERE genre like "%sci-fi%"


