
##############################################################
# R script for plot figure 2
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


#combine the three datasets, this reflects we can combine three 
# data.frame by row
df_100Ma= rbind(DF_0_10100Ma, DF_10_100100Ma)

attach(df_100Ma)



#begin to plot
p_Figure2_3_Combed<-ggplot() + 
  geom_point(data=subset(df_100Ma,feature=="10_100"),aes(x = x,y = y),
           shape = 21,  #cycle shape
           fill = "#9dc3e6",color = "#1379c6", 
           size = 4,alpha = .6,stroke=1.1 )+
  
  geom_point(data=subset(df_100Ma,feature=="0_10"),aes(x = x,y = y),
             shape = 21, #cycle shape
             fill = "#FFB6C1",color = "#FF1493", 
             # the 10 percentiles into pink circles 
             #dark-orange #fe7217
             #light-orange #ffc411
             #light-pink #FFB6C1
             #deep-pink #FF1493
             size = 4,alpha = .6,stroke=1.2)+
  
  geom_smooth(data=subset(df_100Ma,feature=="0_10"),#the 10 percentiles used to do the curve fitting 
              aes(x = x,y = y),color='#ff64b1',#blue curve
              alpha = .45,span = 0.4, #the smoothness of the fit curve
              method="loess")+
  
  geom_point(data=DF_00_10MaPO2,aes(x = Age_Mg,y = -0.3*(1+log10(PO2))),#secondary Y axes
           shape = 21,fill = "#ffc411",color = "#fe7217", 
           size = 4,alpha = .6,stroke=1.1 )+
  
  geom_smooth(data=DF_00_10MaPO2,aes(x = Age_Mg,y = -0.3*(1+log10(PO2))),
            alpha = .45,span = 0.4,method="loess")+
  #set the scale and label
  scale_x_reverse(name = "Age (Ma)",
                  limits = c(2500, -1), 
                  breaks = seq(2500, -1, by = -500))+
  scale_y_reverse(name = "Ce/Ce*",
                  breaks = seq(1.5, 0, by = -0.3),
                  limits = c(1.5, -1.2), 
                  sec.axis = sec_axis(~ 10^((.* (-1/0.3))-1) ,
                                      breaks=c(0,1,10,100),
                                      labels=c(0,1,10,100),
                                      name = expression(P[O[2]]*"(% PAL)")), 
                  labels=seq(1.5, 0, by = -0.3)
                  )+
  #set some background color, font size, and ticks 
  theme_linedraw(base_size = 22)+
  theme(
    #panel.background = element_rect(fill = "white", colour = "grey50")
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    #panel.grid.major.x = element_line(colour = c("white"), size = c(0.33, 0.2)),
    # axis.text.x = element_text(colour = c(NA,"black")),
    axis.text.y.right=element_text(angle=90, hjust=0.5),
    axis.title.y.right = element_text(angle = 90)
  )


p_Figure2_3_Combed

#save the figure
ggsave(paste(workstation,"p_Figure2_Combed2500_100Ma_Loess045_rerun.pdf",sep=''), 
       plot = p_Figure2_3_Combed, device='pdf',height = 9.3, width = 12, units = "in",dpi =500)






