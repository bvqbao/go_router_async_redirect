import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'auth_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _authManager = AuthManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _authManager,
        ),
      ],
      child: MaterialApp.router(
        title: 'My Shop',
        routerConfig: _router,
      ),
    );
  }

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (ctx, state) => const LoginScreen(),
      ),
    ],
    redirect: (ctx, state) async {
      final loggingIn = state.location == '/login';

      if (_authManager.isAuth && loggingIn) return '/';

      if (!_authManager.isAuth && !loggingIn) {
        await _authManager.tryAutoLogIn();
        return '/login';
      }

      return null;
    },
    refreshListenable: _authManager,
  );
}
