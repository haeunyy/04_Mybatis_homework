--DDL(CREAT TABLE)및 제약조건
--[표현식]

--CREATE TABLE 테이블명(컬럼명 자료형(크기) , 컬럼명 자료형(크기), ...)
CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(20),
  MEMBER_PWD VARCHAR2(20),
  MEMBER_NAME VARCHAR2(20)
  );
  
SELECT
        M.*
  FROM MEMBER M;
  
--컬럼에 주석 달기 
--[표현식]
--COMMENT ON COLUMN 테이블명, 컬럼명 IS '주석내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
  
--해당 계정이 보유하고 있는 테이블, 컬럼 조회구문
SELECT 
        UT.*
 FROM USER_TABLES UT;

SELECT 
        UTC.*
 FROM USER_TAB_COLUMNS UTC
 WHERE UTC.TABLE_NAME = 'MEMBER';
 
--제약조건 
--테이블 작성시 각 컬럼에 대해 값 기록에 대한 제약조건을 설정할 수 있다. 
--데이터 무결성 보장을 목적으로 한다. 
--입력하거나 수정하는 데이터에 문제가 없는지 자동으로 검사한다. 
--PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

--해당 계정이 보유하고 있는 제약 조건 조회 구문
SELECT 
        UC.*
  FROM USER_CONSTRAINTS UC;
  
SELECT 
        UCC.*
  FROM USER_CONS_COLUMNS UCC;
  
  
--NOT NULL : 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
--           삽입 | 수정시 NULL 값을 허용하지 않도록 하며 "컬럼 레벨" 에서 제한
--DROP TABLE 테이블명 으로 삭제가능 
CREATE TABLE TBL_YOUTUBER (
 YOUTUBER_CODE NUMBER UNIQUE NOT NULL ,
 YOUTUBER_NAME VARCHAR2(30) PRIMARY KEY,
 YOUTUBER_NUNMBER VARCHAR2(30) NOT NULL,
 YOUTUBER_URL VARCHAR2(150)NOT NULL,
 YOUTUBER_UPLOAD_DATE DATE,
 MANAGER_CODE NUMBER 
 );
 
 
CREATE TABLE TBL_MANAGEMENT (
 MANAGER_CODE NUMBER UNIQUE NOT NULL ,
 MANAGER_NAME VARCHAR2(30),
 MANAGER_NUMBER VARCHAR2 (30),
 ); 

CREATE TABLE TBL_GRADE (
 YOUTUBER_CODE NUMBER UNIQUE NOT NULL ,
 SUBSCRIBER VARCHAR2(30),
 GRADE VARCHAR2 (30),
 ); 
 
 --제약조건이 없는 USER_NOCONS 테이블에 데이터 1행 삽입
 INSERT
INTO USER_NOCONS
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
1
,'user01'
,'pass01'
,'홍길동'
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);
  
--아무런 제약 조건없이 테이블을 생성하면 필수 정보가 null로 누락되어도 문제없이 삽입

 INSERT
INTO USER_NOCONS
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
2
, NULL
, NULL
, NULL
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);
  
  
--"컬럼 레벨"에 NOT NULL 제약 조건을 설정한다. NOT NULL은 컬럼레벨 자리에만 쓸수있다. 

CREATE TABLE USER_NOTNULL (
 USER_NO NUMBER NOT NULL,
 USER_ID VARCHAR2(20) NOT NULL,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50)
 );

--만들어진 테이븡릐 제약조건 검색
SELECT 
        UC.*
        ,UCC.*
  FROM USER_CONSTRAINTS UC 
  JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'USER_NOTNULL';

--USER_NOTNULL
 INSERT
INTO USER_NOTNULL
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
  1
, 'user01'
, 'pass01'
, '홍길동'
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);

--UNIQUE 제약조건 : 컬럼의 입력 값에 대해 중복을 제한하는 제약 조건
--"컬럼 레벨" , "테이블레벨" 모두 설정가능
--제약 조건이 없는 user_nocons에는 완전히 동일한 행을 삽입해도 문제가 없다 .
--아이디등의 컬럼은 중복을 허용하면 안되므로 UNIQUE제약 조건이 필요하다. 
 INSERT
INTO UNIQUE
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
1
,'user01'
,'pass01'
,'홍길동'
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);

CREATE TABLE USER_UNIQUE (
 USER_NO NUMBER NOT NULL,
 USER_ID VARCHAR2(20) UNIQUE NOT NULL,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50)
 );

--두번 실행시켜 유니크 구문의 오류 명칭 확인한다. 
 INSERT
INTO USER_UNIQUE
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
1
,'user01'
,'pass01'
,'홍길동'
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);

--위에서 확인된 조건명을 확인한 후에 
--제약 조건명을 이용해서 제약 조건 검색
SELECT
        UCC.TABLE_NAME
        ,UCC.COLUMN_NAME
        ,UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  , USER_CONS_COLUMNS UCC 
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007445';

--UNIQUE 제약 조건을 "테이블 레벨"에서 설정한 USER_UNIQUE2 테이블 생성 
CREATE TABLE USER_UNIQUE2 (
 USER_NO NUMBER NOT NULL,
 USER_ID VARCHAR2(20) NOT NULL,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50),
 UNIQUE (USER_ID)
 );
 
 
 INSERT
INTO USER_UNIQUE2
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
1
,'user01'
,'pass01'
,'홍길동'
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);

--위에서 확인된 조건명을 확인한 후에 
--제약 조건명을 이용해서 제약 조건 검색
SELECT
        UCC.TABLE_NAME
        ,UCC.COLUMN_NAME
        ,UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  , USER_CONS_COLUMNS UCC 
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007450';


--두 개 이상의 컬럼을 묶어서 하나의 UNIQUE 제약 조건을 설정할 수도 있다. 
--이때는 테이블레벨에서만 설정할 수 있다. 
CREATE TABLE USER_UNIQUE3 (
 USER_NO NUMBER NOT NULL,
 USER_ID VARCHAR2(20) NOT NULL,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50),
 UNIQUE (USER_NO, USER_ID)-- 여러개의 테이블을 묶을때는 반드시 테이블 레벨에서 설정
 );

---USER UNIQUE3에 USER_NO, USER_ID 에 대해 중복값 입력 가능한지 확인
 INSERT
INTO USER_UNIQUE3
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
1
,'user01'
,'pass01'
,'홍길동'
,'남'
,'010-1234-5678'
,'hong123@greedy.com'
);

SELECT
        UCC.TABLE_NAME
        ,UCC.COLUMN_NAME
        ,UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  , USER_CONS_COLUMNS UCC 
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007455';
   
-- 제약 조건명을 이용해서 제약 조건 검색
SELECT
       UCC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
     , USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007359';

-- 제약조건에 이름을 붙여서 테이블 생성
CREATE TABLE CONS_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UN_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(30),
  CONSTRAINT UN_TEST_DATA3 UNIQUE(TEST_DATA3)
);


-- CONS_NAME 테이블의 제약 조건 검색
SELECT
       UC.*
  FROM USER_CONSTRAINTS UC
 WHERE TABLE_NAME = 'CONS_NAME';



-- CHECK제약 조건 : 컬럼에 기록되는 값에 조건 설정을 할 수 있다. 
--- CHRCK(컬럼명 비교연산자 비교값)
--주의 : 비교값은 리터럴만 사용할 수 있음, 변하는 값이나 함수는 사용 못함 


--USER_CHECK에 GENDER에 대해'남''여' 외에 입력 불가한지 테스트 
CREATE TABLE USER_CHECK (
 USER_NO NUMBER ,
 USER_ID VARCHAR2(20) UNIQUE,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10) CHECK(GENDER IN ('남','여')),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50) 
 );

 INSERT
INTO USER_CHECK
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
3
,'user02'
,'pass02'
,'선덕여왕'
,'여자'
,'010-1234-5678'
,'hong123@greedy.com'
);

--테이블 레벨에서 CHECK제약 조건 설정
CREATE TABLE TEST_CHECK(
  TEST_NUMBER NUMBER,
  CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
  );

--TEST_CHECK테이블에 삽입 테스트
INSERT
  INTO TEST_CHECK
  (
  TEST_NUMBER
  )
VALUES
(
-10
);



-- 회원 가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호)
--         USER_ID(회원아이디) -- 중복 금지, NULL값 허용 안함
--         USER_PWD(회원비밀번호) -- NULL값 허용 안함
--         PNO(주민등록번호) -- 중복 금지, NULL값 허용 안함
--         GENDER(성별) -- '남' 또는 '여'로 입력
--         PHONE(연락처) 
--         ADDRESS(주소)
--         STATUS(탈퇴여부) -- NOT NULL, 'Y' 혹은 'N'으로 입력
-- 각 제약조건 이름 부여
-- 5명 이상 회원 정보 INSERT
-- 각 컬럼별로 코멘트 생성

CREATE TABLE USER_TEST(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) CONSTRAINT NN_USER_ID NOT NULL,
  USER_PWD VARCHAR2(20) CONSTRAINT NN_USER_PWD NOT NULL,
  PNO VARCHAR2(20) CONSTRAINT NN_PNO NOT NULL,
  GENDER VARCHAR2(3),
  PHONE VARCHAR2(20),
  ADDRESS VARCHAR2(100),
  STATUS VARCHAR2(3) CONSTRAINT NN_STATUS NOT NULL,
  CONSTRAINT UK_USER_ID UNIQUE(USER_ID),
  CONSTRAINT UK_PNO UNIQUE (PNO),
  CONSTRAINT CK_GENDER CHECK(GENDER IN ('남', '여')),
  CONSTRAINT CK_STATUS CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN USER_TEST.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST.USER_PWD IS '비밀번호';
COMMENT ON COLUMN USER_TEST.PNO IS '주민등록번호';
COMMENT ON COLUMN USER_TEST.GENDER IS '성별';
COMMENT ON COLUMN USER_TEST.PHONE IS '연락처';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '주소';
COMMENT ON COLUMN USER_TEST.STATUS IS '탈퇴여부';

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, PNO, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  1, 'user01', 'pass01'
, '881122-1234567', '여', '010-1234-5678'
, '서울시 강남구 역삼동', 'N'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, PNO, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  2, 'user02', 'pass02'
, '891122-1234567', '남', '010-1234-5679'
, '서울시 강남구 역삼동', 'N'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, PNO, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  3, 'user03', 'pass03'
, '901122-1234567', '여', '010-1234-5670'
, '서울시 강남구 역삼동', 'Y'
);
INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, PNO, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  4, 'user04', 'pass04'
, '911122-1234567', '남', '010-1234-5671'
, '서울시 강남구 역삼동', 'N'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, PNO, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  5, 'user05', 'pass05'
, '921122-1234567', '여', '010-1234-5672'
, '서울시 강남구 역삼동', 'N'
);

--PRIMARY KEY 기본키 제약 조건
--테이블에서 핸 행의 정보를 찾기 위해 사용할 컬럼을 의미한다. 
--테이블에 대한 식별자 역할을 한다. 
 --PK
 --NOT NULL + UNIQUE 의 의미를 가진다. 
 --NULL이거나 같은 값을 가지면 분별력이 없기 때문에 
 --한테이블당 하나만 설정할 수 있으며 컬럼 레벨, 테이블레벨 둘다 설정 가능하다. 
 --한개 컬럼에 설정할 수도 있고 여러개의 컬럼을 묶어서 설정할 수도 있다. 
 
--컬럼레벨에서 PK설정
CREATE TABLE USER_PRIMARY (
 USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
 USER_ID VARCHAR2(20) UNIQUE,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10) CHECK(GENDER IN ('남','여')),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50) 
 SDADASDFD 
 );

--PRIMARY KEY의 NOT NULL, UNIQUE 테스트 
 INSERT
INTO USER_PRIMARY
(
USER_NO
,USER_ID
,USER_PWD
,USER_NAME
,GENDER
,PHONE
,EMAIL
)
VALUES 
(
1
,'user01'
,'pass01'
,'선덕여왕'
,'여'
,'010-1234-5678'
,'hong123@greedy.com'
);

--테이블 레벨에서 PK설정 (두개의 값을 기본키로 설정할때 복합키라고 함)
CREATE TABLE USER_PRIMARY2 (
 USER_NO NUMBER,
 USER_ID VARCHAR2(20),
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30) NOT NULL,
 GENDER VARCHAR2 (10) CHECK(GENDER IN ('남','여')),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50),
 CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)
 );



-- FOREIGN KEY(외부키|외래키) 제약 조건
-- 참조(REFERENCES) 된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- 참조 무결성을 위배하지 않기 위해서 사용한다.
-- FOREIGN KEY 제약 조건에 의해서 테이블 간의 관계가 형성 되며 제공되는 값 외에는 NULL을 사용할 수 있다.

-- 컬럼 레벨인 경우
-- 컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조테이블명 [(참조컬럼명)] [삭제룰]

-- 테이블 레벨인 경우
-- [CONSTRAINT 제약조건명] FOREIGN KEY(적용컬럼명) REFENECES 참조테이블명 [(참조컬럼명)] [삭제룰]

-- 참조테이블의 참조컬럼명이 생략되면 PRIMARY KEY로 설정 된 컬럼이 자동으로 참조 컬럼이 된다.
-- PRIMARY KEY 컬럼과 UNIQUE로 지정된 컬럼만 참조 될 수 있다.


--삭제옵션
-- : 부모테이블의 데이터 삭제시 자식 테이블의 데이터를 어떤 식으로 처리할 것인지에 대한 설정
DELETE
  FROM USER_GRADE
 WHERE GRADE_CODE = 10;

--ON DELETE RESTRICT :  삭제 기본 지정 룰
--FK로 지정 된 컬럼에서 사용되고 있는 값일 경우 제공하는 컬럼의 값은 삭제 불가 .

--자식 레코드로 사용되지 않은 값은 삭제가능
DELETE
  FROM USER_GRADE
 WHERE GRADE_CODE = 20; 
-- ON DELETE RESTRICT : 삭제 기본 지정 룰
-- FK로 지정 된 컬럼에서 사용 되고 있는 값일 경우 제공하는 컬럼의 값은 삭제 불가

-- 자식 레코드로 사용되지 않는 값은 삭제 가능
DELETE
  FROM USER_GRADE
 WHERE GRADE_CODE = 20;

-- ON DELETE SET NULL : 부모키를 삭제 시 자식 키를 NULL로 변경하는 옵션
CREATE TABLE USER_GRADE2(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT 
  INTO USER_GRADE2
(
  GRADE_CODE
, GRADE_NAME
)
VALUES
(
  10
, '일반회원'
);

INSERT 
  INTO USER_GRADE2
(
  GRADE_CODE
, GRADE_NAME
)
VALUES
(
  20
, '우수회원'
);

INSERT 
  INTO USER_GRADE2
(
  GRADE_CODE
, GRADE_NAME
)
VALUES
(
  30
, '특별회원'
);

SELECT
       UG.*
  FROM USER_GRADE2 UG;

CREATE TABLE USER_FOREIGNKEY2 (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
);

INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  1
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@greedy.com'
, 10
);

INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  2
, 'user02'
, 'pass02'
, '유관순'
, '여'
, '010-1111-2222'
, 'yoo123@greedy.com'
, 10
);

INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  3
, 'user03'
, 'pass03'
, '윤봉길'
, '남'
, '010-1234-5678'
, 'yoon123@greedy.com'
, 30
);
-- FK는 NULL 값을 허용한다.
INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  4
, 'user04'
, 'pass04'
, '선덕여왕'
, '여'
, '010-1234-5678'
, 'sun123@greedy.com'
, NULL
);
-- 부모 키가 없어 외래키 제약 조건 위반
INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  5
, 'user05'
, 'pass05'
, '신사임당'
, '여'
, '010-1234-5678'
, 'shin123@greedy.com'
, 50
);
-- 삭제 제한이 걸려있지 않아 자식 레코드가 있더라도 삭제가 수행된다.
DELETE 
  FROM USER_GRADE2
 WHERE GRADE_CODE = 10;

SELECT
       UG.*
  FROM USER_GRADE2 UG;
-- 대신 삭제 된 값을 참조할 수는 없으므로 NULL 값으로 변경되어 있는 것을 확인할 수 있다.
SELECT
       UF.*
  FROM USER_FOREIGNKEY2 UF;

-- ON DELETE CASCADE : 부모 키 삭제 시 자식 키를 가진 행도 함께 삭제
CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT 
  INTO USER_GRADE3
(
  GRADE_CODE
, GRADE_NAME
)
VALUES
(
  10
, '일반회원'
);

INSERT 
  INTO USER_GRADE3
(
  GRADE_CODE
, GRADE_NAME
)
VALUES
(
  20
, '우수회원'
);

INSERT 
  INTO USER_GRADE3
(
  GRADE_CODE
, GRADE_NAME
)
VALUES
(
  30
, '특별회원'
);

SELECT
       UG.*
  FROM USER_GRADE3 UG;

CREATE TABLE USER_FOREIGNKEY3 (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);

INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  1
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@greedy.com'
, 10
);

INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  2
, 'user02'
, 'pass02'
, '유관순'
, '여'
, '010-1111-2222'
, 'yoo123@greedy.com'
, 10
);

INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  3
, 'user03'
, 'pass03'
, '윤봉길'
, '남'
, '010-1234-5678'
, 'yoon123@greedy.com'
, 30
);
-- FK는 NULL 값을 허용한다.
INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  4
, 'user04'
, 'pass04'
, '선덕여왕'
, '여'
, '010-1234-5678'
, 'sun123@greedy.com'
, NULL
);
-- 부모 키가 없어 외래키 제약 조건 위반
INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  5
, 'user05'
, 'pass05'
, '신사임당'
, '여'
, '010-1234-5678'
, 'shin123@greedy.com'
, 50
);
-- 삭제 제한이 걸려있지 않아 자식 레코드가 있더라도 삭제 가능
DELETE
  FROM USER_GRADE3
 WHERE GRADE_CODE = 10;
 
SELECT
       UG.*
  FROM USER_GRADE3 UG;
-- 대신 삭제 된 값을 참조할 수 없으므로 자식 테이블의 해당 행이 같이 삭제 되었다.
SELECT
       UF.*
  FROM USER_FOREIGNKEY3 UF;

-- 서브쿼리를 이용한 테이블 생성
-- 컬럼명, 데이터타입, 값이 복사되고, 제약조건은 NOT NULL만 복사된다.
CREATE TABLE EMPLOYEE_COPY
AS
SELECT
       E.*
  FROM EMPLOYEE E;

SELECT
       EC.*
  FROM EMPLOYEE_COPY EC;


