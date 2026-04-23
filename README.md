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