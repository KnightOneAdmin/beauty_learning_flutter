import 'package:beauty_flutter/card_free.dart';
import 'package:beauty_flutter/card_recommend.dart';
import 'package:beauty_flutter/card_special.dart';
import 'package:beauty_flutter/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'card_share.dart';

class ContentPager extends StatefulWidget {
  final ValueChanged<int> onPageChanged;
  final ContentPagerController contentPageController;

//构造方法,可选参数
  const ContentPager({Key key, this.onPageChanged, this.contentPageController})
      //初始化例表
      : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPager> {
  /*创建视图比例*/
  PageController _pageController = PageController(viewportFraction: 0.8);

  /*创建颜色列表*/
  static List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.deepOrange,
    Colors.teal
  ];

  @override
  void initState() {
    if (widget.contentPageController != null) {
      widget.contentPageController._pageController = _pageController;
    }
    _statusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomAppBar(),
        Expanded(
            child: PageView(
          onPageChanged: widget.onPageChanged,
          controller: _pageController,
          children: <Widget>[
            _wrapItem(CardRecommend()),
            _wrapItem(CardShare()),
            _wrapItem(CardFree()),
            _wrapItem(CardSpecial()),
          ],
        ))
      ],
    );
  }

  Widget _wrapItem(Widget widget) {
    return Padding(padding: EdgeInsets.all(10), child: widget);
  }

  _statusBar() {
    SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
  }
}

/// 内容区域控制器
class ContentPagerController {
  PageController _pageController;

  void jumpToPage(int index) {
    _pageController?.jumpToPage(index);
  }
}
