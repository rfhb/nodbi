#' Setup a sqlite database connection
#'
#' @export
#' 
#' @param dbname (character) name of database file, 
#'   defaults to ":memory:" for an in-memory database,
#'   see [RSQLite::SQLite()]
#' @param ... additional named parameters passed 
#'   on to [RSQLite::SQLite()]
#' 
#' @details uses \pkg{RSQLite} under the hood
#' 
#' @examples \dontrun{
#' (con <- src_sqlite())
#' print(con)
#' }
#' 
src_sqlite <- function(dbname = ":memory:", 
                       ...) {

  # open connection
  con <- DBI::dbConnect(
    drv = RSQLite::SQLite(), 
    dbname = dbname, 
    ...)
  
  # check if json1 extension is supported
  if ("try-error" %in% class(
    try(
      DBI::dbExecute(
        conn = con, 
        statement = paste0('SELECT * FROM json_each(\'{"test":"1"}\');')
      ), silent = TRUE)
  )) {
    stop("SQLite does not have json1 extension enabled. Call ", 
         "install.packages('RSQLite') to install a current version.")
  }
  
  # return standard nodbi structure
  structure(list(con = con, 
                 dbname = dbname, 
                 ...), 
            class = c("src_sqlite", "docdb_src"))

}

#' @export
print.src_sqlite <- function(x, ...) {
  dbname <- x$dbname
  dbsize <- file.size(dbname)
  # RSQLite::rsqliteVersion() was introduced with
  # same version that introduced json1 extension
  srv <- rev(RSQLite::rsqliteVersion())[1]
  cat(sprintf("SQLite library version: %s\n size: %s kBytes\n dbname: %s\n",
              srv, dbsize / 2^10, dbname))
}