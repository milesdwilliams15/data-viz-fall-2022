# helpers for color palettes #

# write a function that gets the colors to the right format
coolors <- function(url) {
  url <- as.character(url)
  col <- stringr::str_remove(url, "https://coolors.co/")
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
  }
  if(is.null(sequential)) {
    sequ <<- coolors("https://coolors.co/eff1f3-265a73")
  } else {
    sequ <<- coolors(sequential)
  }
  if(is.null(binary)) {
    dual <<- coolors("https://coolors.co/faa916-265a73")
  } else {
    dual <<- coolors(binary)
  }
}

# write a function to add palettes to ggplot
ggpal <- function(type = "qualitative", aes = "color", midpoint = 0) {
  if(!(type %in% c("qualitative", "diverging", "sequential", "binary"))) {
    stop("You have not selected an appropriate palette type! Check your spelling!")
  } 
  if(type == "qualitative" & aes == "color") {
    scale_color_manual(values = qual)
  } else if(type == "qualitative" & aes == "fill") {
    scale_fill_manual(values = qual)
  } else if(type == "diverging" & aes == "color") {
    scale_color_gradient2(low = dive[1], mid = dive[2], high = dive[3],
                          midpoint = midpoint)
  } else if(type == "diverging" & aes == "fill") {
    scale_fill_gradient2(low = dive[1], mid = dive[2], high = dive[3],
                         midpoint = midpoint)
  } else if(type == "sequential" & aes == "color") {
    scale_color_gradient(low = sequ[1], high = sequ[2])
  } else if(type == "sequential" & aes == "fill") {
    scale_fill_gradient(low = sequ[1], high = sequ[2])
  } else if(type == "binary" & aes == "color") {
    scale_color_manual(values = dual)
  } else if(type == "binary" & aes == "fill") {
    scale_fill_manual(values = binary)
  } else {
    stop("Select a valid aes.")
  }
}
