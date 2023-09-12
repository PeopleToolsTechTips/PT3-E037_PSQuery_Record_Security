/*
PeoopleTools Tech Tips 
Randy Groncki 2023-09-03
Contact: randy@peopletoolstechtips.com
PSQuery Security Record Views  */

 WITH TREE_NODE AS
		  (SELECT CONNECT_BY_ROOT P.TREE_NODE AS RECNAME,
		    P.TREE_NAME,
		    P.EFFDT,
		    P.TREE_NODE_TYPE ,
		    P.SETID ,
		    REVERSE(LTRIM(SYS_CONNECT_BY_PATH (REVERSE(P.TREE_NODE),' >- '),' >- ')) AS TREE_PATH ,
		    P.TREE_NODE    AS ACCESS_PATH
		  FROM      PSTREENODE P,
                PSTREEDEFN A 
      WHERE P.TREE_NODE_TYPE = 'G' 
                AND P.SETID   = ' '
                AND A.SETID         = P.SETID
                and A.SETCNTRLVALUE = P.SETCNTRLVALUE
                and A.EFFDT         = P.EFFDT
                AND A.TREE_NAME     = P.TREE_NAME
                AND A.TREE_STRCT_ID = 'ACCESS_GROUP'
                AND A.EFF_STATUS    = 'A'
                AND A.EFFDT         =   (SELECT MAX(D.EFFDT)  FROM PSTREEDEFN D
                                        WHERE D.SETID   = ' '
                                        AND D.TREE_NAME = A.TREE_NAME
                                        AND D.EFFDT    <= SYSDATE   )
		    CONNECT BY PRIOR P.PARENT_NODE_NUM = P.TREE_NODE_NUM
                  AND PRIOR P.TREE_NAME                = P.TREE_NAME
                  AND PRIOR P.EFFDT                    = P.EFFDT
                  AND PRIOR P.SETID                    = P.SETID
                  AND PRIOR P.SETCNTRLVALUE            = P.SETCNTRLVALUE     )   
SELECT DISTINCT 
  RU.ROLEUSER,
--  RC.ROLENAME,  
--  C.CLASSID,
  B.RECNAME ,
  RD.RECDESCR,
  B.TREE_NAME,
  B.EFFDT,
  C.ACCESS_GROUP,
  C.ACCESSIBLE,
  B.TREE_PATH
FROM 
PS_SCRTY_ACC_GRP C ,
  TREE_NODE B ,
  PSRECDEFN RD
  , PSROLECLASS RC ,
   PSROLEUSER RU
WHERE C.TREE_NAME   = B.TREE_NAME
AND C.ACCESS_GROUP  = B.ACCESS_PATH
 AND RD.RECNAME = B.RECNAME
 AND RC.CLASSID = C.CLASSID 
 AND RU.ROLENAME = RC.ROLENAME
  AND RU.ROLEUSER = 'PT3';  /* User ID Here */