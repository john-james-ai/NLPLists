#' Get Data
#'
#' \code{getData} Loads the data into an R object and stores in the data directory.
#'
#' Given a file path, this function loads the file into an R data frame. The name
#' is the basename name of the file without the file extension, unless otherwise
#' designated through the name parameter. Lastly, the data is stored as an RDA
#' object in the data-raw directory. This function currently supports csv and
#' excel files.
#'
#' @param path Character string indicating the location of the file to be loaded.
#' The file must be a CSV file with a single header row that will be
#' the column names for the data frame.
#' @param name Optional character string indicating the name of the R object. If
#' NULL, the base name of the file sans the extention will be used.
#'
getData <- function(path, name = NULL) {

  if (!(file.exists(path))) stop("File does not exist.")

  if (!(tools::file_ext(path) == "csv")) stop("Unable to load file. Only 'csv' files are supported")

  directory <- "./data"
  if (is.null(name)) name <- tools::file_path_sans_ext(basename(path))
  filePath <- file.path(directory, paste0(name, ".rda"))

  data <- read.csv(file = path, header = TRUE)
  data[] <- lapply(data, as.character)
  assign(name, data)
  save(list = name, file = filePath, compression_level = 9)
}

getData(path = "./data-raw/contractions.csv", name = "contractions")
getData(path = "./data-raw/emoticons.csv", name = "emoticons")
getData(path = "./data-raw/internetAbbreviations.csv", name = "internetAbbreviations")
getData(path = "./data-raw/profanity.csv", name = "profanity")

