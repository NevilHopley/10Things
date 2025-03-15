# Background Script 1

df_1 = data.frame()
time_start = Sys.time()
for(i in c(1:70000)){
  extra_row = data.frame(x = i)
  df_1 = dplyr::bind_rows(df_1, extra_row)
}
time_end = Sys.time()

time_end - time_start

                    