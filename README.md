# R Basics — A Hands-On Intro to R & RStudio

A lightweight starter course for absolute beginners to learn R for data analysis.  
Use this repository in class or for self-study—each session is practical and reproducible.

---

## What you’ll learn
- Set up **R** and **RStudio** and work comfortably with the IDE
- Core R syntax: objects, vectors, data frames, lists, functions, control flow
- Import/export data (CSV/Excel) and **clean/transform** it with `dplyr`
- **Visualize** data with `ggplot2`
- Write **reproducible reports** with **R Markdown**

## What’s in this repo
- `Duc_R basics.R` – the main script that walks through the course
- Cheat sheets (PDF): Base R, Data Import, Data Transformation, Data Visualization,  
  R Markdown, and RStudio IDE

## Suggested course plan (6 × 2 hours)
1. **Getting started:** R & RStudio, objects, vectors, basic operations  
2. **Data structures & functions:** data frames, lists, indexing, control flow, writing functions  
3. **Importing data:** `readr`, `readxl`, quick cleaning tips  
4. **Data wrangling with dplyr:** `select`, `filter`, `mutate`, `summarise`, `group_by`, joins  
5. **Visualization with ggplot2:** scatter, bar, line, box plots; aesthetics and themes  
6. **Reproducible reports:** R Markdown, knitting to HTML/PDF; mini-project (EDA)

## Quick start
1) Install **R** (CRAN) and **RStudio Desktop**  
2) Open RStudio and install the core packages:
```r
install.packages(c("tidyverse", "readxl", "janitor", "skimr", "rmarkdown"))
