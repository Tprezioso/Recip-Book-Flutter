import 'package:dio/dio.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio();

  factory HTTPService() {
    return _singleton;
  }
  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final options = BaseOptions(headers: headers);
  }
}
