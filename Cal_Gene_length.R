FilePath <- "D:/MyProject/TCGA-CESC/AnnotationFile/Simple_Annotiation.txt"

Original_Annotation <- read.table(file = FilePath, header = TRUE, sep = " ")

ENGS_ID_Identify <- Original_Annotation[!duplicated(Original_Annotation[, "Gene_ID"]), "Gene_ID"]

#创建数据框保存结果
Gene_length <- data.frame()

for (i in 1 : length(ENGS_ID_Identify)){
  #初始化基因长度为0
  Length <- 0
  Index <- which(Original_Annotation[, "Gene_ID"] == ENGS_ID_Identify[i])
  for (j in Index){
    if(Original_Annotation[j, "Feature_type"] == "exon"){
      Length <- Original_Annotation[j, "Genomic_end_location"] - Original_Annotation[j, "Genomic_start_location"] + 1 + Length
    }
  }
  Gene_length[i, 1] <- ENGS_ID_Identify[i]
  Gene_length[i, 2] <- Length
}

colnames(Gene_length) <- c("ENGS_ID", "Gene_length")
write.table(Gene_length, file = "D:/MyProject/TCGA-CESC/AnnotationFile/Gene_length.txt", row.names = FALSE, quote = FALSE)
