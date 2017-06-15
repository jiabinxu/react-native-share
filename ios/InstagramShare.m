//
//  InstagramShare.m
//  RNShare
//
//  Created by 徐佳斌 on 2017/5/11.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "InstagramShare.h"

@implementation InstagramShare
- (void)shareSingle:(NSDictionary *)options
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {
    
    
    NSLog(@"Try open view");
    
    if ([options objectForKey:@"message"] && [options objectForKey:@"message"] != [NSNull null]) {
        NSString *text = [RCTConvert NSString:options[@"message"]];
        NSURL *assetsURL = [RCTConvert NSURL:options[@"assetsURL"]];
        
        
        NSString *escapedString   = [assetsURL.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]; // urlencodedString
        NSString *escapedCaption  = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]; // urlencodedString
        NSURL *instagramURL       = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@&InstagramCaption=%@", escapedString, escapedCaption]];
        
        if ([[UIApplication sharedApplication] canOpenURL: instagramURL]) {
            [[UIApplication sharedApplication] openURL: instagramURL];
            successCallback(@[]);
        } else {
            // Cannot open whatsapp
            NSString *stringURL = @"http://itunes.apple.com/en/app/whatsapp-messenger/id310633997";
            NSURL *url = [NSURL URLWithString:stringURL];
            [[UIApplication sharedApplication] openURL:url];
            
            NSString *errorMessage = @"Not installed";
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
            NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];
            
            NSLog(errorMessage);
            failureCallback(error);
        }
    }
    
    
}

@end
