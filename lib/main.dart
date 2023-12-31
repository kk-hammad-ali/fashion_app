import 'dart:io';
import 'dart:ui';

import 'package:fashion_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WidgetPageViewHeader(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: WidgetDescription(),
          ),
          SafeArea(
            minimum: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Stack(
                      children: <Widget>[
                        const Icon(
                          Icons.shopping_basket,
                          color: Colors.white,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WidgetPageViewHeader extends StatelessWidget {
  final HeaderController controller = Get.put(HeaderController());

  WidgetPageViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final listImageHeader = [
      'assets/images/header_1.jpg',
      'assets/images/header_2.jpg',
      'assets/images/header_3.jpg',
      'assets/images/header_4.jpg',
    ];
    var mediaQuery = MediaQuery.of(context);
    var heightImage = mediaQuery.size.height / 1.5;
    return Obx(
      () => SizedBox(
        height: heightImage,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              itemBuilder: (context, index) {
                return Image.asset(
                  listImageHeader[controller.indexHeader.value],
                  fit: BoxFit.cover,
                );
              },
              itemCount: listImageHeader.length,
              onPageChanged: controller.onPageChanged,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: mediaQuery.size.height / 1.9,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < listImageHeader.length; i++)
                    if (i == controller.indexHeader.value)
                      circleBar(true)
                    else
                      circleBar(false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 16 : 12,
      width: isActive ? 16 : 12,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: isActive ? Border.all(color: Colors.white) : null,
      ),
      padding: EdgeInsets.all(isActive ? 4.0 : 0.0),
      child: Container(
        width: isActive ? 8 : 16,
        height: isActive ? 8 : 16,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
      ),
    );
  }
}

class WidgetDescription extends StatelessWidget {
  const WidgetDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height / 2.3,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48.0),
          topRight: Radius.circular(48.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 40.0, right: 24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  padding: EdgeInsets.only(
                      bottom: mediaQuery.size.height -
                          mediaQuery.size.height / 1.1 +
                          16.0),
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildWidgetProductName(context),
                        _buildWidgetProductPrice(context),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Divider(
                            height: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        WidgetChooseColor(),
                        const SizedBox(height: 16.0),
                        WidgetChooseSize(),
                        _buildWidgetProductInfo(context),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: WidgetAddToBag(),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetProductPrice(BuildContext context) {
    return Text(
      'Rp 159.000',
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .merge(const TextStyle(fontSize: 16.0)),
    );
  }

  Widget _buildWidgetProductName(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                'Y&F Samhita Plain Bodycon\nMini Dress',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Icon(Icons.share),
                SizedBox(height: 16.0),
                Icon(Icons.favorite_border),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWidgetProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'This is a beautiful women Mini Dress for your daily look, '
                  'it is elegance meets... ',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .merge(const TextStyle(fontSize: 16.0)),
            ),
            TextSpan(
                text: 'More',
                style: Theme.of(context).textTheme.bodySmall!.merge(
                      const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WidgetChooseColor extends StatelessWidget {
  WidgetChooseColor({super.key});

  final HeaderController controller = Get.put(HeaderController());

  final List<String> colorsName = [
    'Navy',
    'Milo',
    'Maroon',
    'Grey',
  ];

  final List<Color> colors = [
    const Color(0xFF221D33),
    const Color(0xFFD7BA97),
    const Color(0xFF9C606C),
    const Color(0xFFA8BCBD),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Color: ',
                  style: TextStyle(color: Colors.black87),
                ),
                TextSpan(
                  text: colorsName[controller.indexHeader.value],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 80,
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.onPageChanged(index);
                      },
                      child: Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: controller.indexHeader.value == index
                                ? 4.0
                                : 0.0,
                          ),
                          boxShadow: [
                            controller.indexHeader.value == index
                                ? const BoxShadow(
                                    color: Color(0xFF757575),
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                : const BoxShadow(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetChooseSize extends StatefulWidget {
  final List<String> listSize = [
    'XL',
    'S',
    'M',
    'L',
  ];

  WidgetChooseSize({super.key});

  @override
  _WidgetChooseSizeState createState() => _WidgetChooseSizeState();
}

class _WidgetChooseSizeState extends State<WidgetChooseSize> {
  late int _indexSelected;

  @override
  void initState() {
    _indexSelected = widget.listSize.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Size: ',
                style: TextStyle(color: Colors.black87),
              ),
              TextSpan(
                text: widget.listSize[_indexSelected],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 24.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: widget.listSize.length,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    Text(widget.listSize[index]),
                    Radio(
                      value: index,
                      groupValue: _indexSelected,
                      activeColor: const Color(0xFF32312D),
                      onChanged: (index) {
                        setState(() {
                          _indexSelected = int.parse(index.toString());
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class WidgetAddToBag extends StatelessWidget {
  const WidgetAddToBag({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: (mediaQuery.size.height - mediaQuery.size.height / 1.1),
      child: Material(
        type: MaterialType.canvas,
        color: const Color(0xFF32312D),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),
        child: InkWell(
          onTap: () {
            showBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return const WidgetMyCart();
              },
            );
          },
          child: const Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Add to bag +',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetMyCart extends StatefulWidget {
  const WidgetMyCart({super.key});

  @override
  _WidgetMyCartState createState() => _WidgetMyCartState();
}

class _WidgetMyCartState extends State<WidgetMyCart> {
  List<Cart> listMyCart = [];

  @override
  void initState() {
    listMyCart
      ..add(Cart(
          productName: 'Haicila Two Tone V-neck Blouse',
          price: 89000,
          size: 'M',
          quantity: 1,
          color: 'Black',
          image: 'assets/images/img_item_cart_1.jpeg'))
      ..add(Cart(
          productName: 'Y&F Samhita Plain Bodycon',
          price: 159000,
          size: 'L',
          quantity: 1,
          color: 'Maroon',
          image: 'assets/images/header_1.jpg'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Container(
        height: mediaQuery.height / 2.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48.0),
            topRight: Radius.circular(48.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            top: 40.0,
            right: 24.0,
            bottom: 20.0,
          ),
          child: Column(
            children: <Widget>[
              _buildWidgetHeaderMyCart(context),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: listMyCart.length,
                  itemBuilder: (context, index) {
                    Cart cart = listMyCart[index];
                    String rupiahPrice =
                        NumberFormat('#,##0', 'id_ID').format(cart.price);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            cart.image,
                            width: 48.0,
                            height: 48.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Wrap(
                              direction: Axis.vertical,
                              children: <Widget>[
                                Text(
                                  cart.productName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text(
                                  'Rp $rupiahPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .merge(const TextStyle(fontSize: 12.0)),
                                ),
                                Text(
                                  'Size: ${cart.size}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .merge(const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          WidgetControllerQuantity(cart.quantity),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 2.0,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total amount',
                      style: Theme.of(context).textTheme.bodySmall!.merge(
                            const TextStyle(color: Colors.grey),
                          )),
                  Text('Rp 248.000',
                      style: Theme.of(context).textTheme.bodySmall!.merge(
                            const TextStyle(fontWeight: FontWeight.w600),
                          )),
                ],
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: mediaQuery.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Check out',
                    style: TextStyle(color: Colors.white),
                  ),
                  // padding: EdgeInsets.symmetric(vertical: 12.0),
                  // color: Color(0xFF32312D),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetHeaderMyCart(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'My Cart',
          style: Theme.of(context).textTheme.bodySmall!.merge(const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              )),
        ),
        Text('2 items', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class WidgetControllerQuantity extends StatefulWidget {
  final int qty;

  const WidgetControllerQuantity(this.qty, {super.key});

  @override
  _WidgetControllerQuantityState createState() =>
      _WidgetControllerQuantityState();
}

class _WidgetControllerQuantityState extends State<WidgetControllerQuantity> {
  late int qty;

  @override
  void initState() {
    qty = widget.qty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (qty == 1) return;
            setState(() {
              qty -= 1;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.remove,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ),
        Text('$qty'),
        GestureDetector(
          onTap: () {
            if (qty == 10) return;
            setState(() {
              qty += 1;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.add,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}

class Cart {
  String productName;
  int price;
  String size;
  int quantity;
  String color;
  String image;

  Cart(
      {required this.productName,
      required this.price,
      required this.size,
      required this.quantity,
      required this.color,
      required this.image});
}
