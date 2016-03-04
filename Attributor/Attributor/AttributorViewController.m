//
//  ViewController.m
//  Attributor
//
//  Created by iOS Entwickler on 02.03.16.
//  Copyright (c) 2016 noorg. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextsStatsViewController.h";

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    NSRange aRange = NSMakeRange(0, [title length]);
    title = [self outlineString:title forRange:aRange];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"Analyze Text"]){
        if([segue.destinationViewController isKindOfClass:[TextsStatsViewController class]]){
            TextsStatsViewController *tsvc = (TextsStatsViewController *) segue.destinationViewController;
            tsvc.textToAnalyze = self.body.textStorage;
        }
        
    }
    
}




-(void)preferredFontsChanged:(NSNotification *)notification{
    [self usePreferredFonts];
}

- (void)usePreferredFonts{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (NSMutableAttributedString *)outlineString:(NSMutableAttributedString *)string forRange:(NSRange)aRange{
    [string addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                  NSStrokeColorAttributeName : [UIColor blackColor]} range:aRange];
    return string;

}


- (IBAction)changeBodySelectionColorToMatchBackgroundColorOfButton:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection {
    [self outlineString:self.body.textStorage forRange:self.body.selectedRange];
}


- (IBAction)unoutlineBodySelection {
    
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

@end
