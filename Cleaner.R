

library(readxl)

d <- read_excel("REACH_UKR_Dataset_MSNA-within-20km-of-Contact-Line_Sept2020.xlsx", 
                                                                          sheet = "dataset")

write.csv(d, "Cleaned_Ukraine_data.csv")
