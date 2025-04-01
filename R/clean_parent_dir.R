
#' @title Remove Augment Files in Parent Directory of a Package in Development
#' 
#' @param pkg ..
#' 
#' @details
#' To remove the augment `*.pdf` and `.Rcheck` file/directories created 
#' in the parent directory of a package in development.
#' 
#' @examples
#' # debug(clean_parent_dir); clean_parent_dir(pkg = '../rmarkdown.tzh')
#' @keywords internal
#' @importFrom pkgload pkg_name pkg_version
#' @export
clean_parent_dir <- function(pkg = '.') {
  
  path <- pkg |> normalizePath() # package path
  name <- path |> pkg_name()
  version <- path |> pkg_version()
  parent_dir <- path |> dirname()
  
  parent_dir |>
    list.files(pattern = paste0('^', name, '_.*\\.pdf$'), full.names = TRUE) |>
    file.remove()
  
  parent_dir |>
    list.files(pattern = paste0('^', name, '_.*\\.tar\\.gz$'), full.names = TRUE) |>
    file.remove()
  
  parent_dir |> 
    file.path(paste0(name, '.Rcheck')) |>
    unlink(recursive=TRUE)
  
}