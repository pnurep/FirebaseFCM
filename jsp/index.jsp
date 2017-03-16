<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.security.*, java.io.*, java.net.*" %>

<%
String result = "";

//1. fcm서버 정보 세팅
String fcm_url = "https://fcm.googleapis.com/fcm/send";
String content_type = "application/json";
String server_key = "AAAAXtye6mg:APA91bFGu8ulzkWz3Ti3ffwZOLOXfQtKo-K4vpsigFu7fVPX-smAT4-4fzLT9iFwSgo9ptwsWmUlLM11PQ-TJG-AeOt1B3IxxarrUQW2ePS0_ejjgR_OynchbiCpRhOSDkIqM2X4ksJG";

//2. 메시지 정보를 클라이언트(폰)로 부터 수신
request.setCharacterEncoding("utf-8");

String to_token = request.getParameter("to_token");
//"fFodFcHgKiE:APA91bHHF95bVsW207pTUIgP8K3Xgj28bOEMiRzuUW66TQqQtWLPoJmYvMvX13xvyXjm3lNqk0rnCYIUwcnQCWj9Q4LZRyxK9NQDhU3R_HSjeCFqhO4VgeMG0pB30mh_J2uc6OkabOSS"; //
String msg      = request.getParameter("msg"); //리퀘스트 객체로 받는다.
String sender   = request.getParameter("sender");
String title    = " 보내는사람:"+sender;

//3. fcm서버로 메시지를 전송
//3.1 수신한 메시지를 json형태로 변경해준다.
String json_string = "{\"to\": \"" + to_token + "\", \"notification\": { \"title\":\"FCM_TEST\" , \"body\": \"" + msg + "\"}}";
   
//3.2 HTTPURLConnection을 사용해서 FCM서버측으로 메시지를 전송한다..
// a. 서버연결
URL url = new URL(fcm_url);
HttpURLConnection con = (HttpURLConnection) url.openConnection();

// b. header 설정
con.setRequestMethod("POST");
con.setRequestProperty("Authorization", "key=" + server_key);
con.setRequestProperty("Content-type", content_type);

// c. post데이터(body)전송
con.setDoOutput(true); //바디가 있다 라고 알려주는 것
OutputStream os = con.getOutputStream(); // 아웃풋스트림을 열고
os.write(json_string.getBytes());
os.flush();
os.close();

// d. 전송후 결과처리
int responseCode = con.getResponseCode();
if(responseCode == HttpURLConnection.HTTP_OK){ //code 200
	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	String dataLine = "";
	//메시지를 한줄 씩 읽어서 result변수에 담아두고
	while((dataLine = br.readLine()) != null){
		result = result + dataLine;
	}
	br.close();
}

out.print("RESUlT" + result);

%>

<%= result%>


