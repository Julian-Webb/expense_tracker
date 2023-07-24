import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense) _onAddExpense;
  const NewExpense(this._onAddExpense, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // Object for handling user input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    // this returns a Future
    // this means you don't have the value yet (you will only have it after the
    // user finishes inputting the date and this will take a while). The Future
    // is returned immediately but you don't have the value yet.
    // showDatePicker(
    //         context: context,
    //         initialDate: now,
    //         firstDate: firstDate,
    //         lastDate: lastDate)
    //     .then((value) {
    //   date = value;
    // });

    // await makes this code wait until we get the input (?)
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    // convert input String to double
    final enteredAmount = double.tryParse(_amountController.text);
    // amount is invalid if the input isn't a number, it's emtpy or <0
    final amountIsInvalid = (enteredAmount == null) || (enteredAmount <= 0);
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date, and category were entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    // If the input is fine, we want to add the new expense to expenses,
    // i.e. append to [List<Expense> _registeredExpenses].
    widget._onAddExpense(Expense(
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    // close the overlay
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // we need to delete the controller when we don't need it anymore, otherwise
    // it won't be deleted
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // function for saving entered title
  // String _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  // [Row] with title and amount
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '€ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  // just title field
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                if (width >= 600)
                  // [Row] with category and date picker
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                // the values is what is stored internally
                                value: category,
                                // the child is what is displayed to the user
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(width: 24),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              Theme.of(context).textTheme.titleLarge!.color),
                        ),
                        onPressed: _presentDatePicker,
                        child: Row(
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Please select date'
                                  : formatter.format(_selectedDate!),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.calendar_month,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  // [Row] with amount and date picker
                  Row(
                    children: [
                      // Amount Field
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '€ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      // Date Picker
                      const Spacer(),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              Theme.of(context).textTheme.titleLarge!.color),
                        ),
                        onPressed: _presentDatePicker,
                        child: Row(
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Please select date'
                                  : formatter.format(_selectedDate!),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.calendar_month,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width > 600)
                  // [Row] with just cancel and save expense buttons
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // this closes the overlay
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  // [Row] with category, cancel, and save expense buttons
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                // the values is what is stored internally
                                value: category,
                                // the child is what is displayed to the user
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // this closes the overlay
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
