class ToDo {
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    this.id,
    this.todotext,
    this.isDone = false,
  });
  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todotext: 'add new task',)
    ];
  }
}
