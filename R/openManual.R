
#' @title Open pdf Manual
#' 
#' @param x returned object from function \link[devtools]{build_manual}
#' 
#' @keywords internal
#' @export
openManual <- function(x) {
  # `x` is the invisible return from ?devtools::build_manual
  manual <- x$command |>
    grepv(pattern = '^--output=') |>
    gsub(pattern = '^--output=', replacement = '')
  paste('open', manual) |> system() # no need to close the open pdf
}


