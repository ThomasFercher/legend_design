import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_widgets/legendButton/legendButtonStyle.dart';
import 'package:provider/provider.dart';

import '../legendButton/legendButton.dart';

class LegendBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final Widget content;

  LegendBottomSheet({
    Key? key,
    required this.title,
    required this.onConfirm,
    required this.onCancel,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeInfo ss = SizeInfo.of(context);
    LegendTheme theme = Provider.of<LegendTheme>(context);
    double width = theme.sizeIsRange(0, 2) ? ss.width : ss.width / 3;

    return Container(
      alignment: Alignment.bottomCenter,
      height: 160,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
          maxHeight: 160,
          minWidth: width,
          minHeight: 160,
        ),
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: theme.sizing.borderRadius[0].copyWith(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: theme.sizing.borderInset[0] / 2,
                    bottom: theme.sizing.borderInset[0] / 2,
                    right: theme.sizing.borderInset[0] / 2,
                    left: theme.sizing.borderInset[0],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                      ),
                      IconButton(
                        splashRadius: 20.0,
                        onPressed: () => {
                          // Maybe Implement with RouterProvider
                          Navigator.pop(context),
                        },
                        icon: Icon(Icons.close),
                        padding: EdgeInsets.all(0),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.sizing.borderInset[0],
                    ),
                    child: content,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: theme.sizing.borderInset[0] / 2,
                    bottom: theme.sizing.borderInset[0] / 2,
                    right: theme.sizing.borderInset[0] / 2,
                    left: theme.sizing.borderInset[0],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LegendButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onCancel();
                        },
                        text: LegendText(
                          text: "Cancel",
                          selectable: false,
                        ),
                        style: LegendButtonStyle.danger(),
                      ),
                      LegendButton(
                        onPressed: () {
                          onConfirm();
                        },
                        text: LegendText(
                          text: "Confirm",
                          selectable: false,
                        ),
                        style: LegendButtonStyle.confirm(
                          color: Colors.blue,
                          activeColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
