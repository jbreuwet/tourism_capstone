-- Finding differences in country lists between main tourism tables and gdp/gdp_per_capita tables

(SELECT UPPER("Country")
FROM gdp_per_capita)
EXCEPT
(SELECT UPPER("Country")
FROM arrivals);

-- Finding differences in country lists between main tourism tables and tourism_gdp table

(SELECT UPPER("Country")
FROM tourism_gdp)
EXCEPT
(SELECT UPPER("Country")
FROM arrivals);

-- Finding differences in country lists between main tourism tables and population table

(SELECT UPPER("Country")
FROM population)
EXCEPT
(SELECT UPPER("Country")
FROM arrivals);

-- Script to form main table to use for analysis

SELECT arrivals."Country" AS "Country",
	arrivals."Year"::int AS "Year",
	REPLACE(NULLIF("Total arrivals", '..'), ',', '') AS "Total Arrivals (K)",
	REPLACE(NULLIF("Tourist", '..'), ',', '') AS "Tourists (K)",
	REPLACE(NULLIF("Excursionists", '..'), ',', '') AS "Excursionists (K)",
	REPLACE(NULLIF("Cruise Passengers", '..'), ',', '') AS "Cruise Passengers (K)",
	REPLACE(NULLIF("Tourism Expenditure", '..'), ',', '') AS "Tourism Expenditure ($M)",
	REPLACE(NULLIF("GDP", 'no data'), '.', '') AS "GDP ($B)",
	REPLACE(NULLIF("GDP Per Capita", 'no data'), '.', '') AS "GDP Per Capita ($)",
	"%GDP" AS "% Tourism GDP",
	REPLACE("Population", ' ', '') AS "Population (K)",
	"Population Density" AS "Population Density (/Km2)"
FROM arrivals
	LEFT JOIN expenditure
	ON arrivals."Country" = expenditure."Country"
	AND arrivals."Year" = expenditure."Year"
	LEFT JOIN gdp
	ON arrivals."Country" = gdp."Country"
	AND arrivals."Year" = gdp."Year"
	LEFT JOIN gdp_per_capita
	ON arrivals."Country" = gdp_per_capita."Country"
	AND arrivals."Year" = gdp_per_capita."Year"
	LEFT JOIN tourism_gdp
	ON arrivals."Country" = tourism_gdp."Country"
	AND arrivals."Year" = tourism_gdp."Year"
	LEFT JOIN population
	ON arrivals."Country" = population."Country"
	AND arrivals."Year" = population."Year";

-- Scripts below analyze main table created above and answer data questions.

-- On average, what are the top 10 most popular tourist destination between 2000 and 2022?

SELECT "Country",
		AVG(NULLIF("Total Arrivals (K)", 'NULL')::float) AS "AVG Arrivals"
FROM main
WHERE ("Year"::int) BETWEEN 2000 AND 2022
GROUP BY "Country"
ORDER BY "AVG Arrivals" DESC;

-- On average, what are the top 10 most popular tourist destinations between 2010 and 2022?

SELECT "Country",
		AVG(NULLIF("Total Arrivals (K)", 'NULL')::float) AS "AVG Arrivals"
FROM main
WHERE ("Year"::int) BETWEEN 2010 AND 2022
GROUP BY "Country"
ORDER BY "AVG Arrivals" DESC;

-- On average, what were the top 10 cruise destinations between 2010 and 2022?

SELECT "Country",
		AVG(NULLIF("Cruise Passengers (K)", 'NULL')::float) AS "AVG Cruise Passengers"
FROM main
WHERE ("Year"::int) BETWEEN 2010 AND 2022
GROUP BY "Country"
ORDER BY "AVG Cruise Passengers" DESC;

-- Which 10 countries had the highest average tourism expenditure between 2010 and 2022?

SELECT "Country",
		AVG(NULLIF("Tourism Expenditure ($M)", 'NULL')::float) AS "AVG Tourism Expenditure"
FROM main
WHERE ("Year"::int) BETWEEN 2010 AND 2022
GROUP BY "Country"
ORDER BY "AVG Tourism Expenditure" DESC;

-- Which 10 countires had the highest average tourism expenditure per tourist between 2010 and 2022?

SELECT "Country",
		AVG((NULLIF("Tourism Expenditure ($M)", 'NULL')::float)/(NULLIF("Total Arrivals (K)", 'NULL')::float)) AS "AVG Tourism Expenditure Per Tourist"
FROM main
WHERE ("Year"::int) BETWEEN 2010 AND 2022
	AND "Total Arrivals (K)" IS NOT NULL
	AND "Tourism Expenditure ($M)" IS NOT NULL
	AND (NULLIF("Total Arrivals (K)", 'NULL')::float) > 0
GROUP BY "Country"
ORDER BY "AVG Tourism Expenditure Per Tourist" DESC;

-- On average, between 2010 and 2022, what countries depend the most and least on their tourism industries? (Filtered countries who had more than 1M average total visitors per year)

SELECT "Country",
		AVG(NULLIF("% Tourism GDP", 'NULL')::float) AS "% Tourism GDP"
FROM main
WHERE ("Year"::int) BETWEEN 2010 AND 2022
GROUP BY "Country"
HAVING AVG(NULLIF("Total Arrivals (K)", 'NULL')::float) > 1000
ORDER BY "% Tourism GDP" DESC;

-- Which countries have the highest growing tourism markets between 2000 and 2022?

WITH growth AS	(SELECT a."Country",
						"2022",
						"2000"
				FROM (SELECT "Country",
							NULLIF("Tourism Expenditure ($M)", 'NULL')::float AS "2022"
					FROM main
					WHERE ("Year"::int) = 2022) AS a
					INNER JOIN (SELECT "Country", 
									NULLIF("Tourism Expenditure ($M)", 'NULL')::float AS "2000"
								FROM main
								WHERE ("Year"::int) = 2000) AS b
					ON a."Country" = b."Country")
SELECT "Country",
		(growth."2022" - growth."2000") AS "Tourism Expenditure Growth"
FROM growth
WHERE growth."2022" IS NOT NULL
	AND growth."2000" IS NOT NULL
GROUP BY "Country",
		growth."2022",
		growth."2000"
ORDER BY "Tourism Expenditure Growth" DESC;

-- Which countries have the highest growing tourism markets between 2010 and 2022?

WITH growth AS	(SELECT a."Country",
						"2022",
						"2010"
				FROM (SELECT "Country",
							NULLIF("Tourism Expenditure ($M)", 'NULL')::float AS "2022"
					FROM main
					WHERE ("Year"::int) = 2022) AS a
					INNER JOIN (SELECT "Country", 
									NULLIF("Tourism Expenditure ($M)", 'NULL')::float AS "2010"
								FROM main
								WHERE ("Year"::int) = 2010) AS b
					ON a."Country" = b."Country")
SELECT "Country",
		(growth."2022" - growth."2010") AS "Tourism Expenditure Growth"
FROM growth
WHERE growth."2022" IS NOT NULL
	AND growth."2010" IS NOT NULL
GROUP BY "Country",
		growth."2022",
		growth."2010"
ORDER BY "Tourism Expenditure Growth" DESC;

