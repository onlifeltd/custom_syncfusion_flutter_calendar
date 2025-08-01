import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  return runApp(const CalendarApp());
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
  }
}

/// The hove page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final calendarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        body: Column(
          children: [
            Container(
              height: 200,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                'Tap on the appointment to see the tap data',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              child: SfCalendar(
                    key: calendarKey,
                    dataSource: MeetingDataSource(_getDataSource()),
                    // by default the month appointment display mode set as Indicator, we can
                    // change the display mode as appointment using the appointment display
                    // mode property
                    allowAppointmentResize: true,
                    headerHeight: 0,
                    viewHeaderHeight: 0,
                    allowDragAndDrop: true,
                    selectionDecoration: const BoxDecoration(color: Colors.transparent),                   
                  ),
            ),
          ],
        ),);
  }

  List<Appointment> _getDataSource() {
    final today = DateTime.now();
    final startTime = DateTime(today.year, today.month, today.day, 14);
    final endTime = startTime.add(const Duration(hours: 1));
    const duration = Duration(hours: 2);


    return [
      Appointment(startTime: startTime.subtract(duration), endTime: endTime,
        etaDuration: duration,
        subject: 'Conference w duration', color: Colors.red,
      ),
      // Appointment(startTime: startTime, endTime: startTime.add(const Duration(hours: 24)),
      //   subject: 'Conference some', color: Colors.green,
      // ),
      Appointment(startTime: startTime, endTime: startTime.add(const Duration(hours: 22)),
        subject: 'Conference spanned', color: Colors.red,
      ),
    ];
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  // @override
  // DateTime getStartTime(int index) {
  //   return _getMeetingData(index).from;
  // }

  // @override
  // DateTime getEndTime(int index) {
  //   return _getMeetingData(index).to;
  // }

  // @override
  // String getSubject(int index) {
  //   return _getMeetingData(index).eventName;
  // }

  // @override
  // Color getColor(int index) {
  //   return _getMeetingData(index).background;
  // }

  // @override
  // bool isAllDay(int index) {
  //   return _getMeetingData(index).isAllDay;
  // }

  // Meeting _getMeetingData(int index) {
  //   final dynamic meeting = appointments![index];
  //   late final Meeting meetingData;
  //   if (meeting is Meeting) {
  //     meetingData = meeting;
  //   }

  //   return meetingData;
  // }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
