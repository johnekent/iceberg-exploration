# iceberg-exploration
Commands and experiences


## Creating Table.
This creates a containing folder (garden_plants) along with metadata folder and a single json metadata file.  The data folder is not yet created.<br>
```
[cloudshell-user@ip-10-0-8-96 ~]$ aws s3 ls us-east-1-brainflutter-analytics/data/garden_plants/
                           PRE metadata/
[cloudshell-user@ip-10-0-8-96 ~]$ aws s3 ls us-east-1-brainflutter-analytics/data/garden_plants/metadata/
2022-02-05 16:58:25       1346 00000-87984b88-b64c-46fa-930b-576434eecc9f.metadata.json
```
```
{
  "format-version" : 2,
  "table-uuid" : "317317f5-b692-47c9-9167-0919c9422f9c",
  "location" : "s3://us-east-1-brainflutter-analytics/data/garden_plants",
  "last-sequence-number" : 0,
  "last-updated-ms" : 1644080304343,
  "last-column-id" : 3,
  "current-schema-id" : 0,
  "schemas" : [ {
    "type" : "struct",
    "schema-id" : 0,
    "fields" : [ {
      "id" : 1,
      "name" : "id",
      "required" : false,
      "type" : "int"
    }, {
      "id" : 2,
      "name" : "name",
      "required" : false,
      "type" : "string"
    }, {
      "id" : 3,
      "name" : "category",
      "required" : false,
      "type" : "string"
    } ]
  } ],
  "default-spec-id" : 0,
  "partition-specs" : [ {
    "spec-id" : 0,
    "fields" : [ {
      "name" : "category",
      "transform" : "identity",
      "source-id" : 3,
      "field-id" : 1000
    } ]
  } ],
  "last-partition-id" : 1000,
  "default-sort-order-id" : 0,
  "sort-orders" : [ {
    "order-id" : 0,
    "fields" : [ ]
  } ],
  "properties" : {
    "write.format.default" : "parquet",
    "write.target-file-size-bytes" : "1024",
    "write.object-storage.enabled" : "true",
    "write.object-storage.path" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/data"
  },
  "current-snapshot-id" : -1,
  "snapshots" : [ ],
  "snapshot-log" : [ ],
  "metadata-log" : [ ]
}
```

## Inserting Initial Data
insert into garden_plants (id, name, category) values (1, 'oregano', 'herb');<br>
The insert creates the following structure and parquet file.  Note the category partition.<br>
[cloudshell-user@ip-10-0-8-96 ~]$ aws s3 ls us-east-1-brainflutter-analytics/data/garden_plants/data/21d0b195/data/garden_plants/category=herb/<br>
2022-02-05 17:06:14        428 3083a5d0-f815-405a-9914-11f877cdb4f6.gz.parquet<br>

The insert also creates a new metadata file and 2 avro files: <br>

```
cloudshell-user@ip-10-0-8-96 ~]$ aws s3 ls us-east-1-brainflutter-analytics/data/garden_plants/metadata/
2022-02-05 16:58:25       1346 00000-87984b88-b64c-46fa-930b-576434eecc9f.metadata.json
2022-02-05 17:06:16       2317 00001-41d8f851-4ef5-42c8-990e-c06c3fee78bf.metadata.json
2022-02-05 17:06:15       6828 5fb6ab2d-f3d6-44f9-90ac-7913fa33e05d-m0.avro
2022-02-05 17:06:15       4282 snap-8270461298068518761-1-5fb6ab2d-f3d6-44f9-90ac-7913fa33e05d.avro
```

*Note the addition of the snapshot and manifest content in the new metadata.json file*

```
{
  "format-version" : 2,
  "table-uuid" : "317317f5-b692-47c9-9167-0919c9422f9c",
  "location" : "s3://us-east-1-brainflutter-analytics/data/garden_plants",
  "last-sequence-number" : 1,
  "last-updated-ms" : 1644080774700,
  "last-column-id" : 3,
  "current-schema-id" : 0,
  "schemas" : [ {
    "type" : "struct",
    "schema-id" : 0,
    "fields" : [ {
      "id" : 1,
      "name" : "id",
      "required" : false,
      "type" : "int"
    }, {
      "id" : 2,
      "name" : "name",
      "required" : false,
      "type" : "string"
    }, {
      "id" : 3,
      "name" : "category",
      "required" : false,
      "type" : "string"
    } ]
  } ],
  "default-spec-id" : 0,
  "partition-specs" : [ {
    "spec-id" : 0,
    "fields" : [ {
      "name" : "category",
      "transform" : "identity",
      "source-id" : 3,
      "field-id" : 1000
    } ]
  } ],
  "last-partition-id" : 1000,
  "default-sort-order-id" : 0,
  "sort-orders" : [ {
    "order-id" : 0,
    "fields" : [ ]
  } ],
  "properties" : {
    "write.target-file-size-bytes" : "1024",
    "write.format.default" : "parquet",
    "write.object-storage.enabled" : "true",
    "write.object-storage.path" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/data"
  },
  "current-snapshot-id" : 8270461298068518761,
  "snapshots" : [ {
    "sequence-number" : 1,
    "snapshot-id" : 8270461298068518761,
    "timestamp-ms" : 1644080774700,
    "summary" : {
      "operation" : "append",
      "added-data-files" : "1",
      "added-records" : "1",
      "added-files-size" : "428",
      "changed-partition-count" : "1",
      "total-records" : "1",
      "total-files-size" : "428",
      "total-data-files" : "1",
      "total-delete-files" : "0",
      "total-position-deletes" : "0",
      "total-equality-deletes" : "0"
    },
    "manifest-list" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/metadata/snap-8270461298068518761-1-5fb6ab2d-f3d6-44f9-90ac-7913fa33e05d.avro",
    "schema-id" : 0
  } ],
  "snapshot-log" : [ {
    "timestamp-ms" : 1644080774700,
    "snapshot-id" : 8270461298068518761
  } ],
  "metadata-log" : [ {
    "timestamp-ms" : 1644080304343,
    "metadata-file" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/metadata/00000-87984b88-b64c-46fa-930b-576434eecc9f.metadata.json"
  } ]
}
```

## Inserting Additional Data
insert into garden_plants (id, name, category) values (2, 'pepper', 'vegetable');<br>

This creates additional metadata contents:<br>

```
[cloudshell-user@ip-10-0-8-96 ~]$ aws s3 ls us-east-1-brainflutter-analytics/data/garden_plants/metadata/
2022-02-05 16:58:25       1346 00000-87984b88-b64c-46fa-930b-576434eecc9f.metadata.json
2022-02-05 17:06:16       2317 00001-41d8f851-4ef5-42c8-990e-c06c3fee78bf.metadata.json
2022-02-05 17:06:15       6828 5fb6ab2d-f3d6-44f9-90ac-7913fa33e05d-m0.avro
2022-02-05 17:06:15       4282 snap-8270461298068518761-1-5fb6ab2d-f3d6-44f9-90ac-7913fa33e05d.avro
2022-02-05 17:36:40       3322 00002-6a2862b4-916d-4693-a304-9ffae5991b67.metadata.json
2022-02-05 17:36:39       6833 9aeb5939-65c7-4e30-b319-d5c065cef1d7-m0.avro
2022-02-05 17:36:39       4370 snap-1397432436782130529-1-9aeb5939-65c7-4e30-b319-d5c065cef1d7.avro
```

*Note the additional snapshot and manifest content.*

```
{
  "format-version" : 2,
  "table-uuid" : "317317f5-b692-47c9-9167-0919c9422f9c",
  "location" : "s3://us-east-1-brainflutter-analytics/data/garden_plants",
  "last-sequence-number" : 2,
  "last-updated-ms" : 1644082598442,
  "last-column-id" : 3,
  "current-schema-id" : 0,
  "schemas" : [ {
    "type" : "struct",
    "schema-id" : 0,
    "fields" : [ {
      "id" : 1,
      "name" : "id",
      "required" : false,
      "type" : "int"
    }, {
      "id" : 2,
      "name" : "name",
      "required" : false,
      "type" : "string"
    }, {
      "id" : 3,
      "name" : "category",
      "required" : false,
      "type" : "string"
    } ]
  } ],
  "default-spec-id" : 0,
  "partition-specs" : [ {
    "spec-id" : 0,
    "fields" : [ {
      "name" : "category",
      "transform" : "identity",
      "source-id" : 3,
      "field-id" : 1000
    } ]
  } ],
  "last-partition-id" : 1000,
  "default-sort-order-id" : 0,
  "sort-orders" : [ {
    "order-id" : 0,
    "fields" : [ ]
  } ],
  "properties" : {
    "write.target-file-size-bytes" : "1024",
    "write.format.default" : "parquet",
    "write.object-storage.enabled" : "true",
    "write.object-storage.path" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/data"
  },
  "current-snapshot-id" : 1397432436782130529,
  "snapshots" : [ {
    "sequence-number" : 1,
    "snapshot-id" : 8270461298068518761,
    "timestamp-ms" : 1644080774700,
    "summary" : {
      "operation" : "append",
      "added-data-files" : "1",
      "added-records" : "1",
      "added-files-size" : "428",
      "changed-partition-count" : "1",
      "total-records" : "1",
      "total-files-size" : "428",
      "total-data-files" : "1",
      "total-delete-files" : "0",
      "total-position-deletes" : "0",
      "total-equality-deletes" : "0"
    },
    "manifest-list" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/metadata/snap-8270461298068518761-1-5fb6ab2d-f3d6-44f9-90ac-7913fa33e05d.avro",
    "schema-id" : 0
  }, {
    "sequence-number" : 2,
    "snapshot-id" : 1397432436782130529,
    "parent-snapshot-id" : 8270461298068518761,
    "timestamp-ms" : 1644082598442,
    "summary" : {
      "operation" : "append",
      "added-data-files" : "1",
      "added-records" : "1",
      "added-files-size" : "448",
      "changed-partition-count" : "1",
      "total-records" : "2",
      "total-files-size" : "876",
      "total-data-files" : "2",
      "total-delete-files" : "0",
      "total-position-deletes" : "0",
      "total-equality-deletes" : "0"
    },
    "manifest-list" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/metadata/snap-1397432436782130529-1-9aeb5939-65c7-4e30-b319-d5c065cef1d7.avro",
    "schema-id" : 0
  } ],
  "snapshot-log" : [ {
    "timestamp-ms" : 1644080774700,
    "snapshot-id" : 8270461298068518761
  }, {
    "timestamp-ms" : 1644082598442,
    "snapshot-id" : 1397432436782130529
  } ],
  "metadata-log" : [ {
    "timestamp-ms" : 1644080304343,
    "metadata-file" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/metadata/00000-87984b88-b64c-46fa-930b-576434eecc9f.metadata.json"
  }, {
    "timestamp-ms" : 1644080774700,
    "metadata-file" : "s3://us-east-1-brainflutter-analytics/data/garden_plants/metadata/00001-41d8f851-4ef5-42c8-990e-c06c3fee78bf.metadata.json"
  } ]
}
```

This additional partition folder and data file were also created.

```
[cloudshell-user@ip-10-0-8-96 ~]$ aws s3 ls us-east-1-brainflutter-analytics/data/garden_plants/data/739c43e1/data/garden_plants/category=vegetable/
2022-02-05 17:36:38        448 6499133c-e17f-4079-a917-5425dacdd202.gz.parquet
```
