import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
  final String id;
  final String name;

CategoryDetail(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(this.id)),
        body: Container(padding: EdgeInsets.all(16), child: Text(this.name)));
  }
}
