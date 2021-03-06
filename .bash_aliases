alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'
alias mysql_restart='sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper restart'
alias mysql_start='sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper start'
alias mysql_stop='sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper stop'

#search for a string in a android studio project
alias findString='find . -type f -not -path "./*/build/*" | xargs grep'
