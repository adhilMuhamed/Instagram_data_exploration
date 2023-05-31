Select * from comments;
select * from follows;
select * from likes;
select * from photo_tags;
select * from photos;
select * from tags;
select * from users;


#We want to reward the user who has been around the longest, Find the 5 oldest users.

Select * from users order by created_at limit 5;

#To target inactive users in an email ad campaign, find the users who have never posted a photo.


select distinct(user_id) from photos;

select * from users u left join photos p on u.id=p.user_id where p.id is null; 

select * from users where id not in (select distinct(user_id) from photos);

#Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?

select * from users;
select * from likes;
select * from photos;
select distinct(photo_id) from likes;

select photo_id,count(user_id) AS total_likes from likes group by photo_id order by total_likes desc limit 1;

select photo_id from (select photo_id,count(user_id) AS total_likes from likes group by photo_id order by total_likes desc limit 1) As photo;

SELECT 
    *
FROM
    users u
        JOIN
    photos p ON u.id = p.user_id
WHERE
    p.id = (SELECT 
            photo_id
        FROM
            (SELECT 
                photo_id, COUNT(user_id) AS total_likes
            FROM
                likes
            GROUP BY photo_id
            ORDER BY total_likes DESC
            LIMIT 1) AS photo);


#The investors want to know how many times does the average user post.

select * from users;
select * from photos;

select user_id,count(id) AS no_of_posts from photos group by user_id;

select sum(no_of_posts)/count(user_id) AS Average_posts from (select user_id,count(id) AS no_of_posts from photos group by user_id) As posts;

#A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

select * from tags;
select * from photo_tags;

select tag_id,count(photo_id)As count_of_tagged_photos from photo_tags group by tag_id order by count_of_tagged_photos desc limit 5;

select tag_id from (select tag_id,count(photo_id)As count_of_tagged_photos from photo_tags group by tag_id order by count_of_tagged_photos desc limit 5) As tag_pics;


select id,tag_name from tags where id IN (select tag_id from (select tag_id,count(photo_id)As count_of_tagged_photos from photo_tags group by tag_id order by count_of_tagged_photos desc limit 5) As tag_pics);


#To find out if there are bots, find users who have liked every single photo on the site.

select * from users;
select * from likes;
select * from photos;

select count(distinct(photo_id)) from likes;

select user_id,count(user_id) As total_likes_userwise from likes group by user_id;

select user_id,count(user_id) As total_likes_userwise from likes group by user_id having total_likes_userwise = (select count(distinct(photo_id)) from likes);


#Find the users who have created instagramid in may and select top 5 newest joinees from it?

select * from users;

select * from users where month(created_at)=5 order by created_at desc limit 5;

#Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?

select * from users;
select * from photos;
select * from likes;

select * from users where username  regexp "^c" and username regexp "[0123456789]$";

select * from users u join photos p on u.id=p.user_id  where username  regexp "^c" and username regexp "[0123456789]$";

select * from users u join photos p on u.id=p.user_id join likes l on u.id=l.user_id where username  regexp "^c" and username regexp "[0123456789]$";

select u.id,u.username,p.id,p.image_url,l.photo_id from users u join photos p on u.id=p.user_id join likes l on u.id=l.user_id where username  regexp "^c" and username regexp "[0123456789]$";


#Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.

select user_id,count(id) AS no_of_posts from photos group by user_id;

select user_id,count(id) AS no_of_posts from photos group by user_id having no_of_posts between 3 AND 5;

select p.user_id,count(p.id) AS no_of_posts,u.username from photos p join users u on u.id=p.user_id group by user_id having no_of_posts between 3 AND 5;

