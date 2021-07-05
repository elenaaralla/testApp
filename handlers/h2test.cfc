component extends="coldbox.system.EventHandler" {

	property name="h2testService" inject="quickService:h2test";
	property name="infosService" inject="quickService:informationschema";

	// Default Action
	function index( event, rc, prc ){
	
		prc.welcomeMessage = "Welcome to ColdBox!";
		var test = h2testService.findOrFail( 1 );

		return "num records=" & h2testService.count() & "<br /> row## " & test.getId() & "=>name = " & test.getName();
	}


	function index2( event, rc, prc ){
	
		prc.welcomeMessage = "Index2";

		// SELECT 1 FROM "information_schema"."tables" WHERE "table_name" = 'cfmigrations' AND "table_schema" = 'testAppDB' 
		
		var inft = infosService.findOrFail( "cfmigrations" );

		return "num records=" & inft.count() & "<br /> row## " & inft.getSECTION()();
	}

}