% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db-sql.R
\name{db-sql}
\alias{db-sql}
\alias{sql_query_explain}
\alias{sql_table_analyze}
\alias{sql_index_create}
\alias{sql_query_save}
\alias{sql_query_fields}
\alias{sql_query_rows}
\alias{sql_expr_matches}
\title{SQL generation generics}
\usage{
sql_query_explain(con, sql, ...)

sql_table_analyze(con, table, ...)

sql_index_create(con, table, columns, name = NULL, unique = FALSE, ...)

sql_query_save(con, sql, name, temporary = TRUE, ...)

sql_query_fields(con, sql, ...)

sql_query_rows(con, sql, ...)

sql_expr_matches(con, x, y)
}
\description{
\itemize{
\item \code{sql_table_analyze()} <- \code{db_analyze()} <- \code{db_copy_to(analyze = TRUE)}
\item \code{sql_index_create()} <- \code{db_create_index()} <- \code{db_copy_to(indexes = ...)}
\item \code{sql_query_explain()} <- \code{db_explain} <- \code{explain()}
\item \code{sql_query_fields()} <- \code{db_query_fields()} <- \code{tbl()}
\item \code{sql_query_rows()} <- \code{db_query_rows()} <- \code{do()}
\item \code{sql_query_save()} <- \code{db_save_query()} <- \code{db_compute()} <- \code{compute()}
\item \code{sql_expr_matches(con, x, y)} is used to generate an alternative to
\code{x == y} to use when you want \code{NULL}s to match. The default translation
uses a \verb{CASE WHEN} as described in
\url{https://modern-sql.com/feature/is-distinct-from}
}
}
\seealso{
Other generic: 
\code{\link{db_copy_to}()},
\code{\link{db_desc.DBIConnection}()},
\code{\link{sql_escape_logical}()}
}
\concept{generic}
\keyword{internal}
