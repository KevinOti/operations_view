# SQL Server Relational View Library 🗄️

Production-grade database layout matrices and view scripts engineered in Microsoft SQL Server to optimize performance reporting and ensure relational data integrity for enterprise metrics.

---

## 📊 Business Logic Focus
* **0% Query Downtime:** Implements strict conditional check mechanisms (`CASE` clauses) to completely prevent server compilation crashes caused by missing field boundaries or division-by-zero errors.
* **Streamlined Python Connectors:** Standardizes messy structural tables into a single database View layer, reducing the number of complex data transformation scripts needed downstream in the pipeline.
* **Auditable Variance Calculations:** Automatically calculates reach performance variances and percentage shifts at the database layer before the data leaves the warehouse environment.

---

## 🛠 Relational Schema Map
The view pipeline cleanly handles missing metrics and prepares rows for automated delivery tools:

1. **`Commercial_Sales_Data` (Core Table):** The underlying database ledger table structured to capture transaction dates, branch codes, target limits, and local revenue metrics.
2. **`vw_Executive_Performance_Summary` (Analytics View):** An automated database query aggregation mask that sanitizes null column exceptions, computes variances, and presents analytical outputs to external script connectors.

---

## ⚙ Deployment Instructions
To set up and run this SQL schema environment on your local server instance:

1. Copy the contents of the `operational_views.sql` file.
2. Open your database tool (e.g., SQL Server Management Studio / SSMS).
3. Paste the code into a fresh query terminal window and hit **Execute (F5)**.
4. Verify the analytics view layer outputs by executing a standard data query:
   ```sql
   SELECT * FROM [dbo].[vw_Executive_Performance_Summary];
   ```

---
**Maintained by Kevin Otieno** • *Architecture Engineered for Scalable Operations Analytics*
