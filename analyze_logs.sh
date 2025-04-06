#!/bin/bash

# Создаем отчетный файл
report_file="report.txt"

# Заголовок отчета
echo "Отчет о логе веб-сервера" > $report_file
echo "==========================" >> $report_file

# 1. Общее количество запросов
total_requests=$(wc -l < access.log)
echo "Общее количество запросов:    $total_requests" >> $report_file

# 2. Количество уникальных IP-адресов (с использованием awk)
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)
echo "Количество уникальных IP-адресов:    $unique_ips" >> $report_file

# Пустая строка для разделения
echo "" >> $report_file

# 3. Количество запросов по методам (с использованием awk)
echo "Количество запросов по методам:" >> $report_file
awk -F'"' '{print $2}' access.log | awk '{print $1}' | sort | uniq -c | while read count method; do
    echo "    $count $method" >> $report_file
done

# Пустая строка для разделения
echo "" >> $report_file

# 4. Самый популярный URL (с использованием awk)
echo "Самый популярный URL:" >> $report_file
awk -F'"' '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -nr | head -1 | while read count url; do
    echo "   $count $url" >> $report_file
done

echo "Отчет сохранен в файл $report_file"