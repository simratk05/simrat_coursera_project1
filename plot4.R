##############################################################################
#
# FILE
#   plot4.R
#
# OVERVIEW
#
#   Using data collected from the UC Irvine Machine Learning Repository,  
#   to generate 4 plots in 1 space (GAP vs. time, Vol vs. time, 
# 	submetering vs. time and GRP vs. time)
#
#   See README.md for details.
#
#
##############################################################################


##############################################################################
# STEP 1 - Get data
##############################################################################

data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")


##############################################################################
# STEP 2 - Subsetting the data
##############################################################################

data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

##############################################################################
# STEP 3 - Converting dates
##############################################################################
 
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

##############################################################################
# STEP 4 - Generate the plot
##############################################################################

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})

	 
##############################################################################
# STEP 5 - Saving to file
##############################################################################	 

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
