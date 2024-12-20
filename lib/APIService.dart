import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final url =
        Uri.parse('https://api.ezuite.com/api/External_Api/Mobile_Api/Invoke');
    final body = jsonEncode({
      "API_Body": [
        {"Unique_Id": "", "Pw": password}
      ],
      "Api_Action": "GetUserData",
      "Company_Code": username
    });

    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }
}
