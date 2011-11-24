//
//  PBPlayer.m
//  PlayBar
//
//  Created by Ryan Petrich on 11-11-23.
//  Copyright (c) 2011 Ryan Petrich. All rights reserved.
//

#import "PBPlayer.h"

@interface PBPlayer ()
- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier;
@end

@implementation PBPlayer

+ (id)playerWithBundleIdentifier:(NSString *)bundleIdentifier
{
    return [[[self alloc] initWithBundleIdentifier:bundleIdentifier] autorelease];
}

- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier
{
    if ((self = [super init])) {
        _bundleIdentifier = [bundleIdentifier copy];
    }
    return self;
}

- (void)dealloc
{
    [_bundleIdentifier release];
    [_runningApplication release];
    [_titleScript release];
    [super dealloc];
}

- (NSString *)currentTitle
{
    if (_runningApplication.terminated) {
        [_runningApplication release];
        _runningApplication = nil;
    }
    if (!_runningApplication) {
        _runningApplication = [[[NSRunningApplication runningApplicationsWithBundleIdentifier:_bundleIdentifier] lastObject] retain];
    }
    if (_runningApplication) {
        if (!_titleScript) {
            NSString *name = [_runningApplication localizedName];
            NSString *script = [NSString stringWithFormat:@"tell application \"%@\" to return artist of current track & \" - \" & name of current track", name];
            _titleScript = [[NSAppleScript alloc] initWithSource:script];
            [_titleScript compileAndReturnError:NULL];
        }
        return [[_titleScript executeAndReturnError:NULL] stringValue];
    } else {
        return nil;
    }
}

@end
