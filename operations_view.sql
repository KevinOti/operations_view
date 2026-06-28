-- ====================================================================
-- Script: operational_views.sql
-- Author: Kevin Otieno (Analytics Engineer)
-- Description: Core relational infrastructure to aggregate commercial 
--              sales targets vs actual branch reach metrics.
-- ====================================================================

-- 1. Create the Central Relational Schema Infrastructure
CREATE TABLE [dbo].[Commercial_Sales_Data] (
    [Transaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Record_Date] DATE NOT NULL,
    [Branch_Code] VARCHAR(20) NOT NULL,
    [SKU_Code] VARCHAR(30) NOT NULL,
    [Target_Reach] INT DEFAULT 0,
    [Actual_Reach] INT DEFAULT 0,
    [Revenue_KES] DECIMAL(18,2) DEFAULT 0.00
);

-- 2. Insert Dummy Records to Simulate FMCG Operational Volatility
INSERT INTO [dbo].[Commercial_Sales_Data] 
    ([Record_Date], [Branch_Code], [SKU_Code], [Target_Reach], [Actual_Reach], [Revenue_KES])
VALUES 
    ('2026-06-25', 'BR_NAIROBI_01', 'SKU_TEA_01', 50000, 48500, 735000.00),
    ('2026-06-25', 'BR_NAIROBI_01', 'SKU_TEA_02', 35000, 31200, 460000.00),
    ('2026-06-25', 'BR_MOMBASA_02', 'SKU_TEA_01', 20000, 21500, 325000.00),
    ('2026-06-25', 'BR_KISUMU_03',  'SKU_TEA_03', 15000, 0,     0.00); -- Simulating a missing field entry

GO

-- 3. Build the Self-Healing Analytics View for Python Ingestion
CREATE VIEW [dbo].[vw_Executive_Performance_Summary] AS
SELECT 
    [Record_Date],
    [Branch_Code],
    [SKU_Code],
    
    -- Ensuring database metrics are completely bulletproof against division-by-zero errors
    ISNULL([Target_Reach], 0) AS [Target_Reach],
    ISNULL([Actual_Reach], 0) AS [Actual_Reach],
    
    -- Calculating absolute performance variance
    (ISNULL([Actual_Reach], 0) - ISNULL([Target_Reach], 0)) AS [Reach_Variance],
    
    -- Calculating variance percentages safely using analytical conditionals
    CASE 
        WHEN ISNULL([Target_Reach], 0) = 0 THEN 0.00
        ELSE CAST(((CAST([Actual_Reach] AS DECIMAL(18,2)) - [Target_Reach]) / [Target_Reach]) * 100 AS DECIMAL(10,2))
    END AS [Variance_Percentage],
    
    ISNULL([Revenue_KES], 0.00) AS [Revenue_KES]
FROM 
    [dbo].[Commercial_Sales_Data];
GO
