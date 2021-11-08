import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zcart/data/network/network_utils.dart';
import 'package:zcart/lib2/Home/HomeScreen.dart';
import 'package:zcart/lib2/Message/Message.dart';
import 'package:zcart/lib2/Notification/Notification.dart';
import 'package:zcart/lib2/Profile/Profile.dart';
import 'package:zcart/lib2/Splash/SplashScreen.dart';
import 'package:zcart/lib2/Stream/StreamScreen.dart';
import 'package:zcart/lib2/widget/GredianIcon.dart';
import 'package:zcart/main.dart';
import 'package:zcart/translations/locale_keys.g.dart';
import 'package:zcart/views/screens/auth/login_screen.dart';
import 'package:zcart/views/screens/auth/not_logged_in_screen.dart';
import 'package:zcart/views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:zcart/views/screens/tabs/brands_tab/brands_tab.dart';
import 'package:zcart/views/screens/tabs/tabs.dart';
import 'package:easy_localization/easy_localization.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Widget icon;
  final Widget selectedIcon;
  final String label;
  TabNavigationItem(
      {required this.page,
      required this.title,
      required this.icon,
      required this.selectedIcon,
      required this.label});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomeTab(),
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          title: Text(LocaleKeys.home_text.tr()),
          label: LocaleKeys.home_text.tr(),
        ),
        TabNavigationItem(
          page: accessAllowed ? PageScreen() : LoginScreen(),
          icon: Image.asset(
            'assets/images/logo.png',
            height: 30,
            width: 30,
          ),
          selectedIcon: Image.asset(
            'assets/images/logo.png',
            height: 30,
            width: 30,
          ),
          title: Text(LocaleKeys.socail_app.tr()),
          label: LocaleKeys.socail_app.tr(),
        ),
        TabNavigationItem(
          page: VendorsTab(),
          icon: Icon(Icons.store_outlined),
          selectedIcon: Icon(Icons.store),
          title: Text(LocaleKeys.vendor_text.tr()),
          label: LocaleKeys.vendor_text.tr(),
        ),
        // TabNavigationItem(
        //   page: BrandsTab(),
        //   icon: Icon(Icons.local_mall_outlined),
        //   selectedIcon: Icon(Icons.local_mall),
        //   title: Text(LocaleKeys.brands.tr()),
        //   label: LocaleKeys.brands.tr(),
        // ),
        TabNavigationItem(
          page: accessAllowed ? WishListTab() : NotLoggedInScreen(),
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          title: Text(LocaleKeys.wishlist_text.tr()),
          label: LocaleKeys.wishlist_text.tr(),
        ),
        TabNavigationItem(
          page: MyCartTab(),
          icon: Icon(Icons.shopping_cart_outlined),
          selectedIcon: Icon(Icons.shopping_cart),
          title: Text(LocaleKeys.cart_text.tr()),
          label: LocaleKeys.cart_text.tr(),
        ),
        TabNavigationItem(
          page: accessAllowed ? AccountTab() : NotLoggedInScreen(),
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          title: Text(LocaleKeys.account_text.tr()),
          label: LocaleKeys.account_text.tr(),
        ),
      ];
}

class PageScreen extends StatefulWidget {
  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Widget indexView;
  // Widget indexView = HomeScreen();
  BottomBarType bottomBarType = BottomBarType.Home;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = HomeScreen(
      animationController: animationController,
    );
    animationController..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppThemeSocail.getTheme().backgroundColor,
        bottomNavigationBar: Container(
            height: 58 + MediaQuery.of(context).padding.bottom,
            child: getBottomBarUI(bottomBarType)),
        body: indexView,
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((f) {
        if (tabType == BottomBarType.Home) {
          setState(() {
            indexView = HomeScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Message) {
          setState(() {
            indexView = MessageScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Notification) {
          setState(() {
            indexView = NotificationScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            indexView = ProfileScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Straming) {
          setState(() {
            indexView = StreamScreen(
              animationController: animationController,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      color: HexColor("#20242F"),
      height: MediaQuery.of(context).padding.bottom + 60,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Home);
              },
              child: GradientIcon(
                FontAwesomeIcons.home,
                20,
                LinearGradient(
                  colors: tabType == BottomBarType.Home
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // tabClick(BottomBarType.Straming);
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => BottomNavBar(
                      selectedIndex: 0,
                    ),
                  ),
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
              },
              child: Icon(
                Icons.storefront,
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Straming);
              },
              child: GradientIcon(
                Icons.live_tv,
                26,
                LinearGradient(
                  colors: tabType == BottomBarType.Straming
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Message);
              },
              child: GradientIcon(
                FontAwesomeIcons.facebookMessenger,
                20,
                LinearGradient(
                  colors: tabType == BottomBarType.Message
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Notification);
              },
              child: GradientIcon(
                Icons.notifications_active,
                26,
                LinearGradient(
                  colors: tabType == BottomBarType.Notification
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Profile);
              },
              child: GradientIcon(
                FontAwesomeIcons.user,
                20,
                LinearGradient(
                  colors: tabType == BottomBarType.Profile
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum BottomBarType {
  Home,
  Straming,
  Message,
  Notification,
  Profile,
  Stories,
}
