import 'package:flutter/material.dart';

void main() {
  runApp(const NotePad());
}

class NotePad extends StatelessWidget {
  const NotePad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Все аннотации'),
          backgroundColor: Colors.green[600],

          // leading: IconButton(
          //   icon: Icon(Icons.account_circle),
          //   onPressed: () {},
          // ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // TextField(
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: "Искать в заметках",
              //       prefixIcon: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.menu,
              //             size: 30,
              //           )),
              //       suffixIcon: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.account_circle,
              //             size: 30,
              //           )),
              //       fillColor: Color.fromARGB(31, 8, 212, 185),
              //       filled: true),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(
              //           Icons.menu,
              //           size: 30,
              //         )),
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(
              //           Icons.account_circle_outlined,
              //           size: 30,
              //         )),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // const Text(
              //   'NotePad',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 22,
              //   ),
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
