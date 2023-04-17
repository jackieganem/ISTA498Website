# Manual individual scrape, to test for issues

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
podsearch_df_tester <- data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(podsearch_df_tester) <- columns

# Function that takes the RSS url and grabs all the datapoints for one podcast.

css_tags <- c('title', 'pubDate', 'itunes\\:explicit', 'itunes\\:duration')
col_names <- c('title', 'date', 'explicit', 'duration')


### Put URL in line below to test.
url <- 'https://feed.podbean.com/thenationalnewsmy2020/feed.xml'


podcast_feed <- read_xml(url)
items <- xml_nodes(podcast_feed, 'item')

extract_element <- function(item, css_tags) {
  element <- xml_node(item, css_tags) %>% xml_text
}

podcast_df <- sapply(css_tags, function(x) {
  extract_element(items, x)}) %>% as_tibble()
names(podcast_df) <- col_names


# Gathers all the values wanted for podsearch_df row

# Values from podcast_df (created above):
number_epis <- nrow(podcast_df)

### Issues because of discrepancies in how the duration is shown. Work in progress.
avg_duration_min<- round((((sum(as.integer(podcast_df$duration)))/(number_epis)) / 60)) 

### I want to give podcasts zodiac signs LOL. Work in progress.
birthday<- podcast_df$date[nrow(podcast_df)] 


# Values from XML file:
xml_file<- xmlParse(read_xml(url))  

title<- xmlToDataFrame(getNodeSet(xml_file, '//channel/title'))
image<- xmlToDataFrame(getNodeSet(xml_file, 'itunes:image'))
if(nrow(image)==0){
  image<- "NO IMAGE"
  print("IMAGE ISSUE")
}

print(image)
description<- xmlToDataFrame(getNodeSet(xml_file, '//channel/itunes:summary'))
if(nrow(description)==0){
  description<- "NO DESCRIPTION"
  print("DESC ISSUE")
}
rsslink<- xmlToDataFrame(getNodeSet(xml_file, '//channel/link')) 
explicit <- xmlToDataFrame(getNodeSet(xml_file, '//channel/itunes:explicit'))

# Appends a column to podsearch_df about one individual podcast! 

print(c(url, title, image, description, rsslink, number_epis, avg_duration_min, explicit, birthday))
print(title[1,1])

podsearch_df_tester[i,] <- c(url, title, image, description, rsslink, number_epis, avg_duration_min, explicit, birthday)
