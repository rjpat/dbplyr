#' @importFrom assertthat assert_that
#' @importFrom assertthat is.flag
#' @importFrom stats setNames update
#' @importFrom utils head tail
#' @importFrom glue glue
#' @importFrom dplyr n
#' @importFrom blob is_blob as_blob
#' @import rlang
#' @import DBI
#' @import tibble
#' @keywords internal
"_PACKAGE"

# Generics that really should live in dbplyr
#' @importFrom dplyr sql_join
#' @importFrom dplyr sql_select
#' @importFrom dplyr sql_semi_join
#' @importFrom dplyr sql_set_op
#' @importFrom dplyr sql_subquery
#' @importFrom dplyr sql_translate_env
NULL
