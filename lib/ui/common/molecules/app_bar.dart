import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../apps/yonesto/molecules/package.dart';

class UNICappAppBar extends StatefulWidget implements PreferredSizeWidget {
  const UNICappAppBar({
    super.key,
    required this.title,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  });

  final Widget title;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  State<UNICappAppBar> createState() => _UNICappAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight / 1.4);
}

class _UNICappAppBarState extends State<UNICappAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Stack(
        children: [
          Center(child: widget.title),
          Positioned(
            left: widget.left,
            top: widget.top,
            right: widget.right,
            bottom: widget.bottom,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
                //context.go('/home');
              },
            ),
          )
        ],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: size.width > 750 ? 200 : 0,
    );
  }
}

class MinimalistAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MinimalistAppBar({
    super.key,
    this.leading,
    required this.title,
  });

  final Widget? leading;
  final String title;

  @override
  State<MinimalistAppBar> createState() => _MinimalistAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MinimalistAppBarState extends State<MinimalistAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      leading: widget.leading,
      title: Stack(
        children: [
          Center(
            child: Text(
              widget.title,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w200,
                fontSize: 25,
              ),
            ),
          ),
          const Positioned(
            right: -5,
            top: -10,
            child: ThemeButton(),
          )
        ],
      ),
    );
  }
}
