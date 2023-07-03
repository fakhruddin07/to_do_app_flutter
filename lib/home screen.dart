import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
        actions: [
          IconButton(
              onPressed: (){
                todos.clear();
                if(mounted){
                  setState(() {});
                }
              },
              icon: const Icon(Icons.playlist_remove)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTodo();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: todos.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemBuilder: (context, index) {
          return ListTile(contentPadding: const EdgeInsets.all(5),
            onLongPress: (){
              todos[index].isDone = !todos[index].isDone;
              if(mounted){
                setState(() {});
              }
            },
            leading: todos[index].isDone
                ? const Icon(Icons.done)
                : const Icon(Icons.close),
            title: Text(todos[index].title),
            subtitle: Text(todos[index].description),
            trailing: FittedBox(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      todos.removeAt(index);
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      todos.removeAt(index);
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  addNewTodo() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text("Add New Todo", style: Theme.of(context).textTheme.displayLarge,),

              const SizedBox(height: 20),

              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    )
                  )
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration(
                  // errorText: "Description can't be empty",
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )
                    ),
                ),
              ),

              const SizedBox(height: 20,),

              Flexible(
                fit: FlexFit.loose,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    if (_titleController.text.trim().isNotEmpty &&
                        _descriptionController.text.trim().isNotEmpty) {
                      todos.add(Todo(_titleController.text.trim(),
                          _descriptionController.text.trim(), false));
                      if (mounted) {
                        setState(() {});
                      }
                      _titleController.clear();
                      _descriptionController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class Todo {
  String title;
  String description;
  bool isDone;
  Todo(this.title, this.description, this.isDone);
}
