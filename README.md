# 🏏 IPL Cricket Autopsy (2008–2024)
### *A Data-Driven Investigation into What Actually Wins Cricket Matches*

[![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)](https://python.org)
[![MySQL](https://img.shields.io/badge/MySQL-Analysis-orange?logo=mysql)](https://mysql.com)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)](YOUR_POWERBI_LINK_HERE)
[![NLP](https://img.shields.io/badge/NLP-VADER-green)](https://github.com/cjhutto/vaderSentiment)

---

## The Central Question

> **"Does winning the toss actually help win the match?"**
> The data says... barely. Here is what actually matters.

---

## Key Findings

| Finding | Insight |
|---|---|
| 🪙 Toss Impact | Win rate ≈ 50% — effectively a coin flip across 17 seasons |
| 🏟️ Field First Wins | Teams fielding first won **53.9%** vs **45.4%** when batting first |
| 🏟️ Venue Difference | **38% scoring gap** between highest and lowest-scoring grounds |
| 💀 Death Over King | T Stubbs led death-over strike rate at **239** (min 50 balls) |
| 🧠 NLP Finding | Close finishes score **87% higher** on excitement vs dominant wins |

---

## What Makes This Project Unique

**NLP Excitement Scoring — an original approach not found on Kaggle:**
The IPL dataset has zero review or text data. Python was used to generate
structured English match narratives from game statistics. VADER sentiment
analysis then scored each narrative for excitement (−1 to +1 compound score).
This produced team-level, season-level, and win-type excitement trends
that do not exist in any other IPL analysis on Kaggle.

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python (Pandas, NumPy) | Data cleaning, feature engineering |
| Matplotlib, Seaborn | 12 EDA charts |
| MySQL | 10 analytical query sections |
| VADER (NLP) | Match excitement scoring |
| Power BI + DAX | 4-page interactive dashboard |
| Git | Version control |

---

## Project Structure
ipl-cricket-autopsy/
ipl-cricket-autopsy/
│
├── 📂 data/
│   ├── ipl_cleaned.csv
│   ├── ipl_deliveries_cleaned.csv
│   ├── ipl_final.csv
│   ├── ipl_team_sentiment.csv
│   ├── ipl_season_sentiment.csv
│   └── ipl_pom_excitement.csv
│
├── 📂 notebooks/
│   ├── 01_Data_Cleaning.ipynb          
│   ├── 02_EDA_Visualization.ipynb      
│   └── 03_NLP_Sentiment.ipynb          
│
├── 📂 sql/
│   └── ipl_analysis.sql                
│
├── 📂 powerbi_csvs/                    
│   ├── ipl_top_batsmen.csv
│   ├── ipl_top_bowlers.csv
│   ├── ipl_death_batsmen.csv
│   ├── ipl_pp_bowlers.csv
│   ├── ipl_dismissals.csv
│   └── ipl_phase_runs.csv
│
├── 📂 dashboard/
│   └── IPL_Cricket_Autopsy.pbix        
│
├── 📂 charts/
│   └── (all PNG charts from EDA Visuals folder)                         

---

## How to Run

```bash
# 1. Clone the repo
git clone https://github.com/SangharshNikam/IPL-Cricket-Autopsy
cd ipl-cricket-autopsy

# 2. Install dependencies
pip install pandas numpy matplotlib seaborn vaderSentiment

# 3. Run notebooks in order
# Open Jupyter → run 01 → 02 → 03

# 4. Import CSVs into MySQL Workbench
# Run sql/ipl_analysis.sql

# 5. Import CSVs into Power BI
# Open dashboard/IPL_Cricket_Autopsy.pbix
```

---

## Dataset

- **Source:** Kaggle — IPL Complete Dataset (2008–2024)
- **Matches:** 1,090 | **Deliveries:** 2,60,920 ball-by-ball records
- **Period:** 2008–2024 (17 seasons)
- **Join key:** match_id (matches ↔ deliveries)

---

## Dashboard

🔗 **[View Live Power BI Dashboard](https://app.powerbi.com/links/I_6yTLSLcD?ctid=405ddc34-d660-46e5-b52d-bfd0be156bb5&pbi_source=linkShare)**


**Sangharsh Nikam** | nikam.sangharsh.anil@gmail.com | [LinkedIn](https://www.linkedin.com/in/sangharsh-nikam-b655212b8/)
