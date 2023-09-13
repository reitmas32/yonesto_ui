import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/ui/widgets/add_to_cart_button.dart';
import 'package:yonesto_ui/ui/widgets/remove_to_cart_button.dart';

class ShoppingCard extends StatelessWidget {
  ShoppingCard({
    super.key,
    required this.index,
    required this.product,
  });

  final int index;
  final Product product;
  final List<bool> starStates = [true, true, true, false, false];

  @override
  Widget build(BuildContext context) {
    final currentColor = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Card(
      color: currentColor.isDarkTheme()
          ? const Color.fromARGB(255, 35, 34, 34)
          : const Color.fromARGB(255, 199, 197, 197),
      elevation: 15.0,
      shadowColor: Colors.purple,
      child: Container(
        width: size.width > 750 ? 200 : 120,
        height: 200,
        padding: EdgeInsets.all(size.width > 750 ? 20 : 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Image.network(
                'https://www.generaldistributionlc.com/cdn/shop/products/Sabritas-Chetos-Flaming-150gr.png?v=1558976038',
                height: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  //fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  starStates[index] ? Icons.star : Icons.star_border,
                  color: Colors.purple,
                  size: 15,
                ),
              ),
            ),
            Text('${product.stock} Unidades'),
            Row(
              children: [
                Text('\$${product.salePrice}'),
                const Spacer(),
                RemoveToCartButton(
                  product: product,
                ),
                AddToCartButton(
                  product: product,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
