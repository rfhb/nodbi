% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/src_sqlite.R
\name{src_sqlite}
\alias{src_sqlite}
\title{Setup a sqlite database connection}
\usage{
src_sqlite(dbname = ":memory:", ...)
}
\arguments{
\item{dbname}{(character) name of database file,
defaults to ":memory:" for an in-memory database,
see \code{\link[RSQLite:SQLite]{RSQLite::SQLite()}}}

\item{...}{additional named parameters passed
on to \code{\link[RSQLite:SQLite]{RSQLite::SQLite()}}}
}
\description{
Setup a sqlite database connection
}
\details{
uses \pkg{RSQLite} under the hood
}
\examples{
\dontrun{
(con <- src_sqlite())
print(con)
}

}
