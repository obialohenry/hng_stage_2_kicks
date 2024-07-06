import 'package:hng_stage_2_kicks/repository/service/api/api_service.dart';


class KicksProductsBackEnd extends ApiService {
  Future<dynamic> fetchKicksProducts() async {
    return getMth(
      fetchProductsUri,
      headers: apiHeader,
    );
  }
}
