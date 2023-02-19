import 'dart:convert';

import 'package:http/http.dart';
import 'package:vid01dropdownsearch/product.dart';

class RemoteService {
  var client = Client();

  Future<List<Product>> fetchProduct() async {
    var response = client.get(Uri.parse('https://dummyjson.com/products'));

    var responseHttp = await response;

    var responseProductObj = jsonDecode(responseHttp.body);

    return productFromJson(jsonEncode(responseProductObj['products']));
  }
}
