import 'package:firebase_database/firebase_database.dart';
import 'package:media_classifier/category_container.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void saveCategory(Category category) {
  databaseReference..push().set({'test': 'test'});
}
