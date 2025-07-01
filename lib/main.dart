import 'package:flutter/material.dart';

var todoArray = <String>[];
int? selectedIndex = -1;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final title = "Flutter サンプル";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title}) : super();
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDoリスト')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "ToDoを入力してください",
                ),
                controller: _controller,
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                ),
              ),
            ),
            Expanded(
              child: todoArray.isEmpty
                ? Center(
                    child: Text(
                      "ToDoリストは空です",
                      style: TextStyle(
                        fontSize: 48.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                      ),
                    ),
                  )
                : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  itemCount: todoArray.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            todoArray[index],
                            style: TextStyle(
                              fontSize: 32.0,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                          trailing:selectedIndex == index
                            ? IconButton(
                              icon: const Icon(Icons.delete),
                              iconSize:32.0,
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  todoArray.removeAt(index);
                                  selectedIndex = null;
                                });
                              },
                            ) : null,
                          onTap: () {
                            setState(() {
                              selectedIndex =
                                  selectedIndex == index ? null : index;
                            });
                          },
                        ),                        
                      ],
                    );
                  },
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPressed,
        child: Icon(Icons.add),
      ),
    );
  }

  // 追加ボタンを押す
  void addPressed() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        todoArray.add(text);
        _controller.clear();
      });
    }
  }
}
