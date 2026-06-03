-- Structure check
SELECT *
FROM ab_test_data_raw
LIMIT 20;

SELECT
	COUNT(*) AS row_ct,
	COUNT(DISTINCT user_id) AS id_ct,
	COUNT(DISTINCT version) AS version_ct
FROM ab_test_data_raw;

-- Completeness check
-- NULL values per column
SELECT
	COUNT(*) FILTER (WHERE user_id IS NULL) AS id_nulls,
	COUNT(*) FILTER (WHERE version IS NULL) AS version_nulls,
	COUNT(*) FILTER (WHERE sum_gamerounds IS NULL) AS gamerounds_nulls,
	COUNT(*) FILTER (WHERE retention_1 IS NULL) AS retention_1_nulls,
	COUNT(*) FILTER (WHERE retention_7 IS NULL) AS retention_7_nulls
FROM ab_test_data_raw;

-- Invalid or impossible values
SELECT *
FROM ab_test_data_raw
WHERE sum_gamerounds < 0
   OR version NOT IN ('gate_30', 'gate_40');
	
-- Basic value range check
SELECT
	MAX(sum_gamerounds),
	MIN(sum_gamerounds)
FROM ab_test_data_raw;

-- Group balance check for sample-ratio-mismatch
SELECT
	version,
	COUNT(*),
	ROUND(COUNT(*) *1.0 / (SELECT COUNT(*) FROM ab_test_data_raw) *100, 2) AS group_pct
FROM ab_test_data_raw
GROUP BY version;

-- Create clean data table with primary key as the last step of validation
CREATE TABLE ab_test AS
SELECT *
FROM ab_test_data_raw;

ALTER TABLE ab_test
ADD PRIMARY KEY (user_id);