import 'package:arrre/Write%20and%20Record/RecordPage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int selectedIndex = 0;
  final List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  final List<String> dates = ["01", "02", "03", "04", "05", "06", "07"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: Icon(Icons.ac_unit),
        actions: [
          Padding(padding: EdgeInsets.all(20),child: Icon(
              Icons.account_circle_outlined
          ),)
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Good morning.',
                  style: TextStyle(fontSize: 32,fontFamily: 'MonaSans', fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  return Column(
                    children: [
                      Text(days[index]), // Replace dynamically with days
                      Text(dates[index]),
                    ],
                  );
                }),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'FRIDAY',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,fontFamily: 'MonaSans'),
                ),
              ),

              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        TaskCard(
                          title: "Let's start your day",
                          subtitle: "with morning preparation",
                          color: Color(0xff074a65),
                          icon: Icons.circle,
                        ),

                        TaskCard(
                          title: "Evening reflection",
                          subtitle: "Sum up your day",
                          color: Colors.white,
                          textColor: Color(0xff074a65),
                          icon: Icons.mode_night_sharp,
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(

        showSelectedLabels: false,
        showUnselectedLabels: true,

        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Recordpage()));
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
          } else if (index == 4) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
          }
        },

        currentIndex: 2,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          // BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: 'Add'),
          BottomNavigationBarItem(icon: Container(height: 56, width: 56, decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff074a65)),child: Icon(Icons.add,color: Colors.white,),), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Journey'),
          BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: 'Trends'),
        ],
      ),

    );
  }
}


class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final IconData icon;

  const TaskCard({super.key, 
    required this.title,
    required this.subtitle,
    required this.color,
    this.textColor = Colors.white,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 286,
      width: 151,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: 136,
            width: 141,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 87,
                  width: 123,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "MonaSans",
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ),

                SizedBox(height: 4),

                SizedBox(
                  height: 44,
                  width: 121,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 20,),

          Icon(icon, color: textColor, size: 61),
        ],
      ),
    );
  }
}

enum MenuItem {
  write,
  record,
}