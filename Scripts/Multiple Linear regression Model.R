# Stepwise Multiple Linear Regression Analysis
# Load required R packages
library(MASS)      # For stepAIC function
library(lmtest)    # For Breusch-Pagan test (homoscedasticity)
library(car)       # For VIF calculation and variable standardization
library(ggplot2)   # For data visualization

## 1. Data Preparation
# Set working directory and clear environment
setwd("~/Pictures")
rm(list = ls())

# Read data from CSV file
dat = read.csv(file.choose(), header = TRUE, row.names = 1, sep = ",")
head(dat)  # Preview first few rows of data

## 2. Model Selection using AIC
# 2.1 Create null model (intercept only)
fit0 <- lm(N2 ~ 1, data = dat)  # N2 represents dissolved N2 concentration
 fit0 <- lm(N2_E ~ 1, data = dat)  # N2_E represents △N2 concentration

# 2.2 Perform stepwise model selection using AIC criterion
# Direction: both (forward and backward selection)
# Scope: lower = null model, upper = full model with all predictors
stepAIC(fit0, direction = 'both', 
        scope = list(lower = fit0, upper = ~ logNO3 + logNH4 + MPD + HA))
stepAIC(fit0, direction = 'both', scope = list(lower = fit0, upper = ~ DO + pH10 + logNO3 + logNH4 + MPD + HA)) # for △N2 concentration
                                                                                                                  # pH10 means 10^(-pH)
# 2.3 Build final model based on stepAIC results
fit1 <- lm(N2 ~ MPD + logNO3, data = dat)
fit1 <- lm(N2_E ~ MPD + DO + logNO3 + pH10 + logNH4, data = dat)

# 2.4 Check for multicollinearity using Variance Inflation Factor (VIF)
# Rule of thumb: VIF < 5 indicates acceptable multicollinearity
car::vif(fit1)

# Note: If any VIF ≥ 5, remove one variable at a time and recheck
# until all VIF values are below 5

## 3. Model Evaluation
# 3.1 Test for homoscedasticity (constant variance of residuals)
# Breusch-Pagan test: null hypothesis is homoscedasticity
bptest(fit1)

# 3.2 Test for normality of residuals
# Shapiro-Wilk test: null hypothesis is normal distribution
shapiro.test(residuals(fit1))

# 3.3 Analyze significance of model coefficients
summary(fit1)

## 4. Model Comparison
# 4.1 Build reduced model with only significant predictors
# (Based on results from section 3.3)
fit2 <- lm(N2 ~ MPD, data = dat)
 fit2 <- lm(N2_E ~ MPD, data = dat)

# 4.2 Compare nested models using ANOVA
# Tests whether adding variables significantly improves model fit
anova(fit2, fit1)

## 5. Variable Importance Analysis
# Standardize variables to compare coefficient magnitudes
# 5.1 Fit standardized model (mean = 0, SD = 1)
model_std <- lm(scale(N2) ~ scale(MPD) + scale(logNO3), data = dat)
 model_std <- lm(scale(N2_E) ~ scale(MPD) + scale(DO) + scale(logNO3) + scale(pH10) + scale(logNH4), data = dat)

# 5.2-5.3 Model diagnostics for standardized model
bptest(model_std)                   # Homoscedasticity test
shapiro.test(residuals(model_std))  # Normality test

# 5.4 Compare standardized models
fit_reduced <- lm(scale(N2) ~ scale(MPD), data = dat)   # Reduced model
 fit_reduced <- lm(scale(N2_E) ~ scale(MPD), data = dat) 
fit_full <- model_std                                   # Full model (same as model_std)
anova(fit_reduced, fit_full)  # Model comparison

# 5.5 Extract coefficient summary
coef_summary <- summary(model_std)$coefficients

# Process coefficients (excluding intercept)
variables <- rownames(coef_summary)[-1]  
variables <- gsub("scale\\(|\\)", "", variables)  # Clean variable names
coefficients <- coef_summary[-1, "Estimate"]

# Create significance labels
p_values <- coef_summary[-1, "Pr(>|t|)"]
significance <- ifelse(p_values < 0.001, "***",
                       ifelse(p_values < 0.01, "**",
                              ifelse(p_values < 0.05, "*", "")))

# Create plotting dataframe
coef_df <- data.frame(
  Variable = variables,
  Coefficient = coefficients,
  Significance = significance
)

# 5.6 Generate coefficient plot with adaptive legend
# Dynamic coloring based on coefficient signs
if (all(coefficients > 0)) {
  # All positive coefficients case
  ggplot(coef_df, aes(x = reorder(Variable, -abs(Coefficient)), 
                      y = Coefficient, 
                      fill = "Positive")) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = Significance), vjust = -0.5, size = 5, color = "red") +
    labs(x = "Predictors", 
         y = "Standardized Coefficients", 
         title = "Variable Importance Ranking") +
    scale_fill_manual(values = c(Positive = "blue"), name = "Effect Direction") +
    theme_minimal() +
    coord_flip()
} else if (all(coefficients < 0)) {
  # All negative coefficients case
  ggplot(coef_df, aes(x = reorder(Variable, -abs(Coefficient)), 
                      y = Coefficient, 
                      fill = "Negative")) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = Significance), vjust = -0.5, size = 5, color = "red") +
    labs(x = "Predictors", 
         y = "Standardized Coefficients", 
         title = "Variable Importance Ranking") +
    scale_fill_manual(values = c(Negative = "red"), name = "Effect Direction") +
    theme_minimal() +
    coord_flip()
} else {
  # Mixed coefficients case
  coef_df$Direction <- factor(
    ifelse(coef_df$Coefficient > 0, "Positive", "Negative"),
    levels = c("Negative", "Positive")
  )
  
  ggplot(coef_df, aes(x = reorder(Variable, -abs(Coefficient)), 
                      y = Coefficient, 
                      fill = Direction)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = Significance), vjust = -0.5, size = 5, color = "red") +
    labs(x = "Predictors", 
         y = "Standardized Coefficients", 
         title = "Variable Importance Ranking") +
    scale_fill_manual(
      values = c(Negative = "red", Positive = "blue"),
      name = "Effect Direction"
    ) +
    theme_minimal() +
    coord_flip()
}
