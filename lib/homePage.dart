import 'package:flutter/material.dart';
import 'package:media_classifier/authentication_service.dart';
import 'package:media_classifier/category_container.dart';
import 'package:media_classifier/database.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationService _authenticationService;
  final _formKey = GlobalKey<FormState>();
  String _field;
  List<Category> _categories = <Category>[
    Category(title: "Movies", icon: Icons.movie),
    Category(title: "Theater Plays", icon: Icons.theater_comedy),
    Category(title: "Games", icon: Icons.games),
    Category(title: "Songs", icon: Icons.music_note),
    Category(title: "TV Series", icon: Icons.tv),
    Category(title: "Others", icon: Icons.devices_other),
  ];

  @override
  void initState() {
    super.initState();
    _authenticationService = new AuthenticationService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        title: Text("Mediassifier"),
        actions: [
          IconButton(
              icon: Icon(Icons.settings_applications_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.red.shade600,
                          title: Text("Settings"),
                          actions: [
                            IconButton(
                              icon: Icon(Icons.logout),
                              onPressed: () async {
                                await _authenticationService.signOut();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        body: ListView.builder(
                          itemBuilder: (context, i) {
                            return ListTile(
                                //title: Text(),
                                );
                          },
                        ),
                      );
                    },
                  ),
                );
              })
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        primary: false,
        padding: const EdgeInsets.all(20),
        children: List.generate(_categories.length, (index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onLongPress: () {
              print("test");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    print("test2");
                    return AlertDialog(
                      title: Text('Delete category?'),
                      content: Text(
                          'This will delete the current category and all its components'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _categories.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Delete category'),
                        ),
                      ],
                    );
                  });
            },
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return Scaffold(
                    floatingActionButtonAnimator:
                        FloatingActionButtonAnimator.scaling,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Colors.red[600],
                      child: Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the new item';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _field = value;
                                      },
                                    ),
                                    ElevatedButton(
                                        child: const Text('Insert'),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(_field +
                                                        ' item added')));
                                            print(_field);
                                            setState(() {
                                              _categories[index]
                                                  .items
                                                  .add(_field);
                                            });
                                          }

                                          Navigator.pop(context);
                                        })
                                  ],
                                ),
                              ));
                            });
                      },
                    ),
                    appBar: AppBar(
                      backgroundColor: Colors.red.shade600,
                      title: Text(_categories[index].title),
                    ),
                    body: ListView.builder(
                        itemCount: _categories[index].items.length,
                        itemBuilder: (context, index2) {
                          final item = _categories[index].items[index2];
                          print(_categories[index].items);
                          return ListTile(
                            title: Text(_categories[index].items[index2]),
                          );
                        }));
              }));
            },
            child: Center(
              child: SelectCard(
                category: _categories[index],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the category name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _field = value;
                          },
                        ),
                        ElevatedButton(
                            child: const Text('Insert'),
                            onPressed: () {
                              saveCategory(Category(
                                  title: _field, icon: Icons.devices_other));
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(_field + ' category added')));
                                print(_field);
                                setState(
                                  () {
                                    _categories.add(Category(
                                        title: _field,
                                        icon: Icons.devices_other));
                                  },
                                );
                              }

                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ));
                });
          },
          child: Icon(
            Icons.add,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
