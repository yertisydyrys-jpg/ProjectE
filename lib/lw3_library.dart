// Класс Book
class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false, 
  });
}

class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
    print('Книга добавлена: ${book.title}');
  }

  List<Book> getAvailableBooks() {
    return _books.where((book) => !book.isBorrowed).toList();
  }

  double getTotalValue() {
    return _books.fold(0.0, (sum, book) => sum + book.price);
  }
}

void main() {
  Library library = Library();

  library.addBook(Book(title: '1984', author: 'Джордж Оруэлл', price: 15.99));
  library.addBook(Book(title: 'Мастер и Маргарита', author: 'Михаил Булгаков', price: 12.50, isBorrowed: true));
  library.addBook(Book(title: 'Чистый код', author: 'Роберт Мартин', price: 45.00));
  library.addBook(Book(title: 'Гарри Поттер', author: 'Дж.К. Роулинг', price: 20.00));

  print('\n--- Доступные книги ---');
  List<Book> available = library.getAvailableBooks();
  for (var book in available) {
    print('- ${book.title} (${book.author})');
  }

  print('\n--- Общая стоимость библиотеки ---');
  print('\$${library.getTotalValue().toStringAsFixed(2)}');
}