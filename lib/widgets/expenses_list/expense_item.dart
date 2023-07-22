import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

/// ExpenseItem is a [Widget] used to display an [Expense]
///
/// Example:
/// ```dart
/// ExpenseItem(expense)
/// ```
class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('€${expense.amount.toStringAsFixed(2)}'),
                // [Spacer] takes up all the space it can get
                const Spacer(),
                // we put a [Row] inside a [Row] because the former should be
                // pushed all the way to the right
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
