
##############################################################
# R script for plot figure 3
# of paper "A persistently low-level of atmospheric oxygen in Earth's middle age"
# by Xiaoming Liu, published on Nature communications
##############################################################


library(quantreg)
library(dplyr)
library(ggplot2)
library(tidyverse)

#define a workstation
workstation='C:\\Workstation\\XiaomingLiu\\'

#give the file path of the dataset prepared
csvfile=paste(workstation,'Ce_DataVersion3.csv',sep='')

#read the csv file and get the dataframe
CeDataFrame <- read_csv(csvfile)


#set the Age to null since we don;t need it
CeDataFrame$Age<-NULL


# Check for missing values for Ce and Age (Ma)
colSums(is.na(CeDataFrame))

# remove null
CeDataFrame <- CeDataFrame[complete.cases(CeDataFrame), ]

#get the colnames to be used later
colnames(CeDataFrame)


breaks <-c(seq(from = 0, to = 3500, by =100))
# specify interval/bin labels
tags <- c("[0-100)","[100-200)", "[200-300)", "[300-400)", "[400-500)", 
          "[500-600)","[600-700)", "[700-800)","[800-900)", "[900-1000)",
          "[1000-1100)","[1100-1200)", "[1200-1300)","[1300-1400)", "[1400-1500)",
          "[1500-1600)","[1600-1700)", "[1700-1800)","[1800-1900)", "[1900-2000)",
          "[2000-2100)","[2100-2200)", "[2200-2300)","[2300-2400)", "[2400-2500)",
          "[2500-2600)","[2600-2700)", "[2700-2800)","[2800-2900)", "[2900-3000)",
          "[3000-3100)","[3100-3200)", "[3200-3300)","[3300-3400)", "[3400-3500)")


# bucketing values into bins
group_tags <- cut(CeDataFrame$Age_Mg, 
                  breaks=breaks, 
                  include.lowest=TRUE, 
                  right=FALSE, 
                  labels=tags)

summary(group_tags) # inspect bins


v <- CeDataFrame %>% select(Age_Mg,Ce_Ce) #pick the variable 

vgroup <- as_tibble(v) %>% #group the data based on Age_Mg
  mutate(tag = case_when(
    Age_Mg < 100 ~ tags[1],
    Age_Mg >= 100 & Age_Mg < 200 ~ tags[2],
    Age_Mg >= 200 & Age_Mg < 300 ~ tags[3],
    Age_Mg >= 300 & Age_Mg < 400 ~ tags[4],
    Age_Mg >= 400 & Age_Mg < 500 ~ tags[5],
    Age_Mg >= 500 & Age_Mg < 600 ~ tags[6],
    Age_Mg >= 600 & Age_Mg < 700 ~ tags[7],
    Age_Mg >= 700 & Age_Mg < 800 ~ tags[8],
    Age_Mg >= 800 & Age_Mg < 900 ~ tags[9],
    Age_Mg >= 900 & Age_Mg < 1000 ~ tags[10],
    Age_Mg >= 1000 & Age_Mg < 1100 ~ tags[11],
    Age_Mg >= 1100 & Age_Mg < 1200 ~ tags[12],
    Age_Mg >= 1200 & Age_Mg < 1300 ~ tags[13],
    Age_Mg >= 1300 & Age_Mg < 1400 ~ tags[14],
    Age_Mg >= 1400 & Age_Mg < 1500 ~ tags[15],
    Age_Mg >= 1500 & Age_Mg < 1600 ~ tags[16],
    Age_Mg >= 1600 & Age_Mg < 1700 ~ tags[17],
    Age_Mg >= 1700 & Age_Mg < 1800 ~ tags[18],
    Age_Mg >= 1800 & Age_Mg < 1900 ~ tags[19],
    Age_Mg >= 1900 & Age_Mg < 2000 ~ tags[20],
    Age_Mg >= 2000 & Age_Mg < 2100 ~ tags[21],
    Age_Mg >= 2100 & Age_Mg < 2200 ~ tags[22],
    Age_Mg >= 2200 & Age_Mg < 2300 ~ tags[23],
    Age_Mg >= 2300 & Age_Mg < 2400 ~ tags[24],
    Age_Mg >= 2400 & Age_Mg < 2500 ~ tags[25],
    Age_Mg >= 2500 & Age_Mg < 2600 ~ tags[26],
    Age_Mg >= 2600 & Age_Mg < 2700 ~ tags[27],
    Age_Mg >= 2700 & Age_Mg < 2800 ~ tags[28],
    Age_Mg >= 2800 & Age_Mg < 2900 ~ tags[29],
    Age_Mg >= 2900 & Age_Mg < 3000 ~ tags[30],
    Age_Mg >= 3000 & Age_Mg < 3100 ~ tags[31],
    Age_Mg >= 3100 & Age_Mg < 3200 ~ tags[32],
    Age_Mg >= 3200 & Age_Mg < 3300 ~ tags[33],
    Age_Mg >= 3300 & Age_Mg < 3400 ~ tags[34],
    Age_Mg >= 3400 & Age_Mg < 3500 ~ tags[35]
  ))

summary(vgroup)

#To make the new column tag as a factor from a character vector.
vgroup$tag <- factor(vgroup$tag,
                     levels = tags,
                     ordered = FALSE)
summary(vgroup$tag)


##########################################
#after 100Ma bin group tag setting, 
#now we can calculate the min 10% pencentile of Ce/Ce* for each bin
#Step1: group bin elements based on tag 
#Step2: filter elements in each 100Ma bin group 
#based on the Ce-Ce minimum 10% of this bin group
quantile_00_10_Ce100Ma=vgroup %>% group_by(tag) %>% filter(quantile(Ce_Ce, 0.1)>=Ce_Ce)

quantile_10_100_Ce100Ma=vgroup %>% group_by(tag) %>% filter(quantile(Ce_Ce, 0.1)<Ce_Ce)

vgroup %>% group_by(tag)


#assgin the data into dataframe
DF_0_10100Ma = data.frame(x=quantile_00_10_Ce100Ma$Age_Mg, y=quantile_00_10_Ce100Ma$Ce_Ce)

DF_10_100100Ma = data.frame(x=quantile_10_100_Ce100Ma$Age_Mg, y=quantile_10_100_Ce100Ma$Ce_Ce)




##########################################
#after 100Ma bin group tag setting, 
#now we can calculate the min 10% pencentile of Ce/Ce* for each bin
#Step1: group bin elements based on tag 
#Step2: filter elements in each 100Ma bin group 
#based on the Ce-Ce minimum 10% of this bin group
quantile_00_10_Ce100Ma=
  vgroup %>%                                  # Specify data frame     
  group_by(tag) %>%                           # Specify group indicator
  filter(quantile(Ce_Ce, 0.1)>=Ce_Ce)         # Specify column and function


#calculate the mean of the min 10% of 100-0Ma Ce/Ce* values
#it approximate 0.27 should be a fixed value
FilterModernCe_Ce100Ma<-quantile_00_10_Ce100Ma %>% filter(Age_Mg<100)


#calculate the Modern Ce_Ce within 100Ma
GetMeanModernCe_Ce100Ma<-mean(FilterModernCe_Ce100Ma$Ce_Ce)


###add the value
# CeDataFrame$PO2<-(0.27/real time 10% of Ce/Ce* within 100Ma years bin)^4*100
# quantile_00_10_Ce100MaAddMean$PO2<-(GetMeanModernCe_Ce100Ma/quantile_00_10_Ce100MaAddMean$Ce_Ce)^4
quantile_00_10_Ce100Ma$PO2<-(GetMeanModernCe_Ce100Ma/quantile_00_10_Ce100Ma$Ce_Ce)^4*100

#assgin the data into dataframe
# DF_00_10MaPO2 = data.frame(Age_Mg=quantile_00_10_Ce100MaAddMean$Age_Mg, PO2=quantile_00_10_Ce100MaAddMean$PO2)
DF_00_10MaPO2 = data.frame(Age_Mg=quantile_00_10_Ce100Ma$Age_Mg, PO2=quantile_00_10_Ce100Ma$PO2)
attach(DF_00_10MaPO2)


##############################################
###re-organize the dataset

# add another feature variable to 
#differentiate the two datasets
DF_0_10100Ma$feature="0_10"
DF_10_100100Ma$feature="10_100"

#set PO2 data and add label
DF_00_10MaPO2$feature="PO2"




####################################################
####Loading other dataset for comparision###########

#PhanerozoicO2_Proxies_Min
PhanerozoicO2_Proxies_Min_csvfile=paste(workstation,'PhanerozoicO2_Proxies_Min.csv',sep='')

#PhanerozoicO2_Proxies_Max
PhanerozoicO2_Proxies_Max_csvfile=paste(workstation,'PhanerozoicO2_Proxies_Max.csv',sep='')

#PhanerozoicO2_COPSE
PhanerozoicO2_COPSE_csvfile=paste(workstation,'PhanerozoicO2_COPSE.csv',sep='')

#PhanerozoicO2_GEOCARBSULF
PhanerozoicO2_GEOCARBSULF_csvfile=paste(workstation,'PhanerozoicO2_GEOCARBSULF.csv',sep='')



#read the csv file and get the dataframe
PhanerozoicO2_Proxies_MinDataFrame <- read_csv(PhanerozoicO2_Proxies_Min_csvfile)
PAL_Min_DF = data.frame(x=PhanerozoicO2_Proxies_MinDataFrame$Age_Ma, y=PhanerozoicO2_Proxies_MinDataFrame$Min_O2)

#read the csv file and get the dataframe
PhanerozoicO2_Proxies_Max_DataFrame <- read_csv(PhanerozoicO2_Proxies_Max_csvfile)
PAL_Max_DF = data.frame(x=PhanerozoicO2_Proxies_Max_DataFrame$Age_Ma, y=PhanerozoicO2_Proxies_Max_DataFrame$Max_O2)

#read the csv file and get the dataframe
PhanerozoicO2_COPSE_DataFrame <- read_csv(PhanerozoicO2_COPSE_csvfile)
PAL_COPSE_DF = data.frame(x=PhanerozoicO2_COPSE_DataFrame$Age_Ma, y=PhanerozoicO2_COPSE_DataFrame$O2_PAL)

#read the csv file and get the dataframe
PhanerozoicO2_GEOCARBSULF_DataFrame <- read_csv(PhanerozoicO2_GEOCARBSULF_csvfile)
PAL_GEOCARBSULF_DF = data.frame(x=PhanerozoicO2_GEOCARBSULF_DataFrame$Age_Ma, y=PhanerozoicO2_GEOCARBSULF_DataFrame$O2_PAL)


#begin to plot
p_Figure3<-
  ggplot() + 
  
  #set the line
  #color = "#FC4714"
  geom_line(data=PAL_Min_DF,aes(x = x,y = y,colour = "Proxies"),linetype = "dashed", size = 1.5,alpha = .8 )+
  #color = "#FC4714"
  geom_line(data=PAL_Max_DF,aes(x = x,y = y,colour = "Proxies"),linetype = "dashed", size = 1.5,alpha = .8 )+
  #color = "#00D050"
  geom_line(data=PAL_COPSE_DF,aes(x = x,y = y,colour = "COPSE"),linetype = "solid", size = 1.2,alpha = .8 )+
  #color = "#00B0F0"
  geom_line(data=PAL_GEOCARBSULF_DF,aes(x = x,y = y,colour = "GEOCARBSULF"),linetype = "solid", size = 1.2,alpha = .8 )+
  
  geom_point(data=DF_00_10MaPO2,aes(x = Age_Mg,y = PO2),
           shape = 21, #cycle shape
           fill = "#FFB6C1",color = "#FF1493", size = 4,alpha = .6,stroke=1.1 )+
  
  #do the curve fitting 
  geom_smooth(data=DF_00_10MaPO2,aes(x = Age_Mg,y = PO2,colour = "ThisStudy"),
            alpha = .45,span = 0.5,method="loess")+
  #set the scale and label
  scale_x_reverse(name = "Age (Ma)",
                # limits = c(2500, -1),
                # breaks = seq(2500, -1, by = -500) )+
                limits = c(700, -1), # change the range of plot
                breaks = seq(600, -1, by = -200) )+
  
  scale_y_log10(position = "right",breaks=c(0,1,10,100),labels=c(0,1,10,100))+
  
  ylab(expression(P[O[2]]*"(% PAL)"))+ #"PO2 (PAL)" #Log transformation of y scale
  
  scale_colour_manual("", 
                      breaks = c("Proxies", "COPSE", "GEOCARBSULF","ThisStudy"),
                      values = c("Proxies"="#FC4714", "COPSE"="#00D050", 
                                 "GEOCARBSULF"="#00B0F0","ThisStudy"="blue")) +
  
  theme_linedraw(base_size = 22)+ #set some background color, font size, and ticks 
  theme(
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    axis.text.y.right=element_text(angle=90, hjust=0.5),
    axis.title.y = element_text(angle = 270),
    axis.title.y.right = element_text(angle = 90)
  )

p_Figure3

#export the pdf format
ggsave(paste(workstation,"ScatterPlotPO2_Figure3_sep0_600_100bin_Loess_045_rerun.pdf",sep=''), 
       plot = p_Figure3, device='pdf',height = 7.5, width = 15, units = "in",dpi =500)

