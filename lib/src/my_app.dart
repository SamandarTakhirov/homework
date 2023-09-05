import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStorePage(),
      debugShowCheckedModeBanner: false,
      title: "Store",
    );
  }
}

class AppState {
  final List<String> productList;
  final Set<String> itemInCart;

  AppState({
    required this.productList,
    this.itemInCart = const <String>{},
  });

  AppState copyWith({
    List<String>? productList,
    Set<String>? itemInCart,
  }) {
    return AppState(
      productList: productList ?? this.productList,
      itemInCart: itemInCart ?? this.itemInCart,
    );
  }
}

class AppStateScope extends InheritedWidget {
  final AppState data;

  const AppStateScope(
    this.data, {
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) => data == oldWidget.data;
}

class AppStateWidget extends StatefulWidget {
  AppStateWidget({required this.child});

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  State<AppStateWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {

  AppState _data = AppState(
    productList: [],
    // productList: Server.getProductList(),
  );

  get newItemInCart => null;



  void setProductList(List<String> newProductList) {
    if (_data.productList != newProductList) {
      setState(() {
        _data = _data.copyWith(productList: newProductList);
      });
    }
  }

  void addToCart(String id) {
    if (!_data.itemInCart.contains(id)) {
      setState(() {
        final Set<String> newItemInCard = Set<String>.from(_data.itemInCart);
        newItemInCart.add(id);
        _data = _data.copyWith(itemInCart: newItemInCard);
      });
    }
  }

  void removeFromCart(String id) {
    if (_data.itemInCart.contains(id)) {
      setState(() {
        final Set<String> newItemInCard = Set<String>.from(_data.itemInCart);
        newItemInCart.remove(id);
        _data = _data.copyWith(itemInCart: newItemInCard);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      _data,
      child: widget.child,
    );
  }
}

class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
