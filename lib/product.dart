import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  int id;
  String title;
  String thumbnail;

  Product({required this.id, required this.title, required this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'], title: json['title'], thumbnail: json['thumbnail']);
}
