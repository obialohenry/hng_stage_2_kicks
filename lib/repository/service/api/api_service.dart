import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hng_stage_2_kicks/repository/exceptions/custom_exceptions.dart';
import 'package:hng_stage_2_kicks/repository/network/api_constants.dart';
import 'package:dio/dio.dart';

class ApiService extends ApiConstants {
  final dio = Dio();
  Future<dynamic> getMth(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    debugPrint('Making request to $uri');

    final options = Options(headers: headers, responseType: ResponseType.plain);
    try {
      final response = await dio
          .get(
            uri.toString(),
            options: options,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      debugPrint(response.requestOptions.path);
      debugPrint(response.data);
      return _dioResponse(
        response,
      );
    } on SocketException catch (e) {
      debugPrint("$e");
      throw InternetException(e.toString());
    } on DioException catch (error) {
      debugPrint("${error.response!.statusCode}");
      debugPrint(error.response!.data.toString() + error.requestOptions.path.toString());
    } on FormatException catch (error) {
      debugPrint('FormatException: $error');
      throw HttpException('Bad response format: $error');
    } on TimeoutException {
      throw RequestTimeoutException('Request Timed out');
    } catch (error) {
      throw HttpException('Something went wrong, $error');
    }
  }

  dynamic _dioResponse(
    Response response,
  ) async {
    dynamic responseJson;
   
    switch (response.statusCode) {
      case 200:

        ///* This is a catch block for when the server returns a 200 ok status.
        debugPrint("${response.statusCode}");
        debugPrint(response.data);
        // log(response.data);

        responseJson = json.decode(response.data.toString());
        // status = responseJson['page'];
        // message = responseJson[
        //     'size']; //TODO: work on this message and status, make sure it's exactly the message from the api.
        // if (message != null) {
        //   debugPrint(
        //     '$status\n$message',
        //   );
        // }

        return response.data;
      case 201:

        ///* This is a catch block for when the server returns a 201 created status.
        debugPrint("${response.statusCode}");
        debugPrint(response.data);
        return response.data;
      case 400:

        ///* This is a catch block for when the server returns a 400 bad request status.
        debugPrint("${response.statusCode}");
        debugPrint(response.data);
        throw BadRequestException(response.data.toString());
      case 401:

        ///* This is a catch block for when the server returns a 401 unauthorised error.
        debugPrint("${response.statusCode}");
        debugPrint(response.data);

        throw UnauthorisedException(response.data.toString());
      case 403:

        ///* This is a catch block for when the server returns a 403 access unauthorised error.
        debugPrint("${response.statusCode}");
        debugPrint(response.data);

        throw ForbiddenRequestException(response.data.toString());

      case 500:

        ///* This is a catch block for when the server returns a 500 error.

        debugPrint(response.data);
        throw Exception(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}',
        );
      default:
        debugPrint(response.data);
        throw Exception(
          'Something went wrong: ${response.statusCode}',
        );
    }
  }
}
