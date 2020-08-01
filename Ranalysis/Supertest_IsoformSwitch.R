## Isoform Switch Overlaps

library(optparse)
library(SuperExactTest)

### Arguments
args <- commandArgs(trailingOnly = TRUE)
filename1 <- args[1]
filename2 <- args[2]
filename3 <- args[3]


### Our Dataset ###
kahraman_list <- as.vector(as.list(read.csv(filename1, header=TRUE)))
eyras_list <- as.vector(as.list(read.csv(filename2, header=TRUE)))
sandelin_list <- as.vector(as.list(read.csv(filename3, header=TRUE)))

data_merged <- c(kahraman = kahraman_list, eyras = eyras_list, sandelin = sandelin_list)
total=198002

##### More than 1 intersections -- it is more helpful for our case!
res=supertest(data_merged, n=total)

pdf(file='vennlike.pdf')
plot(res, sort.by="size", margin=c(2,2,2,2), color.scale.pos=c(0.8,1), legend.pos=c(0.5,0.15))
dev.off()

pdf(file='barlike.pdf')
plot(res, Layout="landscape", degree=2:4, sort.by="size", margin=c(0.5,15,1,3))
dev.off()

write.csv(summary(res)$Table, file="summary.table.csv", row.names=FALSE)
