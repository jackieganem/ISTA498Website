# Download CSV of dataframe
# Written by Sydney Brandt

# Run the most recent podsearch scrape script to get podsearch_df in the environment

# Make a datetime for today
date <- format(Sys.Date(), '%m_%d_%Y')

# Makes filename with today's date
csv_name <- paste("podsearch_df_",date,".csv",sep="")

# Writes it and sticks it in the environment! Need to push it to the Git if you want it saved to the Git.
write.csv(podsearch_df, csv_name)
