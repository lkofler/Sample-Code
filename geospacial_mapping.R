#geo-spatial mapping by zipcode 


#reading in  libraries
library(zipcode)
library(ggmap)
library(dplyr)
data("zipcode")

#setwd to project 
setwd("~/Dropbox/Dospert_Norming_Firstwave_Analyses")

#read in cleaned norming data 
datafile <- readRDS("Dospert_Norm_Data.RDS")

#this strips off "Zip+4" suffixes & replaces non-US zipcodes with NAs
datafile$zip <- clean.zipcodes(datafile$Zipcode)

#this adds latitude and longitude, state, city information to a new dataset
ProcessedGeoData= merge(datafile, zipcode, by.x='zip', by.y='zip')

#############################################################################
#mapping!
library(ggmap) #install.packages("ggmap")  

#getting US backgrop to plot
usa_center <- as.numeric(geocode("United States"))
USAMap <- ggmap(get_googlemap(center=usa_center, 
                              scale=2, zoom=4), extent="normal")  
#cleaning for non-continental US points i.e. "outliers"
ProcessedGeoData <- ProcessedGeoData %>% 
  filter(state != "AK", #alaska and hawaii
         state != "HI") 

state_aggregate <- ProcessedGeoData %>% 
  group_by(state) 

circle_scale_amt <- .05 #plot aesthetics 

USAMap +  
  geom_point(data=ProcessedGeoData, 
             aes(x=longitude, y=latitude), alpha=0.4, 
             col="orange")