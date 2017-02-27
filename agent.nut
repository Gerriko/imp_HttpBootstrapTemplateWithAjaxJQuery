function httpHandler(request,response) {
    try 
    {
        local urlPath = split(http.agenturl(), "/");
        local pathField = "path=/" + urlPath[2];
        server.log("pathField: " + pathField);
        
        local method = request.method.toupper();
        server.log("method: " + method);
        local reqpath = split(request.path.tolower(), "/");

        response.header("Access-Control-Allow-Origin", "*");            // If you are placing html page on web server then lock this down (don't use *)
        response.header("Access-Control-Request-Headers", "X-Requested-With, Content-Type");
        response.header("Access-Control-Allow-Methods", "GET, POST");
        //response.header("Access-Control-Allow-Credentials", "True");
        //response.header("X-From-Agent", "Yes");
        server.log("http path: "+ reqpath[0]);
        if (reqpath[0] == "lights") {
            if (method == "GET") {
                foreach(key, value in request.query) {
                    local now = date();
                    local htmlTable = {v1=now.sec, v2=0, v3="lights all ok"};
                    local jvars = http.jsonencode(htmlTable);
                    response.send(200, jvars);
                }
            }
            else if (method == "POST") {
                server.log("post: " + request.body);
                local keyval = split(request.body, "=");
                if (keyval[1].tointeger() == 1) response.send(200, "Lights OFF");
                else if (keyval[1].tointeger() == 2) response.send(200, "Lights ON");
                else response.send(200, "no action");
            }
        }
        else if (reqpath[0] == "heat") {
            if (method == "GET") {
                foreach(key, value in request.query) {
                    local now = date();
                    local htmlTable = {v1=20, v2=now.sec, v3="heating all ok"};
                    local jvars = http.jsonencode(htmlTable);
                    response.send(200, jvars);
                }
            }
            else if (method == "POST") {
                server.log("post: " + request.body);
                local keyval = split(request.body, "=");
                if (keyval[1].tointeger() == 1) response.send(200, "Heat OFF");
                else if (keyval[1].tointeger() == 2) response.send(200, "Heat ON");
                else response.send(200, "no action");
            }
        }
        else if (reqpath[0] == "alarm") {
            if (method == "GET") {
                foreach(key, value in request.query) {
                    local now = date();
                    local datestmp = now.year.tostring()+"-"+format("%02d", now.month+1)+"-"+format("%02d", now.day)+"@"+format("%02d", now.hour)+":"+format("%02d", now.min);
                    local htmlTable = {v1=datestmp, v2="kitchen", v3="alarms all ok"};
                    local jvars = http.jsonencode(htmlTable);
                    response.send(200, jvars);
                }
            }
            else if (method == "POST") {
                server.log("post: " + request.body);
                local keyval = split(request.body, "=");
                if (keyval[1].tointeger() == 1) response.send(200, "Alarm OFF");
                else if (keyval[1].tointeger() == 2) response.send(200, "Alarm ON");
                else response.send(200, "no action");
            }
        }
        else response.send(200, "OK");
    }
    catch(error)
    {
        response.send(500, "Internal Server Error: " + error)
    }    
}

http.onrequest(httpHandler);
