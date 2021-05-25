Setlocal 
# Выясняем день недели
For /f %%# In ('WMIC Path Win32_LocalTime Get DayOfWeek^|Findstr [0-6]') Do ( 
        Set DOW=%%#)
cd "Место расположения текущей папки"
# Надо откорректировать путь к putty, адрес и пароль
C:\putty\putty.exe -ssh root@128.0.0.1 -pw password -m backup.txt
# Скачиваем архив в текущую папку
winscp.com /command "open ftp://user:password@128.0.0.1" "get /backups/*.tar.gz" "exit"
# По воскресениям загружаем последний архив на долговременное хранение
if %DOW%==0 copy c:\buckups\*.tar.gz c:\buckups\archive\
# Стираем предыдущий архив
del c:\buckups\*.tar.gz
# Копируем скачанный архив в папку для архивов
copy  *.tar.gz c:\buckups\
# Стираем скачанный архив из текущей папки
del *.tar.gz
# Стираем архив на сервере
C:\putty\putty.exe -ssh root@128.0.0.1 -pw password -m backup1.txt