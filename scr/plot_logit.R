plot_logit <- function(varname, xlabel = NULL) {
  ggplot(df, aes_string(x = varname, y = "logit")) +
    geom_point(alpha = 0.3, size = 1) +
    geom_smooth(method = "loess", se = FALSE, color = "blue") +
    labs(x = xlabel, y = "Estimated Logit",
         title = paste("Logit vs", xlabel)) +
    theme_minimal()
}
