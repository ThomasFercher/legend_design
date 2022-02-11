import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_widgets/input/text/legendInputDecoration.dart';
import 'package:provider/src/provider.dart';

class LegendTextField extends StatefulWidget {
  final LegendInputDecoration decoration;
  final bool obscureText;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final String? value;
  final bool? editable;

  LegendTextField({
    required this.decoration,
    Key? key,
    this.obscureText = false,
    this.onSubmitted,
    this.onChanged,
    this.value,
    this.editable,
  }) : super(key: key);

  @override
  _LegendTextFieldState createState() => _LegendTextFieldState();
}

class _LegendTextFieldState extends State<LegendTextField> {
  late TextEditingController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(
      text: widget.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();

    return TextField(
      controller: ctrl,
      decoration: widget.decoration,
      cursorColor: widget.decoration.cursorColor,
      textAlignVertical: TextAlignVertical.top,
      onSubmitted: (value) {
        if (widget.onSubmitted != null) widget.onSubmitted!(value);
      },
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      style: theme.typography.h1.copyWith(
        color: widget.decoration.textColor,
      ),
      toolbarOptions: ToolbarOptions(
        copy: true,
        selectAll: true,
        paste: true,
        cut: true,
      ),
    );
  }
}
