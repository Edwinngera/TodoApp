import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item=items[index] as Map;
            return ListTile(
              leading: Text('${index+1}'),
              title: Text(item['title'].toString()),
              subtitle: Text(item['description']),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Add Todo')),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      //
    }
  }
}
