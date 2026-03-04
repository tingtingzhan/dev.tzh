

#' @title Rprofile
#' 
#' @export
Rprofile <- function() {
  
  if (.Platform$OS.type != 'unix') {
    stop('not tested for windows!!')
    return(invisible())
  }
  
  c(
    'Sys.setenv(',
    
    '  \'_R_CHECK_LIMIT_CORES_\' = \'false\',',
    # otherwise ?parallel:::.check_ncores causes error when ?devtools::check
    
    '  \'_R_CHECK_SYSTEM_CLOCK_\' = 0',
    # https://stackoverflow.com/questions/63613301/r-cmd-check-note-unable-to-verify-current-time
    # to disable "checking for future file timestamps" in R Check
    
    ')'#,
    
    # 'options(',
      
    # '  bitmapType = \'cairo\'', # unicode support # MUST as of macOS, R 4.5.1
      
    # ')'  

  ) |>
    writeLines(con = '~/.Rprofile')
  
  return(invisible())
  
}