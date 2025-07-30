
#' @title Create `~/.R/Makevars` File for Unix System
#' 
#' @export
Makevars_unix <- function() {
  
  if (.Platform$OS.type != 'unix') {
    warning('only for unix')
    return(invisible())
  }
  
  ####### Fortran
  
  # Terminal:
  # brew install gcc # Install gcc, which includes gfortran
  
  gcc <- '/opt/homebrew/Cellar/gcc' |>
    list.files()
  if (length(gcc) != 1L) stop('must have one-and-only-one folder under brew/gcc')
  
  '~/.R' |> 
    dir.create(showWarnings = FALSE) 
  f <- '~/.R/Makevars'
  if (file.exists(f)) file.remove(f)
  file.create(f)
  
  c(
    gcc |> sprintf(fmt = 'FC = /opt/homebrew/Cellar/gcc/%s/bin/gfortran'),
    gcc |> sprintf(fmt = 'F77 = /opt/homebrew/Cellar/gcc/%s/bin/gfortran'),
    gcc |> sprintf(fmt = 'FLIBS = -L/opt/homebrew/Cellar/gcc/%s/lib/gcc/11')
  ) |>
    writeLines(con = '~/.R/Makevars')
  
  ####### End of Fortran
  
  return(invisible())

}




