import 'package:flutter/material.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '.././models/setting_model.dart';
import '.././services/settings_service.dart';

class spRegForm extends StatefulWidget {
  final Setting settings = Get.find<SettingsService>().setting.value;

  State<spRegForm> createState() => _spRegFormState();
}

class _spRegFormState extends State<spRegForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedRole = 'Freelancers';
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _IdNoCtrl = TextEditingController();
  bool agree = false;
  bool isBusiness = false;
  bool isCategoryNotAvailable = false;
  bool isServicetoProvideNotAvailable = false;
  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Select your role',
        subtitle: 'Choose a role that better defines you',
        content: Container(
          child: Row(
            children: <Widget>[
              _buildSelector(
                context: context,
                name: 'Freelancers',
              ),
              SizedBox(width: 5.0),
              _buildSelector(
                context: context,
                name: 'Business',
              ),
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Personal Information',
        subtitle: 'Please fill some of the personal information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: (isBusiness) ? 'Owner Name' : 'Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    controller: _nameCtrl,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email address is required';
                    }
                    return null;
                  },
                  controller: _emailCtrl,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ID Number is required';
                        }
                        return null;
                      },
                      controller: _IdNoCtrl)),
              if (isBusiness)
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Company Name',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Company Name is required';
                        }
                        return null;
                      },
                    )),
              if (isBusiness)
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Commercial Registration Number',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Commercial Registration Number is required';
                        }
                        return null;
                      },
                    )),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: "OTP Verification",
        subtitle:
            "OTP sent to mobile number for verification and code needs to be entered in order to proceed to next step/page.",
        content: OTPTextField(
          length: 5,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 40,
          style: TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            print("Completed: " + pin);
          },
        ),
        validation: () {},
      ),
      CoolStep(
          title: 'Service Information',
          subtitle: 'Add information about your services',
          content: Column(
            children: [
              DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: [
                  "Cleaning Services",
                  "Furniture & Decor",
                  "Maintainence Services",
                  'Other'
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Service Category",
                  hintText: "Select Category of Your Service",
                ),
                //popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (print) {
                  if (print == 'Other') {
                    setState(() {
                      this.isCategoryNotAvailable = true;
                    });
                  } else {
                    setState(() {
                      this.isCategoryNotAvailable = false;
                    });
                  }
                },
                selectedItem: "Cleaning Services",
              ),
              if (isCategoryNotAvailable)
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Your Service Category',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Service Category is required';
                        }
                        return null;
                      },
                    )),
              DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: [
                  "Cleaning Services",
                  "Furniture & Decor",
                  "Maintainence Services",
                  'Other'
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Service to provide",
                  hintText: "Select service to provide",
                ),
                //popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (print) {
                  if (print == 'Other') {
                    setState(() {
                      this.isServicetoProvideNotAvailable = true;
                    });
                  } else {
                    setState(() {
                      this.isServicetoProvideNotAvailable = false;
                    });
                  }
                },
                selectedItem: "Furniture & Decor",
              ),
              if (isServicetoProvideNotAvailable)
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Service to Provide',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Service to provide is required';
                        }
                        return null;
                      },
                    )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Service Price',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Price is required';
                      }
                      return null;
                    },
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Upload Previous Work',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          validation: () {}),
      CoolStep(
        title: 'Bank Account Details',
        subtitle: 'Please fill some of the bank account details',
        content: Form(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Bank Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bank Name is required';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: (isBusiness)
                        ? 'Company Account Name'
                        : 'Account Holder Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return (isBusiness)
                          ? 'Company Account Name is required'
                          : 'Account Holder Name is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: (isBusiness)
                          ? 'Company Bank Account Number'
                          : 'Bank Account Number',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return (isBusiness)
                            ? 'Company Bank Account Number is required'
                            : 'Bank Account Number is required';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'IBAN',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'IBAN is required';
                      }
                      return null;
                    },
                  ))
            ],
          ),
        ),
        validation: () {},
      ),
      CoolStep(
          title: "Upload Documents",
          subtitle: "Final Step, Upload your documents.",
          content: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    child: Text("ID Document",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  child: Text("Stamped Personal Bank Account",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                ),
                if (isBusiness)
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                      child: Text("Commercial Registeration",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                  ),
                Row(
                  children: [
                    Material(
                      child: Checkbox(
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Text('I have read and accept terms and conditions',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 10))
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Get.theme.colorScheme.secondary)),
                    onPressed: agree ? () {} : null,
                    child: const Text('Submit'))
              ],
            ),
          ),
          validation: () {}),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        print('Steps completed!');
      },
      steps: steps,
      config: CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Service Provider Registration",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: stepper,
      ),
    );
  }

  Widget _buildSelector({
    BuildContext context,
    String name,
  }) {
    final isActive = name == selectedRole;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.orange,
          groupValue: selectedRole,
          onChanged: (String v) {
            setState(() {
              selectedRole = v;
              if (selectedRole == 'Business') {
                isBusiness = true;
              } else {
                isBusiness = false;
              }
            });
          },
          title: Text(
            name,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
