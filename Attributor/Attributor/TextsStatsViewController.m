//
//  TextsStatsViewController.m
//  Attributor
//
//  Created by iOS Entwickler on 04.03.16.
//  Copyright (c) 2016 noorg. All rights reserved.
//

#import "TextsStatsViewController.h"

@interface TextsStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharsLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharsLabel;

@end

@implementation TextsStatsViewController


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self updateUI];
}




- (void)updateUI {

    int colorfulCharsCount = [[self charsWithAttribute:NSForegroundColorAttributeName] length];
    self.colorfulCharsLabel.text = [NSString stringWithFormat:@"%d colorful chars", colorfulCharsCount];

    int outlinedCharsCount = [[self charsWithAttribute:NSStrokeColorAttributeName] length];
    self.outlinedCharsLabel.text = [NSString stringWithFormat:@"%d outlined chars", outlinedCharsCount];

}


- (NSAttributedString *) charsWithAttribute:(NSString *) attributeName{


    NSMutableAttributedString *chars = [[NSMutableAttributedString alloc] init];

    int index = 0;
    while(index < [self.textToAnalyze length]){
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value){
            [chars appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    return chars;
}




- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze{

    _textToAnalyze = textToAnalyze;
    // update UI only if this setter is called AND this view is active/ visible
    if(self.view.window)[self updateUI];
}

@end
