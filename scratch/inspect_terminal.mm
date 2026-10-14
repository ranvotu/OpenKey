#import <Cocoa/Cocoa.h>
#import <ApplicationServices/ApplicationServices.h>

int main() {
    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        if ([app.bundleIdentifier.lowercaseString containsString:@"terminal"] ||
            [app.bundleIdentifier.lowercaseString containsString:@"iterm"]) {
            NSLog(@"Terminal app: %@, pid=%d", app.bundleIdentifier, app.processIdentifier);
            AXUIElementRef appElem = AXUIElementCreateApplication(app.processIdentifier);
            AXUIElementRef focused = NULL;
            AXError err = AXUIElementCopyAttributeValue(appElem, kAXFocusedUIElementAttribute, (CFTypeRef*)&focused);
            NSLog(@"Focused err: %d, focused: %@", err, focused);
            if (focused) {
                CFTypeRef role = NULL;
                AXUIElementCopyAttributeValue(focused, kAXRoleAttribute, &role);
                NSLog(@"Role: %@", role);
                if (role) CFRelease(role);
                
                AXValueRef rangeVal = NULL;
                err = AXUIElementCopyAttributeValue(focused, kAXSelectedTextRangeAttribute, (CFTypeRef*)&rangeVal);
                NSLog(@"SelectedTextRange err: %d", err);
                if (rangeVal) CFRelease(rangeVal);
                
                CFRelease(focused);
            }
            CFRelease(appElem);
        }
    }
    return 0;
}
