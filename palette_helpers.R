# helpers for color palettes #

# write a function that gets the colors to the right format
coolors <- function(url) {
  url <- as.character(url)
  col <- stringr::str_remove(url, "https://coolors.co/")
  col <- stringr::str_remove(col, "palette/")
  col <- unlist(strsplit(col, "-"))
  paste0("#", col)
} 

# palette setter function
set_palette <- function(
    qualitative = NULL,
    diverging = NULL,
    sequential = NULL,
    binary = NULL
    ) {
  if(is.null(qualitative)) {
    qual <<- coolors("https://coolors.co/265a73-e8c547-b0bbbf-a85751-331832")
  } else {
    qual <<- coolors(qualitative)
  }
  if(is.null(diverging)) {
    dive <<- coolors("https://coolors.co/265a73-eff1f3-df2935")
  } else {
    dive <<- coolors(diverging)
    if(length(dive)!=3) stop("Diverging palette must have 3 colors! You have: ", length(dive))
  }
  if(is.null(sequential)) {
    sequ <<- coolors("https://coolors.co/eff1f3-265a73")
  } else {
    sequ <<- coolors(sequential)
    if(length(sequ)!=2) stop("Sequential palette must have 2 colors! You have: ", length(sequ))
  }
  if(is.null(binary)) {
    dual <<- coolors("https://coolors.co/faa916-265a73")
  } else {
    dual <<- coolors(binary)
    if(length(dual)!=2) stop("Binary palette must have 2 colors! You have: ", length(dual))
  }
}

# write a function to add palettes to ggplot
ggpal <- function(type = "qualitative", 
                  aes = "color", 
                  midpoint = 0,
                  is_continuous_scale = TRUE) {
  if(!exists('dive')) {
    stop("You must use set_palette() before using ggpal().")
  }
  if(!any(type %in% c("qualitative", "diverging", "sequential", "binary"))) {
    stop("You have not selected an appropriate palette type! Check your spelling!")
  } 
  if(!any(aes %in% c("color", "fill"))) {
    stop("You have not selected an appropriate aes! Check your spelling!")
  }
  if(type == "qualitative" & aes == "color") {
    scale_color_manual(values = qual)
  } else if(type == "qualitative" & aes == "fill") {
    scale_fill_manual(values = qual)
  } else if(type == "diverging" & aes == "color" & is_continuous_scale) {
    scale_color_gradient2(low = dive[1], mid = dive[2], high = dive[3],
                          midpoint = midpoint)
  } else if(type == "diverging" & aes == "fill" & is_continuous_scale) {
    scale_fill_gradient2(low = dive[1], mid = dive[2], high = dive[3],
                         midpoint = midpoint)
  } else if(type == "sequential" & aes == "color" & is_continuous_scale) {
    scale_color_gradient(low = sequ[1], high = sequ[2])
  } else if(type == "sequential" & aes == "fill" & is_continuous_scale) {
    scale_fill_gradient(low = sequ[1], high = sequ[2])
  } else if(type == "diverging" & aes == "color" & !is_continuous_scale) {
    scale_color_gradient2(low = dive[1], mid = dive[2], high = dive[3],
                          midpoint = midpoint)
  } else if(type == "diverging" & aes == "fill" & !is_continuous_scale) {
    scale_fill_gradient2(low = dive[1], mid = dive[2], high = dive[3],
                         midpoint = midpoint)
  } else if(type == "sequential" & aes == "color" & !is_continuous_scale) {
    scale_color_gradient(low = sequ[1], high = sequ[2])
  } else if(type == "sequential" & aes == "fill" & !is_continuous_scale) {
    scale_fill_gradient(low = sequ[1], high = sequ[2])
  } else if(type == "binary" & aes == "color") {
    scale_color_manual(values = dual)
  } else if(type == "binary" & aes == "fill") {
    scale_fill_manual(values = binary)
  } 
}
