Setlocal 
# �������� ���� ������
For /f %%# In ('WMIC Path Win32_LocalTime Get DayOfWeek^|Findstr [0-6]') Do ( 
        Set DOW=%%#)
cd "����� ������������ ������� �����"
# ���� ���������������� ���� � putty, ����� � ������
C:\putty\putty.exe -ssh root@128.0.0.1 -pw password -m backup.txt
# ��������� ����� � ������� �����
winscp.com /command "open ftp://user:password@128.0.0.1" "get /backups/*.tar.gz" "exit"
# �� ������������ ��������� ��������� ����� �� �������������� ��������
if %DOW%==0 copy c:\buckups\*.tar.gz c:\buckups\archive\
# ������� ���������� �����
del c:\buckups\*.tar.gz
# �������� ��������� ����� � ����� ��� �������
copy  *.tar.gz c:\buckups\
# ������� ��������� ����� �� ������� �����
del *.tar.gz
# ������� ����� �� �������
C:\putty\putty.exe -ssh root@128.0.0.1 -pw password -m backup1.txt