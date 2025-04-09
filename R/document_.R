

#' @title Checke `.Rd` File
#' 
#' @description
#' Checking compliance to some conventions of CRAN.
#' 
#' @param path \link[base]{character} scalar, directory of one `.Rd` file
#' 
#' @export
check_Rd <- function(path) {
  nm <- path |> basename()
  txt <- path |> readLines()
  
  idx <- grep(pattern = '^\\\\docType\\{.*\\}$', x = txt)
  if (n <- length(idx)) {
    if (n != 1L) stop('will not have more than one docType in one Rd file')
    dTy <- txt[idx] |> gsub(pattern = '^\\\\docType\\{|\\}$', replacement = '')
    switch(dTy, data = {
      # do something
    }, package = { # '\\docType{package}' still created by \CRANpkg{roxygen2}
      # do something
    }, class = { # S4 class
      # do something
    }, stop(sQuote(dTy), ' unknown?'))
    return(invisible())
  }
  
  int <- ('\\keyword{internal}' %in% txt)
  
  if (!int) {
    
    # check '\value' fields in .Rd files (@returns in \pkg{roxygen2})
    # \pkg{roxygen2} does not force this check, but CRAN personnel insists.
    idx <- ('\\value{' == txt)
    if (sum(idx) > 1L) stop(sQuote(nm), ' has more than one @return')
    if (!any(idx)) stop(sQuote(nm), ' does not have @return') # masked temporarily..
    # no need; also do not want to import my [.cyan], etc.
    # cat(c(sQuote(nm), 'has'), '@return', sQuote(txt[which(idx) + 1L]), '\n\n')
    
  }
  
  # After R 4.0.0, \dontest{} is always run as part of CRAN submission (see ?devtools::check)
  if (any('\\dontrun{' == txt)) stop('Replace \\dontrun with \\donttest in ', sQuote(nm)) # masked temporarily
  #if (any(grepl('microbenchmark', x = txt)) && !any('library(microbenchmark)' == txt)) stop('microbenchmark in ', sQuote(nm))
  
  return(invisible())
}





