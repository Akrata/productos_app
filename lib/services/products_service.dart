import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _BaseUrl = "flutter-varios-82a38-default-rtdb.firebaseio.com";
  final List<Product> products = [];
  bool is_loading = true;

  ProductsService() {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    is_loading = true;
    notifyListeners();
    final url = Uri.https(_BaseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    is_loading = false;
    notifyListeners();
    return products;
  }
}
