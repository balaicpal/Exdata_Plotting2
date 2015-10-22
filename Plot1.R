#Read input Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
total_emission <- vector()
year <- vector()
NEI$year <- as.factor(NEI$year)

for (i in unique(NEI$year)){
  year_data <- subset(NEI,NEI$year == i)
  year <- c(year,i)
  total_emission <- c(total_emission,sum(year_data$Emissions))
}
png('plot1.png')

#Change the margin lengths
op <- par(mar = c(4,8,4,2))

#Plot initally with no axes ticks and labels
plot(year,total_emission,yaxt="n",xaxt="n",ann = FALSE,pch=15)

#Generate the y axis ticks
axis_seq = seq(min(total_emission),max(total_emission),length.out = 4)

#Plot the yaxis ticks
axis(2,at=axis_seq,las=1)

#Plot the xaxis ticks
axis(1,at=year,las=2)

#Draw lines joining the points
lines(year,total_emission,col="red",lwd=2)

#Give titles for xaxis,yaxis and for the plot as a whole
title(ylab = "Total PM2.5 emission(tonnes)",line = 4.5)

title(xlab = "Year",line = 2.5)
title(main="PM2.5 Emissions in each year")
dev.off()

#Restore original settings
par(op)