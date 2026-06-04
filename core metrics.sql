--Core metrics
--Summary metrics
SELECT
	version,
	COUNT(*) AS users,
	ROUND(avg(sum_gamerounds), 2) AS average_rounds,
	ROUND(avg(retention_1::int), 2) AS retention_1_rate,
	ROUND(avg(retention_7::int), 2) AS retention_7_rate
FROM ab_test
GROUP BY version;

--Computing standard deviation
SELECT
	version,
	COUNT(*) AS users,
	ROUND(stddev_pop(sum_gamerounds), 2) AS stdev_rounds,
	ROUND(stddev_pop(retention_1::int), 2) AS retention_1_stdev,
	ROUND(stddev_pop(retention_7::int), 2) AS retention_7_stdev
FROM ab_test
GROUP BY version;

--Comparing distribution shape
SELECT
	version,
	MIN(sum_gamerounds) AS min_rounds,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS median_rounds,
	ROUND(AVG(sum_gamerounds), 2) AS average_rounds,
	MAX(sum_gamerounds) AS max_rounds
FROM ab_test
GROUP BY version;

--Comparing quartiles
SELECT
	version,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sum_gamerounds) AS q1,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS median,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sum_gamerounds) AS q3
FROM ab_test
GROUP BY version;

SELECT
	version,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sum_gamerounds) AS q1,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS median,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sum_gamerounds) AS q3,
	PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY sum_gamerounds) AS top_10pct,
	PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY sum_gamerounds) AS top_1pct,
	max(sum_gamerounds)
FROM ab_test
GROUP BY version;

--Identifying outlier
SELECT *
FROM ab_test
WHERE sum_gamerounds>3000;