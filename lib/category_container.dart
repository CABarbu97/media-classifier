import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Category {
  Category({this.title, this.icon});
  final String title;
  final IconData icon;
  List items = [];

  Map<String, dynamic> toJson() {
    return {'title': this.title, 'items': this.items};
  }
}

class SelectCard extends StatefulWidget {
  SelectCard({this.category}) : super();
  Category category;

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  Map<String, dynamic> toJson() {
    return {'title': widget.category.title, 'items': widget.category.items};
  }

  @override
  Widget build(BuildContext context) {
    List items = widget.category.items;
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return Card(
        color: Colors.red[500],
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(widget.category.icon,
                        size: 50.0, color: textStyle.color)),
                Text(widget.category.title, style: textStyle),
              ]),
        ));
  }
}
