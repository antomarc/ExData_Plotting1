################################
## Electric power consumption ##
################################
## The goal is to examine how household energy usage varies over a 2-day period in February, 2007.
## Plot 2: Global Active Power (kilowatts) function of time


# Preparing   
# In working directory  
# this file "plot2.R" and the unzipped folder "exdata-data-household_power_consumption" 
# that contains "household_power_consumption.txt", the raw data.


if (!require("data.table")){install.packages("data.table")}
require("data.table")
if (!require("dplyr")){install.packages("dplyr")}
require("dplyr")
if (!require("lubridate")){install.packages("lubridate")}
require("lubridate")


####################
## Loading the data


dt0<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",sep=";",na.strings=c("NA", "?"),stringsAsFactors=FALSE)  
#dt0: 2075260 obs. of  1 variable

#First row is not an observation: it contains names of variables 
#dt0[1,]:  Date Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3

dt1<-slice(dt0,-1)  ## all rows except row number 1
names(dt1)<-slice(dt0,1)
#dt1:  2075259 obs. of 9 var.

dt1<-mutate(dt1,DateTime=paste(Date,Time,sep="_")) #chr "16/12/2006_17:24:00"...
dt1<-select(dt1,DateTime,Global_active_power)
#dt1:  2075259 obs. of 2 var. chr chr

dt1$DateTime<-dmy_hms(dt1$DateTime) #POSIXct "2006-12-16 17:24:00"...


## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## Subsetting dataset to those dates:

dt<-filter(dt1,as.Date(dt1$DateTime)>="2007-02-01",as.Date(dt1$DateTime)<="2007-02-02")
#dt 2880 obs of 2 var
dt$Global_active_power<-as.numeric(dt$Global_active_power)

any(is.na(dt)) #FALSE
#no NA in dt


####################
## Making Plots
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Plot 2: Global Active Power (kilowatts) function of time


Sys.setlocale("LC_TIME", "English") #"Thu Fri Sat" in plot

png("plot2.png",width=480,height=480,bg="transparent")

plot(x=dt$DateTime,y=dt$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()

