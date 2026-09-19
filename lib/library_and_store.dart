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
  }

  Iterable<Book> getAvailableBooks() {
    return _books.where((book) => !book.isBorrowed);
  }

  double getTotalValue() {
    return _books.fold(0.0, (sum, book) => sum + book.price);
  }
}

abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
  });

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading $title...');
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required String id,
    required String title,
    required double price,
    required this.durationHours,
    required this.narrator,
  }) : super(id: id, title: title, price: price);

  @override
  String getDetails() {
    return 'Audiobook: $title, Narrator: $narrator, Duration: ${durationHours}h, Price: \$$price';
  }
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required String id,
    required String title,
    required double price,
    required this.fileSizeMB,
    required this.author,
  }) : super(id: id, title: title, price: price);

  @override
  String getDetails() {
    return 'EBook: $title, Author: $author, Size: ${fileSizeMB}MB, Price: \$$price';
  }
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(0.0, (sum, item) => sum + item.price);
    return subtotal + (subtotal * taxRate);
  }

  Iterable<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice);
  }

  void printReceipt() {
    for (var item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
  }
}

void main() {
  Library library = Library();
  
  library.addBook(Book(title: '1984', author: 'George Orwell', price: 15.99));
  library.addBook(Book(title: 'Brave New World', author: 'Aldous Huxley', price: 14.50));
  library.addBook(Book(title: 'Fahrenheit 451', author: 'Ray Bradbury', price: 12.99, isBorrowed: true));
  library.addBook(Book(title: 'The Hobbit', author: 'J.R.R. Tolkien', price: 25.00));

  print('--- Library System ---');
  Iterable<Book> availableBooks = library.getAvailableBooks();
  for (var book in availableBooks) {
    print('${book.title} is available');
  }
  print('Total Library Value: \$${library.getTotalValue()}');

  print('\n--- Digital Store System ---');
  ShoppingCart cart = ShoppingCart();
  
  cart.addItem(Audiobook(
    id: 'A001',
    title: 'Dart for Beginners',
    price: 19.99,
    durationHours: 12.5,
    narrator: 'John Doe',
  ));
  
  cart.addItem(EBook(
    id: 'E001',
    title: 'Flutter Masterclass',
    price: 29.99,
    fileSizeMB: 5.2,
    author: 'Jane Smith',
  ));

  cart.printReceipt();
  print('Total with Tax (12%): \$${cart.calculateTotalWithTax().toStringAsFixed(2)}');

  print('\nItems under \$25:');
  Iterable<MediaItem> cheapItems = cart.filterByMaxPrice(25.00);
  for (var item in cheapItems) {
    print(item.title);
  }
}