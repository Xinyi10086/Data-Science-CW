# Function for generating empirical logit plots with arbitrary variable transformations
emp_logit_plot <- function(x, y, title = "") {
  bins <- cut(x, breaks = unique(quantile(x, probs = seq(0, 1, 0.1), na.rm = TRUE)), include.lowest = TRUE)
  df_bin <- data.frame(x = tapply(x, bins, mean, na.rm = TRUE),
                       p = tapply(y, bins, mean, na.rm = TRUE))
  df_bin <- df_bin %>% filter(!is.na(p) & p > 0 & p < 1)
  df_bin$logit <- log(df_bin$p / (1 - df_bin$p))
  
  ggplot(df_bin, aes(x = x, y = logit)) +
    geom_point(size = 2) +
    geom_smooth(method = "lm", se = FALSE, color = "blue") +
    labs(title = title, x = NULL, y = "Empirical Logit") +
    theme_minimal()
}

# Perform four types of transformations on a given variable and generate corresponding plots
plot_logit_transforms <- function(df, varname, yvar = "made") {
  x_raw <- df[[varname]]
  y <- df[[yvar]]
  
  safe_log <- function(x) {
    tryCatch({
      x2 <- ifelse(x + 1 > 0, log(x + 1), NA)
      x2[is.infinite(x2) | is.nan(x2)] <- NA
      x2
    }, error = function(e) rep(NA, length(x)))
  }
  
  safe_inverse <- function(x) {
    tryCatch({
      x2 <- 1 / (x + 1e-5)
      x2[is.infinite(x2) | is.nan(x2)] <- NA
      x2
    }, error = function(e) rep(NA, length(x)))
  }
  
  plots <- list(
    emp_logit_plot(x_raw, y, title = paste0(varname, " (Original)")),
    emp_logit_plot(sqrt(pmax(x_raw, 0)), y, title = paste0(varname, " (Sqrt)")),
    emp_logit_plot(safe_log(x_raw), y, title = paste0(varname, " (Log)")),
    emp_logit_plot(safe_inverse(x_raw), y, title = paste0(varname, " (Inverse)"))
  )
  
  return(plots)
}