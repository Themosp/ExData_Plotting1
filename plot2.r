#This R script reads specific rows from the Household Power Consumption dataset
#and creates a .png file of the Global Active Power measurement

#First, let us find out the column names of the dataset
pccolnames <- read.table("household_power_consumption.txt" , sep=";" , na.strings="? " , as.is=TRUE , nrows=1)

#Then let's see how many colums the dataset has
numofcols=ncol(pccolnames)

#Read only the first column of the dataset
pc.Dates=read.table("household_power_consumption.txt" , header=TRUE , sep=";" , na.strings="? " , as.is=TRUE , colClasses=c(NA,rep("NULL",numofcols-1)))

#convert the data into proper Date format
pc.Dates$Date=as.Date(pc.Dates$Date , format="%d/%m/%Y")

#Calculate how many rows to skip from start when reading the data
startrow=which.max(pc.Dates$Date >= "2007-02-01")

#Calculate how many rows to read when reading data
stoprow=which.max(pc.Dates$Date > "2007-02-02")
nofr=stoprow-startrow

#Read only desired data from file ( ! WITHOUT HEADERS ! ) to save memory space (and time)
plotdata=read.table("household_power_consumption.txt",sep=";",na.strings="?",as.is=TRUE,skip=startrow,nrow=nofr,col.names=pccolnames)

#Add a timestamp to the data
plotdata$Timestamp <- strptime(paste(plotdata$Date , plotdata$Time , sep=" ") , format="%d/%m/%Y %H:%M:%S")

#Create a plot and save it to a .png file
png(filename="plot2.png" , height=480 , width=480 , units="px" , bg = "white")

plot(plotdata$Timestamp,plotdata$Global_active_power, xlab="", ylab="Global Active Power (Kilowatts)",type="l")

# !!! Do not forget to close the output device !!!
dev.off()

