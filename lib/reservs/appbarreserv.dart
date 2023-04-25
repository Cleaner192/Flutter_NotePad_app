// Копия кода до введения в appbar поиска

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/addNote.dart';
import 'package:flutter_application_1/editNote.dart';

import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sample1(),
    );
  }
}

class Sample1 extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  accountName: Text('Біләл Азамат'),
                  accountEmail: Text("home@dartflutter.ru"),
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
              ),
              new ListTile(
                  title: new Text("Github"),
                  leading: Icon(Icons.question_mark_rounded),
                  onTap: () {}),
              new ListTile(
                  title: new Text("Настройки"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => AddNote()));
                  })
            ],
          ),
        ),
        appBar: MyCustomAppBar(
          height: 70,
          defaultAppBar: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNote()));
          },
        ),
        body: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditNote(
                              docToEdit: snapshot.data?.docs[index]
                                  as DocumentSnapshot<Object?>,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 150,
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Text((snapshot.data?.docs[index].data()
                                as Map<String, dynamic>)['title']),
                            Text((snapshot.data?.docs[index].data()
                                as Map<String, dynamic>)['content']),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   List<String> searchTerms = ['Apple', 'Banana', 'Pear', 'Oranges'];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;
  String name = "";

  MyCustomAppBar({
    Key? key,
    required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: defaultAppBar
                ? AppBar(
                    title: AppBar(
                      title: Card(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Искать в заметках",
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              filled: true),
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                : _customAppBar(context),
          ),
        ),
      ],
    );
  }

  Widget _customAppBar(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 146, 14, 4),
      padding: EdgeInsets.all(5),
      child: Row(children: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.verified_user),
          onPressed: () => null,
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  void setState(Null Function() param0) {}
}

// floatingActionButton: FloatingActionButton(
//   child: Icon(Icons.add),
//   onPressed: () async {
//     final db = FirebaseFirestore.instance;
//     // Create a new user with a first and last name
//     final user = <String, dynamic>{
//       "first": "Ada",
//       "last": "Lovelace",
//       "born": 1815
//     };

//     // Add a new document with a generated ID
//     db.collection("users").add(user).then((DocumentReference doc) =>
//         print('DocumentSnapshot added with ID: ${doc.id}'));

// Запись пользователя в базу данных
// try {
//   final credential =
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: 'testuser@test.com',
//     password: '12331231232',
//   );
//   print('User created!');
//   print(credential.user!.uid);
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//   }
// } catch (e) {
//   print(e);
// }
// },
// ),

// body: Image.asset("assets/images/logo.png",
//     width: MediaQuery.of(context).size.width,
//     height: 250.0,
//     alignment: Alignment.center),

// body: Center(
//   child: FlutterLogo(
//     size: MediaQuery.of(context).size.width / ,
//   ),
// ),

