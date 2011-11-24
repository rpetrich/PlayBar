//
//  PBAppDelegate.m
//  PlayBar
//
//  Created by Ryan Petrich on 11-11-23.
//  Copyright (c) 2011 Ryan Petrich. All rights reserved.
//

#import "PBAppDelegate.h"

#import "PBPlayer.h"
#import <ApplicationServices/ApplicationServices.h>

@interface PBAppDelegate ()
@property (retain) NSStatusItem *statusItem;
@end

@implementation PBAppDelegate

@synthesize statusItem;

- (void)updateTitle
{
    for (PBPlayer *player in players) {
        NSString *currentTitle = player.currentTitle;
        if ([currentTitle length]) {
            statusItem.title = currentTitle;
            return;
        }
    }
    statusItem.title = @"(not running)";
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    players = [[NSArray alloc] initWithObjects:
               [PBPlayer playerWithBundleIdentifier:@"com.spotify.client"], 
               [PBPlayer playerWithBundleIdentifier:@"com.apple.iTunes"],
               nil];
    [self updateTitle];
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTitle) userInfo:nil repeats:YES] forMode:NSRunLoopCommonModes]; 
}

@end
