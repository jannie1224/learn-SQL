-- 我用https://sqliteviz.com/app/#/workspace
-- 可以用 My SQL 、PostgreSQL 、SQL Server 、ORACLE
-- 不同資料庫的「方言（特性）」不太一樣，要注意喔


/*註解
 * Your CSV file has been imported into students table.
 * You can run this SQL query to make all CSV records available for charting.
 */
 -- 一行的註解
/*SELECT * 
FROM "students" 
LIMIT 5 
OFFSET 5;*/
-- 選取 全部的欄位 從student這個表格中找
-- student不一定要加""，要看資料類型
-- ctrl+enter 打開表格資料
-- * 可以改成其他東西，例如:學號、姓名、班級，可以只顯示部分資料
-- 用LIMIT 限制顯示的資料數量
-- OFFSET 可以跳過資訊
-- 可以簡寫成 LIMIT 5, 5（注意：前面是 OFFSET，後面是 LIMIT，順序與原本相反
-- 慣例是要一行一行分著寫
/*SELECT 姓名, 班級, 成績 
FROM students 
WHERE 班級 = '1 年 2 班'
WHERE 班級 <> '1 年 2 班'
-- WHERE 找特定標籤的資料
-- <>是除了有這個標籤以外的資料顯示，又不然就用=
ORDER BY 班級, 成績 DESC;*/
-- 按照標籤排序(低到高) 
-- 加 DESC (高到低)

-- SELECT 姓名, 班級, 成績 
-- FROM students
-- WHERE 姓名 LIKE '張%';
-- WHERE 姓名 LIKE '張_';
-- • %：代表零個、一個或多個任意字元。
-- • _：代表嚴格一個任意字元
-- 如果想用名字找，但不記得全名，用%，代表一個或多個字元，但=要改成LIKE
-- 如果%改成_，_只找一個字
-- WHERE 成績 >= 80 AND 成績 < 90;
-- WHERE 成績 BETWEEN 80 AND 90 AND (班級 = '1 年 1 班' OR '1 年 2 班');
-- WHERE 成績 BETWEEN 80 AND 90 AND (班級 IN ('1 年 1 班', '1 年 2 班'));
-- 加AND加更多條件，找區間有2種寫法
-- SQL 中 AND 語法的優先級比 OR 高
-- 用括號調整邏輯順序，兩種寫法

-- SELECT AVG(成績), SUM(成績), MAX(成績), MIN(成績), COUNT(成績)
-- FROM students;
-- 直接找全部人的平均......，系統內建 
-- 也可以自己命名
-- SELECT AVG(成績) AS 成績平均, MAX(成績) AS 最高分
-- FROM students;
-- SELECT ROUND (AVG(成績),1) AS 成績平均, MAX(成績) AS 最高分
-- FROM students;
/*SELECT 班級, ROUND (AVG(成績)) AS 成績平均
FROM students
GROUP BY 班級
ORDER BY 成績平均 DESC;
HAVING 成績平均>= 80;*/
-- ROUND 將小數四捨五入到小數第幾位，如果是整數，就不用加數字
-- GROUP BY 按照分類做平均，如果要找 GROUP BY 中的項目，要用HAVING
-- 寫到這，你會發現錯誤訊息
-- SQL 有特定順序　
/*SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT*/
/*SELECT 班級, ROUND (AVG(成績)) AS 成績平均
FROM students
GROUP BY 班級
HAVING 成績平均>= 80
ORDER BY 成績平均 DESC;*/
-- 這樣才對喔

-- SELECT COUNT(*)　　
-- FROM students;
-- SELECT COUNT(DISTINCT 社團)　　
-- FROM students;
-- *代表輸出總行數
-- • COUNT(*) 会計算所有行數，包含 NULL 的格子。
-- • COUNT(欄位名) 才會自動忽略該欄位的 NULL 值。
-- DISTINCT 可以移除重複的資料
-- SELECT DISTINCT (社團)　　
-- FROM students
-- 直接找出此類型的不同項目
-- DISTINCT 不會去除空白值
-- WHERE 社團 IS NOT NULL
-- 去除空白值
-- ORDER BY 社團;

-- 建立一個表格 
/*CREATE TABLE clubs ( 
社團編號 INT PRIMARY KEY,
社團名稱 VARCHAR(15)
);*/
-- 要有項目和項目的類型，INT 整數，VARCHAR字串類型，加限制幾個字
-- 要在表格中放主鍵，不能有重複和空值
-- 新表格出現在左側
-- DROP TABLE clubs2;
-- 如果多放一個table，可以刪

-- INSERT INTO clubs (社團編號,社團名稱)
-- 在表格中輸入新資料，表格名稱，要插入資料的標題
-- VALUES(101, '吉他社'), (102, '籃球社'), (103, '美術社'), (104, NULL);
-- 資料要和欄位相對應，不知道可以寫NULL

-- UPDATE clubs
-- SET 社團名稱 = '舞蹈社'
-- WHERE 社團編號 = 104;
-- SELECT * FROM clubs;
-- 如果要更新資料，寫這個
-- 要寫WHERE，又不然全部資料都會變 舞蹈社

/*DELETE
FROM clubs
WHERE 社團編號 = 104;
SELECT * FROM clubs;*/
-- 刪除資料
-- 要寫WHERE，又不然東西會全部被刪掉

-- 跨表格查詢，因為跨表格，所以要寫table的名字
/*SELECT DISTINCT students.姓名, students.社團, clubs.社團名稱
FROM students
LEFT JOIN clubs
-- LEFT JOIN 將表格加入進來
-- 保留左表（Left Table）全部的資料，右表有吻合的就接上去，沒有吻合的則填入 NULL

--  有用別名：我打字不用打到累死
--SELECT s.姓名, s.班級, c.社團名稱, c.社團老師
--FROM students AS s
--LEFT JOIN clubs AS c ON s.社團 = c.社團編號;
SELECT 
    姓名 AS 學生姓名, 
    班級 AS 班級別, 
    成績 AS 期末總成績
FROM students;
--  精準區分同名的欄位
-- AS可寫可不寫
-- 一但用新名字，舊名字失效
On students.社團 = clubs.社團編號
-- 要說明兩個table如何相連
WHERE 班級 = '1 年 1 班';*/
-- SELECT DISTINCT students.姓名, students.社團, clubs.社團名稱
-- FROM students
-- INNER JOIN clubs
-- INNER JOIN 將表格加入進來，只回傳兩邊資料表都有吻合的交集資料。
-- On students.社團 = clubs.社團編號
-- 要說明兩個table如何相連
-- WHERE 班級 = '1 年 1 班';
-- 改成INNER，把沒有配對的去除
-- 雙引號 "" 是用來包住「欄位名稱」或「資料表名稱」（特別是名稱內含空格或關鍵字時）
-- 而單引號 '' 才是用來包住「字串資料」（例如 '1 年 2 班')

-- 如果你的資料庫欄位裡存的是代碼（例如：M、F）或特定數值，你想在顯示時變成特定的中文細項    
-- 我查google是這樣啦，但是我覺得是改細項
SELECT 姓名,
    CASE 
        WHEN 班級 = '1 年 1 班' THEN '一年一班（忠班）'
        WHEN 班級 = '1 年 2 班' THEN '一年二班（孝班）'
        WHEN 班級 IS NULL THEN '未分班' -- 可能有人沒填資料，會報錯，要寫這個喔!
        ELSE '其他班級'
    END AS 班級完整名稱
FROM students;

-- 下面這兩個一改，就永遠改變
-- 語法：ALTER TABLE 表名 RENAME COLUMN 舊欄位名 TO 新欄位名;
ALTER TABLE students RENAME COLUMN 成績 TO 期末分數;

-- 語法：ALTER TABLE 舊表名 RENAME TO 新表名;
ALTER TABLE students RENAME TO taiwan_students;



