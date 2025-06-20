// All colors in current file are defined in web standards.
// ignore_for_file: public_member_api_docs

/// Extension to convert nullable string to color value.
extension StringToColorExt on String? {
  static final _colorRe = RegExp(r'^(#)?[0-9a-fA-F]{1,6}$');

  /// Parse nullable color string to color value.
  ///
  /// * If `this` is null, return null.
  /// * Parse `this` in style `#COLOR_VALUE` or `COLOR_NAME` where COLOR_NAME is
  ///   hit in [WebColors].
  int? toColor() {
    int? colorValue;
    // Parse as color value.
    if (this != null && _colorRe.hasMatch(this!)) {
      if (this!.startsWith('#')) {
        if (this!.length == 4) {
          // #abc, RGB format short hand for #aabbcc.
          colorValue = int.tryParse(
            '${this![1]}${this![1]}' // R
            '${this![2]}${this![2]}' // G
            '${this![3]}${this![3]}', // B
            radix: 16,
          );
        } else if (this!.length == 5) {
          // Drop support for ARGB or RGBA format since we do not know the exact format.
          // // #fabc, ARGB format short hand for #aabbccff.
          // // Here we do not know the content is ARGB (dart) or RGBA (css, or call it web).
          // // For compatibility reasons, we all assume ARGB format.
          // colorValue = int.tryParse(
          //   '${this![0]}${this![0]}' // A
          //   '${this![1]}${this![1]}' // R
          //   '${this![2]}${this![2]}' // G
          //   '${this![3]}${this![3]}', // B
          //   radix: 16,
          // );
          return null;
        } else {
          // Normal #aabbcc format.
          colorValue = int.tryParse(this!.substring(1), radix: 16);
        }
      } else {
        colorValue = int.tryParse(this!, radix: 16);
      }
    }
    if (colorValue != null) {
      // Only append if do not have alpha channel.
      // This is required by dart side when parsing color.
      if (colorValue < 0x01000000) {
        colorValue += 0xFF000000;
      }
      return colorValue;
    } else {
      // If color not in format #aabcc, try parse as color name.
      final webColor = WebColors.fromString(this);
      if (webColor.isValid) {
        return webColor.colorValue;
      }
    }
    return null;
  }
}

enum WebColors {
  aliceBlue(0xFFF0F8FF),
  antiqueWhite(0xFFFAEBD7),
  aqua(0xFF00FFFF),
  aquamarine(0xFF7FFFD4),
  azure(0xFFF0FFFF),
  beige(0xFFF5F5DC),
  bisque(0xFFFFE4C4),
  black(0xFF000000),
  blanchedAlmond(0xFFFFEBCD),
  blue(0xFF0000FF),
  blueViolet(0xFF8A2BE2),
  brown(0xFFA52A2A),
  burlyWood(0xFFDEB887),
  cadetBlue(0xFF5F9EA0),
  chartreuse(0xFF7FFF00),
  chocolate(0xFFD2691E),
  coral(0xFFFF7F50),
  cornflowerBlue(0xFF6495ED),
  cornsilk(0xFFFFF8DC),
  crimson(0xFFDC143C),
  cyan(0xFF00FFFF),
  darkBlue(0xFF00008B),
  darkCyan(0xFF008B8B),
  darkGoldenRod(0xFFB8860B),
  darkGray(0xFFA9A9A9),
  darkGrey(0xFFA9A9A9),
  darkGreen(0xFF006400),
  darkKhaki(0xFFBDB76B),
  darkMagenta(0xFF8B008B),
  darkOliveGreen(0xFF556B2F),
  darkOrange(0xFFFF8C00),
  darkOrchid(0xFF9932CC),
  darkRed(0xFF8B0000),
  darkSalmon(0xFFE9967A),
  darkSeaGreen(0xFF8FBC8F),
  darkSlateBlue(0xFF483D8B),
  darkSlateGray(0xFF2F4F4F),
  darkSlateGrey(0xFF2F4F4F),
  darkTurquoise(0xFF00CED1),
  darkViolet(0xFF9400D3),
  deepPink(0xFFFF1493),
  deepSkyBlue(0xFF00BFFF),
  dimGray(0xFF696969),
  dimGrey(0xFF696969),
  dodgerBlue(0xFF1E90FF),
  fireBrick(0xFFB22222),
  floralWhite(0xFFFFFAF0),
  forestGreen(0xFF228B22),
  fuchsia(0xFFFF00FF),
  gainsboro(0xFFDCDCDC),
  ghostWhite(0xFFF8F8FF),
  gold(0xFFFFD700),
  goldenRod(0xFFDAA520),
  gray(0xFF808080),
  grey(0xFF808080),
  green(0xFF008000),
  greenYellow(0xFFADFF2F),
  honeyDew(0xFFF0FFF0),
  hotPink(0xFFFF69B4),
  indianRed(0xFFCD5C5C),
  indigo(0xFF4B0082),
  ivory(0xFFFFFFF0),
  khaki(0xFFF0E68C),
  lavender(0xFFE6E6FA),
  lavenderBlush(0xFFFFF0F5),
  lawnGreen(0xFF7CFC00),
  lemonChiffon(0xFFFFFACD),
  lightBlue(0xFFADD8E6),
  lightCoral(0xFFF08080),
  lightCyan(0xFFE0FFFF),
  lightGoldenRodYellow(0xFFFAFAD2),
  lightGray(0xFFD3D3D3),
  lightGrey(0xFFD3D3D3),
  lightGreen(0xFF90EE90),
  lightPink(0xFFFFB6C1),
  lightSalmon(0xFFFFA07A),
  lightSeaGreen(0xFF20B2AA),
  lightSkyBlue(0xFF87CEFA),
  lightSlateGray(0xFF778899),
  lightSlateGrey(0xFF778899),
  lightSteelBlue(0xFFB0C4DE),
  lightYellow(0xFFFFFFE0),
  lime(0xFF00FF00),
  limeGreen(0xFF32CD32),
  linen(0xFFFAF0E6),
  magenta(0xFFFF00FF),
  maroon(0xFF800000),
  mediumAquaMarine(0xFF66CDAA),
  mediumBlue(0xFF0000CD),
  mediumOrchid(0xFFBA55D3),
  mediumPurple(0xFF9370DB),
  mediumSeaGreen(0xFF3CB371),
  mediumSlateBlue(0xFF7B68EE),
  mediumSpringGreen(0xFF00FA9A),
  mediumTurquoise(0xFF48D1CC),
  mediumVioletRed(0xFFC71585),
  midnightBlue(0xFF191970),
  mintCream(0xFFF5FFFA),
  mistyRose(0xFFFFE4E1),
  moccasin(0xFFFFE4B5),
  navajoWhite(0xFFFFDEAD),
  navy(0xFF000080),
  oldLace(0xFFFDF5E6),
  olive(0xFF808000),
  oliveDrab(0xFF6B8E23),
  orange(0xFFFFA500),
  orangeRed(0xFFFF4500),
  orchid(0xFFDA70D6),
  paleGoldenRod(0xFFEEE8AA),
  paleGreen(0xFF98FB98),
  paleTurquoise(0xFFAFEEEE),
  paleVioletRed(0xFFDB7093),
  papayaWhip(0xFFFFEFD5),
  peachPuff(0xFFFFDAB9),
  peru(0xFFCD853F),
  pink(0xFFFFC0CB),
  plum(0xFFDDA0DD),
  powderBlue(0xFFB0E0E6),
  purple(0xFF800080),
  rebeccaPurple(0xFF663399),
  red(0xFFFF0000),
  rosyBrown(0xFFBC8F8F),
  royalBlue(0xFF4169E1),
  saddleBrown(0xFF8B4513),
  salmon(0xFFFA8072),
  sandyBrown(0xFFF4A460),
  seaGreen(0xFF2E8B57),
  seaShell(0xFFFFF5EE),
  sienna(0xFFA0522D),
  silver(0xFFC0C0C0),
  skyBlue(0xFF87CEEB),
  slateBlue(0xFF6A5ACD),
  slateGray(0xFF708090),
  slateGrey(0xFF708090),
  snow(0xFFFFFAFA),
  springGreen(0xFF00FF7F),
  steelBlue(0xFF4682B4),
  tan(0xFFD2B48C),
  teal(0xFF008080),
  thistle(0xFFD8BFD8),
  tomato(0xFFFF6347),
  turquoise(0xFF40E0D0),
  violet(0xFFEE82EE),
  wheat(0xFFF5DEB3),
  white(0xFFFFFFFF),
  whiteSmoke(0xFFF5F5F5),
  yellow(0xFFFFFF00),
  yellowGreen(0xFF9ACD32),
  invalid(0x00000000);

  const WebColors(this.colorValue);

  factory WebColors.fromString(String? c) {
    return switch (c?.toLowerCase()) {
      'aliceblue' => WebColors.aliceBlue,
      'antiquewhite' => WebColors.antiqueWhite,
      'aqua' => WebColors.aqua,
      'aquamarine' => WebColors.aquamarine,
      'azure' => WebColors.azure,
      'beige' => WebColors.beige,
      'bisque' => WebColors.bisque,
      'black' => WebColors.black,
      'blanchedalmond' => WebColors.blanchedAlmond,
      'blue' => WebColors.blue,
      'blueviolet' => WebColors.blueViolet,
      'brown' => WebColors.brown,
      'burlywood' => WebColors.burlyWood,
      'cadetblue' => WebColors.cadetBlue,
      'chartreuse' => WebColors.chartreuse,
      'chocolate' => WebColors.chocolate,
      'coral' => WebColors.coral,
      'cornflowerblue' => WebColors.cornflowerBlue,
      'cornsilk' => WebColors.cornsilk,
      'crimson' => WebColors.crimson,
      'cyan' => WebColors.cyan,
      'darkblue' => WebColors.darkBlue,
      'darkcyan' => WebColors.darkCyan,
      'darkgoldenrod' => WebColors.darkGoldenRod,
      'darkgray' => WebColors.darkGray,
      'darkgrey' => WebColors.darkGrey,
      'darkgreen' => WebColors.darkGreen,
      'darkkhaki' => WebColors.darkKhaki,
      'darkmagenta' => WebColors.darkMagenta,
      'darkolivegreen' => WebColors.darkOliveGreen,
      'darkorange' => WebColors.darkOrange,
      'darkorchid' => WebColors.darkOrchid,
      'darkred' => WebColors.darkRed,
      'darksalmon' => WebColors.darkSalmon,
      'darkseagreen' => WebColors.darkSeaGreen,
      'darkslateblue' => WebColors.darkSlateBlue,
      'darkslategray' => WebColors.darkSlateGray,
      'darkslategrey' => WebColors.darkSlateGrey,
      'darkturquoise' => WebColors.darkTurquoise,
      'darkviolet' => WebColors.darkViolet,
      'deeppink' => WebColors.deepPink,
      'deepskyblue' => WebColors.deepSkyBlue,
      'dimgray' => WebColors.dimGray,
      'dimgrey' => WebColors.dimGrey,
      'dodgerblue' => WebColors.dodgerBlue,
      'firebrick' => WebColors.fireBrick,
      'floralwhite' => WebColors.floralWhite,
      'forestgreen' => WebColors.forestGreen,
      'fuchsia' => WebColors.fuchsia,
      'gainsboro' => WebColors.gainsboro,
      'ghostwhite' => WebColors.ghostWhite,
      'gold' => WebColors.gold,
      'goldenrod' => WebColors.goldenRod,
      'gray' => WebColors.gray,
      'grey' => WebColors.grey,
      'green' => WebColors.green,
      'greenyellow' => WebColors.greenYellow,
      'honeydew' => WebColors.honeyDew,
      'hotpink' => WebColors.hotPink,
      'indianred' => WebColors.indianRed,
      'indigo' => WebColors.indigo,
      'ivory' => WebColors.ivory,
      'khaki' => WebColors.khaki,
      'lavender' => WebColors.lavender,
      'lavenderblush' => WebColors.lavenderBlush,
      'lawngreen' => WebColors.lawnGreen,
      'lemonchiffon' => WebColors.lemonChiffon,
      'lightblue' => WebColors.lightBlue,
      'lightcoral' => WebColors.lightCoral,
      'lightcyan' => WebColors.lightCyan,
      'lightgoldenrodyellow' => WebColors.lightGoldenRodYellow,
      'lightgray' => WebColors.lightGray,
      'lightgrey' => WebColors.lightGrey,
      'lightgreen' => WebColors.lightGreen,
      'lightpink' => WebColors.lightPink,
      'lightsalmon' => WebColors.lightSalmon,
      'lightseagreen' => WebColors.lightSeaGreen,
      'lightskyblue' => WebColors.lightSkyBlue,
      'lightslategray' => WebColors.lightSlateGray,
      'lightslategrey' => WebColors.lightSlateGrey,
      'lightsteelblue' => WebColors.lightSteelBlue,
      'lightyellow' => WebColors.lightYellow,
      'lime' => WebColors.lime,
      'limegreen' => WebColors.limeGreen,
      'linen' => WebColors.linen,
      'magenta' => WebColors.magenta,
      'maroon' => WebColors.maroon,
      'mediumaquamarine' => WebColors.mediumAquaMarine,
      'mediumblue' => WebColors.mediumBlue,
      'mediumorchid' => WebColors.mediumOrchid,
      'mediumpurple' => WebColors.mediumPurple,
      'mediumseagreen' => WebColors.mediumSeaGreen,
      'mediumslateblue' => WebColors.mediumSlateBlue,
      'mediumspringgreen' => WebColors.mediumSpringGreen,
      'mediumturquoise' => WebColors.mediumTurquoise,
      'mediumvioletred' => WebColors.mediumVioletRed,
      'midnightblue' => WebColors.midnightBlue,
      'mintcream' => WebColors.mintCream,
      'mistyrose' => WebColors.mistyRose,
      'moccasin' => WebColors.moccasin,
      'navajowhite' => WebColors.navajoWhite,
      'navy' => WebColors.navy,
      'oldlace' => WebColors.oldLace,
      'olive' => WebColors.olive,
      'olivedrab' => WebColors.oliveDrab,
      'orange' => WebColors.orange,
      'orangered' => WebColors.orangeRed,
      'orchid' => WebColors.orchid,
      'palegoldenrod' => WebColors.paleGoldenRod,
      'palegreen' => WebColors.paleGreen,
      'paleturquoise' => WebColors.paleTurquoise,
      'palevioletred' => WebColors.paleVioletRed,
      'papayawhip' => WebColors.papayaWhip,
      'peachpuff' => WebColors.peachPuff,
      'peru' => WebColors.peru,
      'pink' => WebColors.pink,
      'plum' => WebColors.plum,
      'powderblue' => WebColors.powderBlue,
      'purple' => WebColors.purple,
      'rebeccapurple' => WebColors.rebeccaPurple,
      'red' => WebColors.red,
      'rosybrown' => WebColors.rosyBrown,
      'royalblue' => WebColors.royalBlue,
      'saddlebrown' => WebColors.saddleBrown,
      'salmon' => WebColors.salmon,
      'sandybrown' => WebColors.sandyBrown,
      'seagreen' => WebColors.seaGreen,
      'seashell' => WebColors.seaShell,
      'sienna' => WebColors.sienna,
      'silver' => WebColors.silver,
      'skyblue' => WebColors.skyBlue,
      'slateblue' => WebColors.slateBlue,
      'slategray' => WebColors.slateGray,
      'slategrey' => WebColors.slateGrey,
      'snow' => WebColors.snow,
      'springgreen' => WebColors.springGreen,
      'steelblue' => WebColors.steelBlue,
      'tan' => WebColors.tan,
      'teal' => WebColors.teal,
      'thistle' => WebColors.thistle,
      'tomato' => WebColors.tomato,
      'turquoise' => WebColors.turquoise,
      'violet' => WebColors.violet,
      'wheat' => WebColors.wheat,
      'white' => WebColors.white,
      'whitesmoke' => WebColors.whiteSmoke,
      'yellow' => WebColors.yellow,
      'yellowgreen' => WebColors.yellowGreen,
      String() || null => WebColors.invalid,
    };
  }

  bool get isValid => this != WebColors.invalid;

  bool get isNotValid => !isValid;

  final int colorValue;
}
