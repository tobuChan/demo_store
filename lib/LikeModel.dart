import 'package:flutter/material.dart';
import 'goods_entity.dart';

class LikeModel with ChangeNotifier {
  List<GoodsEntity> _items = [];
  List<GoodsEntity> get items => _items;

//添加喜欢
  void add(GoodsEntity goods) {
    if (!isInLike(goods)) {
      _items.add(goods);
      notifyListeners();
    }
  }

//移除喜欢
  void remove(GoodsEntity goods) {
    if (isInLike(goods)) {
      _items.remove(goods);
      notifyListeners();
    }
  }

//是否喜欢
  bool isInLike(GoodsEntity goods) {
    return _items.any((element) => element.id == goods.id);
  }
}
