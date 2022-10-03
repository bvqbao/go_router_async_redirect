import 'package:flutter/foundation.dart';

class AuthManager extends ChangeNotifier {
  final _isAuth = false;

  bool get isAuth {
    return _isAuth;
  }

  Future<bool> tryAutoLogIn() async {
    await Future.delayed(const Duration(microseconds: 500));

    notifyListeners();
    return false;
  }
}
