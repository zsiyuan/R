options(stringsAsFactors = FALSE)

FilePath <- "D:/MyProject/TCGA-CESC/AnnotationFile/Simple_Annotiation.txt"

Original_Annotiation <- read.table(file = FilePath, header = TRUE)

ENGS_ID_Identify <- Original_Annotiation[!duplicated(Original_Annotiation[, "Gene_ID"]), "Gene_ID"]

#创建数据框保存变量结果
Gene_length <- data.frame()

#一个一个处理
for(i in 1 : length(ENGS_ID_Identify)){
  Index <- intersect(which(Original_Annotiation[, "Feature_type"] == "exon"), which(Original_Annotiation[, "Gene_ID"] == ENGS_ID_Identify[i]))
  Target_data <- Original_Annotiation[Index, c("Genomic_start_location", "Genomic_end_location")]
  Target_sort <- Target_data[order(Target_data[, "Genomic_start_location"]), ]
  
  Result_data <- data.frame()
  
  if (nrow(Target_sort) <= 1){
    Result_data[1,1] <- Target_sort[1,1]
    Result_data[1,2] <- Target_sort[1,2]
  }else{
    Result_data[1,1] <- Target_sort[1,1]
    Result_data[1,2] <- Target_sort[1,2]
    for (j in 2 : nrow(Target_sort)) {
      if(Result_data[nrow(Result_data), 2] < Target_sort[j, 1]){
        Result_data[nrow(Result_data) + 1, ] <- Target_sort[j, ]
      }else{
        Result_data[nrow(Result_data), 2] <- max(Target_sort[j, 2], Result_data[nrow(Result_data), 2])
      }
    }
  }
  
  #计算基因长度
  # Length <- 0
  # for (k in 1 : nrow(Result_data)){
  #   Length <- Result_data[k, 2] - Result_data[k, 1] + 1 + Length
  # }
  Length <- sum(Result_data[, 2] - Result_data[, 1]) + nrow(Result_data)
  
  Gene_length[i, 1] <- ENGS_ID_Identify[i]
  Gene_length[i, 2] <- Length
}
colnames(Gene_length) <- c("ENGD_ID", "Gene_length")
write.table(Gene_length, file = "D:/MyProject/TCGA-CESC/AnnotationFile/Gene_length_union.txt", row.names = FALSE, quote = FALSE)
