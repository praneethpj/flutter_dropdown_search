import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vid01dropdownsearch/product.dart';
import 'package:vid01dropdownsearch/remote_service.dart';

class SearchableDropDown extends StatefulWidget {
  const SearchableDropDown({super.key});

  @override
  State<SearchableDropDown> createState() => _SearchableDropDownState();
}

class _SearchableDropDownState extends State<SearchableDropDown> {
  RemoteService remoteService = RemoteService();

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  List<Product> itemList = [];

  Product? selectedObj;

  Future<List<Product>> getData() async {
    itemList = await remoteService.fetchProduct();
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return DropdownButtonFormField2<Product>(
                        isExpanded: true,

                        value: selectedObj == null ? selectedObj : null,
                        onChanged: (value) {
                          print(value!.title);
                          selectedValue = value.title;
                        },
                        items: snapshot.data?.map((product) {
                          return DropdownMenuItem<Product>(
                            child: Row(
                              children: [
                                Image.network(
                                  product.thumbnail,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${product.title}"),
                              ],
                            ),
                            value: product,
                            onTap: () {
                              selectedObj = product;
                            },
                          );
                        }).toList(),
                        searchController: textEditingController,
                        searchInnerWidget: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.value.title
                              .toString()
                              .contains(searchValue));
                        },
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
