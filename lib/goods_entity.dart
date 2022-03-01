class GoodsEntity {
  late int _id;
  late String _name;
  late double _price;
  late String _url;
  late String _mealType;

  int get id => _id;
  String get name => _name;
  double get price => _price;
  String get url => _url;
  String get mealType => _mealType;

  static GoodsEntity fromJson(Map<String, dynamic> json) {
    GoodsEntity goods = GoodsEntity();
    goods._id = json['id'];
    goods._name = json['name'];
    goods._price = json['price'];
    goods._url = json['url'];
    goods._mealType = json['mealType'];
    return goods;
  }
}
