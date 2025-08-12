# ===============================================================
# R Basics — Step 2: Export (save plots in multiple formats)
# Author: Nguyen Trung Duc | Institute: VNUA | Email: ntduc11@gmail.com
# ---------------------------------------------------------------
# Assumption:
#   - This script is placed in the same folder as "01_visualization_step.R"
#   - Run Step 1 first, OR let this script source it to build plots
# What you'll learn:
#   1) Create an output folder
#   2) Save individual plots in PNG, PDF, SVG, TIFF, JPEG
#   3) Use ragg for high-quality raster
#   4) Create a multi-page PDF and transparent PNGs
#   5) Batch-save all plots in a loop
# ===============================================================

## STEP 1 — Install/load export-related packages ----------------------------
options(repos = "https://cloud.r-project.org")

install_if_missing <- function(pkgs) {
  for (p in pkgs) if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

install_if_missing(c("svglite","ragg","here"))

# If Step 1 hasn't been run, source it to create the plot objects
if (!exists("p_scatter")) {
  message("Sourcing '01_visualization_step.R' to create plots...")
  # Try both possible filenames
  if (file.exists("01_visualization_step.R")) {
    source("01_visualization_step.R", echo = FALSE, max.deparse.length = Inf)
  } else if (file.exists("01_step-by-step_visualization.R")) {
    source("01_step-by-step_visualization.R", echo = FALSE, max.deparse.length = Inf)
  } else {
    stop("Cannot find Step 1 script. Make sure it's in the same folder.")
  }
}

## STEP 2 — Create an output folder ----------------------------------------
out_dir <- here::here("outputs")
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

## STEP 3 — Save plots in common formats -----------------------------------
# PNG (web/slides)
ggplot2::ggsave(file.path(out_dir, "scatter.png"), p_scatter,
       width = 8, height = 5, units = "in", dpi = 200)

# High-res PNG (print-like)
ggplot2::ggsave(file.path(out_dir, "box_highres.png"), p_box,
       width = 6, height = 6, units = "in", dpi = 300, bg = "white")

# JPEG (lossy)
ggplot2::ggsave(file.path(out_dir, "ridge.jpg"), p_ridge,
       width = 7, height = 5, units = "in", dpi = 300)

# TIFF (journals; LZW compression)
ggplot2::ggsave(file.path(out_dir, "facet.tiff"), p_facet,
       width = 8, height = 6, units = "in", dpi = 300, compression = "lzw")

# PDF (vector)
ggplot2::ggsave(file.path(out_dir, "timeseries.pdf"), p_ts,
       width = 7, height = 4.5, units = "in")

# SVG (vector for web/Illustrator/Inkscape)
ggplot2::ggsave(file.path(out_dir, "stats.svg"), p_stats,
       width = 7, height = 5, units = "in", device = svglite::svglite)

# Multi-panel figure (PDF)
ggplot2::ggsave(file.path(out_dir, "figure_grid.pdf"), fig_grid,
       width = 10, height = 6, units = "in")

## STEP 4 — Optional: ragg device for crisp raster text --------------------
# install_if_missing("ragg") # already handled above
ggplot2::ggsave(file.path(out_dir, "scatter_ragg.png"), p_scatter,
       width = 8, height = 5, units = "in", dpi = 300,
       device = ragg::agg_png)

## STEP 5 — Base devices: multi-page PDF & transparent PNG ------------------
# Multi-page PDF (three plots)
pdf(file.path(out_dir, "multipage.pdf"), width = 8, height = 5)
print(p_scatter); print(p_box); print(p_ts)
dev.off()

# Transparent PNG
png(file.path(out_dir, "scatter_transparent.png"),
    width = 1600, height = 1000, bg = "transparent", res = 200)
print(p_scatter)
dev.off()

## STEP 6 — Batch-export: save all plots in PNG + PDF -----------------------
plots <- list(
  scatter = p_scatter,
  box     = p_box,
  ridge   = p_ridge,
  facet   = p_facet,
  ts      = p_ts,
  stats   = p_stats,
  grid    = fig_grid
)

for (nm in names(plots)) {
  ggplot2::ggsave(file.path(out_dir, paste0(nm, ".png")), plots[[nm]],
         width = 8, height = 5, units = "in", dpi = 300)
  ggplot2::ggsave(file.path(out_dir, paste0(nm, ".pdf")), plots[[nm]],
         width = 8, height = 5, units = "in")
}

# End of Step 2 script
