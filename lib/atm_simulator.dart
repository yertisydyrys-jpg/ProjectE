void main() {
  String userName = 'Ivan Ivanov';
  double accountBalance = 1000.0;

  print('--- 1. Проверка баланса ---');
  checkBalance(name: userName, balance: accountBalance);

  print('\n--- 2. Пополнение средств ---');
  accountBalance = deposit(currentBalance: accountBalance);
  accountBalance = deposit(currentBalance: accountBalance, amount: 500.50);

  print('\n--- 3. Снятие средств ---');
  accountBalance = withdraw(name: userName, currentBalance: accountBalance, amount: 200.0, pinCode: 9999);
  
  accountBalance = withdraw(name: userName, currentBalance: accountBalance, amount: 100.0);
  
  accountBalance = withdraw(name: userName, currentBalance: accountBalance, amount: 5000.0, pinCode: 1234);
  
  accountBalance = withdraw(name: userName, currentBalance: accountBalance, amount: 350.0, pinCode: 1234);

  print('\n--- Итоговый баланс ---');
  checkBalance(name: userName, balance: accountBalance);
}

void checkBalance({required String name, required double balance}) => 
    print('Клиент: $name | Доступный баланс: \$${balance.toStringAsFixed(2)}');

double deposit({required double currentBalance, double? amount}) {
  double safeAmount = amount ?? 0.0;
  
  double newBalance = currentBalance + safeAmount;
  print('Чек: Внесено \$${safeAmount.toStringAsFixed(2)}. Новый баланс: \$${newBalance.toStringAsFixed(2)}');
  
  return newBalance;
}

double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  int safePin = pinCode ?? 0000;
  
  if (safePin != 1234) {
    print('Ошибка: Неверный PIN-код. Транзакция отклонена.');
    return currentBalance; // Возвращаем баланс без изменений
  }

  double safeAmount = amount ?? 0.0;

  if (safeAmount > currentBalance) {
    print('Ошибка: Недостаточно средств на счете. Запрошено: \$${safeAmount.toStringAsFixed(2)}. Транзакция отклонена.');
    return currentBalance;
  }

  double newBalance = currentBalance - safeAmount;
  print('Успешно: Выдано \$${safeAmount.toStringAsFixed(2)} для $name. Остаток: \$${newBalance.toStringAsFixed(2)}');
  
  return newBalance;
}