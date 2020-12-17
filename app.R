ui = fluidPage(
  sidebarLayout(width=3,
                actionButton("Start", "Save New Files")
    )
)

server = function(input, output){

  FCSExpress_fcs_standard<-function(){
  setwd(choose.dir(caption = "Choose the folder containing the files."))
  files = list.files(pattern = ".fcs$|.FCS$")
  fs<-read.flowSet(files)
  fs<-fsApply(fs,function(x){
    col_length = 1:length(colnames(x))
    first_columns = grep("Time|Event_length|Center|Offset|Width|Residual|Ce140Di|Ir191Di|Ir193Di", colnames(x))
    other_columns = col_length[!col_length %in% first_columns]
    x<-x[,c(first_columns,other_columns)]
    x
  })
  
  if(!dir.exists(file.path(getwd(),"files_to_fcsExpress"))){
    dir.create(file.path(getwd(),"files_to_fcsExpress"))
  }
  
  write.flowSet(fs,outdir = "files_to_fcsExpress",filename = paste0("STD_",keyword(fs,"$FIL")))
  
}
  
}


#FCSExpress_fcs_standard()
