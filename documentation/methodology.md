# LabPulse – Project Methodology

## 1. Project Objective

LabPulse is a healthcare analytics portfolio project designed to analyze synthetic laboratory result data, evaluate turnaround-time patterns, and explore sample workload and delay trends.

## 2. Data Source

The project uses synthetic healthcare data from the Auric Grid Synthetic Hospital Interoperability Environment.

The original dataset contains multiple healthcare event types. Records classified as `lab_result_reported` were selected for the analysis.

- Analyzed records: 70,635
- Analysis unit: Laboratory result record
- Data type: Synthetic

No real patient information is used.

## 3. Data Preparation

Python and Pandas were used to:

- Filter laboratory result records.
- Inspect missing values and data types.
- Convert timestamp fields into datetime format.
- Prepare turnaround-time and time-based analytical fields.
- Create derived fields for collection date, collection hour, weekday, and day type.
- Classify records using an exploratory delay threshold.

## 4. Turnaround Time Calculation

Turnaround time (TAT) represents the time difference between sample collection and result reporting.

It is calculated as:

`TAT (Minutes) = Result Time - Collection Time`

The calculated duration is expressed in minutes.

## 5. Delay Classification

For exploratory analysis, a sample is classified as delayed when:

`TAT >= 180 minutes`

This is an analytical threshold selected for this project. It should not be interpreted as an official laboratory service-level agreement (SLA).

## 6. Analytical Tools

| Tool | Application |
|---|---|
| Python | Data cleaning and exploratory analysis |
| Pandas | Data transformation |
| MySQL | SQL queries and aggregations |
| Power BI | Interactive dashboard and KPI reporting |

## 7. Dashboard Analysis

The Power BI report contains three pages:

1. **Operations Overview:** Overall sample volume and turnaround-time KPIs.
2. **TAT Analysis:** Turnaround-time patterns across weekdays, collection hours, and test types.
3. **Delay & Workload Analysis:** Delay percentages and sample workload patterns.

## 8. Data Validation

SQL was used to validate the total number of records and calculate key turnaround-time and delay metrics.

The current analytical baseline is:

- Total samples: 70,635
- Average TAT: 127.93 minutes
- Delayed samples: 11,014
- Delay percentage: 15.59%

## 9. Limitations

- The dataset is synthetic and may not reflect real laboratory workflows.
- The delay threshold is exploratory rather than an official SLA.
- Observed relationships do not establish causation.
- Findings are limited to the available dataset and fields.

## 10. Future Scope

Potential extensions include predictive turnaround-time modelling, anomaly detection, configurable SLA monitoring, and automated reporting.
