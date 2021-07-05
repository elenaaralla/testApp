component {
    
    function up( schema, qb ) {
       	schema.create( "TEST", function(table) {
			table.increments( "ID" );
			table.string( "NAME" );
		} ); 
    }

    function down( schema, qb ) {
        schema.drop( "TEST" );
    }

}
