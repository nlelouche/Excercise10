//
//  MyUIViewController.m
//  Exercice10
//
//  Created by TPG on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyUIViewController.h"

@implementation MyUIViewController

@synthesize myButton = _myButton;
@synthesize myPicker = _myPicker;
@synthesize myTextField = _myTextField;
@synthesize fileNames;

-(IBAction)saveTextToFile:(id)sender{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%i.txt",
                          [fileNames count]];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/%i.txt",
                              documentsDirectory,
                              [fileNames count]];
    
    [_myTextField.text writeToFile:fullFileName
                            atomically:NO
                              encoding:NSStringEncodingConversionAllowLossy
                                 error:nil];

    [fileNames addObject:fileName];
    [_myPicker reloadAllComponents];
    [_myPicker selectRow:[fileNames count] - 1
              inComponent:0
                 animated:YES];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
(NSInteger)component{
    return [fileNames count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    return [fileNames objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/%@",
                              documentsDirectory,
                              [fileNames objectAtIndex:row]];
    NSString *retrievedString = [NSString stringWithContentsOfFile:fullFileName
                                                      usedEncoding:NO
                                                             error:nil];
    _myTextField.text = retrievedString;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *listOfFiles = [fm contentsOfDirectoryAtPath:documentsDirectory
                                                   error:nil];
    fileNames = [[NSMutableArray alloc] initWithArray:listOfFiles];
    
    if([fileNames count] > 0){
        NSString *fullFileName = [NSString stringWithFormat:@"%@/%@",
                                  documentsDirectory,
                                  [fileNames objectAtIndex:0]];
        NSString *retrievedString = [NSString stringWithContentsOfFile:fullFileName
                                                          usedEncoding:NO
                                                                 error:nil];
        _myTextField.text = retrievedString;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [fileNames release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
