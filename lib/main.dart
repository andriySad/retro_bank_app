// import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_bank_app/core/common/app/providers/cards_provider.dart';
import 'package:retro_bank_app/core/common/app/providers/theme_mode_provider.dart';
import 'package:retro_bank_app/core/common/app/providers/transactions_provider.dart';
import 'package:retro_bank_app/core/common/app/providers/user_provider.dart';
import 'package:retro_bank_app/core/extensions/context_extension.dart';
import 'package:retro_bank_app/core/services/bloc_observer.dart';
import 'package:retro_bank_app/core/services/injection_container/injection_container.dart';
import 'package:retro_bank_app/core/services/router/router.dart';
import 'package:retro_bank_app/core/theme/theme.dart';
import 'package:retro_bank_app/firebase_options.dart';
import 'package:retro_bank_app/src/dashboard/providers/dashboard_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  Bloc.observer = const AppBlocObserver();
  //init service locator
  await init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeModeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardController(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.themeProvider.initThemeMode(ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.themeProvider.themeMode,
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
