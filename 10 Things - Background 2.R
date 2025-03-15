# Background Script 2

df_2 = data.frame()
time_start = Sys.time()
for(i in c(1:70000)){
  extra_row = data.frame(x = i)
  df_2 = dplyr::bind_rows(df_2, extra_row)
}
time_end = Sys.time()

time_end - time_start
