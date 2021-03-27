Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D617934B875
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC0RXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:23:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:50425 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhC0RXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:23:39 -0400
IronPort-SDR: 2SzBomrb4Ck+bypAxSgtykV83sEGhzHJynY1ZgrrFfvmzyWgPwFHOY5srwGrh423Y3ZXUILtux
 XbgnihxDgwuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252670216"
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="gz'50?scan'50,208,50";a="252670216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 10:23:39 -0700
IronPort-SDR: ZNfLf97vXTIIff8KZgXk3fOFIwJVAWeHHAyx57Cb2YZDDUaKzQmR0MpAlFEh7/l3Ja4z8F655A
 n9y0P2xE5xCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="gz'50?scan'50,208,50";a="515443155"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2021 10:23:36 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQCet-0003c4-PR; Sat, 27 Mar 2021 17:23:35 +0000
Date:   Sun, 28 Mar 2021 01:22:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Chen <johnchen902@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rohit Pidaparthi <rohitpid@gmail.com>,
        RicardoEPRodrigues <ricardo.e.p.rodrigues@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Chen <johnchen902@gmail.com>
Subject: Re: [PATCH 4/4] HID: input: map battery capacity (00850065)
Message-ID: <202103280129.S0u1EEyy-lkp@intel.com>
References: <20210327130508.24849-5-johnchen902@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20210327130508.24849-5-johnchen902@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linux/master linus/master v5.12-rc4 next-20210326]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/John-Chen/HID-add-Apple-Magic-Mouse-2-support/20210327-211004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: x86_64-kexec (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/00e05cc61c9d267c5857d61fd40638d560460f89
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review John-Chen/HID-add-Apple-Magic-Mouse-2-support/20210327-211004
        git checkout 00e05cc61c9d267c5857d61fd40638d560460f89
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hid/hid-input.c: In function 'hidinput_configure_usage':
>> drivers/hid/hid-input.c:1082:10: error: 'struct hid_device' has no member named 'battery_min'
    1082 |    device->battery_min = 0;
         |          ^~
>> drivers/hid/hid-input.c:1083:10: error: 'struct hid_device' has no member named 'battery_max'
    1083 |    device->battery_max = 100;
         |          ^~


vim +1082 drivers/hid/hid-input.c

   568	
   569	static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
   570					     struct hid_usage *usage)
   571	{
   572		struct input_dev *input = hidinput->input;
   573		struct hid_device *device = input_get_drvdata(input);
   574		int max = 0, code;
   575		unsigned long *bit = NULL;
   576	
   577		field->hidinput = hidinput;
   578	
   579		if (field->flags & HID_MAIN_ITEM_CONSTANT)
   580			goto ignore;
   581	
   582		/* Ignore if report count is out of bounds. */
   583		if (field->report_count < 1)
   584			goto ignore;
   585	
   586		/* only LED usages are supported in output fields */
   587		if (field->report_type == HID_OUTPUT_REPORT &&
   588				(usage->hid & HID_USAGE_PAGE) != HID_UP_LED) {
   589			goto ignore;
   590		}
   591	
   592		if (device->driver->input_mapping) {
   593			int ret = device->driver->input_mapping(device, hidinput, field,
   594					usage, &bit, &max);
   595			if (ret > 0)
   596				goto mapped;
   597			if (ret < 0)
   598				goto ignore;
   599		}
   600	
   601		switch (usage->hid & HID_USAGE_PAGE) {
   602		case HID_UP_UNDEFINED:
   603			goto ignore;
   604	
   605		case HID_UP_KEYBOARD:
   606			set_bit(EV_REP, input->evbit);
   607	
   608			if ((usage->hid & HID_USAGE) < 256) {
   609				if (!hid_keyboard[usage->hid & HID_USAGE]) goto ignore;
   610				map_key_clear(hid_keyboard[usage->hid & HID_USAGE]);
   611			} else
   612				map_key(KEY_UNKNOWN);
   613	
   614			break;
   615	
   616		case HID_UP_BUTTON:
   617			code = ((usage->hid - 1) & HID_USAGE);
   618	
   619			switch (field->application) {
   620			case HID_GD_MOUSE:
   621			case HID_GD_POINTER:  code += BTN_MOUSE; break;
   622			case HID_GD_JOYSTICK:
   623					if (code <= 0xf)
   624						code += BTN_JOYSTICK;
   625					else
   626						code += BTN_TRIGGER_HAPPY - 0x10;
   627					break;
   628			case HID_GD_GAMEPAD:
   629					if (code <= 0xf)
   630						code += BTN_GAMEPAD;
   631					else
   632						code += BTN_TRIGGER_HAPPY - 0x10;
   633					break;
   634			default:
   635				switch (field->physical) {
   636				case HID_GD_MOUSE:
   637				case HID_GD_POINTER:  code += BTN_MOUSE; break;
   638				case HID_GD_JOYSTICK: code += BTN_JOYSTICK; break;
   639				case HID_GD_GAMEPAD:  code += BTN_GAMEPAD; break;
   640				default:              code += BTN_MISC;
   641				}
   642			}
   643	
   644			map_key(code);
   645			break;
   646	
   647		case HID_UP_SIMULATION:
   648			switch (usage->hid & 0xffff) {
   649			case 0xba: map_abs(ABS_RUDDER);   break;
   650			case 0xbb: map_abs(ABS_THROTTLE); break;
   651			case 0xc4: map_abs(ABS_GAS);      break;
   652			case 0xc5: map_abs(ABS_BRAKE);    break;
   653			case 0xc8: map_abs(ABS_WHEEL);    break;
   654			default:   goto ignore;
   655			}
   656			break;
   657	
   658		case HID_UP_GENDESK:
   659			if ((usage->hid & 0xf0) == 0x80) {	/* SystemControl */
   660				switch (usage->hid & 0xf) {
   661				case 0x1: map_key_clear(KEY_POWER);  break;
   662				case 0x2: map_key_clear(KEY_SLEEP);  break;
   663				case 0x3: map_key_clear(KEY_WAKEUP); break;
   664				case 0x4: map_key_clear(KEY_CONTEXT_MENU); break;
   665				case 0x5: map_key_clear(KEY_MENU); break;
   666				case 0x6: map_key_clear(KEY_PROG1); break;
   667				case 0x7: map_key_clear(KEY_HELP); break;
   668				case 0x8: map_key_clear(KEY_EXIT); break;
   669				case 0x9: map_key_clear(KEY_SELECT); break;
   670				case 0xa: map_key_clear(KEY_RIGHT); break;
   671				case 0xb: map_key_clear(KEY_LEFT); break;
   672				case 0xc: map_key_clear(KEY_UP); break;
   673				case 0xd: map_key_clear(KEY_DOWN); break;
   674				case 0xe: map_key_clear(KEY_POWER2); break;
   675				case 0xf: map_key_clear(KEY_RESTART); break;
   676				default: goto unknown;
   677				}
   678				break;
   679			}
   680	
   681			if ((usage->hid & 0xf0) == 0xb0) {	/* SC - Display */
   682				switch (usage->hid & 0xf) {
   683				case 0x05: map_key_clear(KEY_SWITCHVIDEOMODE); break;
   684				default: goto ignore;
   685				}
   686				break;
   687			}
   688	
   689			/*
   690			 * Some lazy vendors declare 255 usages for System Control,
   691			 * leading to the creation of ABS_X|Y axis and too many others.
   692			 * It wouldn't be a problem if joydev doesn't consider the
   693			 * device as a joystick then.
   694			 */
   695			if (field->application == HID_GD_SYSTEM_CONTROL)
   696				goto ignore;
   697	
   698			if ((usage->hid & 0xf0) == 0x90) {	/* D-pad */
   699				switch (usage->hid) {
   700				case HID_GD_UP:	   usage->hat_dir = 1; break;
   701				case HID_GD_DOWN:  usage->hat_dir = 5; break;
   702				case HID_GD_RIGHT: usage->hat_dir = 3; break;
   703				case HID_GD_LEFT:  usage->hat_dir = 7; break;
   704				default: goto unknown;
   705				}
   706				if (field->dpad) {
   707					map_abs(field->dpad);
   708					goto ignore;
   709				}
   710				map_abs(ABS_HAT0X);
   711				break;
   712			}
   713	
   714			switch (usage->hid) {
   715			/* These usage IDs map directly to the usage codes. */
   716			case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
   717			case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
   718				if (field->flags & HID_MAIN_ITEM_RELATIVE)
   719					map_rel(usage->hid & 0xf);
   720				else
   721					map_abs_clear(usage->hid & 0xf);
   722				break;
   723	
   724			case HID_GD_WHEEL:
   725				if (field->flags & HID_MAIN_ITEM_RELATIVE) {
   726					set_bit(REL_WHEEL, input->relbit);
   727					map_rel(REL_WHEEL_HI_RES);
   728				} else {
   729					map_abs(usage->hid & 0xf);
   730				}
   731				break;
   732			case HID_GD_SLIDER: case HID_GD_DIAL:
   733				if (field->flags & HID_MAIN_ITEM_RELATIVE)
   734					map_rel(usage->hid & 0xf);
   735				else
   736					map_abs(usage->hid & 0xf);
   737				break;
   738	
   739			case HID_GD_HATSWITCH:
   740				usage->hat_min = field->logical_minimum;
   741				usage->hat_max = field->logical_maximum;
   742				map_abs(ABS_HAT0X);
   743				break;
   744	
   745			case HID_GD_START:	map_key_clear(BTN_START);	break;
   746			case HID_GD_SELECT:	map_key_clear(BTN_SELECT);	break;
   747	
   748			case HID_GD_RFKILL_BTN:
   749				/* MS wireless radio ctl extension, also check CA */
   750				if (field->application == HID_GD_WIRELESS_RADIO_CTLS) {
   751					map_key_clear(KEY_RFKILL);
   752					/* We need to simulate the btn release */
   753					field->flags |= HID_MAIN_ITEM_RELATIVE;
   754					break;
   755				}
   756				goto unknown;
   757	
   758			default: goto unknown;
   759			}
   760	
   761			break;
   762	
   763		case HID_UP_LED:
   764			switch (usage->hid & 0xffff) {		      /* HID-Value:                   */
   765			case 0x01:  map_led (LED_NUML);     break;    /*   "Num Lock"                 */
   766			case 0x02:  map_led (LED_CAPSL);    break;    /*   "Caps Lock"                */
   767			case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
   768			case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
   769			case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
   770			case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
   771			case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
   772			case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
   773			case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
   774			case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
   775			case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
   776	
   777			default: goto ignore;
   778			}
   779			break;
   780	
   781		case HID_UP_DIGITIZER:
   782			if ((field->application & 0xff) == 0x01) /* Digitizer */
   783				__set_bit(INPUT_PROP_POINTER, input->propbit);
   784			else if ((field->application & 0xff) == 0x02) /* Pen */
   785				__set_bit(INPUT_PROP_DIRECT, input->propbit);
   786	
   787			switch (usage->hid & 0xff) {
   788			case 0x00: /* Undefined */
   789				goto ignore;
   790	
   791			case 0x30: /* TipPressure */
   792				if (!test_bit(BTN_TOUCH, input->keybit)) {
   793					device->quirks |= HID_QUIRK_NOTOUCH;
   794					set_bit(EV_KEY, input->evbit);
   795					set_bit(BTN_TOUCH, input->keybit);
   796				}
   797				map_abs_clear(ABS_PRESSURE);
   798				break;
   799	
   800			case 0x32: /* InRange */
   801				switch (field->physical & 0xff) {
   802				case 0x21: map_key(BTN_TOOL_MOUSE); break;
   803				case 0x22: map_key(BTN_TOOL_FINGER); break;
   804				default: map_key(BTN_TOOL_PEN); break;
   805				}
   806				break;
   807	
   808			case 0x3b: /* Battery Strength */
   809				hidinput_setup_battery(device, HID_INPUT_REPORT, field);
   810				usage->type = EV_PWR;
   811				return;
   812	
   813			case 0x3c: /* Invert */
   814				map_key_clear(BTN_TOOL_RUBBER);
   815				break;
   816	
   817			case 0x3d: /* X Tilt */
   818				map_abs_clear(ABS_TILT_X);
   819				break;
   820	
   821			case 0x3e: /* Y Tilt */
   822				map_abs_clear(ABS_TILT_Y);
   823				break;
   824	
   825			case 0x33: /* Touch */
   826			case 0x42: /* TipSwitch */
   827			case 0x43: /* TipSwitch2 */
   828				device->quirks &= ~HID_QUIRK_NOTOUCH;
   829				map_key_clear(BTN_TOUCH);
   830				break;
   831	
   832			case 0x44: /* BarrelSwitch */
   833				map_key_clear(BTN_STYLUS);
   834				break;
   835	
   836			case 0x45: /* ERASER */
   837				/*
   838				 * This event is reported when eraser tip touches the surface.
   839				 * Actual eraser (BTN_TOOL_RUBBER) is set by Invert usage when
   840				 * tool gets in proximity.
   841				 */
   842				map_key_clear(BTN_TOUCH);
   843				break;
   844	
   845			case 0x46: /* TabletPick */
   846			case 0x5a: /* SecondaryBarrelSwitch */
   847				map_key_clear(BTN_STYLUS2);
   848				break;
   849	
   850			case 0x5b: /* TransducerSerialNumber */
   851				usage->type = EV_MSC;
   852				usage->code = MSC_SERIAL;
   853				bit = input->mscbit;
   854				max = MSC_MAX;
   855				break;
   856	
   857			default:  goto unknown;
   858			}
   859			break;
   860	
   861		case HID_UP_TELEPHONY:
   862			switch (usage->hid & HID_USAGE) {
   863			case 0x2f: map_key_clear(KEY_MICMUTE);		break;
   864			case 0xb0: map_key_clear(KEY_NUMERIC_0);	break;
   865			case 0xb1: map_key_clear(KEY_NUMERIC_1);	break;
   866			case 0xb2: map_key_clear(KEY_NUMERIC_2);	break;
   867			case 0xb3: map_key_clear(KEY_NUMERIC_3);	break;
   868			case 0xb4: map_key_clear(KEY_NUMERIC_4);	break;
   869			case 0xb5: map_key_clear(KEY_NUMERIC_5);	break;
   870			case 0xb6: map_key_clear(KEY_NUMERIC_6);	break;
   871			case 0xb7: map_key_clear(KEY_NUMERIC_7);	break;
   872			case 0xb8: map_key_clear(KEY_NUMERIC_8);	break;
   873			case 0xb9: map_key_clear(KEY_NUMERIC_9);	break;
   874			case 0xba: map_key_clear(KEY_NUMERIC_STAR);	break;
   875			case 0xbb: map_key_clear(KEY_NUMERIC_POUND);	break;
   876			case 0xbc: map_key_clear(KEY_NUMERIC_A);	break;
   877			case 0xbd: map_key_clear(KEY_NUMERIC_B);	break;
   878			case 0xbe: map_key_clear(KEY_NUMERIC_C);	break;
   879			case 0xbf: map_key_clear(KEY_NUMERIC_D);	break;
   880			default: goto ignore;
   881			}
   882			break;
   883	
   884		case HID_UP_CONSUMER:	/* USB HUT v1.12, pages 75-84 */
   885			switch (usage->hid & HID_USAGE) {
   886			case 0x000: goto ignore;
   887			case 0x030: map_key_clear(KEY_POWER);		break;
   888			case 0x031: map_key_clear(KEY_RESTART);		break;
   889			case 0x032: map_key_clear(KEY_SLEEP);		break;
   890			case 0x034: map_key_clear(KEY_SLEEP);		break;
   891			case 0x035: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
   892			case 0x036: map_key_clear(BTN_MISC);		break;
   893	
   894			case 0x040: map_key_clear(KEY_MENU);		break; /* Menu */
   895			case 0x041: map_key_clear(KEY_SELECT);		break; /* Menu Pick */
   896			case 0x042: map_key_clear(KEY_UP);		break; /* Menu Up */
   897			case 0x043: map_key_clear(KEY_DOWN);		break; /* Menu Down */
   898			case 0x044: map_key_clear(KEY_LEFT);		break; /* Menu Left */
   899			case 0x045: map_key_clear(KEY_RIGHT);		break; /* Menu Right */
   900			case 0x046: map_key_clear(KEY_ESC);		break; /* Menu Escape */
   901			case 0x047: map_key_clear(KEY_KPPLUS);		break; /* Menu Value Increase */
   902			case 0x048: map_key_clear(KEY_KPMINUS);		break; /* Menu Value Decrease */
   903	
   904			case 0x060: map_key_clear(KEY_INFO);		break; /* Data On Screen */
   905			case 0x061: map_key_clear(KEY_SUBTITLE);	break; /* Closed Caption */
   906			case 0x063: map_key_clear(KEY_VCR);		break; /* VCR/TV */
   907			case 0x065: map_key_clear(KEY_CAMERA);		break; /* Snapshot */
   908			case 0x069: map_key_clear(KEY_RED);		break;
   909			case 0x06a: map_key_clear(KEY_GREEN);		break;
   910			case 0x06b: map_key_clear(KEY_BLUE);		break;
   911			case 0x06c: map_key_clear(KEY_YELLOW);		break;
   912			case 0x06d: map_key_clear(KEY_ASPECT_RATIO);	break;
   913	
   914			case 0x06f: map_key_clear(KEY_BRIGHTNESSUP);		break;
   915			case 0x070: map_key_clear(KEY_BRIGHTNESSDOWN);		break;
   916			case 0x072: map_key_clear(KEY_BRIGHTNESS_TOGGLE);	break;
   917			case 0x073: map_key_clear(KEY_BRIGHTNESS_MIN);		break;
   918			case 0x074: map_key_clear(KEY_BRIGHTNESS_MAX);		break;
   919			case 0x075: map_key_clear(KEY_BRIGHTNESS_AUTO);		break;
   920	
   921			case 0x079: map_key_clear(KEY_KBDILLUMUP);	break;
   922			case 0x07a: map_key_clear(KEY_KBDILLUMDOWN);	break;
   923			case 0x07c: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
   924	
   925			case 0x082: map_key_clear(KEY_VIDEO_NEXT);	break;
   926			case 0x083: map_key_clear(KEY_LAST);		break;
   927			case 0x084: map_key_clear(KEY_ENTER);		break;
   928			case 0x088: map_key_clear(KEY_PC);		break;
   929			case 0x089: map_key_clear(KEY_TV);		break;
   930			case 0x08a: map_key_clear(KEY_WWW);		break;
   931			case 0x08b: map_key_clear(KEY_DVD);		break;
   932			case 0x08c: map_key_clear(KEY_PHONE);		break;
   933			case 0x08d: map_key_clear(KEY_PROGRAM);		break;
   934			case 0x08e: map_key_clear(KEY_VIDEOPHONE);	break;
   935			case 0x08f: map_key_clear(KEY_GAMES);		break;
   936			case 0x090: map_key_clear(KEY_MEMO);		break;
   937			case 0x091: map_key_clear(KEY_CD);		break;
   938			case 0x092: map_key_clear(KEY_VCR);		break;
   939			case 0x093: map_key_clear(KEY_TUNER);		break;
   940			case 0x094: map_key_clear(KEY_EXIT);		break;
   941			case 0x095: map_key_clear(KEY_HELP);		break;
   942			case 0x096: map_key_clear(KEY_TAPE);		break;
   943			case 0x097: map_key_clear(KEY_TV2);		break;
   944			case 0x098: map_key_clear(KEY_SAT);		break;
   945			case 0x09a: map_key_clear(KEY_PVR);		break;
   946	
   947			case 0x09c: map_key_clear(KEY_CHANNELUP);	break;
   948			case 0x09d: map_key_clear(KEY_CHANNELDOWN);	break;
   949			case 0x0a0: map_key_clear(KEY_VCR2);		break;
   950	
   951			case 0x0b0: map_key_clear(KEY_PLAY);		break;
   952			case 0x0b1: map_key_clear(KEY_PAUSE);		break;
   953			case 0x0b2: map_key_clear(KEY_RECORD);		break;
   954			case 0x0b3: map_key_clear(KEY_FASTFORWARD);	break;
   955			case 0x0b4: map_key_clear(KEY_REWIND);		break;
   956			case 0x0b5: map_key_clear(KEY_NEXTSONG);	break;
   957			case 0x0b6: map_key_clear(KEY_PREVIOUSSONG);	break;
   958			case 0x0b7: map_key_clear(KEY_STOPCD);		break;
   959			case 0x0b8: map_key_clear(KEY_EJECTCD);		break;
   960			case 0x0bc: map_key_clear(KEY_MEDIA_REPEAT);	break;
   961			case 0x0b9: map_key_clear(KEY_SHUFFLE);		break;
   962			case 0x0bf: map_key_clear(KEY_SLOW);		break;
   963	
   964			case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
   965			case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
   966			case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
   967			case 0x0e2: map_key_clear(KEY_MUTE);		break;
   968			case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
   969			case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
   970			case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
   971			case 0x0f5: map_key_clear(KEY_SLOW);		break;
   972	
   973			case 0x181: map_key_clear(KEY_BUTTONCONFIG);	break;
   974			case 0x182: map_key_clear(KEY_BOOKMARKS);	break;
   975			case 0x183: map_key_clear(KEY_CONFIG);		break;
   976			case 0x184: map_key_clear(KEY_WORDPROCESSOR);	break;
   977			case 0x185: map_key_clear(KEY_EDITOR);		break;
   978			case 0x186: map_key_clear(KEY_SPREADSHEET);	break;
   979			case 0x187: map_key_clear(KEY_GRAPHICSEDITOR);	break;
   980			case 0x188: map_key_clear(KEY_PRESENTATION);	break;
   981			case 0x189: map_key_clear(KEY_DATABASE);	break;
   982			case 0x18a: map_key_clear(KEY_MAIL);		break;
   983			case 0x18b: map_key_clear(KEY_NEWS);		break;
   984			case 0x18c: map_key_clear(KEY_VOICEMAIL);	break;
   985			case 0x18d: map_key_clear(KEY_ADDRESSBOOK);	break;
   986			case 0x18e: map_key_clear(KEY_CALENDAR);	break;
   987			case 0x18f: map_key_clear(KEY_TASKMANAGER);	break;
   988			case 0x190: map_key_clear(KEY_JOURNAL);		break;
   989			case 0x191: map_key_clear(KEY_FINANCE);		break;
   990			case 0x192: map_key_clear(KEY_CALC);		break;
   991			case 0x193: map_key_clear(KEY_PLAYER);		break;
   992			case 0x194: map_key_clear(KEY_FILE);		break;
   993			case 0x196: map_key_clear(KEY_WWW);		break;
   994			case 0x199: map_key_clear(KEY_CHAT);		break;
   995			case 0x19c: map_key_clear(KEY_LOGOFF);		break;
   996			case 0x19e: map_key_clear(KEY_COFFEE);		break;
   997			case 0x19f: map_key_clear(KEY_CONTROLPANEL);		break;
   998			case 0x1a2: map_key_clear(KEY_APPSELECT);		break;
   999			case 0x1a3: map_key_clear(KEY_NEXT);		break;
  1000			case 0x1a4: map_key_clear(KEY_PREVIOUS);	break;
  1001			case 0x1a6: map_key_clear(KEY_HELP);		break;
  1002			case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
  1003			case 0x1ab: map_key_clear(KEY_SPELLCHECK);	break;
  1004			case 0x1ae: map_key_clear(KEY_KEYBOARD);	break;
  1005			case 0x1b1: map_key_clear(KEY_SCREENSAVER);		break;
  1006			case 0x1b4: map_key_clear(KEY_FILE);		break;
  1007			case 0x1b6: map_key_clear(KEY_IMAGES);		break;
  1008			case 0x1b7: map_key_clear(KEY_AUDIO);		break;
  1009			case 0x1b8: map_key_clear(KEY_VIDEO);		break;
  1010			case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
  1011			case 0x1bd: map_key_clear(KEY_INFO);		break;
  1012			case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
  1013			case 0x201: map_key_clear(KEY_NEW);		break;
  1014			case 0x202: map_key_clear(KEY_OPEN);		break;
  1015			case 0x203: map_key_clear(KEY_CLOSE);		break;
  1016			case 0x204: map_key_clear(KEY_EXIT);		break;
  1017			case 0x207: map_key_clear(KEY_SAVE);		break;
  1018			case 0x208: map_key_clear(KEY_PRINT);		break;
  1019			case 0x209: map_key_clear(KEY_PROPS);		break;
  1020			case 0x21a: map_key_clear(KEY_UNDO);		break;
  1021			case 0x21b: map_key_clear(KEY_COPY);		break;
  1022			case 0x21c: map_key_clear(KEY_CUT);		break;
  1023			case 0x21d: map_key_clear(KEY_PASTE);		break;
  1024			case 0x21f: map_key_clear(KEY_FIND);		break;
  1025			case 0x221: map_key_clear(KEY_SEARCH);		break;
  1026			case 0x222: map_key_clear(KEY_GOTO);		break;
  1027			case 0x223: map_key_clear(KEY_HOMEPAGE);	break;
  1028			case 0x224: map_key_clear(KEY_BACK);		break;
  1029			case 0x225: map_key_clear(KEY_FORWARD);		break;
  1030			case 0x226: map_key_clear(KEY_STOP);		break;
  1031			case 0x227: map_key_clear(KEY_REFRESH);		break;
  1032			case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
  1033			case 0x22d: map_key_clear(KEY_ZOOMIN);		break;
  1034			case 0x22e: map_key_clear(KEY_ZOOMOUT);		break;
  1035			case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
  1036			case 0x232: map_key_clear(KEY_FULL_SCREEN);	break;
  1037			case 0x233: map_key_clear(KEY_SCROLLUP);	break;
  1038			case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
  1039			case 0x238: /* AC Pan */
  1040				set_bit(REL_HWHEEL, input->relbit);
  1041				map_rel(REL_HWHEEL_HI_RES);
  1042				break;
  1043			case 0x23d: map_key_clear(KEY_EDIT);		break;
  1044			case 0x25f: map_key_clear(KEY_CANCEL);		break;
  1045			case 0x269: map_key_clear(KEY_INSERT);		break;
  1046			case 0x26a: map_key_clear(KEY_DELETE);		break;
  1047			case 0x279: map_key_clear(KEY_REDO);		break;
  1048	
  1049			case 0x289: map_key_clear(KEY_REPLY);		break;
  1050			case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
  1051			case 0x28c: map_key_clear(KEY_SEND);		break;
  1052	
  1053			case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
  1054	
  1055			case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
  1056			case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
  1057			case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
  1058			case 0x2ca: map_key_clear(KEY_KBDINPUTASSIST_NEXTGROUP);		break;
  1059			case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
  1060			case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
  1061	
  1062			case 0x29f: map_key_clear(KEY_SCALE);		break;
  1063	
  1064			default: map_key_clear(KEY_UNKNOWN);
  1065			}
  1066			break;
  1067	
  1068		case HID_UP_GENDEVCTRLS:
  1069			switch (usage->hid) {
  1070			case HID_DC_BATTERYSTRENGTH:
  1071				hidinput_setup_battery(device, HID_INPUT_REPORT, field);
  1072				usage->type = EV_PWR;
  1073				return;
  1074			}
  1075			goto unknown;
  1076	
  1077		case HID_UP_BATTERY:
  1078			switch (usage->hid) {
  1079			case HID_BAT_ABSOLUTESTATEOFCHARGE:
  1080				hidinput_setup_battery(device, HID_INPUT_REPORT, field);
  1081				usage->type = EV_PWR;
> 1082				device->battery_min = 0;
> 1083				device->battery_max = 100;
  1084				return;
  1085			}
  1086			goto unknown;
  1087	
  1088		case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
  1089			set_bit(EV_REP, input->evbit);
  1090			switch (usage->hid & HID_USAGE) {
  1091			case 0x021: map_key_clear(KEY_PRINT);           break;
  1092			case 0x070: map_key_clear(KEY_HP);		break;
  1093			case 0x071: map_key_clear(KEY_CAMERA);		break;
  1094			case 0x072: map_key_clear(KEY_SOUND);		break;
  1095			case 0x073: map_key_clear(KEY_QUESTION);	break;
  1096			case 0x080: map_key_clear(KEY_EMAIL);		break;
  1097			case 0x081: map_key_clear(KEY_CHAT);		break;
  1098			case 0x082: map_key_clear(KEY_SEARCH);		break;
  1099			case 0x083: map_key_clear(KEY_CONNECT);	        break;
  1100			case 0x084: map_key_clear(KEY_FINANCE);		break;
  1101			case 0x085: map_key_clear(KEY_SPORT);		break;
  1102			case 0x086: map_key_clear(KEY_SHOP);	        break;
  1103			default:    goto ignore;
  1104			}
  1105			break;
  1106	
  1107		case HID_UP_HPVENDOR2:
  1108			set_bit(EV_REP, input->evbit);
  1109			switch (usage->hid & HID_USAGE) {
  1110			case 0x001: map_key_clear(KEY_MICMUTE);		break;
  1111			case 0x003: map_key_clear(KEY_BRIGHTNESSDOWN);	break;
  1112			case 0x004: map_key_clear(KEY_BRIGHTNESSUP);	break;
  1113			default:    goto ignore;
  1114			}
  1115			break;
  1116	
  1117		case HID_UP_MSVENDOR:
  1118			goto ignore;
  1119	
  1120		case HID_UP_CUSTOM: /* Reported on Logitech and Apple USB keyboards */
  1121			set_bit(EV_REP, input->evbit);
  1122			goto ignore;
  1123	
  1124		case HID_UP_LOGIVENDOR:
  1125			/* intentional fallback */
  1126		case HID_UP_LOGIVENDOR2:
  1127			/* intentional fallback */
  1128		case HID_UP_LOGIVENDOR3:
  1129			goto ignore;
  1130	
  1131		case HID_UP_PID:
  1132			switch (usage->hid & HID_USAGE) {
  1133			case 0xa4: map_key_clear(BTN_DEAD);	break;
  1134			default: goto ignore;
  1135			}
  1136			break;
  1137	
  1138		default:
  1139		unknown:
  1140			if (field->report_size == 1) {
  1141				if (field->report->type == HID_OUTPUT_REPORT) {
  1142					map_led(LED_MISC);
  1143					break;
  1144				}
  1145				map_key(BTN_MISC);
  1146				break;
  1147			}
  1148			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
  1149				map_rel(REL_MISC);
  1150				break;
  1151			}
  1152			map_abs(ABS_MISC);
  1153			break;
  1154		}
  1155	
  1156	mapped:
  1157		/* Mapping failed, bail out */
  1158		if (!bit)
  1159			return;
  1160	
  1161		if (device->driver->input_mapped &&
  1162		    device->driver->input_mapped(device, hidinput, field, usage,
  1163						 &bit, &max) < 0) {
  1164			/*
  1165			 * The driver indicated that no further generic handling
  1166			 * of the usage is desired.
  1167			 */
  1168			return;
  1169		}
  1170	
  1171		set_bit(usage->type, input->evbit);
  1172	
  1173		/*
  1174		 * This part is *really* controversial:
  1175		 * - HID aims at being generic so we should do our best to export
  1176		 *   all incoming events
  1177		 * - HID describes what events are, so there is no reason for ABS_X
  1178		 *   to be mapped to ABS_Y
  1179		 * - HID is using *_MISC+N as a default value, but nothing prevents
  1180		 *   *_MISC+N to overwrite a legitimate even, which confuses userspace
  1181		 *   (for instance ABS_MISC + 7 is ABS_MT_SLOT, which has a different
  1182		 *   processing)
  1183		 *
  1184		 * If devices still want to use this (at their own risk), they will
  1185		 * have to use the quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE, but
  1186		 * the default should be a reliable mapping.
  1187		 */
  1188		while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
  1189			if (device->quirks & HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE) {
  1190				usage->code = find_next_zero_bit(bit,
  1191								 max + 1,
  1192								 usage->code);
  1193			} else {
  1194				device->status |= HID_STAT_DUP_DETECTED;
  1195				goto ignore;
  1196			}
  1197		}
  1198	
  1199		if (usage->code > max)
  1200			goto ignore;
  1201	
  1202		if (usage->type == EV_ABS) {
  1203	
  1204			int a = field->logical_minimum;
  1205			int b = field->logical_maximum;
  1206	
  1207			if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code == ABS_X || usage->code == ABS_Y)) {
  1208				a = field->logical_minimum = 0;
  1209				b = field->logical_maximum = 255;
  1210			}
  1211	
  1212			if (field->application == HID_GD_GAMEPAD || field->application == HID_GD_JOYSTICK)
  1213				input_set_abs_params(input, usage->code, a, b, (b - a) >> 8, (b - a) >> 4);
  1214			else	input_set_abs_params(input, usage->code, a, b, 0, 0);
  1215	
  1216			input_abs_set_res(input, usage->code,
  1217					  hidinput_calc_abs_res(field, usage->code));
  1218	
  1219			/* use a larger default input buffer for MT devices */
  1220			if (usage->code == ABS_MT_POSITION_X && input->hint_events_per_packet == 0)
  1221				input_set_events_per_packet(input, 60);
  1222		}
  1223	
  1224		if (usage->type == EV_ABS &&
  1225		    (usage->hat_min < usage->hat_max || usage->hat_dir)) {
  1226			int i;
  1227			for (i = usage->code; i < usage->code + 2 && i <= max; i++) {
  1228				input_set_abs_params(input, i, -1, 1, 0, 0);
  1229				set_bit(i, input->absbit);
  1230			}
  1231			if (usage->hat_dir && !field->dpad)
  1232				field->dpad = usage->code;
  1233		}
  1234	
  1235		/* for those devices which produce Consumer volume usage as relative,
  1236		 * we emulate pressing volumeup/volumedown appropriate number of times
  1237		 * in hidinput_hid_event()
  1238		 */
  1239		if ((usage->type == EV_ABS) && (field->flags & HID_MAIN_ITEM_RELATIVE) &&
  1240				(usage->code == ABS_VOLUME)) {
  1241			set_bit(KEY_VOLUMEUP, input->keybit);
  1242			set_bit(KEY_VOLUMEDOWN, input->keybit);
  1243		}
  1244	
  1245		if (usage->type == EV_KEY) {
  1246			set_bit(EV_MSC, input->evbit);
  1247			set_bit(MSC_SCAN, input->mscbit);
  1248		}
  1249	
  1250		return;
  1251	
  1252	ignore:
  1253		usage->type = 0;
  1254		usage->code = 0;
  1255	}
  1256	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
0AEA

--6TrnltStXW4iwmi0--
