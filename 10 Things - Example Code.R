
# Connected Symbols
# install one of these fonts:
# https://github.com/tonsky/FiraCode
# https://www.jetbrains.com/lp/mono/

# ------------------------------------------------------------
# Titles

ggplot2::ggplot(data = mtcars,
                mapping = ggplot2::aes(x = mpg,
                                       y = hp)) +
  ggplot2::geom_point() +
  ggplot2::theme_bw() +
  ggplot2::labs(title = "This is a very long title that goes on for too long and does not stop") +
  ggplot2::theme(plot.title = ggplot2::element_text(colour = "blue"))

# and now using ggtext::element_textbox_simple ....
ggplot2::ggplot(data = mtcars,
                mapping = ggplot2::aes(x = mpg,
                                       y = hp)) +
  ggplot2::geom_point() +
  ggplot2::theme_bw() +
  ggplot2::labs(title = "This is a very long title that goes on for too long and does not stop") +
  ggplot2::theme(plot.title = ggtext::element_textbox_simple(colour = "blue"))

# ------------------------------------------------------------
# Legends

ggplot2::theme(legend.text.position = "bottom",
               legend.text = ggplot2::element_text(colour = "white",
                                                   vjust = 10.5,
                                                   face = "bold"),
               legend.key.width = unit(c(5.5, 5.5, 5.5, 5.5, 17.5), 'mm'),
               legend.margin = ggplot2::margin(t = 0, r = 0, b = -25, l = 0, unit = "pt"))

# ------------------------------------------------------------
# Multiple Sourcing

source("R/function_1.R")
source("R/function_2.R")
source("R/function_3.R")
source("R/function_4.R")
source("R/function_5.R")

# batch source, in stipulated order
purrr::walk(.x = c("R/function_1.R",
                   "R/function_3.R",
                   "R/function_2.R",
                   "R/function_5.R",
                   "R/function_4.R"),
            .f = ~ source(file = .x),
            .progress = TRUE)

# batch source of entire folder
purrr::walk(.x = list.files(path = "R",
                            pattern = "*.R",
                            full.names = TRUE),
            .f = ~ source(file = .x),
            .progress = TRUE)

# ------------------------------------------------------------
# Replace all NAs

tidyr::replace_na(replace = list(col_1_name = 0))
# becomes...
dplyr::mutate(dplyr::across(.cols = tidyselect::where(is.numeric),
                            .fns = ~ tidyr::replace_na(., 0)))

tidyr::replace_na(replace = list(col_2_name = ""))
# becomes...
dplyr::mutate(dplyr::across(.cols = tidyselect::where(is.character),
                            .fns = ~ tidyr::replace_na(., "")))

# ------------------------------------------------------------
# Conditional Piping

df = tibble::tribble(
  ~col_1, ~col_2,
  4, 10,
  5, 20,
  6, 30)

df

# in this example, the status of create_col_3 will determine whether a column is created, or not

create_col_3 = TRUE # "TRUE" or "FALSE"

df_new = df |>
  {\(x) if(create_col_3 == TRUE) dplyr::mutate(x, col_3 = 7 * col_1) else x}() |>
  dplyr::mutate(col_4 = 3 * col_2)

df_new

# ------------------------------------------------------------
# General Syntax for conditional pipe step:
  
{\(x) if(<condition>) <function>(x, <function_arguments>) else x}() |>
# or
{\(y) if(<condition>) <function>(y, <function_arguments>) else y}() |>
# or
# use any variable name as the 'anonymous function variable' to carry the data frame
# through to the next stage of the pipe if the <condition> is not met

# An extension of this that allows for two different things to happen, pending on the `<condition>` is
{\(x) if(<condition>)
  <function_if_condition_true>(x, <function_arguments>)
  else 
    <function_if_condition_false>(x, <function_arguments>)}() |>









