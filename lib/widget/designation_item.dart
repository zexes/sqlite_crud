import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/designation_provider.dart';
import '../screens/add_edit_designationScreen.dart';
import '../screens/designation_screen.dart';

class DesignationItem extends StatelessWidget {
  final int id;
  final String display;
  final String value;

  const DesignationItem({this.id, this.display, this.value});

  Future<void> deleteDesignation(BuildContext context) async {
    final designationProvider =
        Provider.of<DesignationProvider>(context, listen: false);
    await designationProvider.deleteDesignation(id);
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  display.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(display,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 20.0,
              )),
          subtitle: Text(value,
              style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800)),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => EditDesignationScreen(
                        chosenDesignationId: id,
                      ),
                    );
                  },
                  color: Theme.of(context).accentColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    bool result = await _showDialog(context);
                    if (result) {
                      scaffold.hideCurrentSnackBar();
                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text(
                            'Deleted a Designation!!',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                      );
                    }
                  },
                  color: Theme.of(context).errorColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Are you sure'),
        content: Text('Do you want to delete Designation?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(_).pop(false);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () async {
              await deleteDesignation(context);
              Navigator.of(context).pop(true);
            },
          )
        ],
      ),
    );
  }
}
