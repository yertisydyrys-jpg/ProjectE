abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({required this.id, required this.title, required this.price});

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading: $title...');
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() {
    return 'Audiobook: "$title" (Narrator: $narrator, ${durationHours}h) - \$${price.toStringAsFixed(2)}';
  }
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() {
    return 'EBook: "$title" (Author: $author, ${fileSizeMB}MB) - \$${price.toStringAsFixed(2)}';
  }
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
    print('Добавлено в корзину: ${item.title}');
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(0.0, (sum, item) => sum + item.price);
    return subtotal * (1 + taxRate);
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }

  void printReceipt() {
    print('\n=== ЧЕК ПОКУПКИ ===');
    for (var item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
      print('---');
    }
    print('ИТОГО (вкл. налог 12%): \$${calculateTotalWithTax().toStringAsFixed(2)}');
    print('===================\n');
  }
}

void main() {
  var cart = ShoppingCart();

  var book1 = EBook(id: 'e1', title: 'Dart for Beginners', price: 9.99, fileSizeMB: 2.5, author: 'John Doe');
  var book2 = Audiobook(id: 'a1', title: 'Flutter Mastery', price: 14.50, durationHours: 12.0, narrator: 'Jane Smith');
  var book3 = EBook(id: 'e2', title: 'Advanced OOP', price: 29.99, fileSizeMB: 5.0, author: 'Alice Brown');

  cart.addItem(book1);
  cart.addItem(book2);
  cart.addItem(book3);

  cart.printReceipt();

  print('--- Фильтр товаров (дешевле \$15) ---');
  var cheapItems = cart.filterByMaxPrice(15.0);
  for (var item in cheapItems) {
    print('- ${item.title} (\$${item.price})');
  }
}