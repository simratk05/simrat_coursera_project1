##############################################################################
#
# FILE
#   plot3.R
#
# OVERVIEW
#
#   Using data collected from the UC Irvine Machine Learning Repository,  
#   to generate a plot of different submetering vs time
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

with(data, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

	 
##############################################################################
# STEP 5 - Saving to file
##############################################################################	 

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
