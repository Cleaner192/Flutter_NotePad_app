import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/addNote.dart';
import 'package:flutter_application_1/editNote.dart';

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

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key? key,
    required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Color.fromARGB(255, 0, 86, 207),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: defaultAppBar
                ? AppBar(
                    title: Text('NotePad'),
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
}
