//
//  PBAppDelegate.h
//  PlayBar
//
//  Created by Ryan Petrich on 11-11-23.
//  Copyright (c) 2011 Ryan Petrich. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PBAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSStatusItem *statusItem;
    NSArray *players;
}

@end
