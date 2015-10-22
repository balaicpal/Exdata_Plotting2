#Read the data from source file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_emission <- vector()
year <- vector()
df <- data.frame(emission = numeric(),year = factor(),type= character())

NEI$year <- as.factor(NEI$year)
for (i in unique(NEI$type)){
  type_data <- subset(NEI,NEI$type == i & NEI$fips == "24510")
  for (j in unique(type_data$year)){
    year_data <- subset(type_data,type_data$year == j)
    year <- c(year,j)
    total_emission <- c(total_emission,sum(year_data$Emissions))
    df <- rbind(df,data.frame(emission = sum(year_data$Emissions), year = j, type = i))
  }
}
png('plot3.png')

g <- ggplot(df, aes(x = df$year,y = df$emission,color=df$type,group=df$type)) 
g <- g + geom_point() 
g <- g + geom_line() 
g <- g + labs(x= "Year")
g <- g + labs(y = "Emission(Tonnes)") 
g <- g + labs(color = "Type of Source") 
g <- g + labs(title="Change in Emission for each type and year at Baltimore")
print(g)

dev.off()
