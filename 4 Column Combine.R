library(readxl)
library(dplyr)
library(purrr)
library(fs)
library(tools)

main_dir <- "Test_Excel_Compiler"

folders <- dir(main_dir, full.names = TRUE)

output_df_list <- list()

for (folder_iter in folders){
  folder_dataframe = data.frame()
  for (file_iter in dir(folder_iter, full.names = TRUE)){
    if (substr(basename(file_iter),start = 1, stop=4) == 'qual'){
      target_cols <- c('QualCol1','QualCol2','QualCol3','QualCol4') ## Specify the names of the columns here
    } else {
      target_cols <- c('SuggCol1','SuggCol2','SuggCol3')
    }
    
    data <- read_excel(file_iter)
    data <- select(data,target_cols)
    
    
    ## Select random 20% sample here
    total_num_rows <- nrow(data)
    size_of_sample <- round(total_num_rows/5)
    sub_data <- sample_n(data,size_of_sample)
    
    folder_dataframe <- rbind(folder_dataframe, sub_data)
  }
  
  output_df_list[[length(output_df_list)+1]] <- folder_dataframe
}
17m


