import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_bank_app/core/common/app/providers/tab_navigator.dart';
import 'package:retro_bank_app/core/common/views/persistent_view.dart';
import 'package:retro_bank_app/src/dashboard/presentation/views/edit_profile_view.dart';
import 'package:retro_bank_app/src/dashboard/presentation/views/home_view.dart';
import 'package:retro_bank_app/src/dashboard/presentation/views/send_money_view.dart';
import 'package:retro_bank_app/src/dashboard/presentation/views/transaction_view.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const HomeView(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const SendMoneyView(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const TransActionsView(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const EditProfileView(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(_currentIndex);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
