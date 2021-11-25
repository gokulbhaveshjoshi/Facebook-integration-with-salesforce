@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global class WebHookIntegration {
    
    
    @HttpGet
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse response = RestContext.response;
        response.statusCode = 200;
        response.responseBody = Blob.valueOf('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        
    }
    
    @HttpPost 
    global static void handleFacebook(){
        String verifyToken = 'abc123';
            try{
                RestRequest request = RestContext.request;
                string resChallenge = request.headers.get('challenge');
                string resVerify = request.params.get('verify_token');
                RestResponse response = RestContext.response;
                System.System.debug('challenge ' + resChallenge);
                response.responseBody = Blob.valueOf(resChallenge);
                /*if(verifyToken == resVerify){
                    response.responseBody = Blob.valueOf(resChallenge);
                }
                else{
                    response.addHeader('challenge', '123');
                }*/
                System.System.debug('Request ' + request);
                
                System.System.debug('Response ' + response);
            }
            catch(Exception e){
                System.System.debug('Exception Happened: ' + e.getMessage());
            }
    }
}