@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global class WebHookIntegration {
    
    
    @HttpGet
    global static void checkconnection() {
        
        string verify_token = 'thestylishcoder';
        String secertKey = 'f809f6b936ce1e5d3d30938fc929f761';
        
        try{
            RestRequest req = RestContext.request;
            RestResponse response = RestContext.response;
            String req_verify = req.params.get('hub.verify_token');
            string req_mode = req.params.get('hub.mode');
            string req_challenge = req.params.get('hub.challenge');
            String sha = req.headers.get('X-Hub-Signature');
           
            
           system.debug(req_verify);
            Blob bb = req.requestBody;
            system.debug(bb);
            
            if(req_verify == verify_token ){
                response.statusCode = 200;
                response.responseBody = Blob.valueOf(req_challenge);
                Account act = new Account();
                act.Description = sha;
                insert act;
                
                
            }
            else{
                response.statusCode = 403;
                response.responseBody = Blob.valueOf('000000000');
            }
        }
        catch(Exception e){
            System.System.debug('Connection Error ' + e.getMessage());
        }
        
    }
    
    @HttpPost 
    global static void handleFacebook(){
        String verifyToken = 'abc123';
        try{
            Facebook__c fb = new Facebook__c();
            RestRequest request = RestContext.request;
            String sha = request.headers.get('X-Hub-Signature');
            String requestBody = request.requestBody.tostring();
            String Userid;
            
            //JSON deserializeUntyped
            Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(requestBody); // object, entry
            List<Object> entry = (List<Object>) m.get('entry');
            Map<String, Object> ch = (Map<String, Object>) entry[0]; // id, time, changes
            List<Object> Changes = (List<Object>) ch.get('changes');
            Map<String, Object> data = (Map<String, Object>) Changes[0]; // field, value
            Map<String, Object> values = (Map<String, Object>) data.get('value'); // value sets
            
            //Insert Data 
            fb.name = 'Bhavesh ' + m.get('object');
            fb.field_Name__c = (String) data.get('field');
            fb.id__c = '' + ch.get('id'); 
            fb.ad_id__c = (String) values.get('ad_id') ;
            fb.adgroup_id__c = (String) values.get('adgroup_id');
            //fb.created_time__c = (String) ch.get('time');
            fb.form_id__c = (String) values.get('form_id');
            fb.leadgen_id__c = (String) values.get('leadgen_id');
            fb.page_id__c = (String) values.get('page_id');
            
            // JSON Data 
            /*JSONParser jp = JSON.createParser(request.requestBody.toString());
            
            while(jp.nextToken()!=null) 
        	{ 
                if(jp.getText()=='field') { 
                    jp.nextToken();
                    fb.name = 'Bhavesh ' + jp.getText(); 
                 }
                if(jp.getText() == 'id'){
                    jp.nextToken();
                    fb.id__c = jp.getText();
                }
                if(jp.getText() == 'ad_id'){
                    jp.nextToken();
                    fb.ad_id__c = jp.getText();
                }
                if(jp.getText() == 'form_id'){
                    jp.nextToken();ch
                    fb.form_id__c = jp.getText();
                }
                if(jp.getText() == 'leadgen_id'){
                    jp.nextToken();
                    fb.leadgen_id__c = jp.getText();
                }
                if(jp.getText() == 'page_id'){
                    jp.nextToken();
                    fb.page_id__c = jp.getText();
                }
                if(jp.getText() == 'adgroup_id'){
                    jp.nextToken();
                    fb.adgroup_id__c = jp.getText();
                }
                if(jp.getText() == 'created_time'){
                    jp.nextToken();
                    fb.created_time__c = jp.getText();
                }
        	} */
            
            //Response ex = (Response) parser.readValueAs(Response.class);
            
            Account act = new Account();
            act.name = 'bhavesh '  + m.get('object');
            
            act.description = sha;
            insert act;
            insert fb;
            RestResponse response = RestContext.response;
           
            System.System.debug('Request ' + request);
            
            System.System.debug('Response ' + response);
        }
        catch(Exception e){
            System.System.debug('Exception Happened: ' + e.getMessage());
        }
    }
}

/*
{"object": "page",
	"entry": 
	[{
		"id": "0", 
		"time": 1638363210, 
		"changes": 
			[{
				"field": "leadgen", 
				"value": {
						"ad_id": "444444444",
                        "form_id": "444444444444", 
                        "leadgen_id": "444444444444", 
                        "created_time": 1638363210, 
                        "page_id": "444444444444", 
                        "adgroup_id": "44444444444"
                        }
			}]
	}]
}

*/