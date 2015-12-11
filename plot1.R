################################
## Electric power consumption ##
################################
## The goal is to examine how household energy usage varies over a 2-day period in February, 2007.
## Plot 1: Histogram of Global_active_power  (in kilowatt)


# Preparing   
# In working directory  
# this file "plot1.R" and the unzipped folder "exdata-data-household_power_consumption" 
# that contains "household_power_consumption.txt", the raw data.


if (!require("data.table")){install.packages("data.table")}
require("data.table")
if (!require("dplyr")){install.packages("dplyr")}
require("dplyr")


####################
## Loading the data


dt0<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",sep=";",na.strings=c("NA", "?"),stringsAsFactors=FALSE)  
#dt0: 2075260 obs. of  1 variable

#First row is not an observation: it contains names of variables 
#dt0[1,]:  Date Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3

dt1<-slice(dt0,-1)  ## all rows except row number 1
names(dt1)<-slice(dt0,1)
#dt1:  2075259 obs. of 9 var.

## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## Subsetting dataset to those dates:

#dt1$Date chr "16/12/2006"...
dt1$Date<-strptime(dt1$Date,"%d/%m/%Y") #POSIXlt "2006-12-16"...
dt1$Date<-as.Date(dt1$Date) #Date "2006-12-16"...

dt<-filter(dt1,dt1$Date>="2007-02-01",dt1$Date<="2007-02-02") 
#dt: 2880 obs. of 9 var.

any(is.na(dt[,3:9])) #FALSE
#no NA in dt


d<-dt%>%select(Date,Time,Global_active_power)  #2880 obs. of 3 var.

d$Global_active_power<-as.numeric(d$Global_active_power)


####################
## Making Plots
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Plot 1: Histogram of Global_active_power  (in kilowatt)


png("plot1.png",width=480,height=480,bg="transparent")

hist(d$Global_active_power,breaks=12,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()

