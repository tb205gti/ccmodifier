//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#include <substrate.h>


@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
	@property(nonatomic) CGFloat alpha;
	@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

@interface SBAlertView : UIView {

	//SBAlert* _alert;
	unsigned _shouldAnimateIn : 1;

}
@end


@interface _UIActionSlider : UIControl
	-(void)setTrackText:(NSString *)arg1 ;
@end

@interface SBPowerDownView : SBAlertView
@end

%hook SBPowerDownController


	-(void)activate{
		SBPowerDownView *powerDownView = MSHookIvar<SBPowerDownView *>(self, "_powerDownView"); // Than
		_UIActionSlider *actionSlider = MSHookIvar<_UIActionSlider *>(powerDownView, "_actionSlider");
		[actionSlider setTrackText:@"Are you sure?"];

		%orig;
	}
%end


/****************************
	   Dock modifiers
****************************/

//Fjerner Doc'en
%hook SBDockView
	-(void)layoutSubviews
	{
		%orig;
		SBWallpaperEffectView *backgroundView = MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView");
		backgroundView.hidden = YES;
	}


	//Sætter Alpha på dock'en - hvis man vil beholde den.
	/*	- (void)setBackgroundAlpha:(double)arg1
	{
		%orig;
		MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0;
	}*/
%end


/****************************
	CCSetings modifiers
****************************/




%hook CCUIControlCenterContainerView


//-(void)layoutSubviews{
//CCUIControlCenterSettings *backgroundView = MSHookIvar<CCUIControlCenterSettings *>(self, "_settings");
//}

/*-(void)controlCenterWillPresent{
	UIView *backgroundView = MSHookIvar<UIView *>(self, "_darkeningContainer");
	UIColor *color = [UIColor colorWithRed:128.0/255.0 
                        green:128.0/255.0 
                         blue:128.0/255.0 
                        alpha:0.5];

	backgroundView.backgroundColor = color;


}
*/

/*-(void)setRevealPercentage:(double)arg1{

	%orig(100.0);
}*/

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


//disables colors on buttons in ControlCenter
%hook CCUIControlCenterButton

	-(id)_effectiveSelectedColor{
		return 0;
	}

%end


%hook CCUIPersonalHotspotSetting
+(BOOL)isSupported:(int)arg1{

	return TRUE;
}

+(BOOL)isInternalButton{
	return FALSE;
}

%end


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

	-(NSURL *)url{
		return [NSURL URLWithString:@"prefs:root=General&path=Network/VPN"];
	}

	-(void)activateApp{
		[[UIApplication sharedApplication] openURL:
       	[NSURL URLWithString:@"prefs:root=VPN"]];
	}
%end


/*%
hook CCUIMuteSetting

	+(BOOL)isSupported:(int)arg1{
		return TRUE;
	}
	-(BOOL)isRestricted{
		return FALSE;
	}
%end


%hook CCUIAirStuffSectionController
	-(void)_airDropTapped:(id)arg1{
	}
%end

%hook CCUIArtraceShortcut
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

/****************************
	Carrier modifiers
****************************/


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


/****************************
	SpringBoard modifiers
****************************/

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

//Fjerner folder background'en
%hook SBFolderBackgroundView
-(id)_tintViewBackgroundColorAtFullAlpha{

	return NULL;

}

%end