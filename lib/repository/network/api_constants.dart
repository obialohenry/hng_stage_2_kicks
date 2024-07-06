import 'dart:io';

const String appId = '76K1XU6UKT888VX';
const String organizationId = "1f0c74da7ce14463b8a5b3e265db58fb";
const String apiKey = "d3065c1e0edd4fb6a5a6556e42fb1ea920240705111826909731";

// organization_id=$organizationId&reverse_sort=false&page=1&size=10&Appid=$appId&Apikey=$apiKey
class ApiConstants {
  final String scheme = 'https';
  final String host = 'api.timbu.cloud';
  final String path = 'products';
  Uri get fetchProductsUri => Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: {
          "organization_id": organizationId,
          "reverse_sort": "false",
          "page": "1",
          "size": "10",
          "Appid": appId,
          "Apikey": apiKey,
        },
      );

// //*! can be modified
  Map<String, String> apiHeader = {
    // HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptEncodingHeader: "gzip",
    HttpHeaders.acceptHeader: '*/*',
    HttpHeaders.connectionHeader: "Keep-alive"
    
  };

  // Map<String, String> apiHeaderWithToken = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.acceptHeader: '*/*',
  //   HttpHeaders.authorizationHeader: 'Bearer ${DummyData.accessToken}',
  // };
}
