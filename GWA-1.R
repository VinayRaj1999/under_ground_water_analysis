# Install if not already installed
install.packages("ggtern")

# Load libraries
library(ggplot2)
library(ggtern)

# Sample data (you should replace this with your own water chemistry data)
# Concentrations in meq/L
data <- data.frame(
  cation_ca = c(40, 50, 30),
  cation_mg = c(30, 20, 40),
  cation_na_k = c(30, 30, 30),
  anion_cl = c(40, 30, 20),
  anion_so4 = c(30, 40, 50),
  anion_hco3_co3 = c(30, 30, 30),
  sample = c("A", "B", "C")
)

# Normalize cation and anion data
normalize <- function(x) x / sum(x) * 100

data <- within(data, {
  cation_sum <- cation_ca + cation_mg + cation_na_k
  anion_sum  <- anion_cl + anion_so4 + anion_hco3_co3
  
  ca_pct <- normalize(c(cation_ca[1], cation_ca[2], cation_ca[3]))
  mg_pct <- normalize(c(cation_mg[1], cation_mg[2], cation_mg[3]))
  na_k_pct <- normalize(c(cation_na_k[1], cation_na_k[2], cation_na_k[3]))
  
  cl_pct <- normalize(c(anion_cl[1], anion_cl[2], anion_cl[3]))
  so4_pct <- normalize(c(anion_so4[1], anion_so4[2], anion_so4[3]))
  hco3_pct <- normalize(c(anion_hco3_co3[1], anion_hco3_co3[2], anion_hco3_co3[3]))
})

# Combine ternary plot data
cation_df <- data.frame(Ca = data$ca_pct, Mg = data$mg_pct, NaK = data$na_k_pct, sample = data$sample)
anion_df  <- data.frame(Cl = data$cl_pct, SO4 = data$so4_pct, HCO3 = data$hco3_pct, sample = data$sample)

# Cation ternary plot
p1 <- ggtern(data = cation_df, aes(x = NaK, y = Ca, z = Mg)) +
  geom_point(size = 3, color = "blue") +
  labs(title = "Cation Ternary Plot") +
  theme_bw()

# Anion ternary plot
p2 <- ggtern(data = anion_df, aes(x = HCO3, y = Cl, z = SO4)) +
  geom_point(size = 3, color = "red") +
  labs(title = "Anion Ternary Plot") +
  theme_bw()

# Print plots
print(p1)
print(p2)

