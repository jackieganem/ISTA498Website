# Podsearch RSS XML scrape script V2

# Written by Sydney Brandt
# Inspired by article by John Bica

# TO DO LIST:
# Tidy variable names 
# Alter duration code
# Alter explicit frequency code
# Alter birthday code

# Streamline this in any way possible sweet god.

# loads in packages!
library(dplyr)
library(lubridate)
library(rvest)
library(stringr)
library(textstem)
library(tibble)
library(tm)

library(tidyverse)
library(XML)
library(xml2)

# Makes the podsearch_df! 
columns <- c('xml_link', 'title','image_href','description','show_link','number_episodes','avg_duration_min','explicit_frequency', 'birthday')
podsearch_df <- data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(podsearch_df) <- columns

# Function that takes the RSS url and grabs all the datapoints for one podcast.
podcast_df_maker <- function(df_name,url){
  
  css_tags <- c('title', 'pubDate', 'itunes\\:explicit', 'itunes\\:duration')
  col_names <- c('title', 'date', 'explicit', 'duration')
  
  podcast_feed <- read_xml(url)
  items <- xml_nodes(podcast_feed, 'item')
  
  extract_element <- function(item, css_tags) {
    element <- xml_node(item, css_tags) %>% xml_text
  }
  
  podcast_df <- sapply(css_tags, function(x) {
    extract_element(items, x)}) %>% as_tibble()
  names(podcast_df) <- col_names
  
  
  xml_file<- xmlParse(read_xml(url))
  
  # will take the df and append one column to our data that contains:
  
  # from dframe
  number_epis <- nrow(podcast_df)
  avg_duration_min<- round((((sum(as.integer(podcast_df$duration)))/(number_epis)) / 60)) 
  # Issues because of discrepancies in how the duration is shown. Work in progress.
  birthday<- podcast_df$date[nrow(podcast_df)] 
  # I want to give podcasts zodiac signs LOL. Work in progress.
  explicit_frequency <- (table(podcast_df['explicit'])[2]) / number_epis 
  # Not sure why there's NAs here. Will assess, work in progress.

  # from xml
  
  title<- xmlToDataFrame(getNodeSet(xml_file, '//channel/title'))
  image<- xmlToDataFrame(getNodeSet(xml_file, '//channel/image/url'))
  description<- xmlToDataFrame(getNodeSet(xml_file, '//channel/description'))
  rsslink<- xmlToDataFrame(getNodeSet(xml_file, '//channel/link')) 
  
  # Appends a column to podsearch_df about one individual podcast! 
  
  podsearch_df[i,] <- c(url, title, image, description, rsslink, number_epis, avg_duration_min, explicit_frequency, birthday)

  return(podsearch_df)
  
}


# Loads in the csv currently being used. For this, I have a tester csv with 8 podcasts listed.
csv<- "scrape_csv/rss_sheet_v1.csv"
csv_use <- read_csv(csv)
print(csv_use)

# Runs each podcast RSS link through podcast_df_maker and appends the pod's info to podsearch_df_maker
for (i in 1:nrow(csv_use)){
  podsearch_df <- podcast_df_maker(podsearch_df, csv_use$rss_url[i])
}

podsearch_df

# BAD PRACTICE: I'm manually fixing a few columns 

podsearch_df[5,]$birthday <- podsearch_df[5,]$explicit_frequency
podsearch_df[5,]$explicit_frequency <- podsearch_df[5,]$avg_duration_min
podsearch_df[5,]$avg_duration_min <- podsearch_df[5,]$number_episodes
podsearch_df[5,]$number_episodes <- podsearch_df[5,]$show_link
podsearch_df[5,]$show_link <- podsearch_df[5,]$description
podsearch_df[5,]$description <- podsearch_df[5,]$image_href
podsearch_df[5,]$image_href <- 'error'

podsearch_df[11,]$birthday <- podsearch_df[11,]$explicit_frequency
podsearch_df[11,]$explicit_frequency <- podsearch_df[11,]$avg_duration_min
podsearch_df[11,]$avg_duration_min <- podsearch_df[11,]$number_episodes
podsearch_df[11,]$number_episodes <- podsearch_df[11,]$show_link
podsearch_df[11,]$show_link <- podsearch_df[11,]$description
podsearch_df[11,]$description <- podsearch_df[11,]$image_href
podsearch_df[11,]$image_href <- 'error'

podsearch_df[12,]$birthday <- podsearch_df[12,]$explicit_frequency
podsearch_df[12,]$explicit_frequency <- podsearch_df[12,]$avg_duration_min
podsearch_df[12,]$avg_duration_min <- podsearch_df[12,]$number_episodes
podsearch_df[12,]$number_episodes <- podsearch_df[12,]$show_link
podsearch_df[12,]$show_link <- podsearch_df[12,]$description
podsearch_df[12,]$description <- podsearch_df[12,]$image_href
podsearch_df[12,]$image_href <- 'error'
