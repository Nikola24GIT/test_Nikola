#!/bin/bash
cat <<EOF > report.txt
Отчет о логе веб-сервера
========================
Общее количество запросов:	`awk 'END{ print NR }' access.log`
Количество уникальных IP-адресов:	`awk '!U[$1]++{count++}END{print count}' access.log`

Количество запросов по методам:	
	`awk '{ sum += substr($6, 2, 3)=="GET" }END{ print sum }' access.log` GET
	`awk '{ sum2 += substr($6, 2, 4)=="POST" }END{ print sum2 }' access.log` POST

Самый популярный URL:	`awk '{ count[$7]++ } END { for (word in count) print word, count[word] }' access.log | awk 'BEGIN{m=0}BEGIN{w=0}{if(m<$2) w=$1; if(m<$2) m=$2}END{print m, w}'`
EOF
echo "Отчет сохранен в файл report.txt"
