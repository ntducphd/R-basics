#Scientist: Nguyen Trung Duc
#Institute: ICAR - Indian Agricultural Research Institute
#Email: ntduc11@gmail.com
#Website: ntduc11.github.io

#Techbooks
###01. Wickham, H., & Grolemund, G. (2016). R for data science: import, tidy, transform, visualize, and model data. " O'Reilly Media, Inc.".
###02. Rahlf, T. (2019). Data Visualisation with R: 111 Examples. Springer Nature.


###R basic practical for data visualization
#Create working directory
my.dir <- 'C:/R.practice/R.basics'
if(file.exists(my.dir)){
  cat(paste0('Deleting dir: ', my.dir, ' ...\n'))
  unlink(my.dir, recursive=TRUE, force=TRUE) ## danger! danger!
}
dir.create(my.dir)

#Set the working directory
setwd(my.dir)

## Now the working directory is:
getwd()
## Cleaning the workspace
rm(list=ls())

#Install R packages
R.packages <- c('ggpubr', 'FactoMineR','factoextra','corrplot', 'ade4', 'ggplot2', 'RColorBrewer', 'ggbeeswarm', 'ggridges')
install.packages(R.packages)

#Load all library
library("ggpubr")
library("FactoMineR")
library("factoextra")
library("corrplot")
library("ade4")
library("RColorBrewer")
library("ggplot2")
library("ggbeeswarm")
library("ggridges")

#Load data
head(mpg)

#Plot data
my_plot <- ggplot(data = mpg, aes(x=displ, y=hwy))
my_plot <- my_plot + geom_point()
my_plot

#Add more information in the plot
my_plot <- ggplot(data = mpg, aes(x=displ, y=hwy, colour = class))
my_plot <- my_plot + geom_point()
my_plot

#Add other information
my_plot <- ggplot(data = mpg, aes(x=displ, y=hwy, colour = class, size = cyl))
my_plot <- my_plot + geom_point()
my_plot

#Univariate graphs
my_box_plot <- ggplot(data = mpg, mapping = aes(x = class, y = hwy)) 
my_box_plot <- my_box_plot + geom_boxplot()
my_box_plot

#Add more information
my_box_plot <- ggplot(data = mpg, mapping = aes(x = class, y = hwy)) 
my_box_plot <- my_box_plot + geom_boxplot()
my_box_plot <- my_box_plot + geom_jitter()
my_box_plot

#Modify for publication (black and white)
my_box_plot <- ggplot(data = mpg, mapping = aes(x = class, y = hwy)) 
my_box_plot <- my_box_plot + geom_boxplot()
my_box_plot <- my_box_plot + geom_quasirandom()
my_box_plot

#Modify for publication (color)
my_box_plot <- ggplot(data = mpg, mapping = aes(x = class, y = hwy, colour=class)) 
my_box_plot <- my_box_plot + geom_boxplot()
my_box_plot <- my_box_plot + geom_quasirandom()
my_box_plot


#Remove border
my_box_plot <- ggplot(data = mpg, mapping = aes(x = class, y = hwy, colour=class)) 
my_box_plot <- my_box_plot + geom_quasirandom(alpha = 0.6)
my_box_plot <- my_box_plot + stat_summary(fun.y=mean, geom="point", shape=95, size=10, color="black", fill="black")
my_box_plot


# Label axes
my_box_plot <- my_box_plot + labs(y = "fuel efficiency", 
                                  x = "Class",
                                  title = "Automobile Fuel Efficiency by Class")
my_box_plot

#Change the coordinate by flip function
my_box_plot <- my_box_plot + coord_flip()
my_box_plot


#Present data with RIDGE graph
ridge_graph <- ggplot(mpg, aes(x = cty, y = class, fill = class)) 
ridge_graph <- ridge_graph + geom_density_ridges() 
ridge_graph <- ridge_graph + theme_ridges() 
ridge_graph <- ridge_graph + labs(y="Highway mileage",
                                  x = "Class",
                                  title = "Highway mileage by auto class") 
ridge_graph <- ridge_graph + theme(legend.position = "none")
ridge_graph

#Multivariate graphs
data(gapminder, package = "gapminder")
head(gapminder)

# Select the Americas data
plotdata <- dplyr::filter(gapminder, 
                          continent == "Americas")
# Plot selected data
life_graph <- ggplot(plotdata, aes(x=year, y = lifeExp, colour = country)) 
life_graph <- life_graph + geom_line() 
life_graph <- life_graph + theme(axis.text.x = element_text(angle = 45, 
                                                            hjust = 1)) 
life_graph <- life_graph + labs(title = "Changes in Life Expectancy", 
                                x = "Year",
                                y = "Life Expectancy") 
life_graph

# facetting it into separate countries:
life_graph <- ggplot(plotdata, aes(x=year, y = lifeExp)) 
life_graph <- life_graph + geom_line(color="grey") 
life_graph <- life_graph + geom_point(color="blue") 
life_graph <- life_graph + facet_wrap(~country) 
life_graph <- life_graph + theme(axis.text.x = element_text(angle = 45, 
                                                            hjust = 1)) 
life_graph <- life_graph + labs(title = "Changes in Life Expectancy", 
                                x = "Year",
                                y = "Life Expectancy") 
life_graph

#Time dependent graphs
trend_graph <- ggplot(economics, aes(x = date, y = psavert)) 
trend_graph <- trend_graph + geom_line() 
trend_graph <- trend_graph + labs(title = "Personal Savings Rate",
                                  x = "Date",
                                  y = "Personal Savings Rate")
trend_graph

# add a trend line and include the confidence interval
trend_graph <- ggplot(economics, aes(x = date, y = psavert)) 
trend_graph <- trend_graph + geom_line(color="indianred3") 
trend_graph <- trend_graph + geom_smooth(span=0.3, color="blue") 
trend_graph <- trend_graph + labs(title = "Personal Savings Rate",
                                  x = "Date",
                                  y = "Personal Savings Rate")
trend_graph


#Adding stats directly into your graph
stat_graph <- ggboxplot(data = mpg, x = "class", y = "hwy",
                        color = "class", add = "jitter", shape = "class")
stat_graph <- stat_graph + theme(legend.position = "none")

stat_graph

my_comparisons <- list( c("2seater", "compact"), c("2seater", "midsize"), c("2seater", "minivan"), c("2seater", "pickup"), c("2seater", "subcompact"), c("2seater", "suv"))

# Add pairwise comparisons p-value
stat_graph <- stat_graph + stat_compare_means(comparisons = my_comparisons)

# Add global p-value
stat_graph <- stat_graph + stat_compare_means(label.y = 60)

# plot the graph
stat_graph


#bringing it all together
my_box_plot
library(cowplot)
my_box_plot
stat_graph

###Save the individual graphs
save_plot("my_stats_graph.pdf", stat_graph,
base_aspect_ratio = 1.3 # make room for figure legend
)
#combine different graphs in grids for a complete figure
plot_grid(stat_graph, trend_graph, labels = c("A", "B"), align = "h")

#Leave some space for other figure elements
plot_grid(trend_graph, NULL, NULL, stat_graph, labels = c("A", "B", "C", "D"), ncol = 2)

# create plot annotations
plot_grid(trend_graph, NULL, NULL, stat_graph, labels = c("A", "B", "C", "D"), ncol = 2) + draw_label("DRAFT!", angle = 45, size = 80, alpha = .2)


#Notes
# to get the full list of packages that you use in this R-session:
sessionInfo()
# to get citation 
citation("ggplot2")
citation("ggpubr")