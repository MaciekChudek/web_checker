#!/bin/bash
# Dependencies: wget, grep, wc, telnet, date
# Checks to see if a certain number of instances (HOW_MANY_INSTANCES) of a given text string (TEXT_TO_CHECK_FOR) appear on a web page (WEB_PAGE_TO_CHECK). If so, it sends you an email. Here I check to see an announcement website for a particular job still says "No records to display", and email myself when a job appears.

EMAIL_SERVER="mta1.asu.edu"
EMAIL_FROM="mchudek@asu.edu"
EMAIL_TO="mchudek@asu.edu"
EMAIL_SUBJECT="AFP Website update"
EMAIL_BODY="There are new jobs posted on the AFP website."
WEB_PAGE_TO_CHECK="https://afpcareers.nga.net.au/cp/?event=jobs.listJobs&JobCategoryID=937C3C98-3A61-7084-2AB3-5224D8FB5D82&JobListID=DC74E82E-30AD-49B8-8E1A-9BC90126C77D&jobsListKey=55074176-ee7c-4a5c-baa0-fcec15ed7f52&audienceTypeCode=ext"
TEXT_TO_CHECK_FOR="No records to display"
HOW_MANY_INSTANCES=0

TEST=`wget -qO- "$WEB_PAGE_TO_CHECK" | grep "$TEXT_TO_CHECK_FOR" | wc -l`
DATE_STRING=`date +"%a, %d %b %Y %T %z"`



if [ $TEST -eq $HOW_MANY_INSTANCES ]
	then 		
		{
			sleep 1;
			echo "HELO $EMAIL_SERVER";
			sleep 0.5;
			echo "MAIL FROM: $EMAIL_FROM";
			sleep 0.5;
			echo "RCPT TO: $EMAIL_TO";
			sleep 0.5;
			echo "DATA";
			sleep 0.5;
			echo -e "From: $EMAIL_FROM\nTo: $EMAIL_TO\nSubject: $EMAIL_SUBJECT\nDate: $DATE_STRING \n\n\n";
			sleep 0.5;
			echo -e "$EMAIL_BODY \n\n.";
			sleep 0.5;
			echo "QUIT";
			sleep 0.5;
		} | telnet $EMAIL_SERVER 25
fi



