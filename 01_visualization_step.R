# ===============================================================
# R Basics — Step 1: Visualization (build plots, no export)
# Author: Nguyen Trung Duc | Institute: VNUA | Email: ntduc11@gmail.com
# ---------------------------------------------------------------
# Goal:
#   1) Install/load packages (safe: install only if missing)
#   2) Set global styles for reproducibility
#   3) Build a series of plots with ggplot2
#   4) Combine plots into multi-panel figures
#   5) (No file saving here — exporting is handled in Step 2)
# ===============================================================

## STEP 1 — Install & load packages -----------------------------------------
options(repos = "https://cloud.r-project.org")

install_if_missing <- function(pkgs) {
  for (p in pkgs) if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

install_if_missing(c(
  "tidyverse","ggpubr","ggbeeswarm","ggridges","cowplot",
  "gapminder","here","RColorBrewer"
))

library(tidyverse)
library(ggpubr)
library(ggbeeswarm)
library(ggridges)
library(cowplot)
library(gapminder)
library(here)

## STEP 2 — Global settings (theme, seed) -----------------------------------
theme_set(theme_minimal(base_size = 12))
set.seed(1)  # for reproducible jitter/quasirandom

## STEP 3 — Prepare data objects (if any) -----------------------------------
amer <- gapminder |> dplyr::filter(continent == "Americas")
#dat <-read.csv("data.csv", header = TRUE, row.names = 1) # Load data from local project

## STEP 4 — Build plots ------------------------------------------------------

# 4.1 Scatterplot (continuous x–y)
p_scatter <- ggplot(mpg, aes(displ, hwy, color = class, size = cyl)) +
  geom_point(alpha = 0.85) +
  scale_color_brewer(palette = "Set2") +
  labs(title = "Fuel Efficiency by Engine Size",
       x = "Engine displacement (L)", y = "Highway MPG",
       color = "Class", size = "Cylinders")
print(p_scatter)

# 4.2 Boxplot + quasirandom + mean (publication-ready)
p_box <- ggplot(mpg, aes(class, hwy, color = class)) +
  geom_boxplot(outlier.shape = NA, width = 0.7) +
  ggbeeswarm::geom_quasirandom(alpha = 0.6, width = 0.2) +
  stat_summary(fun = "mean", geom = "point", shape = 95, size = 10, color = "black") +
  scale_color_brewer(palette = "Set2", guide = "none") +
  coord_flip() +
  labs(title = "Highway MPG by Vehicle Class",
       x = "Class", y = "Highway MPG")
print(p_box)

# 4.3 Ridge plot (grouped distributions)
p_ridge <- ggplot(mpg, aes(cty, class, fill = class)) +
  geom_density_ridges(scale = 1.05, rel_min_height = 0.01) +
  theme_ridges() +
  scale_fill_brewer(palette = "Set2", guide = "none") +
  labs(title = "City Mileage by Vehicle Class",
       x = "City MPG", y = "Class")
print(p_ridge)

# 4.4 Faceted line plot (country panels)
p_facet <- ggplot(amer, aes(year, lifeExp, group = country)) +
  geom_line(color = "grey50") +
  geom_point(color = "steelblue") +
  facet_wrap(~ country) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Changes in Life Expectancy (Americas)",
       x = "Year", y = "Life Expectancy")
print(p_facet)

# 4.5 Time series + smoother
p_ts <- ggplot(economics, aes(date, psavert)) +
  geom_line() +
  geom_smooth(span = 0.3, se = TRUE) +
  labs(title = "Personal Savings Rate", x = "Date", y = "Rate (%)")
print(p_ts)

# 4.6 Statistical tests (group comparisons)
pval_y <- max(mpg$hwy, na.rm = TRUE) * 1.10  # place global p above data
p_stats <- ggboxplot(mpg, x = "class", y = "hwy",
                     color = "class", add = "jitter", shape = "class") +
  scale_color_brewer(palette = "Set2", guide = "none") +
  stat_compare_means() +                    # global p-value
  stat_compare_means(label.y = pval_y) +    # show global p up top
  labs(title = "Highway MPG: Group Comparisons",
       x = "Class", y = "Highway MPG")
print(p_stats)

## STEP 5 — Build a multi-panel figure --------------------------------------
fig_grid <- plot_grid(p_stats, p_ts, labels = c("A", "B"), ncol = 2, rel_widths = c(1, 1))
print(fig_grid)

# End of Step 1 script
