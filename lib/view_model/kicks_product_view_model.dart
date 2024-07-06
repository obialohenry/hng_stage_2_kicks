import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_stage_2_kicks/repository/backend/kicks_products_back_end.dart';
import 'package:hng_stage_2_kicks/view/screens/products_screen.dart';


final kicksProductViewModel = ChangeNotifierProvider((ref) => KicksProductsViewModel());

class KicksProductsViewModel extends ChangeNotifier {
  KicksProductsBackEnd kicksProductService = KicksProductsBackEnd();
  bool _gettingKicksProducts = false;
  bool get gettingKicksProducts => _gettingKicksProducts;
  List _kicksProducts = [];
  List get kicksProducts => _kicksProducts;

  Future<void> getKicksProducts(
    BuildContext context,
  ) async {
    try {
      _gettingKicksProducts = true;
      notifyListeners();
      await kicksProductService.fetchKicksProducts().then((value) async {
        if (value != null) {
          final decodedResponse = jsonDecode(value.toString());
          _kicksProducts = decodedResponse["items"];
          notifyListeners();
          Future.delayed(
              const Duration(milliseconds: 300),
              await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProductsScreen())));
      
          _gettingKicksProducts = false;
          notifyListeners();
        } else {
          _gettingKicksProducts = false;
          notifyListeners();
          const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text("API BODY IS EMPTY"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }).whenComplete(() {
        _gettingKicksProducts = false;
        notifyListeners();
      });
    } catch (e, s) {
      debugPrint("Check error logs");
      debugPrint("$s");
      debugPrint("$e");
    }
  }
}
