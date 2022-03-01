import 'package:demo_store/DetailPageNotState.dart';
import 'package:demo_store/LikeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_store/Detail.dart';
import 'package:demo_store/data.dart';
import 'goods_entity.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LikeModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TabBarWidget(),
    );
  }
}

class TabBarWidget extends StatefulWidget {
  TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  //赋值列表数据给goods
  //List<GoodsEntity> goods=[goods<GoodsEntity>,goods<GoodsEntity>,...]
  List<GoodsEntity> goods =
      Data.map((item) => GoodsEntity.fromJson(item)).toList();
  //定义控制器
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();
  //存储列表
  List _list = Data;
  @override
  void initState() {
    super.initState();
    //tabController初始化
    _tabController = TabController(length: 6, vsync: this);
    //监听滚动条事件
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData(); //触底触发事件
      }
    });
  }

//销毁滑动控制器
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

//2秒的delay，上拉加载重复数据
  _getMoreData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      //只刷新20条数据
      List list = _list.sublist(0, 20);
      list.addAll(_list);
      _list = list;
    });
  }

//下拉刷新数据，让列表反转
  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = _list.reversed.toList();
    });
  }

  // 加载动画
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              '加载中',
              style: TextStyle(fontSize: 16.0),
            ),
            // 加载图标
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

  //正方形Card
  Widget? _squareCard(index) {
    return Container(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //图片
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 80,
                width: double.infinity,
                child: Image.network(
                  "${_list[index]['url']}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //名字和价格
            Container(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_list[index]['name']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '￥${_list[index]['price']}',
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                )),
            //当日午餐
            Container(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '当日午餐',
                    style: TextStyle(
                        fontSize: 12,
                        color: _list[index]['mealType'] == "当日午餐"
                            ? Colors.red
                            : Colors.grey),
                  ),
                  Text(
                    '次日午餐',
                    style: TextStyle(
                        fontSize: 12,
                        color: _list[index]['mealType'] == "次日午餐"
                            ? Colors.red
                            : Colors.grey),
                  ),
                  Text(
                    '次日晚餐',
                    style: TextStyle(
                        fontSize: 12,
                        color: _list[index]['mealType'] == "次日晚餐"
                            ? Colors.red
                            : Colors.grey),
                  ),
                ],
              ),
            ),
            //收藏礼品库
            Container(
                height: 25,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPageNotState(
                                _list[index]['name'],
                                _list[index]['price'],
                                _list[index]['url'],
                                _list[index]['mealType'])));
                  },
                  child: Text('查看商品'),
                )),
            //用礼金兑换 送给它
            Container(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '用礼金兑换',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(214, 232, 120, 1),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 22,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.red[100],
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        '送给TA',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //长方形Card
  _rectangleCardNotState(index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 95,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: AspectRatio(
                          aspectRatio: 2 / 1,
                          child: Image.network(
                            '${_list[index]['url']}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Column(children: [
                      //名称
                      Container(
                          height: 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${_list[index]['name']}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '￥${_list[index]['price']}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.red),
                              ),
                            ],
                          )),
                      Container(
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '当日午餐',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _list[index]['mealType'] == "当日午餐"
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                            Text(
                              '次日午餐',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _list[index]['mealType'] == "次日午餐"
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                            Text(
                              '次日晚餐',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _list[index]['mealType'] == "次日晚餐"
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      //收藏至礼品库
                      Container(
                          height: 25,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPageNotState(
                                          _list[index]['name'],
                                          _list[index]['price'],
                                          _list[index]['url'],
                                          _list[index]['mealType'])));
                            },
                            child: Text('已收藏'),
                          )),
                      //用礼金兑换
                      Container(
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                '用礼金兑换',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(214, 232, 120, 1),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 22,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    border: Border.all(width: 0.1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Text(
                                  '送给TA',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]))
                  ])),
        ),
      ),
    );
  }

//Wrap布局
  Widget getItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 10,
              children: List.generate(_list.length, (i) {
                return i != _list.length - 1
                    ? ((i + 1) % 3 == 0
                        ? _rectangleCardNotState(i)
                        : _squareCard(i))
                    : _getMoreWidget();
              }),
            )),
      ],
    );
  }

  //常规列表StateManage
  _listCommon() {
    return RefreshIndicator(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Consumer(
                          builder: (context, value, child) {
                            GoodsEntity goodsEntity = goods[index];
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 95,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: AspectRatio(
                                        aspectRatio: 2 / 1,
                                        child: Image.network(
                                          goodsEntity.url,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: Column(children: [
                                    //名称
                                    Container(
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              goodsEntity.name,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '￥${goodsEntity.price}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      height: 25,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '当日午餐',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: goodsEntity.mealType ==
                                                        "当日午餐"
                                                    ? Colors.red
                                                    : Colors.grey),
                                          ),
                                          Text(
                                            '次日午餐',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: goodsEntity.mealType ==
                                                        "次日午餐"
                                                    ? Colors.red
                                                    : Colors.grey),
                                          ),
                                          Text(
                                            '次日晚餐',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: goodsEntity.mealType ==
                                                        "次日晚餐"
                                                    ? Colors.red
                                                    : Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //收藏至礼品库
                                    Consumer(
                                      builder: (context, value, child) {
                                        bool isInLike = context
                                            .watch<LikeModel>()
                                            .isInLike(goodsEntity);
                                        return Container(
                                            height: 25,
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                                  goodsEntity)));
                                                },
                                                // child: Text('已收藏'),
                                                child: isInLike
                                                    ? Text('已收藏')
                                                    : Text('收藏至礼品库')));
                                      },
                                    ),
                                    //用礼金兑换
                                    Container(
                                      height: 25,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: const Text(
                                              '用礼金兑换',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      214, 232, 120, 1),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 22,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.red[100],
                                                  border:
                                                      Border.all(width: 0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: const Text(
                                                '送给TA',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]))
                                ]);
                          },
                        )),
                  ),
                ),
              );
            }),
        onRefresh: _handleRefresh);
  }

//2-1-2-1列表上拉加载更多
  _listCustom() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: getItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: TabBar(
                    labelColor: Colors.red,
                    labelStyle: TextStyle(fontSize: 20),
                    controller: _tabController,
                    isScrollable: true,
                    tabs: const <Widget>[
                      Tab(text: "美食"),
                      Tab(text: "食品"),
                      Tab(text: "日用"),
                      Tab(text: "花植"),
                      Tab(text: "保健"),
                      Tab(text: "生活")
                    ],
                  ))
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            //美食
            _listCommon(),
            //食品
            _listCustom(),
            //日用
            _listCustom(),
            //花植
            _listCustom(),
            //保健
            _listCustom(),
            //生活
            _listCustom(),
          ],
        ),
      ),
    ));
  }
}
