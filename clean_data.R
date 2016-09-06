#DOSPERT Norming Cleaning 
#Lilly Kofler 
#May 24, 2016


library(base)
library(stats)
library(plyr)
library(dplyr)

#set working directory to dropbox 

setwd("~/Dropbox/Dospert_Norming_Firstwave_Analyses")

###READ IN DATA###

#load in cleaned enviromental data from renaming script 
load("DOSPERT workspace.RData") 


#load in qualtrics data from all iterations of DOSPERT Norm 

DOSPERT_LZ <- read.csv("DOSPERT_with_LZ_study_n1000.csv", stringsAsFactors = F) %>% filter(serial != "") 
DOSPERT_JW <- read.csv("DOSPERT_with_JW_Study.csv", stringsAsFactors = F) %>% filter(serial != "")
DOSPERT_RC_S <- read.csv("DOSPERT_with_RC_Spillover.csv", stringsAsFactors = F) %>% filter(serial != "")
DOSPERT_RC_OM <- read.csv("DOSPERT_with_RC_Order_Matters (1).csv", stringsAsFactors = F) %>% filter(serial != "")
DOSPERT_RA <- read.csv("DOSPERT_with_Claudia_Study (1).csv", stringsAsFactors = F, fileEncoding="latin1") %>% filter(serial != "")


###QUALTRICS DATA###

##Lisa Zaval Data##

#remove second row and shannon test rows from LZ data
DOSPERT_LZ <- DOSPERT_LZ[-c(1:3), ]

#remove Lisa's data from LZ data 
DOSPERT_LZ <- dplyr::select(DOSPERT_LZ, -c(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, 
                                           sorbet, time.break_1,     
                                           time.break_2,        time.break_3,       time.break_4,       hot,                
                                           hotintro,            Q34,                 Q35,                 Q36,                
                                           Q37,                 Q38,                 Q39,                 Q40,                
                                           Q41,                 Q42,                 Q43,                 Q44 ,               
                                           Q45,                 Q46,                 time.hot_1,          time.hot_2,         
                                           time.hot_3,          time.hot_4,          neutral,             neutral.intro,      
                                           Q55,                 Q56,                 Q57,                 Q58,                
                                           Q59,                 Q60,                 Q61,                 Q62,                
                                           Q63,                 Q64,                 Q65,                 Q66,                
                                           Q67,                 time.neutral_1,      time.neutral_2,      time.neutral_3,     
                                           time.neutral_4,      cold,                cold.intro,          Q70,                
                                           Q71,                 Q72,                 Q73,                 Q74,                
                                           Q75,                 Q76,                 Q77,                 Q78,                
                                           Q79,                 Q80,                 Q81,                 Q82,                
                                           time.cold_1,         time.cold_2,         time.cold_3,         time.cold_4,        
                                           intro,               belief,              worry,               intro.1,            
                                           temp,                hunger,              temp.check, LocationLatitude,    LocationLongitude,   LocationAccuracy))


#remove experience columns that don't match with enviro data 

DOSPERT_LZ <- dplyr::select(DOSPERT_LZ, -c(Past.Dospert, Past.Dospert.Number, survey))

##JON WESTFALL DATA## 

#remove useless second row 
DOSPERT_JW <- DOSPERT_JW[-1, ]

#JW's columns and all other useless columns 

DOSPERT_JW <- dplyr::select(DOSPERT_JW, -c(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, time.break_1, time.break_2, time.break_3,        
                                           time.break_4, Time_Allocation_1_1,
                                           Time_Allocation_1_2, Time_Allocation_1_3,
                                           Time_Allocation_1_4, Time_Allocation_1_5,
                                           Time_Allocation_1_6, Time_Allocation_1_7,
                                           Time_Allocation_1_8, sorbet, Past.Dospert, Past.Dospert.Number, 
                                           LocationLatitude, LocationLongitude, LocationAccuracy)) 

##JW AND LZ MERGE## 

Dospert_LZ_JW <- full_join(DOSPERT_LZ, DOSPERT_JW)

##RAY CROOKES DATA SPILLOVER##

#remove useless second row 
DOSPERT_RC_S <- DOSPERT_RC_S[-1, ]

#RC's columns nad other useless columns
DOSPERT_RC_S <- dplyr::select(DOSPERT_RC_S, -c(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, ID,	ID2,	ID3, 
                                               time.break_1, time.break_2, time.break_3,        
                                               time.break_4, sorbet, OptOut, ooChoice_1, ooChoice_2, ooChoice_3,
                                               ooChoice_4,	ooChoice_5,	ooChoice_6,	ooChoice_7,	ooChoice_8,	
                                               ooChoice_9,	ooChoice_10,	ooChoice_11, ooChoice_12,	ooChoice_13,
                                               ooChoice_14,	OptIn,	OIChoice_1,	OIChoice_2,	OIChoice_3,	OIChoice_4,
                                               OIChoice_5,	OIChoice_6,	OIChoice_7,	OIChoice_8,	OIChoice_9,	
                                               OIChoice_10,	OIChoice_11,	OIChoice_12,	OIChoice_13, OIChoice_14,
                                               soNrm,	SNChoice_1,	SNChoice_2,	SNChoice_3,	SNChoice_4,	SNChoice_5,
                                               SNChoice_6,	SNChoice_7,	SNChoice_8,	SNChoice_9,	SNChoice_10,	SNChoice_11,
                                               SNChoice_12,	SNChoice_13,	SNChoice_14,	NegAff,	NAChoice_1,	NAChoice_2,
                                               NAChoice_3,	NAChoice_4,	NAChoice_5,	NAChoice_6,	NAChoice_7,	NAChoice_8,
                                               NAChoice_9,	NAChoice_10,	NAChoice_11,	NAChoice_12,	NAChoice_13,	NAChoice_14,
                                               Q114,	Donate_1,	Donate_2,	Identity_1,	Identity_2,	Identity_3,	Identity_4,
                                               Identity_5,	Identity_6, Identity_7,	Identity_9,	Identity_10,	Identity_11,
                                               Identity_12,	Identity_14,	Identity_15,	Identity_16,	Identity_17,	Identity_18,
                                               IDTime_1,	IDTime_2,	IDTime_3,	IDTime_4, Past.Dospert, Past.Dospert.Number, 
                                               LocationLatitude, LocationLongitude, LocationAccuracy))


##MERGE JW/LZ with RC_S##

DOSPERT_J_L_S <- full_join(DOSPERT_RC_S, Dospert_LZ_JW)

##RAY CROOKES ORDER MATTERS DATA##

#remove useless second row 
DOSPERT_RC_OM <- DOSPERT_RC_OM[-1, ]

##RC's columns nad other useless columns
DOSPERT_RC_OM <- dplyr::select(DOSPERT_RC_OM, -c(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, Past.Dospert, Past.Dospert.Number, 
                                                 time.break_1, time.break_2, time.break_3,        
                                                 time.break_4, sorbet, Term, Q177,               
                                                 NegFirst, Q96, Q97,                
                                                 Q98, Q99, Q100,               
                                                 Q101, Q102, Q103,               
                                                 Q104, Q105, Q106,              
                                                 Q107, Q108, PosFirst,            
                                                 Q115, Q116, Q117,               
                                                 Q118, Q119, Q120,              
                                                 Q121, Q122, Q123,               
                                                 Q124, Q125, Q126,
                                                 Q127, MidNeg, Q129,          
                                                 Q130, Q131, Q132,           
                                                 Q133, Q134, Q135,               
                                                 Q136, Q137, Q138,               
                                                 Q139, Q140, Q141,               
                                                 MidPos, Q143, Q144,               
                                                 Q145,                Q146,                Q147,               
                                                 Q148,                Q149,                Q150,               
                                                 Q151,                Q152,                Q153,               
                                                 Q154,                Q155,                Random,             
                                                 Q157,                Q158,                Q159,               
                                                 Q160,                Q161,                Q162,               
                                                 Q163,                Q164,                Q165,               
                                                 Q166,                Q167,                Q168,               
                                                 Q169,                firechoice,          promchoice,         
                                                 rating,              numprom,             numterm,            
                                                 valstr.1_1,          valstr.1_2,          valstr.1_4,         
                                                 valstr.1_5,          valstr.1_6,          valstr.1_7,         
                                                 valstr.1_8,          valstr.1_9,          valstr.1_10,        
                                                 valstr.1_11,         valstr.1_12,         valstr.1_14,        
                                                 valstr.1_15,         valstr.1_16,         valstr.2_1,         
                                                 valstr.2_2,          valstr.2_4,          valstr.2_5,         
                                                 valstr.2_6,          valstr.2_7,          valstr.2_8,        
                                                 valstr.2_9,          valstr.2_10,         valstr.2_11,        
                                                 valstr.2_12,         valstr.2_14,         valstr.2_15,        
                                                 valstr.2_16,         impact_5,            impact_6,           
                                                 impact_7,            impact_8,            impact_9,           
                                                 impact_10,           impact_11,           impact_13,          
                                                 impact_14,           impact_15,           impact_16,          
                                                 impact_17,           impact_18,           impact_19,          
                                                 fair,                whyfair,             whyunfair,          
                                                 Q179, dohmen1,           Q181,              dohmencar,         dohmenfin,        
                                                 dohmenrec,        dohmencareer,      dohmenhealth, LocationLatitude, LocationLongitude, LocationAccuracy)) 

##Merge Order Matters with Other Data##


DOSPERT <- full_join(DOSPERT_RC_OM, DOSPERT_J_L_S)


##CLaudia Data## 

#remove first row 
DOSPERT_RA<-DOSPERT_RA[-c(1), ]

#remove unnecessary columns
DOSPERT_RA <- dplyr::select(DOSPERT_RA, -c(ï..V1, V2, V3, V4, V5, 
                                            V6, V7, V8, V9, V10, Past.Dospert, 
                                            Past.Dospert.Number, sorbet, 
                                            time.break_1, time.break_2, time.break_3,
                                            Intro, intro_att, envbeh_8, envatt_1, selfothereff_1, 
                                            socialinfl_1, socialinfl2_1, satis1_1, satis2_1, motiv_1, 
                                            mot, thanks, intro_aff, value, aff_txt, timing_1, timing_2, 
                                            timing_3, timing_4, intro.control, control_txt, 
                                            timing_control_1, timing_control_2, timing_control_3, 
                                            timing_control_4, intro_pride, pride_txt, timing_pride_1, timing_pride_2, 
                                            timing_pride_3, timing_pride_4, intro_guilt, guilt_txt, timing_guilt_1, 
                                            timing_guilt_2, timing_guilt_3, timing_guilt_4, emo_1, emo_2, emo_3, emo_4, 
                                            emo_5, emo_6, emo_7, emo_8, thanks.1, intro_intent, intentions_1, intentions_2, 
                                            intentions_3, intentions_4, intentions_5, intentions_6, intentions_7, 
                                            intentions_8, intentions_9, effort_1, liveupto_1, end, prosoc, dohmen_intro, 
                                            dohmen1, dohmen_intro_2, dohmencar, dohmenfin, dohmenrec, dohmencareer, 
                                            dohmenhealth, LocationLatitude, LocationLongitude, LocationAccuracy))

#remove experience columns that don't match with enviro data 
DOSPERT_RA <- dplyr::select(DOSPERT_RA, -c(survey, X))

#merge with DOSPERT
DOSPERT <- full_join(DOSPERT, DOSPERT_RA)

DOSPERT <- dplyr::select(DOSPERT, -c(survey, time.break_4))


### ENVIROMENTAL DOSPERT DATA ###

#rename test to env_dos 

env_dos <- test


env_dos <- env_dos %>% mutate(Gender1 = ifelse(Gender == "0","1","2"))
env_dos <- env_dos %>% mutate(Ethnicity1 = ifelse(Ethnicity == "0","2","1"))
env_dos <- env_dos %>% mutate(Education1 = ifelse(Education == "0","1",
                                                  ifelse(Education == "1", "2",
                                                         ifelse(Education == "2", "3",
                                                                ifelse(Education == "3", "4",
                                                                       ifelse(Education =="4", "5",
                                                                              ifelse(Education =="5", "6",
                                                                                     ifelse(Education == "6", "7", "8"))))))))

#remove unecessary variables from environemntal data 
env_dos <- env_dos[, -c(2:5, 27, 37, 48, 69, 90, 101:125, 149:168)]
env_dos <- dplyr::select(env_dos, -c(Gender, Ethnicity, Education))

#rename demographics columns to match Qulatrics data 
env_dos <- dplyr::rename(env_dos, Gender = Gender1, Ethnicity = Ethnicity1, Education = Education1, Age = Birth_Year, Marital.Status = Marital_Status, Race_1 = Race_BlackAA_, 
                         Race_2 = Race_AmerInd_, Race_3 = Race_White_,  Race_4 = Race_Asian_, Race_5 = Race_Hawaii_, 
                         Race_6 = Race_NoAns_, Race_7_TEXT= Race_other_, Political_TEXT = Political_other_, Employment = EmploymentStatus,
                         Past.Surveys = Experience, Past.week.Surveys = Experience2, Comments = Questions)

#remove experience columns that don't match DOSPERT data 

env_dos <- dplyr::select(env_dos, -Experience3, -Experience4)


####MERGE DATAFRAMES####

#change class of columns so all the same by selecting columns and breaking into numeric and character dataframes 

dospert_stuff <- DOSPERT %>% dplyr::select(ethRT_1:socRB_6) %>% 
  mutate_each(funs(as.numeric))

demographics_stuff <- DOSPERT %>% dplyr::select(serial, Gender:Comments) %>%
  mutate_each(funs(as.character))

env_dospert_stuff <- env_dos %>% dplyr::select(socRT_1:ethRB_6) %>% 
  mutate_each(funs(as.numeric))

env_demographics_stuff <- env_dos %>% dplyr::select(serial, Age:Education) %>%
  mutate_each(funs(as.character))

#change weird values within env_dos data demographics while separated 
#first race 

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Race_AA = ifelse(Race_1 =="Y", "1", "0"))

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Race_AI = ifelse(Race_2 =="Y", "1", "0"))

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Race_W = ifelse(Race_3 =="Y", "1", "0"))

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Race_As = ifelse(Race_4 =="Y", "1", "0"))

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Race_H = ifelse(Race_5 =="Y", "1", "0"))

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Race_NA = ifelse(Race_6 =="Y", "1", "0"))

env_demographics_stuff <- env_demographics_stuff  %>% dplyr::select(-Race_1, - Race_2, -Race_3, -Race_4, -Race_5, -Race_6) 

env_demographics_stuff <- env_demographics_stuff  %>% dplyr::rename(Race_O = Race_7_TEXT)

#marital status 
#single = 1, married = 2, div/ls = 3, liv together = 4, widow = 5, no answer = 6 

env_demographics_stuff <- env_demographics_stuff  %>% mutate(Marital_Status = ifelse(Marital.Status =="Singl", "1", 
                                                                                     ifelse(Marital.Status =="Marri", "2", 
                                                                                            ifelse(Marital.Status =="DivLS", "3", 
                                                                                                   ifelse(Marital.Status =="LivTo", "4", 
                                                                                                          ifelse(Marital.Status == "Widow", "5",
                                                                                                                 ifelse(Marital.Status == "NoAns", "6", "0")))))))



env_demographics_stuff <- env_demographics_stuff  %>% dplyr::select(-Marital.Status) 

#rename the DOSPERT demographics to match 

demographics_stuff <- demographics_stuff %>% dplyr::rename(Race_AA = Race_1, Race_AI = Race_2, Race_W = Race_3, Race_As = Race_4, 
                                                           Race_H = Race_5, Race_NA = Race_6, Race_O = Race_7_TEXT, Marital_Status = Marital.Status)



#remerge the dataframes 
DOSPERT <- cbind(dospert_stuff, demographics_stuff)

env_dos <- cbind(env_dospert_stuff, env_demographics_stuff)

#merge the norming and enviro data 
Dospert_Clean <- full_join(DOSPERT, env_dos)

#remove any rows with NAs in dospert questions 

completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

Dospert_Clean <- completeFun(Dospert_Clean, c("ethRT_1", "ethRT_2", "ethRT_3", "ethRT_4", "ethRT_5", "ethRT_6", 
                                              "ethRP_1", "ethRP_2", "ethRP_3", "ethRP_4", "ethRP_5", "ethRP_6", 
                                              "ethRB_1", "ethRB_2", "ethRB_3", "ethRB_4", "ethRB_5", "ethRB_6", 
                                              "finRT_1", "finRT_2", "finRT_3", "finRT_4", "finRT_5", "finRT_6", 
                                              "finRP_1", "finRP_2", "finRP_3", "finRP_4", "finRP_5", "finRP_6", 
                                              "finRB_1", "finRB_2", "finRB_3", "finRB_4", "finRB_5", "finRB_6", 
                                              "heaRT_1", "heaRT_2", "heaRT_3", "heaRT_4", "heaRT_5", "heaRT_6", 
                                              "heaRP_1", "heaRP_2", "heaRP_3", "heaRP_4", "heaRP_5", "heaRP_6", 
                                              "heaRB_1", "heaRB_2", "heaRB_3", "heaRB_4", "heaRB_5", "heaRB_6", 
                                              "recRT_1", "recRT_2", "recRT_3", "recRT_4", "recRT_5", "recRT_6", 
                                              "recRP_1", "recRP_2", "recRP_3", "recRP_4", "recRP_5", "recRP_6", 
                                              "recRB_1", "recRB_2", "recRB_3", "recRB_4", "recRB_5", "recRB_6", 
                                              "socRT_1", "socRT_2", "socRT_3", "socRT_4", "socRT_5", "socRT_6", 
                                              "socRP_1", "socRP_2", "socRP_3", "socRP_4", "socRP_5", "socRP_6", 
                                              "socRB_1", "socRB_2", "socRB_3", "socRB_4", "socRB_5", "socRB_6"))

#merge race columns
#1 = African American/Black 
#2= American Indian 
#3= White 
#4 = Asian 
#5 = Hawaiian/Pacific 
#6 = No Answer 
#7 = Other 

Dospert_Clean <- Dospert_Clean  %>% mutate(Race = ifelse(Race_AA =="1", "1", 
                                                         ifelse(Race_AI =="1", "2", 
                                                                ifelse(Race_W =="1", "3", 
                                                                       ifelse(Race_As =="1", "4", 
                                                                              ifelse(Race_H == "1", "5",
                                                                                     ifelse(Race_NA == "1", "6", 
                                                                                            ifelse(Race_O == "Hispanic", "7",
                                                                                                   ifelse(Race_O == "Multiracial", "7",
                                                                                                          ifelse(Race_O == "Middle Eastern/Arab", "7", "6"))))))))))



#remove old race columns 

Dospert_Clean <- Dospert_Clean  %>% 
  
  dplyr::select(-c(Race_AA, Race_AI, Race_W, Race_As, Race_H, Race_NA, Race_O))

#remove people who didn't understand age question 
#adding in age column converting year to current age 
#first renaming age column to birth year to avoid confusion 


# Dospert_Clean <- Dospert_Clean[Dospert_Clean$Age > 1900,]


Dospert_Clean <- Dospert_Clean %>% dplyr::mutate(Political1 = ifelse(Political == "1", "1",
                                                                     ifelse(Political == "2", "3",
                                                                            ifelse(Political == "3", "2", "4"))))    


Dospert_Clean <- Dospert_Clean %>%
  dplyr::filter(Age > 1900) %>%
  dplyr::rename(Birth_Year = Age) %>%
  dplyr::mutate(Birth_Year = as.numeric(Birth_Year),
                Age = 2016 - Birth_Year) %>%
  dplyr::filter(Age < 1900, 
                Gender < 3,
                Gender > 0, 
                Ethnicity < 3,
                Ethnicity > 0,
                Political < 4,
                Political > 0,
                Political != "-oth-", 
                Income < 8,
                Income > 0,
                Marital_Status < 6,
                Children != 9999, 
                Children != 34,
                Children != 53, 
                Children != 24, 
                Children != 19, 
                Children != 26,
                Children != 30, 
                Children != 32, 
                Children != 45, 
                Children != 54325)


#convert last few demogrpahics columns to numeric for analyses 
Dospert_Clean$Children <- as.numeric(Dospert_Clean$Children)
Dospert_Clean$Past.Surveys <- as.numeric(Dospert_Clean$Past.Surveys)
Dospert_Clean$Past.week.Surveys <- as.numeric(Dospert_Clean$Past.week.Surveys)
Dospert_Clean$Gender <- as.numeric(Dospert_Clean$Gender)

#remove any duplicate serial numbers

Dospert_Clean <- Dospert_Clean[!duplicated(Dospert_Clean[,91]),]


#save cleaned data as RDS 

saveRDS(Dospert_Clean, "Dospert_Norm_Data.rds")

#clean global environment 

rm(list = ls()) 








