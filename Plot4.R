#Read input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- data.frame(emission = numeric(),year = integer())
Coal_list <- grep("Coal",SCC$Short.Name)

Combustion_list <- grep("Combustion",SCC$Short.Name)
SCC_list <- SCC$SCC[intersect(Coal_list,Combustion_list)]
for (i in unique(NEI$year)){
  total_emission <- vector()
  for (j in SCC_list){
    SCC_data <- subset(NEI,NEI$year == i & NEI$SCC == j)
    total_emission <- c(total_emission,sum(SCC_data$Emissions))
  }
  df <- rbind(df,data.frame(emission = sum(total_emission),year = i))
}
print(df)
png('plot4.png')
g <- ggplot(df,aes(x = df$year,y = df$emission,group = 1)) 
g <- g + geom_point() 
g <- g + geom_line() 
g <- g + labs(x= "Year")
g <- g + labs(y = "Emission(Tonnes)") 
g <- g + labs(title="Change in Emission for COal Combustion as source over years")
print(g)
dev.off()
