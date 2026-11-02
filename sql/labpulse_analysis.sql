
-- =====================================================
-- LabPulse: Laboratory Operations Analytics
-- SQL Analysis
-- Database: labpulse
-- Delay threshold: 180 minutes (exploratory)
-- =====================================================

USE labpulse;


-- 1. DATA OVERVIEW

SELECT
    COUNT(*) AS total_samples,
    COUNT(DISTINCT patient_id) AS unique_patients,
    COUNT(DISTINCT test_name) AS unique_tests
FROM lab_results;


-- 2. DATA QUALITY CHECKS

-- Missing values in important fields
SELECT
    SUM(collection_time IS NULL) AS missing_collection_time,
    SUM(result_time IS NULL) AS missing_result_time,
    SUM(tat_minutes IS NULL) AS missing_tat
FROM lab_results;

-- Invalid or negative TAT
SELECT COUNT(*) AS invalid_tat_records
FROM lab_results
WHERE tat_minutes IS NULL
   OR tat_minutes < 0;

-- Duplicate event IDs
SELECT
    COUNT(*) - COUNT(DISTINCT event_id) AS duplicate_event_ids
FROM lab_results;


-- 3. OVERALL TAT ANALYSIS

SELECT
    COUNT(*) AS total_samples,
    ROUND(AVG(tat_minutes), 2) AS average_tat,
    ROUND(MIN(tat_minutes), 2) AS minimum_tat,
    ROUND(MAX(tat_minutes), 2) AS maximum_tat
FROM lab_results;


-- 4. DELAY ANALYSIS

SELECT
    COUNT(*) AS total_samples,

    SUM(CASE
        WHEN tat_minutes >= 180 THEN 1
        ELSE 0
    END) AS delayed_samples,

    ROUND(
        100.0 * SUM(CASE
            WHEN tat_minutes >= 180 THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS delay_percentage

FROM lab_results;


-- 5. TAT BY TEST NAME

SELECT
    test_name,
    COUNT(*) AS total_samples,
    ROUND(AVG(tat_minutes), 2) AS average_tat,
    ROUND(AVG(CASE
        WHEN tat_minutes >= 180 THEN 1.0
        ELSE 0.0
    END) * 100, 2) AS delay_percentage

FROM lab_results
GROUP BY test_name
ORDER BY average_tat DESC;


-- 6. TAT BY WEEKDAY

SELECT
    day_of_week,
    COUNT(*) AS total_samples,
    ROUND(AVG(tat_minutes), 2) AS average_tat

FROM lab_results
GROUP BY day_of_week
ORDER BY average_tat DESC;


-- 7. TAT BY COLLECTION HOUR

SELECT
    collection_hour,
    COUNT(*) AS total_samples,
    ROUND(AVG(tat_minutes), 2) AS average_tat

FROM lab_results
GROUP BY collection_hour
ORDER BY collection_hour;


-- 8. WORKLOAD BY COLLECTION HOUR

SELECT
    collection_hour,
    COUNT(*) AS sample_workload

FROM lab_results
GROUP BY collection_hour
ORDER BY collection_hour;


-- 9. DELAY RATE BY WEEKDAY AND COLLECTION HOUR

SELECT
    day_of_week,
    collection_hour,
    COUNT(*) AS total_samples,

    SUM(CASE
        WHEN tat_minutes >= 180 THEN 1
        ELSE 0
    END) AS delayed_samples,

    ROUND(
        100.0 * SUM(CASE
            WHEN tat_minutes >= 180 THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS delay_percentage

FROM lab_results
GROUP BY day_of_week, collection_hour
ORDER BY day_of_week, collection_hour;
