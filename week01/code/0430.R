# 텍스트 분석 실습 (텍스트 마이닝)
#시작21
# 오전 - 텍스트마이닝에 대하여, KoNLP
# 품사태깅의 원리; 명사사전, 조사사전을 만든다.
# readLines와 달리 readline의 다른 점
readline("prompt 요렇게")

library(KoNLP)
data1 <-readLines("./data/seoul_new.txt")
head(data1)
extractNoun("아버지가 방에 들어가신다.")
extractNoun("아버지가방에 들어가신다.")

for(line in data1){
  print(extractNoun(line))
}

data2 <- sapply(data1, extractNoun, USE.NAMES=F)
# USE.NAMES=F 이름없이
head(data2)

extractNoun("나는 오늘 밥을 안먹었다.")
extractNoun("나는 오늘 밥을 먹었다.")
data2[1]
data2[[1]]

table(unlist(data2))
#unlist 한 후 의미 없는 단어를 제거 후 table

#---------
data3 <- unlist(data2)
data3 <- gsub("\\d+","",data3) 
# d를 찾는게 아니라 digit 숫자를 찾는 거임
# d+ 숫자 1 이상
data3 <- gsub("서울시","",data3)
data3 <- gsub("서울","",data3)
data3 <- gsub("요청","",data3)
data3 <- gsub("제안","",data3)
data3 <- gsub("관련","",data3)
data3 <- gsub(" ","",data3)
data3 <- gsub("\\W","",data3)
data3 <- gsub("OO","",data3)
data3 <- gsub("^님$","",data3)
data3 <- gsub("^한$","",data3)
data3 <- gsub("^시$","",data3)
data3 <- gsub("^장$","",data3)
data3 <- gsub("[A-z]","",data3)
# data3 <- gsub("개선","", data3)
# data3 <- gsub("문제","", data3)
# data3 <- gsub("관리","", data3)
# data3 <- gsub("민원","", data3)
# data3 <- gsub("이용","", data3)
# data3 <- gsub("시장","", data3)
data3
# 첫번째 인자를 찾은 후 두번째 인자로 바꿈
# 정규 표현식
#---------- 포문사용
dat3 <- unlist(data2)
word <- c("\\d+","서울시","서울","요청","제안"," ","\\W",
          "관련","[A-z]","^님$","^한$","^시$","^장$")
for(i in word){
  dat3 <- gsub(i,"",dat3)
}
#한글자만 지우고 싶은뒈
#----------
write(data3, "./data/seoul_2.txt")
data4 <- read.table("./data/seoul_2.txt")
wordcount <- table(data4)
head(sort(wordcount,decreasing=T),20)

# install.packages("wordcloud")
# install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer) 
palete <- brewer.pal(9,"Set3")
palete <- brewer.pal(9,"Paired") 
wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(5,1),
          rot.per=0.25,
          min.freq=1,
          random.order=F,
          random.color=T,
          colors=palete)
legend(0.5,1,"서울시 응답소 요청사항 분석",
       cex=0.5,fill=NA,border=NA,bg="white",
       text.col="red",text.font=2,box.col="red")
#----------
#과제1) 텍스트마이닝_제주도추천여행코스분석
#제주도에서 추천되는 여행코스로 많이 소개되는 지명을 워드클라우드로 시각화하세요.
library(KoNLP)
name <-readLines("./data/제주도여행지.txt")

data1 <-readLines("./data/jeju.txt")
data2 <- sapply(data1, extractNoun, USE.NAMES=F)
data3 <- unlist(data2)
# word <- c("\\d+","[A-z]","[:punct:]","\\W","^소$","^수$",
#           "^도$","^한$","^곳$","^것$","^날$","^적$","^숙$","^항$",
#           "^저$","^차$","^분$")

#data3 <- data3[which(data3%in%name)]
data4 <- NULL
for(i in 1:length(name)){
  data4 <- c(data4,data3[which(data3 %in% name[i])])
}

write(data4, "./data/jeju_2.txt")
data5 <- read.table("./data/jeju_2.txt")
wordcount <- table(data5)
head(sort(wordcount,decreasing=T),20)

library(wordcloud)
library(RColorBrewer) 
palete <- brewer.pal(9,"Set3")
palete <- brewer.pal(9,"Paired") 
wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(3.5,1),
          rot.per=0.25,
          min.freq=1,
          random.order=F,
          random.color=T,
          colors=palete)
legend(0.3,1,"제주도추천 여행코스",
       cex=0.6,fill=NA,border=NA,bg="white",
       text.col="red",text.font=2,box.col="red")





