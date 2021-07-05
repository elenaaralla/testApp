// informationschema.cfc
component
    datasource="other"
    table="TABLES"
    extends="quick.models.BaseEntity"
    accessors="true"
{
    variables._key = "TABLE_NAME";

    property name="TABLE_SCHEMA"; 
}