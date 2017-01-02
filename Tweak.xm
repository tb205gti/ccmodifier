#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <substrate.h>

//disables colors on buttons in ControlCenter
%hook CCUIControlCenterButton

-(id)_effectiveSelectedColor{

	return 0;
}

%end


@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
@property(nonatomic) CGFloat alpha;
@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

//Fjerner Doc'en
%hook SBDockView


-(void)layoutSubviews
{
	%orig;
	SBWallpaperEffectView *backgroundView = MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView");
	backgroundView.hidden = YES;
}

/*	- (void)setBackgroundAlpha:(double)arg1
	{
		%orig;
		MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0;
	}*/
%end


/*%hook CCUIArtraceShortcut

+(BOOL)isSupported:(int)arg1{
	return TRUE;
}
+(BOOL)isInternalButton{

	return FALSE;
}

-(NSURL *)url{

	return [NSURL URLWithString:@"prefs:root=General&path=Network/VPN"];
}

-(void)activateApp{


[[UIApplication sharedApplication] openURL:
       [NSURL URLWithString:@"prefs:root=VPN"]];
}


%end
*/

%hook CCUIPersonalHotspotSetting
+(BOOL)isSupported:(int)arg1{

	return TRUE;
}

+(BOOL)isInternalButton{
	return FALSE;
}

%end

/*%hook CCUIMuteSetting

+(BOOL)isSupported:(int)arg1{

	return TRUE;
}
-(BOOL)isRestricted{
	return FALSE;
}
%end*/


%hook CCUIRecordScreenShortcut

+(BOOL)isSupported:(int)arg1{

	return TRUE;
}

+(BOOL)isInternalButton{
return FALSE;

}

-(BOOL)isRestricted{

	return FALSE;
}

//Tilføjer et ikon til record knappen
/*- (UIImage *)glyphImageForState:(UIControlState)state
{
	return [UIImage imageNamed:@"RecordVideo-OrbHW@2x.png" inBundle:[NSBundle bundleWithPath:@"/Applications/Camera.app/"]];
}*/


%end


%hook CCUICalculatorShortcut

/*
-(void)setDisplayID:(NSString *)arg1 {

	
}*/


-(NSURL *)url{

	return [NSURL URLWithString:@"prefs:root=General&path=Network/VPN"];
}

-(void)activateApp{

/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connect VPN"
                                                message:@"Do you with to connect to your VPN?"
                                               delegate:self
                                      cancelButtonTitle:@"Nope"
                                      otherButtonTitles:@"Yes",nil];
	[alert show];
*/

[[UIApplication sharedApplication] openURL:
       [NSURL URLWithString:@"prefs:root=VPN"]];
}


%end

/*%hook CCUIWiFiSetting

-(void)_setWifiEnabled:(BOOL)arg1 {

	if (arg1 == FALSE){	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connect VPN"
                                                message:@"Do you with to connect to your VPN?"
                                               delegate:self
                                      cancelButtonTitle:@"Nope"
                                      otherButtonTitles:@"Yes",nil];
	[alert show];
	}
	}
	
%end*/


//Hides the signalstrength dots..
%hook UIStatusBarSignalStrengthItemView
	- (id)contentsImage{
		return NULL;
	}
%end

//Hides the CarrierName
%hook UIStatusBarServiceItemView
-(id)_serviceContentsImage{
	return NULL;
}

-(id)contentsImage{
	return NULL;
}
%end

/*
%hook CCUIAirStuffSectionController

	-(void)_airDropTapped:(id)arg1{


	}

%end
*/
%hook SBApplicationInfo

//Fjerner navnet fra ikonerne på Springboard'et
-(NSString *)displayName{
	return @"";

}
%end

%hook SBFolder
-(NSString *)displayName{
	return @"";
}
%end

%hook CCUIControlCenterContainerView
-(double)_contentHeight{
	return 245.0;
}
%end

%hook CCUIControlCenterPushButtonSettings

	-(void)setEnabled:(BOOL)arg1{
		%orig;
		return;
}

%end