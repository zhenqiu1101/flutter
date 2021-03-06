// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_tools/src/base/utils.dart';
import 'package:test/test.dart';

void main() {
  group('ItemListNotifier', () {
    test('sends notifications', () async {
      ItemListNotifier<String> list = new ItemListNotifier<String>();
      expect(list.items, isEmpty);

      Future<List<String>> addedStreamItems = list.onAdded.toList();
      Future<List<String>> removedStreamItems = list.onRemoved.toList();

      list.updateWithNewList(<String>['aaa']);
      list.updateWithNewList(<String>['aaa', 'bbb']);
      list.updateWithNewList(<String>['bbb']);
      list.dispose();

      List<String> addedItems = await addedStreamItems;
      List<String> removedItems = await removedStreamItems;

      expect(addedItems.length, 2);
      expect(addedItems.first, 'aaa');
      expect(addedItems[1], 'bbb');

      expect(removedItems.length, 1);
      expect(removedItems.first, 'aaa');
    });
  });
}
