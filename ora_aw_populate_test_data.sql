DELETE FROM users;
DELETE FROM profiles;
DELETE FROM comments;
DELETE FROM stories;

DECLARE
 curr_user_id NUMBER; curr_fname VARCHAR2(50) := 'Jim'; 
 curr_lname VARCHAR2(50) := 'Williams'; 
 curr_login_name VARCHAR2(50) := 'JimWilliams';
 curr_photo_id NUMBER;
 curr_story_id NUMBER;
 curr_profile_id NUMBER;
 curr_comment_id NUMBER;
 temp_email VARCHAR2(50);
 
 BEGIN
   FOR i IN 1..10
   LOOP
     temp_email := curr_login_name||i||'@'||curr_login_name||'.'||'com';
     SELECT USER_ID_SEQ.NEXTVAL INTO curr_user_id FROM dual;
     INSERT INTO users(user_id, login_name, FIRST_NAME, LAST_NAME, email, created_date) 
     VALUES (curr_user_id||i, curr_login_name||i, curr_fname||i,curr_lname||i, temp_email, SYSDATE);
     
     SELECT profile_id_seq.NEXTVAL INTO curr_profile_id FROM dual;
     INSERT INTO profiles(PROFILE_ID, USER_ID) VALUES (curr_profile_id, curr_user_id||i);
     
     SELECT STORY_ID_SEQ.NEXTVAL INTO curr_story_id FROM dual;
     INSERT INTO stories(STORY_ID, STORY_TITLE, STORY_URL, STORY_TEASER, POSTED_BY_USER_ID, STORY_CREATED_DATE, votes) 
         VALUES(curr_story_id, 'Toyota disputes critic who blames electronics','http://www.google.com/hostednews/ap/article/ALeqM5iNwJcVe09iBDYjmKOaeF4IU9vGRwD9E9EQ984',
         'NEW YORK - Toyota Motor Corp. plans Monday to try to undercut suggestions that its electronics systems caused the sudden acceleration problems that led to the recall of more than 8 million vehicles.',
         curr_user_id||i, SYSDATE, 5);
         
     SELECT comment_id_seq.NEXTVAL INTO curr_comment_id FROM dual;
     INSERT INTO comments(COMMENT_ID, STORY_ID, COMMENT_TEXT, COMMENTED_BY_USER_ID, COMMENT_CREATED_DATE, COMMENT_MODERATED)
     VALUES (curr_comment_id, curr_story_id, 'Great comment'||i,  curr_user_id||i, SYSDATE, 'Y');
   END LOOP;
 
 END;
 /


 







