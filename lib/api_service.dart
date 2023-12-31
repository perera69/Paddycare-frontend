import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl =
      "http://172.31.112.1:3000"; // Replace with your actual server IP

  static Future<Map<String, dynamic>> registerUser(
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse("$baseUrl/registration");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      print("Request: $data");
      print("Response: ${response.statusCode} - ${response.body}");

      try {
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception("Failed to register user: ${response.statusCode}");
        }
      } catch (e) {
        print("Failed to decode response body: $e");
        return {'success': false, 'message': 'Failed to decode response body'};
      }
    } catch (e) {
      print("Failed to register user: $e");
      return {'success': false, 'message': 'Failed to register user: $e'};
    }
  }
}

class ApiServicelogin {
  static const baseUrl = "http://172.31.112.1:3000"; // my server IP

  static Future<Map<String, dynamic>> loginUser(
      Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      print("Request: $data");
      print("Response: ${response.statusCode} - ${response.body}");

      try {
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception("Failed to log in user: ${response.statusCode}");
        }
      } catch (e) {
        print("Failed to decode response body: $e");
        return {'success': false, 'message': 'Failed to decode response body'};
      }
    } catch (e) {
      print("Failed to log in user: $e");
      return {'success': false, 'message': 'Failed to log in user: $e'};
    }
  }
}
