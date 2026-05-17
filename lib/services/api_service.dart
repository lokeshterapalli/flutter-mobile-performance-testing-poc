import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      'http://10.0.2.2:3000';

static Future<Map<String, dynamic>> login(
    String username,
    String password,
    ) async {

  print('CALLING LOGIN API');

  final response = await http.post(

    Uri.parse('$baseUrl/login'),

    headers: {
      'Content-Type': 'application/json',
    },

    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );

  print('STATUS CODE: ${response.statusCode}');
  print('RESPONSE BODY: ${response.body}');

  if (response.statusCode == 200) {

    return jsonDecode(response.body);

  } else {

    throw Exception(
      'API FAILED WITH STATUS ${response.statusCode}',
    );
  }
}
  static Future<List<dynamic>> getEmployees() async {

    final response = await http.get(
      Uri.parse('$baseUrl/employees'),
    );

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getStores() async {

    final response = await http.get(
      Uri.parse('$baseUrl/stores'),
    );

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getSalary() async {

    final response = await http.get(
      Uri.parse('$baseUrl/salary'),
    );

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getHolidays() async {

    final response = await http.get(
      Uri.parse('$baseUrl/holidays'),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> bookLeave() async {

    final response = await http.post(
      Uri.parse('$baseUrl/leave-booking'),
    );

    return jsonDecode(response.body);
  }
}