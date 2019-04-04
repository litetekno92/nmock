import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'category_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'categoryDetail.dart';



class CategoryList extends StatefulWidget {
  
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data/categories.json');
}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryListState();
  }
}

class _CategoryListState extends State<CategoryList> {
  
  Future<String> future;
  String result;
  List<Category> categories =[];

  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    future =  rootBundle.loadString('assets/data/categories.json');
    result = await future;
    categories =   categoryFromJson(result);
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text("There was an error: ${snapshot.error}");
            var categories = snapshot.data;
            return ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                Category category = categories[index];

                return Slidable(
                  delegate: SlidableDrawerDelegate(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Archive',
                      color: Colors.blue,
                      icon: Icons.archive,
                      onTap: () {},
                    ),
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () {},
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'More',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () {},
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        setState(() {
                          categories.removeAt(index);
                        });
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(category.id.toString()),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      child: Text('PJ'),
                    ),
                    subtitle: Text(
                      category.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetail(category.id.toString(), category.name),
                        ),
                      );
                    },
                  ),
                  key: ObjectKey(category),
                );
              },
            );
        }
      },
    );
  }
}