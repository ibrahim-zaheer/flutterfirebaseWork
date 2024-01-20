import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work/firebase_options.dart';

//Steps to integrate firebase with flutter
// the code return below in main use this to ensure you can access collections in fire base and access data
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AddingDataToFireBase());
}

// use this code when want to add data in flutter
class AddingDataToFireBase extends StatelessWidget {
  // Function to add data to Firestore
  Future<void> addDataToFirestore() async {
    // Reference to the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Data to be added
    Map<String, dynamic> userData = {
      'name': 'Ibrahim Zaheer',
      'email': 'IbrahimZaheer@example.com',
      'age': 25,
    };

    // Add data to the collection
    await users.add(userData);
    print('Data added successfully!');
  }

// use this to read all the data in the collections
  Future<void> readDataFromFirestore() async {
    // Reference to the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Get all documents in the collection
      QuerySnapshot querySnapshot = await users.get();

      // Iterate through the documents and print data
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print('Document ID: ${documentSnapshot.id}');
        print('Name: ${data['name']}');
        print('Email: ${data['email']}');
        print('Age: ${data['age']}');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

// reading single data
  Future<void> readSingleDataFromFirestore(String documentId) async {
    // Reference to the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Get the document with the specified document ID
      DocumentSnapshot documentSnapshot = await users.doc(documentId).get();

      if (documentSnapshot.exists) {
        // Document exists, print its data
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print('Document ID: ${documentSnapshot.id}');
        print('Name: ${data['name']}');
        print('Email: ${data['email']}');
        print('Age: ${data['age']}');
      } else {
        print('Document does not exist with ID: $documentId');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  //Update Single Data
  Future<void> updateSingleDataInFirestore(
      String documentId, Map<String, dynamic> updatedData) async {
    // Reference to the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Get the document reference for the specified document ID
      DocumentReference documentReference = users.doc(documentId);

      // Update the document with the provided data
      await documentReference.update(updatedData);

      print('Document updated successfully!');
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  //Update Single Data
  Future<void> deleteSingleDataInFirestore(String documentId) async {
    // Reference to the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Get the document reference for the specified document ID
      DocumentReference documentReference = users.doc(documentId);

      // Update the document with the provided data
      await documentReference.delete();

      print('Document deleted successfully!');
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize Firestore
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello World"),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await addDataToFirestore();
              },
              child: Text('Add Data to Firestore'),
            ),
            ElevatedButton(
              onPressed: () async {
                await readDataFromFirestore();
              },
              child: Text('Read Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await readSingleDataFromFirestore("j2Xd82SzPTaZc3erAyZc");
              },
              child: Text('Read Single Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Specify the document ID and the updated data
                String documentId = "UrsCV1LZInIIDmztB86c";
                Map<String, dynamic> updatedData = {
                  'name': 'Fahad Zaheer',
                  'age': 30,
                  // Add other fields and values to update
                };

                await updateSingleDataInFirestore(documentId, updatedData);
              },
              child: Text('Update Single Data in Firestore'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Specify the document ID to delete
                String documentId = 'UrsCV1LZInIIDmztB86c';

                await deleteSingleDataInFirestore(documentId);
              },
              child: Text('Delete Single Data in Firestore'),
            )
          ],
        ),
      ),
    );
  }
}
