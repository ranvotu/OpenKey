#import <Cocoa/Cocoa.h>
#import <iostream>
#import <cassert>

BOOL isTerminalApp(NSString* topApp) {
    if (!topApp || topApp.length == 0) return NO;
    static NSSet *terminalApps = nil;
    if (!terminalApps) {
        terminalApps = [[NSSet alloc] initWithArray:@[
            @"com.apple.Terminal",
            @"com.googlecode.iterm2",
            @"net.kovidgoyal.kitty",
            @"alacritty",
            @"io.alacritty",
            @"dev.warp.Warp-Stable",
            @"com.mitchellh.ghostty",
            @"com.github.wez.wezterm",
            @"co.zeit.hyper"
        ]];
    }
    if ([terminalApps containsObject:topApp]) return YES;
    NSString *lower = [topApp lowercaseString];
    if ([lower containsString:@"terminal"] || [lower containsString:@"iterm"] || [lower containsString:@"ghostty"] || [lower containsString:@"alacritty"] || [lower containsString:@"warp"]) {
        return YES;
    }
    return NO;
}

BOOL isBrowserApp(NSString* topApp) {
    if (!topApp || topApp.length == 0) return NO;
    static NSSet *browserApps = nil;
    if (!browserApps) {
        browserApps = [[NSSet alloc] initWithArray:@[
            @"com.google.Chrome",
            @"com.google.Chrome.canary",
            @"com.apple.Safari",
            @"com.apple.SafariTechnologyPreview",
            @"com.brave.Browser",
            @"com.microsoft.edgemac",
            @"com.microsoft.edgemac.Dev",
            @"com.microsoft.edgemac.Beta",
            @"com.microsoft.Edge",
            @"org.mozilla.firefox",
            @"com.operasoftware.Opera",
            @"com.vivaldi.Vivaldi",
            @"company.thebrowser.Browser"
        ]];
    }
    if ([browserApps containsObject:topApp]) return YES;
    NSString *lower = [topApp lowercaseString];
    return [lower containsString:@"chrome"] || [lower containsString:@"browser"] || [lower containsString:@"safari"] || [lower containsString:@"firefox"];
}

int main() {
    // Test terminal detection
    assert(isTerminalApp(@"com.apple.Terminal") == YES);
    assert(isTerminalApp(@"com.googlecode.iterm2") == YES);
    assert(isTerminalApp(@"com.mitchellh.ghostty") == YES);
    assert(isTerminalApp(@"io.alacritty") == YES);
    assert(isTerminalApp(@"dev.warp.Warp-Stable") == YES);
    assert(isTerminalApp(@"com.google.Chrome") == NO);
    assert(isTerminalApp(@"md.obsidian") == NO);

    // Test browser detection
    assert(isBrowserApp(@"com.google.Chrome") == YES);
    assert(isBrowserApp(@"com.apple.Safari") == YES);
    assert(isBrowserApp(@"company.thebrowser.Browser") == YES);
    assert(isBrowserApp(@"com.apple.Terminal") == NO);
    assert(isBrowserApp(@"com.googlecode.iterm2") == NO);

    std::cout << "All Terminal and Browser detection assertions PASSED!" << std::endl;
    return 0;
}
