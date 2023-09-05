# PT3-E037_PSQuery_Record_Security
PSQueries &amp; SQL views revealing PSQuery Record access through Roles, PLists and Trees

PeopleTools Tech Tips    
Randy Groncki

2023-09-03

Users have access to records in PSQuery through the Query Access Manager.  Records are assigned to Query security trees.  However, finding the bigger picture of what records a user has access to through many roles and permission lists is somewhat daunting.  Just as difficult, questions about which roles and permission lists have access to a specific record can be a trip down the multiple rabbit holes.

I’ve created a few PSQiueries and SQL statements to help clarify the current relationships between the Records, Roles and Users. Hopefully these can help you adjust security in your implementation so your PSQuery users have correct record access.


### Web Posting: 

### YouTube demo: https://youtu.be/4IWKzVH6ajk

### Contact:  
* randy@peopletoolstechtips.com  
* PeopleToolsTechTips@Gmail.com

This file contains all the objects referenced in the video and document.

## PeopleTools Project is using PeopleTools 8.60.05
  * This contains all the components, pages, records and PeopleCode used in the demonstration.
  * The target database must be minimal 8.58 PeopleTools

* X_PT3_E037_QUERY_SECURITY (PeopleTools Project folder)  
* X_PT3_E037_QUERY_SECURITY.zip  (zip file containing PeopleTools Project and SQL Scripts)
