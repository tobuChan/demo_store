import 'package:demo_store/LikeModel.dart';
import 'package:demo_store/goods_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  GoodsEntity goodsEntity;

  DetailPage(this.goodsEntity);

  @override
  State<DetailPage> createState() => _DetailPageState(goodsEntity);
}

class _DetailPageState extends State<DetailPage> {
  GoodsEntity goodsEntity;
  _DetailPageState(this.goodsEntity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.1,
          centerTitle: true,
          title: Text(
            goodsEntity.name,
            style: TextStyle(color: Colors.blue),
          ),
          actions: [
            Consumer<LikeModel>(builder: (context, value, child) {
              bool isInLike = context.read<LikeModel>().isInLike(goodsEntity);
              return IconButton(
                onPressed: isInLike
                    ? () {
                        var cart = context.read<LikeModel>();
                        cart.remove(goodsEntity);
                      }
                    : () {
                        var cart = context.read<LikeModel>();
                        cart.add(goodsEntity);
                      },
                icon: isInLike
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
              );
            })
          ],
        ),
        body: Center(
          child: Column(
            children: [
              //图片和价格..
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 120,
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 1.8,
                      child: Image.network(
                        goodsEntity.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //单价
                          Container(
                            height: 25,
                            child: Text(
                              '单价：￥${goodsEntity.price}',
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ),

                          //配送范围
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '配送范围：10千米',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.orange),
                            ),
                          ),
                          //当日午餐
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 30,
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 12,
                                        width: 12,
                                        color: goodsEntity.mealType == "当日午餐"
                                            ? Colors.pinkAccent[100]
                                            : Colors.grey,
                                      ),
                                      Text('当日午餐')
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 12,
                                        width: 12,
                                        color: goodsEntity.mealType == "次日午餐"
                                            ? Colors.pinkAccent[100]
                                            : Colors.grey,
                                      ),
                                      Text('次日午餐')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 12,
                                  width: 12,
                                  color: goodsEntity.mealType == "次日晚餐"
                                      ? Colors.pinkAccent[100]
                                      : Colors.grey,
                                ),
                                Text('次日晚餐')
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //美食介绍
              Container(
                padding: EdgeInsets.all(10),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(left: 20),
                      height: 25,
                      width: double.infinity,
                      child: Text(
                        '美食介绍：',
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[200]),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(20),
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      height: 130,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromRGBO(237, 237, 237, 1)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼沼产越光米，香香嫩滑回味留甘，限量供应,快快速抢",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, letterSpacing: 3),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //产品图片
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      //padding: EdgeInsets.only(left: 20),
                      height: 30,
                      width: double.infinity,
                      child: Text(
                        '产品图片：',
                        style:
                            TextStyle(fontSize: 20, color: Colors.orange[200]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: (MediaQuery.of(context).size.width - 40) / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(goodsEntity.url),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 120,
                            width: (MediaQuery.of(context).size.width - 40) / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(goodsEntity.url),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //退出，查看商家
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('退出'),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 20)), //字体样式
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(172, 141, 156, 1)), //按钮背景颜色
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white), //字体颜色
                        fixedSize:
                            MaterialStateProperty.all(Size(120, 50)), //按钮大小
                        side: MaterialStateProperty.all(const BorderSide(
                            width: 1, color: Colors.blue)), //边框的颜色和厚度

                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))), //圆角按钮
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        '查看商家',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        //按钮样式
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 20)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(226, 172, 195, 1)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        fixedSize: MaterialStateProperty.all(Size(120, 50)),
                        side: MaterialStateProperty.all(
                            const BorderSide(width: 1, color: Colors.blue)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
