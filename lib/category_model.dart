// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Category>.from(jsonData.map((x) => Category.fromJson(x)));
}

String categoryToJson(List<Category> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class Category {
    int id;
    String name;

    Category({
        this.id,
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}


// import 'dart:convert';

// class Category {
//   final int id;
//   final String name;
  
//   Category({this.id,this.name});

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return new Category(
//       id: json['id'] as int,
//       name: json['name'] as String
//           );
//   }
// }

// class ListCategory {
//   List<Category> categories = List<Category>();
//   ListCategory({this.categories});
//   factory ListCategory.fromJson(List <Map<String, dynamic>> json) {
//       List<Category> categories = List<Category>();
//       var mappedCategories = json.map((i)=>new Category.fromJson(i));
//       return mappedCategories.toList();
//   }
// }