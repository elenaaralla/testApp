/**
 * Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Application properties
	this.name              = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout    = createTimespan( 0, 0, 30, 0 );
	this.setClientCookies  = true;


	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE   = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY       = "";

	// Java Integration
	this.javaSettings = { 
		loadPaths = [ 
			COLDBOX_APP_ROOT_PATH & "\lib"
		], 
		reloadOnChange = false 
	};	

    variables.util = new coldbox.system.core.util.Util();

this.datasources["testappdb"] = {
	class: 'org.h2.Driver'
	// , bundleName: 'com.h2database'
	// , bundleVersion: '1.4.200'
	//, 
	, schema: 'INFORMATION_SCHEMA'
	, connectionString: 'jdbc:h2:/Users/elena/coldbox-examples/testApp/database/appDB;MODE=MySQL;DATABASE_TO_LOWER=TRUE;CASE_INSENSITIVE_IDENTIFIERS=TRUE;'	
	//, username = ''// optional settings
	//, password = ''
	, connectionLimit:100 // default:-1
	, validate:false // default: false
};

/* 	this.datasources["testappdb"] = {
		  class = util.getSystemSetting( "DB_CLASS" )
		, driver = util.getSystemSetting( "DB_DRIVER" )
		, bundleName = util.getSystemSetting( "DB_BUNDLENAME" )
		, bundleVersion =  util.getSystemSetting( "DB_BUNDLEVERSION" )
		, schema = util.getSystemSetting( "DB_SCHEMA" )
		, connectionString = util.getSystemSetting( "DB_CONNECTIONSTRING" )	
		, password = util.getSystemSetting( "DB_PASSWORD" )
		, username = util.getSystemSetting( "DB_USER" )
		// optional settings
		, connectionLimit:100 // default:-1
		, validate:false // default: false
	}; */

	this.defaultdatasource = "testappdb";

	this.mappings[ "/quick" ] = COLDBOX_APP_ROOT_PATH & "/modules/quick";

	// application start
	public boolean function onApplicationStart() {
		application.cbBootstrap = new coldbox.system.Bootstrap(
			COLDBOX_CONFIG_FILE,
			COLDBOX_APP_ROOT_PATH,
			COLDBOX_APP_KEY,
			COLDBOX_APP_MAPPING
		);
		application.cbBootstrap.loadColdbox();
		return true;
	}

	// application end
	public void function onApplicationEnd( struct appScope ) {
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	// request start
	public boolean function onRequestStart( string targetPage ) {
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );

		return true;
	}

	public void function onSessionStart() {
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ) {
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection = arguments );
	}

	public boolean function onMissingTemplate( template ) {
		return application.cbBootstrap.onMissingTemplate( argumentCollection = arguments );
	}

	function getSystemSetting( required string key, any defaultValue ){
		param variables.javaSystem = createObject( "java", "java.lang.System" );
		var value = variables.javaSystem.getProperty( arguments.key );
		if ( !isNull( local.value ) ) {
			return value;
		}

		value = variables.javaSystem.getEnv( arguments.key );
		if ( !isNull( local.value ) ) {
			return value;
		}

		if ( !isNull( arguments.defaultValue ) ) {
			return arguments.defaultValue;
		}

		throw(
			type = "SystemSettingNotFound",
			message = "Could not find a Java System property or Env setting with key [#arguments.key#]."
		);
	}	

}
