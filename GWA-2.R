# Load required package
library(smwrGraphs)

# Sample groundwater data (Bengaluru)
bengaluru_data <- data.frame(
  Site = paste0("S", 1:5),  # Shortest labels: S1, S2, ...
  Ca = c(40, 35, 50, 60, 45),       
  Mg = c(12, 15, 10, 20, 18),
  Na = c(25, 30, 22, 28, 27),
  K  = c(2, 2.5, 2, 3, 2.8),
  Cl = c(30, 35, 28, 40, 33),
  SO4 = c(20, 25, 18, 22, 21),
  HCO3 = c(90, 100, 85, 110, 95)
)

# mg/L to meq/L conversion function
to_meq <- function(mgL, mol_weight, valence) {
  (mgL / mol_weight) * valence
}

# Convert to meq/L
bengaluru_meq <- transform(bengaluru_data,
                           Ca   = to_meq(Ca,   40.08, 2),
                           Mg   = to_meq(Mg,   24.31, 2),
                           NaK  = to_meq(Na + K, 22.99, 1),
                           Cl   = to_meq(Cl,   35.45, 1),
                           SO4  = to_meq(SO4,  96.06, 2),
                           HCO3 = to_meq(HCO3, 61.02, 1)
)

# Piper plot with clearer labels
piperPlot(
  bengaluru_meq$Ca,
  bengaluru_meq$Mg,
  bengaluru_meq$NaK,
  bengaluru_meq$Cl,
  bengaluru_meq$SO4,
  bengaluru_meq$HCO3,
  Plot = list(
    name = bengaluru_data$Site,
    name.cex = 0.6,        # Smaller font
    name.offset = 0.05,    # Bigger offset
    symbol = list(size = 0.08, what = "circle")  # Point symbols
  ),
  caption = "Piper Diagram – Bengaluru Water Samples"
)

