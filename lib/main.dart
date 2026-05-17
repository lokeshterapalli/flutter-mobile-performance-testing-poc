import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salon Staff App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String message = '';

void login() async {

  try {

    print('LOGIN BUTTON CLICKED');

    final response = await ApiService.login(
      usernameController.text,
      passwordController.text,
    );

    print('LOGIN RESPONSE: $response');

    if (response['status'] == 'success') {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );

    } else {

      setState(() {
        message = 'Invalid Credentials';
      });

    }

  } catch (e) {

  print('LOGIN ERROR: $e');

  setState(() {
    message = e.toString();
  });

}
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Salon Staff App'),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.cut,
              size: 80,
              color: Colors.purple,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              message,
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Dashboard'),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            dashboardButton(
              context,
              'Employees',
              const EmployeeScreen(),
            ),

            dashboardButton(
              context,
              'Stores',
              const StoreScreen(),
            ),

            dashboardButton(
              context,
              'Salary',
              const SalaryScreen(),
            ),

            dashboardButton(
              context,
              'Holidays',
              const HolidayScreen(),
            ),

            dashboardButton(
              context,
              'Leave Booking',
              const LeaveBookingScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardButton(
      BuildContext context,
      String title,
      Widget screen,
      ) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 20),

      child: SizedBox(

        width: double.infinity,
        height: 60,

        child: ElevatedButton(

          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screen,
              ),
            );
          },

          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  List employees = [];

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  void loadEmployees() async {

    final data = await ApiService.getEmployees();

    setState(() {
      employees = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Employees'),
      ),

      body: ListView.builder(

        itemCount: employees.length,

        itemBuilder: (context, index) {

          final employee = employees[index];

          return Card(

            child: ListTile(

              title: Text(employee['name']),

              subtitle: Text(employee['role']),

              trailing: Text(
                '₹${employee['salary']}',
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  List stores = [];

  @override
  void initState() {
    super.initState();
    loadStores();
  }

  void loadStores() async {

    final data = await ApiService.getStores();

    setState(() {
      stores = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Stores'),
      ),

      body: ListView.builder(

        itemCount: stores.length,

        itemBuilder: (context, index) {

          final store = stores[index];

          return Card(

            child: ListTile(
              title: Text(store['name']),
            ),
          );
        },
      ),
    );
  }
}

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {

  List salary = [];

  @override
  void initState() {
    super.initState();
    loadSalary();
  }

  void loadSalary() async {

    final data = await ApiService.getSalary();

    setState(() {
      salary = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Salary Details'),
      ),

      body: ListView.builder(

        itemCount: salary.length,

        itemBuilder: (context, index) {

          final item = salary[index];

          return Card(

            child: ListTile(

              title: Text(item['month']),

              subtitle: Text(
                'Bonus: ₹${item['bonus']}',
              ),

              trailing: Text(
                '₹${item['salary']}',
              ),
            ),
          );
        },
      ),
    );
  }
}

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {

  List holidays = [];

  @override
  void initState() {
    super.initState();
    loadHolidays();
  }

  void loadHolidays() async {

    final data = await ApiService.getHolidays();

    setState(() {
      holidays = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Holiday Calendar'),
      ),

      body: ListView.builder(

        itemCount: holidays.length,

        itemBuilder: (context, index) {

          final holiday = holidays[index];

          return Card(

            child: ListTile(

              title: Text(holiday['holiday']),

              subtitle: Text(holiday['date']),
            ),
          );
        },
      ),
    );
  }
}

class LeaveBookingScreen extends StatefulWidget {
  const LeaveBookingScreen({super.key});

  @override
  State<LeaveBookingScreen> createState() =>
      _LeaveBookingScreenState();
}

class _LeaveBookingScreenState
    extends State<LeaveBookingScreen> {

  String message = '';

  void bookLeave() async {

    final response = await ApiService.bookLeave();

    setState(() {
      message = response['message'];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Leave Booking'),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            SizedBox(

              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                onPressed: bookLeave,

                child: const Text(
                  'Submit Leave Request',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}