import 'package:chisa/media/media_history_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MediaHistory {
  MediaHistory(
    this.sharedPreferences,
    this.prefsDirectory,
    this.maxItemCount,
  );

  /// A directory name for where this media's history should be stored in
  /// [SharedPreferences].
  late String prefsDirectory;

  /// A maximum number of items to keep in history.
  late int maxItemCount;

  /// An instance of SharedPreferences.
  late SharedPreferences sharedPreferences;

  /// Add the media history item to the latest end of history. If history
  /// is too huge and exceeds [maxItemCount], get rid of the oldest items
  /// first and end up with a list with [maxItemCount] number of elements.
  ///
  /// If a [MediaHistoryItem] with a conflicting key exists, delete the
  /// existing item and push the new item to the latest end of history.
  Future<void> addItem(MediaHistoryItem item);

  /// Remove a given media history item with a given unique identifier.
  /// If the key identifier does not exist, do nothing.
  Future<void> removeItem(String key);

  /// Given a list of [MediaHistoryItem], serialise all with [toJson] and
  /// update the appropriate [prefsDirectory] in [SharedPreferences] with
  /// the serialised list of [MediaHistoryItem] in JSON format.
  void setItems(List<MediaHistoryItem> items);

  /// Get the serialised history in [prefsDirectory] of [SharedPreferences]
  /// and deserialise each [MediaHistoryItem] and return the list.
  List<MediaHistoryItem> getItems();
}
