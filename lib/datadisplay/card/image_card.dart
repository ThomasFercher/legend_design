import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Function() onClick;
  final bool showTitleTop;
  final String? heroKey;
  final WidgetBuilder? builder;

  ImageCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onClick,
    this.showTitleTop = false,
    this.heroKey,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);
    return InkWell(
      onTap: () {
        print("ye");
        onClick();
      },
      child: Card(
        color: theme.colors.background[1],
        shape: RoundedRectangleBorder(
          borderRadius: theme.sizing.borderRadius[0],
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          double width = constraints.maxWidth;
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showTitleTop) getTitle(theme),
                  Expanded(
                    child: getImage(theme, width),
                  ),
                  if (!showTitleTop) getTitle(theme),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight / 6,
                    ),
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: theme.sizing.borderInset[0],
                    ),
                    child: LegendText(
                      text: description,
                      textStyle: theme.typography.h1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              if (builder != null) Builder(builder: builder!),
            ],
          );
        }),
      ),
    );
  }

  Widget getTitle(LegendTheme theme) {
    return LegendText(
      padding: EdgeInsets.only(
        left: 16,
        top: theme.sizing.borderInset[0],
        bottom: 4,
      ),
      text: title,
      textStyle: theme.typography.h4,
    );
  }

  Widget getImage(LegendTheme theme, double width) {
    return heroKey != null
        ? Hero(
            tag: heroKey!,
            child: ClipRRect(
              borderRadius: theme.sizing.borderRadius[0].copyWith(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                width: width,
              ),
            ),
          )
        : Image.asset(
            imagePath,
            fit: BoxFit.cover,
          );
  }
}