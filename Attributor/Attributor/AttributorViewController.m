//
//  ViewController.m
//  Attributor
//
//  Created by iOS Entwickler on 02.03.16.
//  Copyright (c) 2016 noorg. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;

@end

@implementation AttributorViewController


- (IBAction)changeBodySelectionColorToMatchBackgroundColorOfButton:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection {
    
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                           NSStrokeColorAttributeName : [UIColor blackColor]} range:self.body.selectedRange];
}
- (IBAction)unoutlineBodySelection {
    
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)viewDidLoad{
    [super viewDidLoad];
}



@end
