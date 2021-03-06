#' Backend: Redshift
#'
#' @description
#' Base translations come from [PostgreSQL backend][simulate_postgres]. There
#' are generally few differences, apart from string manipulation.
#'
#' Use `simulate_redshift()` with `lazy_frame()` to see simulated SQL without
#' converting to live access database.
#'
#' @name backend-redshift
#' @aliases NULL
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' lf <- lazy_frame(a = TRUE, b = 1, c = 2, d = "z", con = simulate_redshift())
#' lf %>% transmute(x = paste(c, " times"))
#' lf %>% transmute(x = substr(c, 2, 3))
#' lf %>% transmute(x = str_replace_all(c, "a", "z"))
NULL

#' @export
#' @rdname backend-redshift
simulate_redshift <- function() simulate_dbi("RedshiftConnection")

#' @export
sql_translate_env.RedshiftConnection <- function(con) {
  postgres <- sql_translate_env.PostgreSQL(con)

  sql_variant(
    sql_translator(.parent = postgres$scalar,

      # https://docs.aws.amazon.com/redshift/latest/dg/r_Numeric_types201.html#r_Numeric_types201-floating-point-types
      as.numeric = sql_cast("FLOAT"),
      as.double = sql_cast("FLOAT"),

      # https://stackoverflow.com/questions/56708136
      paste  = sql_paste_redshift(" "),
      paste0 = sql_paste_redshift(""),
      str_c = sql_paste_redshift(""),

      # https://docs.aws.amazon.com/redshift/latest/dg/r_SUBSTRING.html
      substr = sql_substr("SUBSTRING"),
      substring = sql_substr("SUBSTRING"),
      str_sub = sql_str_sub("SUBSTRING", "LEN"),

      # https://docs.aws.amazon.com/redshift/latest/dg/REGEXP_REPLACE.html
      str_replace = sql_not_supported("str_replace"),
      str_replace_all = function(string, pattern, replacement) {
        sql_expr(REGEXP_REPLACE(!!string, !!pattern, !!replacement))
      },

      # https://docs.aws.amazon.com/redshift/latest/dg/r_patternmatching_condition_like.html
      str_like = function(string, pattern, ignore_case = TRUE) {
        if (isTRUE(ignore_case)) {
          sql_expr(!!string %ILIKE% !!pattern)
        } else {
          sql_expr(!!string %LIKE% !!pattern)
        }
      }
    ),
    sql_translator(.parent = postgres$aggregate),
    sql_translator(.parent = postgres$window)
  )
}

#' @export
sql_translate_env.Redshift <- sql_translate_env.RedshiftConnection

sql_paste_redshift <- function(sep) {
  sql_paste_infix(sep, "||", function(x) sql_expr(cast(!!x %as% text)))
}

globalVariables(c("REGEXP_REPLACE"))
