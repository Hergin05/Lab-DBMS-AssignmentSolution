Create Database order_directory;

1)
create table order_directory.supplier(
SUPP_ID int primary key,
SUPP_NAME varchar(50) ,
SUPP_CITY varchar(50),
SUPP_PHONE varchar(10)
);


CREATE TABLE order_directory.customer(
  CUS_ID INT NOT NULL,
  CUS_NAME VARCHAR(20) NULL DEFAULT NULL,
  CUS_PHONE VARCHAR(10),
  CUS_CITY varchar(30) ,
  CUS_GENDER CHAR,
  PRIMARY KEY (CUS_ID));

 

CREATE TABLE order_directory.category (
  CAT_ID INT NOT NULL,
  CAT_NAME VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (CAT_ID)
  );



  CREATE TABLE order_directory.product (
  PRO_ID INT NOT NULL,
  PRO_NAME VARCHAR(20) NULL DEFAULT NULL,
  PRO_DESC VARCHAR(60) NULL DEFAULT NULL,
  CAT_ID INT NOT NULL,
  PRIMARY KEY (PRO_ID),
  FOREIGN KEY (CAT_ID) REFERENCES CATEGORY (CAT_ID)
  
  );


 CREATE TABLE order_directory.product_details (
  PROD_ID INT NOT NULL,
  PRO_ID INT NOT NULL,
  SUPP_ID INT NOT NULL,
  PROD_PRICE INT NOT NULL,
  PRIMARY KEY (PROD_ID),
  FOREIGN KEY (PRO_ID) REFERENCES PRODUCT (PRO_ID),
  FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER(SUPP_ID)
  
  );


 
CREATE TABLE order_directory.order (
  ORD_ID INT NOT NULL,
  ORD_AMOUNT INT NOT NULL,
  ORD_DATE DATE,
  CUS_ID INT NOT NULL,
  PROD_ID INT NOT NULL,
  PRIMARY KEY (ORD_ID),
  FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID),
  FOREIGN KEY (PROD_ID) REFERENCES PRODUCT_DETAILS(PROD_ID)
  );


CREATE TABLE order_directory.rating (
  RAT_ID INT NOT NULL,
  CUS_ID INT NOT NULL,
  SUPP_ID INT NOT NULL,
  RAT_RATSTARS INT NOT NULL,
  PRIMARY KEY (RAT_ID),
  FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER (SUPP_ID),
  FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID)
  );


2)
insert into order_directory.supplier values(1,"Rajesh Retails","Delhi",'1234567890');
insert into order_directory.supplier values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into order_directory.supplier values(3,"Knome products","Banglore",'9785462315');
insert into order_directory.supplier values(4,"Bansal Retails","Kochi",'8975463285');
insert into order_directory.supplier values(5,"Mittal Ltd.","Lucknow",'7898456532');

insert into order_directory.customer values(1,"AAKASH",'9999999999',"DELHI",'M');  
insert into order_directory.customer values(2,"AMAN",'9785463215',"NOIDA",'M');
insert into order_directory.customer values(3,"NEHA",'9999999999',"MUMBAI",'F');
insert into order_directory.customer values(4,"MEGHA",'9994562399',"KOLKATA",'F');
insert into order_directory.customer values(5,"PULKIT",'7895999999',"LUCKNOW",'M');

insert into order_directory.category values( 1,"BOOKS"); 
insert into order_directory.category values(2,"GAMES");
insert into order_directory.category values(3,"GROCERIES");
insert into order_directory.category values(4,"ELECTRONICS");
insert into order_directory.category values(5,"CLOTHES");
  

insert into order_directory.product values(1,"GTA V","DFJDJFDJFDJFDJFJF",2); 
insert into order_directory.product values(2,"TSHIRT","DFDFJDFJDKFD",5);
insert into order_directory.product values(3,"ROG LAPTOP","DFNTTNTNTERND",4);
insert into order_directory.product values(4,"OATS","REURENTBTOTH",3);
insert into order_directory.product values(5,"HARRY POTTER","NBEMCTHTJTH",1);
    
insert into order_directory.product_details values(1,1,2,1500); 
insert into order_directory.product_details values(2,3,5,30000);
insert into order_directory.product_details values(3,5,1,3000);
insert into order_directory.product_details values(4,2,3,2500);
insert into order_directory.product_details values(5,4,1,1000);
  
insert into order_directory.order values(50,2000,"2021-10-06",2,1); 
insert into order_directory.order values(20,1500,"2021-10-12",3,5);
insert into order_directory.order values(25,30500,"2021-09-16",5,2);
insert into order_directory.order values(26,2000,"2021-10-05",1,1);
insert into order_directory.order values(30,3500,"2021-08-16",4,3);
  
insert into order_directory.rating values(1,2,2,4);  
insert into order_directory.rating values(2,3,4,3);
insert into order_directory.rating values(3,5,1,5);
insert into order_directory.rating values(4,1,3,2);
insert into order_directory.rating values(5,4,5,4);

3)
select customer.cus_gender,count(customer.cus_gender) as count 
from order_directory.customer 
inner join order_directory.order on customer.cus_id=`order`.cus_id 
where `order`.ord_amount>=3000 
group by customer.cus_gender;

4)
select `order`.*,product.pro_name 
from order_directory.order, order_directory.product_details, order_directory.product 
where `order`.cus_id=2 and `order`.prod_id=product_details.prod_id and product_details.prod_id=product.pro_id;

5)
select supplier.* 
from order_directory.supplier, order_directory.product_details 
where supplier.supp_id in (select product_details.supp_id 
							from order_directory.product_details 
                            group by product_details.supp_id 
                            having count(product_details.supp_id)>1) 
group by supplier.supp_id;

6)
select category.* 
from order_directory.order
inner join order_directory.product_details on `order`.prod_id=product_details.prod_id 
inner join order_directory.product on product.pro_id=product_details.pro_id 
inner join order_directory.category on category.cat_id=product.cat_id 
having min(`order`.ord_amount);

7)
select product.pro_id,product.pro_name 
from order_directory.order
inner join order_directory.product_details on product_details.prod_id=`order`.prod_id 
inner join order_directory.product on product.pro_id=product_details.pro_id 
where `order`.ord_date>"2021-10-05";

8)
select supplier.supp_id,supplier.supp_name,customer.cus_name,rating.rat_ratstars 
from order_directory.rating 
inner join order_directory.supplier on rating.supp_id=supplier.supp_id 
inner join order_directory.customer on rating.cus_id=customer.cus_id 
order by rating.rat_ratstars desc limit 3;

9)
select customer.cus_name ,customer.cus_gender 
from order_directory.customer 
where customer.cus_name like 'A%' or customer.cus_name like '%A';

10)
select sum(`order`.ord_amount) as Amount 
from order_directory.order
inner join order_directory.customer on `order`.cus_id=customer.cus_id 
where customer.cus_gender='M';

11)
select *  
from order_directory.customer 
left outer join order_directory.order on customer.cus_id=`order`.cus_id; 

12)
DELIMITER &&  
CREATE PROCEDURE order_directory.proc()
BEGIN
select supplier.supp_id, supplier.supp_name, rating.rat_ratstars,
CASE
    WHEN rating.rat_ratstars >4 THEN 'Genuine Supplier'
    WHEN rating.rat_ratstars>2 THEN 'Average Supplier'
    ELSE 'Supplier should not be considered'
END AS verdict from order_directory.rating inner join order_directory.supplier on supplier.supp_id=rating.supp_id;
END &&  
DELIMITER ;  

call order_directory.proc();
