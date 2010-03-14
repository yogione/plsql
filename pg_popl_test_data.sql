CREATE or replace FUNCTION popl_test_data() returns real AS $$
DECLARE
 curr_user_id integer default 0; 
 curr_fname VARCHAR := 'Jim'; 
 curr_lname VARCHAR := 'Williams'; 
 curr_login_name VARCHAR := 'JimWilliams';
 curr_photo_id integer;
 curr_story_id integer;
 curr_profile_id integer;
 curr_comment_id integer;
 temp_email VARCHAR;
 
 BEGIN
   	DELETE FROM users;
	DELETE FROM profiles;
	DELETE FROM comments;
	DELETE FROM stories;

   FOR i IN 1..10
   LOOP
     temp_email := curr_login_name||i||'@'||curr_login_name||'.'||'com';
     SELECT nextval('USER_ID_SEQ') INTO curr_user_id;
     INSERT INTO users(user_id, login_name, FIRST_NAME, LAST_NAME, email, created_date) 
     VALUES (curr_user_id, curr_login_name||i, curr_fname||i,curr_lname||i, temp_email, now());
     
     SELECT nextval('profile_id_seq') INTO curr_profile_id;
     INSERT INTO profiles(PROFILE_ID, USER_ID) VALUES (curr_profile_id, curr_user_id);
     
     SELECT nextval('STORY_ID_SEQ') INTO curr_story_id ;
     INSERT INTO stories(STORY_ID, STORY_TITLE, STORY_URL, STORY_TEASER, POSTED_BY_USER_ID, STORY_CREATED_DATE, votes) 
         VALUES(curr_story_id, 'Toyota disputes critic who blames electronics','http://www.google.com/hostednews/ap/article/ALeqM5iNwJcVe09iBDYjmKOaeF4IU9vGRwD9E9EQ984',
         'NEW YORK - Toyota Motor Corp. plans Monday to try to undercut suggestions that its electronics systems caused the sudden acceleration problems that led to the recall of more than 8 million vehicles.',
         curr_user_id, now(), 5);
         
     SELECT nextval('comment_id_seq') INTO curr_comment_id;
     INSERT INTO comments(COMMENT_ID, STORY_ID, COMMENT_TEXT, COMMENTED_BY_USER_ID, COMMENT_CREATED_DATE, COMMENT_MODERATED)
     VALUES (curr_comment_id, curr_story_id, 'Great comment'||i,  curr_user_id, now(), 'Y');
   END LOOP;
   return 100.00;
 END;
$$ LANGUAGE plpgsql;

 







