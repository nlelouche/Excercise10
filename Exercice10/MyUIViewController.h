//
//  MyUIViewController.h
//  Exercice10
//
//  Created by TPG on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyUIViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, retain) IBOutlet UIButton *myButton;
@property (nonatomic, retain) IBOutlet UIPickerView *myPicker;
@property (nonatomic, retain) IBOutlet UITextField *myTextField;

-(IBAction)saveTextToFile:(id)sender;

@end
