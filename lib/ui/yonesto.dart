import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/apps/yonesto/providers/providers.dart';
import 'package:unicapp/ui/common/atoms/custom_debug_banner.dart';
import 'package:unicapp/apps/yonesto/pages/cart.dart';
import 'package:unicapp/apps/yonesto/pages/yonesto_shop.dart';
import 'package:unicapp/ui/common/pages/error.dart';
import 'package:unicapp/apps/uniaccounts/pages/sigin.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        ScaleTransition(scale: animation, child: child),
  );
}

CustomTransitionPage buildPageWithSlideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffset = Offset(1.0, 0.0); // Comienza desde la derecha
      const endOffset = Offset.zero; // Termina en la posición inicial
      var tween = Tween<Offset>(begin: beginOffset, end: endOffset);

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class Yonesto extends ConsumerStatefulWidget {
  const Yonesto({
    super.key,
  });

  @override
  ConsumerState<Yonesto> createState() => _YonestoState();
}

class _YonestoState extends ConsumerState<Yonesto> {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) =>
            const CustomDebugBanner(child: SingInPage()),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) =>
            const CustomDebugBanner(child: YonestoShopPage()),
        pageBuilder: (context, state) => buildPageWithSlideTransition<void>(
          context: context,
          state: state,
          child: const CustomDebugBanner(child: YonestoShopPage()),
        ),
      ),
      GoRoute(
        path: "/cart",
        builder: (context, state) => const CustomDebugBanner(child: CartPage()),
        pageBuilder: (context, state) => buildPageWithSlideTransition<void>(
          context: context,
          state: state,
          child: const CustomDebugBanner(child: CartPage()),
        ),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: isDarkMode ? AppTheme.uniDarkTheme : AppTheme.uniLightTheme,
      darkTheme: AppTheme.uniDarkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
