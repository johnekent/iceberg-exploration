CREATE TABLE garden_plants (
  id int,
  name string,
  category string) 
PARTITIONED BY (category) 
LOCATION 's3://us-east-1-brainflutter-analytics/data/garden_plants' 
TBLPROPERTIES (
  'table_type'='ICEBERG',
  'format'='parquet',
  'compaction_bin_pack_target_file_size_bytes'='1024'
);


insert into garden_plants (id, name, category) values (1, 'oregano', 'herb');
insert into garden_plants (id, name, category) values (2, 'pepper', 'vegetable');
