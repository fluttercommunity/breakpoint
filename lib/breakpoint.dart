library breakpoint;

import 'package:flutter/material.dart';

class Breakpoint {
  /// xsmall, small, medium, large, xlarge
  final WindowSize window;

  /// smallHandset, mediumHandset, largeHandset, smallTablet, largeTablet, deskto
  final LayoutClass device;

  /// Number of columns for content
  final int columns;

  /// Spacing between columns
  final double gutters;

  /// Following Material Design Guidlines [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  const Breakpoint({
    required this.columns,
    required this.device,
    required this.gutters,
    required this.window,
  });

  /// Following Material Design Guidlines [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  ///
  /// Use a layout builder to get [BoxConstraints]
  factory Breakpoint.fromConstraints(BoxConstraints constraints) {
    double _width = 359;

    Orientation orientation = Orientation.portrait;

    if (constraints.debugAssertIsValid()) {
      _width = constraints.normalize().maxWidth;
      orientation = constraints.maxHeight > constraints.maxWidth
          ? Orientation.portrait
          : Orientation.landscape;
    }

    return _calcBreakpoint(orientation, _width);
  }

  /// Following Material Design Guidlines [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  ///
  /// Uses [BuildContext] and [MediaQuery] to calculate the device breakpoint
  ///
  /// Use [Breakpoint.fromConstraints] when the widget does not take up the full screen
  factory Breakpoint.fromMediaQuery(BuildContext context) {
    final _media = MediaQuery.of(context);

    double _width = 359;

    Orientation orientation = Orientation.portrait;

    _width = _media.size.width;
    orientation = _media.orientation;

    return _calcBreakpoint(orientation, _width);
  }

  static Breakpoint _calcBreakpoint(Orientation orientation, double _width) {
    if (orientation == Orientation.landscape) {
      // ignore: parameter_assignments
      _width += 120;
    }

    if (_width >= 1920) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.desktop,
        window: WindowSize.xlarge,
      );
    }
    if (_width >= 1600) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.desktop,
        window: WindowSize.large,
      );
    }
    if (_width >= 1440) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.desktop,
        window: WindowSize.large,
      );
    }
    if (_width >= 1280) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.desktop,
        window: WindowSize.medium,
      );
    }
    if (_width >= 1024) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.desktop,
        window: WindowSize.medium,
      );
    }
    if (_width >= 960) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.largeTablet,
        window: WindowSize.small,
      );
    }
    if (_width >= 840) {
      return const Breakpoint(
        columns: 12,
        gutters: 24,
        device: LayoutClass.largeTablet,
        window: WindowSize.small,
      );
    }
    if (_width >= 720) {
      return const Breakpoint(
        columns: 8,
        gutters: 24,
        device: LayoutClass.largeTablet,
        window: WindowSize.small,
      );
    }
    if (_width >= 600) {
      return const Breakpoint(
        columns: 8,
        gutters: 16,
        device: LayoutClass.smallTablet,
        window: WindowSize.small,
      );
    }
    if (_width >= 480) {
      return const Breakpoint(
        columns: 4,
        gutters: 16,
        device: LayoutClass.largeHandset,
        window: WindowSize.xsmall,
      );
    }
    if (_width >= 400) {
      return const Breakpoint(
        columns: 4,
        gutters: 16,
        device: LayoutClass.largeHandset,
        window: WindowSize.xsmall,
      );
    }
    if (_width >= 360) {
      return const Breakpoint(
        columns: 4,
        gutters: 16,
        device: LayoutClass.mediumHandset,
        window: WindowSize.xsmall,
      );
    }
    return const Breakpoint(
      columns: 4,
      gutters: 16,
      device: LayoutClass.smallHandset,
      window: WindowSize.xsmall,
    );
  }

  @override
  String toString() {
    return '$window';
  }
}

class BreakpointBuilder extends StatelessWidget {
  /// Wraps layout builder and returns a breakpoint
  BreakpointBuilder({
    this.context,
    required this.builder,
  });
  final Widget Function(BuildContext, Breakpoint) builder;
  final BuildContext? context;
  @override
  Widget build(BuildContext root) {
    final _context = context ?? root;
    return LayoutBuilder(
      builder: (_context, constraints) {
        return builder(_context, Breakpoint.fromConstraints(constraints));
      },
    );
  }
}

enum WindowSize {
  xsmall,
  small,
  medium,
  large,
  xlarge,
}

enum LayoutClass {
  smallHandset,
  mediumHandset,
  largeHandset,
  smallTablet,
  largeTablet,
  desktop,
}

extension WindowSizeOperators on WindowSize {
  int get value => WindowSize.values.indexOf(this);

  /// Whether this [WindowSize] is larger than [other].
  bool operator >(WindowSize other) => value > other.value;

  /// Whether this [WindowSize] is larger than or equal to [other].
  bool operator >=(WindowSize other) => value >= other.value;

  /// Whether this [WindowSize] is smaller than [other].
  bool operator <(WindowSize other) => value < other.value;

  /// Whether this [WindowSize] is smaller than or equal to [other].
  bool operator <=(WindowSize other) => value <= other.value;
}

extension LayoutClassOperators on LayoutClass {
  int get value => LayoutClass.values.indexOf(this);

  /// Whether this [LayoutClass] is larger than [other].
  bool operator >(LayoutClass other) => value > other.value;

  /// Whether this [LayoutClass] is larger than or equal to [other].
  bool operator >=(LayoutClass other) => value >= other.value;

  /// Whether this [LayoutClass] is smaller than [other].
  bool operator <(LayoutClass other) => value < other.value;

  /// Whether this [WindowSize] is smaller than or equal to [other].
  bool operator <=(LayoutClass other) => value <= other.value;
}
