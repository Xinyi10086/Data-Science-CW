draw_halfcourt <- function(units = c("ft", "m")) {
  units <- match.arg(units)
  # NBA halfcourt standard size: 47 feet long, 50 feet wide
  # 1 foot = 0.3048 meters if using metric
  scale_factor <- ifelse(units == "m", 0.3048, 1)
  
  # Define main court boundary lines (in feet)
  outer_lines <- data.frame(
    x = c(-26, -26, 26, 26, -26),
    y = c(-1, 48, 48, -1, -1)
  )
  # 2. Rim (circle with diameter 18 inches = 1.5 feet, radius = 0.75 feet)
  rim_center <- c(0, 5.25)  # Rim center is 5.25 ft from baseline
  rim_radius <- 0.75        # Rim radius: 0.75 ft (9 inches)
  theta_circle <- seq(0, 2*pi, length.out = 181)
  rim <- data.frame(
    x = rim_center[1] + rim_radius * cos(theta_circle),
    y = rim_center[2] + rim_radius * sin(theta_circle)
  )
  # 3. Backboard (horizontal line, 6 feet wide, 4 feet from baseline)
  backboard <- data.frame(
    x = c(-3, 3),
    y = c(4, 4)
  )
  # 4. Three-point line (corner lines + arc)
  #    NBA 3PT line: max distance 23.75 ft, shortest corner distance 22 ft
  arc_radius <- 23.75
  arc_center <- rim_center
  x_arc <- seq(-22, 22, length.out = 200)
  y_arc <- arc_center[2] + sqrt(arc_radius^2 - x_arc^2)
  three_point_arc <- data.frame(x = x_arc, y = y_arc)
  # Vertical corner lines (height ≈ arc intersection height)
  corner_y <- max(y_arc)
  three_point_line <- rbind(
    c(-22, 0),
    c(-22, corner_y),
    three_point_arc,
    c(22, corner_y),
    c(22, 0)
  )
  names(three_point_line) <- c("x", "y")
  # 5. Key (paint area): 16 ft wide, 19 ft deep, with freethrow line
  key_outer <- data.frame(
    x = c(-8, -8, 8, 8), 
    y = c(0, 19, 19, 0)
  )
  # Free-throw circle (radius 6 ft), top half solid, bottom half dashed
  ft_circle_center <- c(0, 19)
  ft_radius <- 6
  theta_half <- seq(0, pi, length.out = 180)
  ft_circle_top <- data.frame(
    x = ft_radius * cos(theta_half),
    y = ft_circle_center[2] + ft_radius * sin(theta_half)
  )
  ft_circle_bottom <- data.frame(
    x = ft_radius * cos(theta_half),
    y = ft_circle_center[2] - ft_radius * sin(theta_half)
  )
  # 6. Restricted area (4 ft radius arc under the rim)
  restr_radius <- 4
  restr_arc <- data.frame(
    x = seq(-restr_radius, restr_radius, length.out = 100),
    y = rim_center[2] + sqrt(restr_radius^2 - seq(-restr_radius, restr_radius, length.out = 100)^2)
  )
  # Apply scaling and vertical alignment (align rim to y = 0)
  all_paths <- list(outer_lines, rim, backboard, three_point_line,
                    key_outer, ft_circle_top, ft_circle_bottom, restr_arc)
  all_paths <- lapply(all_paths, function(df) {
    df$x <- df$x * scale_factor
    df$y <- df$y * scale_factor
    df$y <- df$y - 5.25 * scale_factor  # Align rim to y = 0
    df
  })
  
  outer_lines       <- all_paths[[1]]
  rim               <- all_paths[[2]]
  backboard         <- all_paths[[3]]
  three_point_line  <- all_paths[[4]]
  key_outer         <- all_paths[[5]]
  ft_circle_top     <- all_paths[[6]]
  ft_circle_bottom  <- all_paths[[7]]
  restr_arc         <- all_paths[[8]]
  
  # Use ggplot to draw all paths with appropriate styling
  court_plot <- ggplot() +
    geom_path(data = outer_lines, aes(x, y), color="black", size = 1) +
    geom_path(data = rim, aes(x, y), color="orange", size=1.2) +
    geom_path(data = backboard, aes(x, y), color="brown", size=1.5, lineend="butt") +
    geom_path(data = three_point_line, aes(x, y), color="black", size = 1.2) +
    geom_path(data = key_outer, aes(x, y), color="black", size = 1) +
    geom_path(data = ft_circle_top, aes(x, y), color="black", size = 1) +
    geom_path(data = ft_circle_bottom, aes(x, y), color="black", linetype="dashed") +
    geom_path(data = restr_arc, aes(x, y), color="black", linetype="solid", size = 1) +
    coord_fixed() +
    theme_void()  # Remove grid/axis, only keep court lines
  return(court_plot)
}
