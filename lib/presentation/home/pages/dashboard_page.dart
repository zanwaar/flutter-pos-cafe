import 'package:flutter/material.dart';
import 'package:flutter_pos_app/presentation/history/pages/history_page.dart';
import 'package:flutter_pos_app/presentation/home/pages/home_page.dart';
import 'package:flutter_pos_app/presentation/order/pages/order_page.dart';
import 'package:flutter_pos_app/presentation/setting/pages/setting_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../widgets/nav_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrderPage(),
    const HistoryPage(),
    const SettingPage(),
    // const HomePage(),
    // const OrdersPage(),
    // const Placeholder(),
    // const ManageMenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(8),
          ),
          color: const Color.fromARGB(255, 27, 27, 27),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(0.18),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.home.path,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
                iconPath: Assets.icons.orders.path,
                label: 'Orders',
                isActive: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  // context.push(const OrdersPage());
                }),
            NavItem(
              iconPath: Assets.icons.payments.path,
              label: 'History',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icons.dashboard.path,
              label: 'Kelola',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
