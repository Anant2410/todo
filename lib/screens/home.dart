import 'package:flutter/material.dart';
import '../constraints/colors.dart';
import '../model/todo.dart';
import '../widget/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _found = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _found = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          ' ToDo Tasks',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todo1 in _found.reversed)
                        ToDoItem(
                          todo: todo1,
                          onToDoChanged: _handletoDoChange,
                          oneDeleteitem: _delete,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add new Task', border: InputBorder.none)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () async {
                    _add(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: toBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _handletoDoChange(ToDo todo) async {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _delete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _add(String Todo) async {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todotext: Todo));
    });
    _todoController.clear();
  }

  void _search(String word) {
    List<ToDo> results = [];
    if (word.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todotext!.toLowerCase().contains(word.toLowerCase()))
          .toList();
    }
    setState(() {
      _found = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _search(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: toBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search ',
          hintStyle: TextStyle(color: toGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: toBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: toBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/avatar.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}

