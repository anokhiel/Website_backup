Setlocal 
rem �������� ���� ������
For /f %%rem In ('WMIC Path Win32_LocalTime Get DayOfWeek^|Findstr [0-6]') Do ( 
        Set DOW=%%rem)
cd "����� ������������ ������� �����"
rem ���� ���������������� ���� � putty, ����� � ������
C:\putty\putty.exe -ssh root@128.0.0.1 -pw password -m backup.txt
rem ��������� ����� � ������� �����
winscp.com /command "open ftp://user:password@128.0.0.1" "get /backups/*.tar.gz" "exit"
rem �� ������������ ��������� ��������� ����� �� �������������� ��������
if %DOW%==0 copy c:\buckups\*.tar.gz c:\buckups\archive\
rem ������� ���������� �����
del c:\buckups\*.tar.gz
rem �������� ��������� ����� � ����� ��� �������
copy  *.tar.gz c:\buckups\
rem ������� ��������� ����� �� ������� �����
del *.tar.gz
rem ������� ����� �� �������
C:\putty\putty.exe -ssh root@128.0.0.1 -pw password -m backup1.txt