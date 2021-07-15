Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D023CAE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhGOVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:22:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:19:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k20so7833589pgg.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student-cerritos-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UkUj23bqrXIroxAQXRPnmSkr+evtxQDp9950ds3c2M=;
        b=ChFajqZo+/BVYPq9XvW5u1gC0TJxRq1EePt/FUJfctkfT2PXLw859JUElV1SR3W8lT
         A+XXJv5tXWmhHRh3awSFYhld7pWsyd/RZFiAdy5EPTSBIIrKdMqRiWoOT7b6INa3mvqU
         XhXhhACfpWaYpcZVP/CvsTAEvMragWbyBX5NGLqorrjLhTvOqQcn/ow0W8aJuhwwo/7R
         d9rn64FdvzfN0Cu2cG+xbuD2MOX1EroylQZqBMGWpPHWMASFG+P7PDYy0NfwfBqXHB40
         CgqW56e6kIzaX1eyooXUUoOg4kxc2tf9koVAZbUR7bL4X7UowFxhdvLA7e1v1MaMXzG1
         BZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UkUj23bqrXIroxAQXRPnmSkr+evtxQDp9950ds3c2M=;
        b=pQ4c257lAEzGFIvzDbkWCap3ykv8ts3socmGIIt272lBSnAmhge3r/7MpcbWBUWeMa
         BwVWDnwejtQvcsuwqM13/CZ7/JBoQfXKwwMzPVWn7hnCEmgqLXtl81xMzYYdWz7hfl08
         6D8tM6z8b/+K2B3bekirnZsX9hFREhGHwLe+qFPPmrDAJWoT+BLmJMNt2yA+lgLMWEmU
         8cWf6JXahY77az1Xi1dVpZJSjA+BqBzrwB2oDb0wIgYtjqjyCwzZ9JePRArkJy3sJDOf
         gAkbAcS5IW5Nh+FZbHvAa1xJaROvlsyY2E4k+StOZGEnRmnqTz72La1WjgdJWmNEFPK+
         VNwA==
X-Gm-Message-State: AOAM530XajFef9jY4XvFBS1SdfWL4vbYKvnNRbgCn30b1UYE1U77O2w9
        ANpNRzcbj6F+LbHtcilNQdL0QQ==
X-Google-Smtp-Source: ABdhPJyx93AoB+795XFjf3x5wHsZXKZffK8OXMeNIEuKFkLvs7p2CZWPkbtRLdm5ucQU2yUggGsItw==
X-Received: by 2002:aa7:9189:0:b029:330:322a:f6f3 with SMTP id x9-20020aa791890000b0290330322af6f3mr6692516pfa.12.1626383967907;
        Thu, 15 Jul 2021 14:19:27 -0700 (PDT)
Received: from fedora.. (066-215-081-126.biz.spectrum.com. [66.215.81.126])
        by smtp.gmail.com with ESMTPSA id gb10sm9811371pjb.43.2021.07.15.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:19:27 -0700 (PDT)
From:   Amy Parker <apark0006@student.cerritos.edu>
To:     pavel@ucw.cz
Cc:     Amy Parker <apark0006@student.cerritos.edu>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] swap led_brightness from enum to typedef
Date:   Thu, 15 Jul 2021 14:18:56 -0700
Message-Id: <9b5902665dcc4c0fca7546987303e348d8657f59.1626383424.git.apark0006@student.cerritos.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626383424.git.apark0006@student.cerritos.edu>
References: <cover.1626383424.git.apark0006@student.cerritos.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit changes how led_brightness, declared in header file
include/linux/leds.h, works throughout the kernel, and updates other
files in accordance.

The TODO located at drivers/leds/TODO requests:

* Get rid of led_brightness

It is really an integer, as maximum is configurable. Get rid of it, or
make it into typedef or something.

This patch changes the declaration of led_brightness from an enum to a
typedef. In order to hold the currently existing enum values, macro
definitions are provided. Files which use led_brightness are updated to
conform to the new types.

Signed-off-by: Amy Parker <apark0006@student.cerritos.edu>
---
 Documentation/leds/leds-class-flash.rst       |  2 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |  4 +--
 arch/arm/mach-footbridge/ebsa285.c            |  4 +--
 arch/arm/mach-footbridge/netwinder-hw.c       |  4 +--
 arch/arm/mach-pxa/idp.c                       |  4 +--
 arch/arm/mach-pxa/lubbock.c                   |  4 +--
 arch/arm/mach-pxa/mainstone.c                 |  4 +--
 arch/arm/plat-omap/debug-leds.c               |  4 +--
 arch/mips/alchemy/devboards/db1000.c          |  4 +--
 arch/mips/alchemy/devboards/db1200.c          |  4 +--
 arch/mips/alchemy/devboards/db1300.c          |  4 +--
 arch/mips/txx9/rbtx4939/setup.c               |  2 +-
 arch/x86/platform/ts5500/ts5500.c             |  4 +--
 drivers/gpu/drm/nouveau/nouveau_led.c         |  4 +--
 drivers/hid/hid-asus.c                        |  4 +--
 drivers/hid/hid-bigbenff.c                    |  4 +--
 drivers/hid/hid-corsair.c                     |  6 ++--
 drivers/hid/hid-elan.c                        |  2 +-
 drivers/hid/hid-google-hammer.c               |  2 +-
 drivers/hid/hid-gt683r.c                      |  4 +--
 drivers/hid/hid-led.c                         | 20 ++++++------
 drivers/hid/hid-lenovo.c                      |  4 +--
 drivers/hid/hid-lg-g15.c                      | 24 +++++++-------
 drivers/hid/hid-lg4ff.c                       |  4 +--
 drivers/hid/hid-picolcd_leds.c                |  4 +--
 drivers/hid/hid-sony.c                        |  4 +--
 drivers/hid/hid-steelseries.c                 |  8 ++---
 drivers/hid/hid-u2fzero.c                     |  2 +-
 drivers/hid/hid-wiimote-modules.c             |  4 +--
 drivers/hid/wacom.h                           |  2 +-
 drivers/hid/wacom_sys.c                       |  8 ++---
 drivers/hwmon/applesmc.c                      |  2 +-
 drivers/hwmon/pmbus/ibm-cffps.c               |  2 +-
 drivers/input/input-leds.c                    |  4 +--
 drivers/input/joystick/xpad.c                 |  2 +-
 drivers/input/keyboard/applespi.c             |  2 +-
 drivers/input/keyboard/cap11xx.c              |  2 +-
 drivers/input/keyboard/lm8323.c               |  2 +-
 drivers/input/keyboard/qt2160.c               |  4 +--
 drivers/input/keyboard/tm2-touchkey.c         |  2 +-
 drivers/input/misc/apanel.c                   |  2 +-
 drivers/input/misc/ims-pcu.c                  |  4 +--
 drivers/input/misc/wistron_btns.c             |  4 +--
 drivers/input/touchscreen/stmfts.c            |  4 +--
 drivers/leds/TODO                             |  2 +-
 drivers/leds/blink/leds-lgm-sso.c             |  6 ++--
 drivers/leds/flash/leds-rt4505.c              |  4 +--
 drivers/leds/flash/leds-rt8515.c              |  2 +-
 drivers/leds/led-class-multicolor.c           |  2 +-
 drivers/leds/led-triggers.c                   |  2 +-
 drivers/leds/leds-88pm860x.c                  |  2 +-
 drivers/leds/leds-aat1290.c                   |  8 ++---
 drivers/leds/leds-acer-a500.c                 |  2 +-
 drivers/leds/leds-adp5520.c                   |  2 +-
 drivers/leds/leds-an30259a.c                  |  2 +-
 drivers/leds/leds-apu.c                       |  4 +--
 drivers/leds/leds-ariel.c                     |  4 +--
 drivers/leds/leds-as3645a.c                   |  4 +--
 drivers/leds/leds-asic3.c                     |  2 +-
 drivers/leds/leds-aw2013.c                    |  2 +-
 drivers/leds/leds-bcm6328.c                   |  2 +-
 drivers/leds/leds-bcm6358.c                   |  2 +-
 drivers/leds/leds-bd2802.c                    |  2 +-
 drivers/leds/leds-blinkm.c                    |  8 ++---
 drivers/leds/leds-clevo-mail.c                |  2 +-
 drivers/leds/leds-cobalt-qube.c               |  2 +-
 drivers/leds/leds-cobalt-raq.c                |  4 +--
 drivers/leds/leds-cpcap.c                     |  2 +-
 drivers/leds/leds-cr0014114.c                 |  2 +-
 drivers/leds/leds-da903x.c                    |  2 +-
 drivers/leds/leds-da9052.c                    |  4 +--
 drivers/leds/leds-dac124s085.c                |  2 +-
 drivers/leds/leds-el15203000.c                |  2 +-
 drivers/leds/leds-fsg.c                       | 12 +++----
 drivers/leds/leds-gpio.c                      |  4 +--
 drivers/leds/leds-hp6xx.c                     |  4 +--
 drivers/leds/leds-ip30.c                      |  2 +-
 drivers/leds/leds-ipaq-micro.c                |  2 +-
 drivers/leds/leds-is31fl319x.c                |  2 +-
 drivers/leds/leds-is31fl32xx.c                |  2 +-
 drivers/leds/leds-ktd2692.c                   |  6 ++--
 drivers/leds/leds-lm3530.c                    |  4 +--
 drivers/leds/leds-lm3532.c                    |  2 +-
 drivers/leds/leds-lm3533.c                    |  4 +--
 drivers/leds/leds-lm355x.c                    |  6 ++--
 drivers/leds/leds-lm3601x.c                   |  2 +-
 drivers/leds/leds-lm36274.c                   |  2 +-
 drivers/leds/leds-lm3642.c                    |  6 ++--
 drivers/leds/leds-lm3692x.c                   |  4 +--
 drivers/leds/leds-lm3697.c                    |  2 +-
 drivers/leds/leds-locomo.c                    |  6 ++--
 drivers/leds/leds-lp3944.c                    |  4 +--
 drivers/leds/leds-lp3952.c                    |  2 +-
 drivers/leds/leds-lp50xx.c                    |  2 +-
 drivers/leds/leds-lp55xx-common.c             |  4 +--
 drivers/leds/leds-lp8788.c                    |  2 +-
 drivers/leds/leds-lp8860.c                    |  2 +-
 drivers/leds/leds-lt3593.c                    |  2 +-
 drivers/leds/leds-max77650.c                  |  2 +-
 drivers/leds/leds-max77693.c                  |  2 +-
 drivers/leds/leds-max8997.c                   |  4 +--
 drivers/leds/leds-mc13783.c                   |  2 +-
 drivers/leds/leds-menf21bmc.c                 |  2 +-
 drivers/leds/leds-mlxcpld.c                   |  4 +--
 drivers/leds/leds-mlxreg.c                    |  8 ++---
 drivers/leds/leds-mt6323.c                    | 10 +++---
 drivers/leds/leds-net48xx.c                   |  2 +-
 drivers/leds/leds-netxbig.c                   |  2 +-
 drivers/leds/leds-nic78bx.c                   |  4 +--
 drivers/leds/leds-ns2.c                       |  4 +--
 drivers/leds/leds-ot200.c                     |  2 +-
 drivers/leds/leds-pca9532.c                   |  4 +--
 drivers/leds/leds-pca955x.c                   |  2 +-
 drivers/leds/leds-pca963x.c                   |  4 +--
 drivers/leds/leds-pm8058.c                    |  6 ++--
 drivers/leds/leds-powernv.c                   |  8 ++---
 drivers/leds/leds-pwm.c                       |  2 +-
 drivers/leds/leds-rb532.c                     |  4 +--
 drivers/leds/leds-regulator.c                 |  4 +--
 drivers/leds/leds-s3c24xx.c                   |  2 +-
 drivers/leds/leds-sc27xx-bltc.c               |  4 +--
 drivers/leds/leds-sgm3140.c                   |  2 +-
 drivers/leds/leds-spi-byte.c                  |  2 +-
 drivers/leds/leds-ss4200.c                    |  2 +-
 drivers/leds/leds-sunfire.c                   | 18 +++++------
 drivers/leds/leds-syscon.c                    |  2 +-
 drivers/leds/leds-tca6507.c                   |  2 +-
 drivers/leds/leds-tlc591xx.c                  |  2 +-
 drivers/leds/leds-tps6105x.c                  |  2 +-
 drivers/leds/leds-turris-omnia.c              |  2 +-
 drivers/leds/leds-wm831x-status.c             |  4 +--
 drivers/leds/leds-wm8350.c                    |  2 +-
 drivers/leds/leds-wrap.c                      |  6 ++--
 drivers/leds/trigger/ledtrig-audio.c          |  6 ++--
 drivers/leds/trigger/ledtrig-camera.c         |  4 +--
 drivers/leds/uleds.c                          |  2 +-
 drivers/macintosh/via-pmu-led.c               |  2 +-
 drivers/media/radio/radio-shark.c             |  6 ++--
 drivers/media/radio/radio-shark2.c            |  4 +--
 drivers/media/rc/redrat3.c                    |  2 +-
 drivers/media/rc/ttusbir.c                    |  4 +--
 drivers/media/rc/winbond-cir.c                |  4 +--
 .../media/v4l2-core/v4l2-flash-led-class.c    |  6 ++--
 drivers/mmc/host/rtsx_usb_sdmmc.c             |  2 +-
 drivers/mmc/host/sdhci.c                      |  2 +-
 drivers/net/arcnet/com20020-pci.c             |  4 +--
 drivers/net/dsa/hirschmann/hellcreek_ptp.c    | 12 +++----
 drivers/net/wireless/ath/ath5k/led.c          |  2 +-
 drivers/net/wireless/ath/ath9k/gpio.c         |  2 +-
 drivers/net/wireless/ath/ath9k/htc.h          |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_gpio.c |  2 +-
 drivers/net/wireless/ath/carl9170/led.c       |  2 +-
 drivers/net/wireless/broadcom/b43/leds.c      |  2 +-
 .../net/wireless/broadcom/b43legacy/leds.c    |  2 +-
 .../broadcom/brcm80211/brcmsmac/led.c         |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |  2 +-
 drivers/net/wireless/intersil/p54/led.c       |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/ralink/rt2x00/rt2400pci.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2500pci.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2500usb.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |  2 +-
 .../wireless/realtek/rtl818x/rtl8187/leds.c   |  2 +-
 .../platform/chrome/cros_kbd_led_backlight.c  |  4 +--
 .../platform/chrome/wilco_ec/keyboard_leds.c  |  4 +--
 drivers/platform/x86/acer-wmi.c               |  2 +-
 drivers/platform/x86/asus-laptop.c            |  8 ++---
 drivers/platform/x86/asus-wireless.c          |  4 +--
 drivers/platform/x86/asus-wmi.c               | 18 +++++------
 drivers/platform/x86/dell/alienware-wmi.c     |  4 +--
 drivers/platform/x86/dell/dell-laptop.c       | 16 +++++-----
 drivers/platform/x86/dell/dell-wmi-led.c      |  2 +-
 drivers/platform/x86/dell/dell-wmi-privacy.c  |  2 +-
 drivers/platform/x86/eeepc-laptop.c           |  4 +--
 drivers/platform/x86/fujitsu-laptop.c         | 22 ++++++-------
 drivers/platform/x86/hp_accel.c               |  8 ++---
 drivers/platform/x86/huawei-wmi.c             |  2 +-
 drivers/platform/x86/ideapad-laptop.c         |  4 +--
 drivers/platform/x86/lg-laptop.c              |  8 ++---
 drivers/platform/x86/samsung-laptop.c         |  4 +--
 drivers/platform/x86/system76_acpi.c          | 16 +++++-----
 drivers/platform/x86/thinkpad_acpi.c          | 20 ++++++------
 drivers/platform/x86/topstar-laptop.c         |  4 +--
 drivers/platform/x86/toshiba_acpi.c           | 12 +++----
 drivers/staging/greybus/light.c               |  4 +--
 drivers/staging/nvec/nvec_paz00.c             |  2 +-
 drivers/video/backlight/adp8860_bl.c          |  4 +--
 drivers/video/backlight/adp8870_bl.c          |  4 +--
 drivers/video/backlight/lm3639_bl.c           |  4 +--
 include/linux/led-class-multicolor.h          |  4 +--
 include/linux/leds-regulator.h                |  2 +-
 include/linux/leds.h                          | 31 +++++++++----------
 include/linux/mfd/wm8350/pmic.h               |  2 +-
 include/media/v4l2-flash-led-class.h          |  6 ++--
 net/rfkill/core.c                             |  2 +-
 sound/pci/hda/hda_generic.c                   |  6 ++--
 sound/pci/hda/hda_generic.h                   |  4 +--
 sound/pci/hda/patch_conexant.c                |  6 ++--
 sound/pci/hda/patch_realtek.c                 | 12 +++----
 sound/pci/hda/patch_sigmatel.c                |  4 +--
 sound/usb/line6/toneport.c                    |  2 +-
 207 files changed, 437 insertions(+), 438 deletions(-)

diff --git a/Documentation/leds/leds-class-flash.rst b/Documentation/leds/leds-class-flash.rst
index 6ec12c5a1a0e..5f9e6bbe7bd0 100644
--- a/Documentation/leds/leds-class-flash.rst
+++ b/Documentation/leds/leds-class-flash.rst
@@ -52,7 +52,7 @@ V4L2 subsystem. The function takes six arguments:
 		strobe start with exposure start,
 	* intensity_to_led_brightness and led_brightness_to_intensity
 		perform
-		enum led_brightness <-> V4L2 intensity conversion in a device
+		led_brightness <-> V4L2 intensity conversion in a device
 		specific manner - they can be used for devices with non-linear
 		LED current scale.
 - config:
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index b3bef74c982a..901378edf430 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -637,7 +637,7 @@ static const struct {
 	{ "dm365evm::ds9", "heartbeat", },
 };
 
-static void cpld_led_set(struct led_classdev *cdev, enum led_brightness b)
+static void cpld_led_set(struct led_classdev *cdev, led_brightness b)
 {
 	struct cpld_led *led = container_of(cdev, struct cpld_led, cdev);
 	u8 reg = __raw_readb(cpld + CPLD_LEDS);
@@ -649,7 +649,7 @@ static void cpld_led_set(struct led_classdev *cdev, enum led_brightness b)
 	__raw_writeb(reg, cpld + CPLD_LEDS);
 }
 
-static enum led_brightness cpld_led_get(struct led_classdev *cdev)
+static led_brightness cpld_led_get(struct led_classdev *cdev)
 {
 	struct cpld_led *led = container_of(cdev, struct cpld_led, cdev);
 	u8 reg = __raw_readb(cpld + CPLD_LEDS);
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 21cf9a358b90..c4a36ed3d186 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -46,7 +46,7 @@ static unsigned char hw_led_state;
 static void __iomem *xbus;
 
 static void ebsa285_led_set(struct led_classdev *cdev,
-		enum led_brightness b)
+		led_brightness b)
 {
 	struct ebsa285_led *led = container_of(cdev,
 			struct ebsa285_led, cdev);
@@ -58,7 +58,7 @@ static void ebsa285_led_set(struct led_classdev *cdev,
 	writeb(hw_led_state, xbus);
 }
 
-static enum led_brightness ebsa285_led_get(struct led_classdev *cdev)
+static led_brightness ebsa285_led_get(struct led_classdev *cdev)
 {
 	struct ebsa285_led *led = container_of(cdev,
 			struct ebsa285_led, cdev);
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index 5f7265b1b34c..7159d7fc2f42 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -686,7 +686,7 @@ static const struct {
  *  - clearing bit means turn on LED
  */
 static void netwinder_led_set(struct led_classdev *cdev,
-		enum led_brightness b)
+		led_brightness b)
 {
 	struct netwinder_led *led = container_of(cdev,
 			struct netwinder_led, cdev);
@@ -703,7 +703,7 @@ static void netwinder_led_set(struct led_classdev *cdev,
 	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
 }
 
-static enum led_brightness netwinder_led_get(struct led_classdev *cdev)
+static led_brightness netwinder_led_get(struct led_classdev *cdev)
 {
 	struct netwinder_led *led = container_of(cdev,
 			struct netwinder_led, cdev);
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index fb0850af8496..7461aea97f45 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -213,7 +213,7 @@ static const struct {
 };
 
 static void idp_led_set(struct led_classdev *cdev,
-		enum led_brightness b)
+		led_brightness b)
 {
 	struct idp_led *led = container_of(cdev,
 			struct idp_led, cdev);
@@ -227,7 +227,7 @@ static void idp_led_set(struct led_classdev *cdev,
 	IDP_CPLD_LED_CONTROL = reg;
 }
 
-static enum led_brightness idp_led_get(struct led_classdev *cdev)
+static led_brightness idp_led_get(struct led_classdev *cdev)
 {
 	struct idp_led *led = container_of(cdev,
 			struct idp_led, cdev);
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 742d18a1f7dc..13e29fdfea57 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -564,7 +564,7 @@ static const struct {
 };
 
 static void lubbock_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
+			      led_brightness b)
 {
 	struct lubbock_led *led = container_of(cdev,
 					 struct lubbock_led, cdev);
@@ -578,7 +578,7 @@ static void lubbock_led_set(struct led_classdev *cdev,
 	LUB_DISC_BLNK_LED = reg;
 }
 
-static enum led_brightness lubbock_led_get(struct led_classdev *cdev)
+static led_brightness lubbock_led_get(struct led_classdev *cdev)
 {
 	struct lubbock_led *led = container_of(cdev,
 					 struct lubbock_led, cdev);
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index d237bd030238..03444b02e308 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -655,7 +655,7 @@ static const struct {
 };
 
 static void mainstone_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
+			      led_brightness b)
 {
 	struct mainstone_led *led = container_of(cdev,
 					 struct mainstone_led, cdev);
@@ -669,7 +669,7 @@ static void mainstone_led_set(struct led_classdev *cdev,
 	MST_LEDCTRL = reg;
 }
 
-static enum led_brightness mainstone_led_get(struct led_classdev *cdev)
+static led_brightness mainstone_led_get(struct led_classdev *cdev)
 {
 	struct mainstone_led *led = container_of(cdev,
 					 struct mainstone_led, cdev);
diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 2b698d074874..aff1b184f5ab 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -77,7 +77,7 @@ static const struct {
  * LED triggers are compiled in.
  */
 static void dbg_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
+			      led_brightness b)
 {
 	struct dbg_led *led = container_of(cdev, struct dbg_led, cdev);
 	u16 reg;
@@ -90,7 +90,7 @@ static void dbg_led_set(struct led_classdev *cdev,
 	writew_relaxed(reg, &fpga->leds);
 }
 
-static enum led_brightness dbg_led_get(struct led_classdev *cdev)
+static led_brightness dbg_led_get(struct led_classdev *cdev)
 {
 	struct dbg_led *led = container_of(cdev, struct dbg_led, cdev);
 	u16 reg;
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 2c52ee27b4f2..736fa4632601 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -239,7 +239,7 @@ static void db1100_mmc_set_power(void *mmc_host, int state)
 		bcsr_mod(BCSR_BOARD, bit, 0);
 }
 
-static void db1100_mmcled_set(struct led_classdev *led, enum led_brightness b)
+static void db1100_mmcled_set(struct led_classdev *led, led_brightness b)
 {
 	if (b != LED_OFF)
 		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
@@ -277,7 +277,7 @@ static void db1100_mmc1_set_power(void *mmc_host, int state)
 		bcsr_mod(BCSR_BOARD, bit, 0);
 }
 
-static void db1100_mmc1led_set(struct led_classdev *led, enum led_brightness b)
+static void db1100_mmc1led_set(struct led_classdev *led, led_brightness b)
 {
 	if (b != LED_OFF)
 		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED1, 0);
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 421d651433b6..aab21b9b594e 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -409,7 +409,7 @@ static int db1200_mmc_card_inserted(void *mmc_host)
 }
 
 static void db1200_mmcled_set(struct led_classdev *led,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	if (brightness != LED_OFF)
 		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
@@ -481,7 +481,7 @@ static int pb1200_mmc1_cd_setup(void *mmc_host, int en)
 }
 
 static void pb1200_mmc1led_set(struct led_classdev *led,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	if (brightness != LED_OFF)
 			bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED1, 0);
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index cd72eaa1168f..639f0d72192d 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -520,7 +520,7 @@ static int db1300_mmc_cd_setup(void *mmc_host, int en)
 }
 
 static void db1300_mmcled_set(struct led_classdev *led,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	if (brightness != LED_OFF)
 		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
@@ -587,7 +587,7 @@ static int db1300_movinand_readonly(void *mmc_host)
 }
 
 static void db1300_movinand_led_set(struct led_classdev *led,
-				    enum led_brightness brightness)
+				    led_brightness brightness)
 {
 	if (brightness != LED_OFF)
 		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED1, 0);
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index ef29a9c2ffd6..a6f191984559 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -196,7 +196,7 @@ struct rbtx4939_led_data {
 
 /* Use "dot" in 7seg LEDs */
 static void rbtx4939_led_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness value)
+					led_brightness value)
 {
 	struct rbtx4939_led_data *led_dat =
 		container_of(led_cdev, struct rbtx4939_led_data, cdev);
diff --git a/arch/x86/platform/ts5500/ts5500.c b/arch/x86/platform/ts5500/ts5500.c
index 0b67da056fd9..1adc9525c5bf 100644
--- a/arch/x86/platform/ts5500/ts5500.c
+++ b/arch/x86/platform/ts5500/ts5500.c
@@ -229,12 +229,12 @@ static struct platform_device ts5500_dio2_pdev = {
 };
 
 static void ts5500_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
+			   led_brightness brightness)
 {
 	outb(!!brightness, TS5500_LED_JP_ADDR);
 }
 
-static enum led_brightness ts5500_led_get(struct led_classdev *led_cdev)
+static led_brightness ts5500_led_get(struct led_classdev *led_cdev)
 {
 	return (inb(TS5500_LED_JP_ADDR) & TS5500_LED) ? LED_FULL : LED_OFF;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_led.c b/drivers/gpu/drm/nouveau/nouveau_led.c
index 2c5e0628da12..35e4f49803dc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_led.c
+++ b/drivers/gpu/drm/nouveau/nouveau_led.c
@@ -33,7 +33,7 @@
 #include "nouveau_led.h"
 #include <nvkm/subdev/gpio.h>
 
-static enum led_brightness
+static led_brightness
 nouveau_led_get_brightness(struct led_classdev *led)
 {
 	struct drm_device *drm_dev = container_of(led, struct nouveau_led, led)->dev;
@@ -51,7 +51,7 @@ nouveau_led_get_brightness(struct led_classdev *led)
 }
 
 static void
-nouveau_led_set_brightness(struct led_classdev *led, enum led_brightness value)
+nouveau_led_set_brightness(struct led_classdev *led, led_brightness value)
 {
 	struct drm_device *drm_dev = container_of(led, struct nouveau_led, led)->dev;
 	struct nouveau_drm *drm = nouveau_drm(drm_dev);
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index fca8fc78a78a..fcf4466985cc 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -481,7 +481,7 @@ static int rog_nkey_led_init(struct hid_device *hdev)
 }
 
 static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
 						 cdev);
@@ -492,7 +492,7 @@ static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
 	schedule_work(&led->work);
 }
 
-static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
+static led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
 {
 	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
 						 cdev);
diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index db6da21ade06..ef4a5e1c59fc 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -252,7 +252,7 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
 }
 
 static void bigben_set_led(struct led_classdev *led,
-	enum led_brightness value)
+	led_brightness value)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
@@ -284,7 +284,7 @@ static void bigben_set_led(struct led_classdev *led,
 	}
 }
 
-static enum led_brightness bigben_get_led(struct led_classdev *led)
+static led_brightness bigben_get_led(struct led_classdev *led)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 902a60e249ed..42996eac0192 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -142,7 +142,7 @@ MODULE_PARM_DESC(profilekey_codes, "Key codes for the profile buttons");
 #define K90_BACKLIGHT_LED_SUFFIX "::backlight"
 #define K90_RECORD_LED_SUFFIX "::record"
 
-static enum led_brightness k90_backlight_get(struct led_classdev *led_cdev)
+static led_brightness k90_backlight_get(struct led_classdev *led_cdev)
 {
 	int ret;
 	struct k90_led *led = container_of(led_cdev, struct k90_led, cdev);
@@ -182,7 +182,7 @@ static enum led_brightness k90_backlight_get(struct led_classdev *led_cdev)
 	return ret;
 }
 
-static enum led_brightness k90_record_led_get(struct led_classdev *led_cdev)
+static led_brightness k90_record_led_get(struct led_classdev *led_cdev)
 {
 	struct k90_led *led = container_of(led_cdev, struct k90_led, cdev);
 
@@ -190,7 +190,7 @@ static enum led_brightness k90_record_led_get(struct led_classdev *led_cdev)
 }
 
 static void k90_brightness_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
+			       led_brightness brightness)
 {
 	struct k90_led *led = container_of(led_cdev, struct k90_led, cdev);
 
diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 021049805bb7..a4b29defdd1f 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -411,7 +411,7 @@ static int elan_start_multitouch(struct hid_device *hdev)
 }
 
 static int elan_mute_led_set_brigtness(struct led_classdev *led_cdev,
-				       enum led_brightness value)
+				       led_brightness value)
 {
 	int ret;
 	u8 led_state;
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 8123b871a3eb..0285d2353333 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -301,7 +301,7 @@ struct hammer_kbd_leds {
 };
 
 static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
-		enum led_brightness br)
+		led_brightness br)
 {
 	struct hammer_kbd_leds *led = container_of(cdev,
 						   struct hammer_kbd_leds,
diff --git a/drivers/hid/hid-gt683r.c b/drivers/hid/hid-gt683r.c
index 29ccb0accfba..9fc86edcd04f 100644
--- a/drivers/hid/hid-gt683r.c
+++ b/drivers/hid/hid-gt683r.c
@@ -46,7 +46,7 @@ struct gt683r_led {
 	struct led_classdev led_devs[GT683R_LED_COUNT];
 	struct mutex lock;
 	struct work_struct work;
-	enum led_brightness brightnesses[GT683R_LED_COUNT];
+	led_brightness brightnesses[GT683R_LED_COUNT];
 	enum gt683r_led_mode mode;
 };
 
@@ -57,7 +57,7 @@ static const struct hid_device_id gt683r_led_id[] = {
 MODULE_DEVICE_TABLE(hid, gt683r_led_id);
 
 static void gt683r_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness brightness)
+				led_brightness brightness)
 {
 	int i;
 	struct device *dev = led_cdev->dev->parent;
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index c2c66ceca132..3a95d2e8e0dc 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -71,12 +71,12 @@ struct hidled_config {
 	enum hidled_type	type;
 	const char		*name;
 	const char		*short_name;
-	enum led_brightness	max_brightness;
+	led_brightness	max_brightness;
 	int			num_leds;
 	size_t			report_size;
 	enum hidled_report_type	report_type;
 	int (*init)(struct hidled_device *ldev);
-	int (*write)(struct led_classdev *cdev, enum led_brightness br);
+	int (*write)(struct led_classdev *cdev, led_brightness br);
 };
 
 struct hidled_led {
@@ -174,7 +174,7 @@ static int hidled_recv(struct hidled_device *ldev, __u8 *buf)
 
 static u8 riso_kagaku_index(struct hidled_rgb *rgb)
 {
-	enum led_brightness r, g, b;
+	led_brightness r, g, b;
 
 	r = rgb->red.cdev.brightness;
 	g = rgb->green.cdev.brightness;
@@ -186,7 +186,7 @@ static u8 riso_kagaku_index(struct hidled_rgb *rgb)
 		return RISO_KAGAKU_IX(r, g, b);
 }
 
-static int riso_kagaku_write(struct led_classdev *cdev, enum led_brightness br)
+static int riso_kagaku_write(struct led_classdev *cdev, led_brightness br)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
 	struct hidled_rgb *rgb = led->rgb;
@@ -197,7 +197,7 @@ static int riso_kagaku_write(struct led_classdev *cdev, enum led_brightness br)
 	return hidled_send(rgb->ldev, buf);
 }
 
-static int dream_cheeky_write(struct led_classdev *cdev, enum led_brightness br)
+static int dream_cheeky_write(struct led_classdev *cdev, led_brightness br)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
 	struct hidled_rgb *rgb = led->rgb;
@@ -226,7 +226,7 @@ static int dream_cheeky_init(struct hidled_device *ldev)
 	return hidled_send(ldev, buf);
 }
 
-static int _thingm_write(struct led_classdev *cdev, enum led_brightness br,
+static int _thingm_write(struct led_classdev *cdev, led_brightness br,
 			 u8 offset)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
@@ -240,12 +240,12 @@ static int _thingm_write(struct led_classdev *cdev, enum led_brightness br,
 	return hidled_send(led->rgb->ldev, buf);
 }
 
-static int thingm_write_v1(struct led_classdev *cdev, enum led_brightness br)
+static int thingm_write_v1(struct led_classdev *cdev, led_brightness br)
 {
 	return _thingm_write(cdev, br, 0);
 }
 
-static int thingm_write(struct led_classdev *cdev, enum led_brightness br)
+static int thingm_write(struct led_classdev *cdev, led_brightness br)
 {
 	return _thingm_write(cdev, br, 1);
 }
@@ -306,7 +306,7 @@ static int delcom_set_pwm(struct hidled_led *led)
 	return hidled_send(led->rgb->ldev, dp.data);
 }
 
-static int delcom_write(struct led_classdev *cdev, enum led_brightness br)
+static int delcom_write(struct led_classdev *cdev, led_brightness br)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
 	int ret;
@@ -338,7 +338,7 @@ static int delcom_init(struct hidled_device *ldev)
 	return le16_to_cpu(dp.fw.family_code) == 2 ? 0 : -ENODEV;
 }
 
-static int luxafor_write(struct led_classdev *cdev, enum led_brightness br)
+static int luxafor_write(struct led_classdev *cdev, led_brightness br)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
 	__u8 buf[MAX_REPORT_SIZE] = { [1] = 1 };
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f935e526..4870a111aa55 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -66,7 +66,7 @@ struct lenovo_drvdata {
 #define TP10UBKBD_LED_ON		2
 
 static int lenovo_led_set_tp10ubkbd(struct hid_device *hdev, u8 led_code,
-				    enum led_brightness value)
+				    led_brightness value)
 {
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 	int ret;
@@ -830,7 +830,7 @@ static void lenovo_led_set_tpkbd(struct hid_device *hdev)
 }
 
 static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index b2a08233f8d5..ce31c0156cb7 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -44,7 +44,7 @@ enum lg_g15_led_type {
 
 struct lg_g15_led {
 	struct led_classdev cdev;
-	enum led_brightness brightness;
+	led_brightness brightness;
 	enum lg_g15_led_type led;
 	u8 red, green, blue;
 };
@@ -91,12 +91,12 @@ static int lg_g15_update_led_brightness(struct lg_g15_data *g15)
 	return 0;
 }
 
-static enum led_brightness lg_g15_led_get(struct led_classdev *led_cdev)
+static led_brightness lg_g15_led_get(struct led_classdev *led_cdev)
 {
 	struct lg_g15_led *g15_led =
 		container_of(led_cdev, struct lg_g15_led, cdev);
 	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
-	enum led_brightness brightness;
+	led_brightness brightness;
 
 	mutex_lock(&g15->mutex);
 	lg_g15_update_led_brightness(g15);
@@ -107,7 +107,7 @@ static enum led_brightness lg_g15_led_get(struct led_classdev *led_cdev)
 }
 
 static int lg_g15_led_set(struct led_classdev *led_cdev,
-			  enum led_brightness brightness)
+			  led_brightness brightness)
 {
 	struct lg_g15_led *g15_led =
 		container_of(led_cdev, struct lg_g15_led, cdev);
@@ -162,8 +162,8 @@ static int lg_g15_led_set(struct led_classdev *led_cdev,
 static void lg_g15_leds_changed_work(struct work_struct *work)
 {
 	struct lg_g15_data *g15 = container_of(work, struct lg_g15_data, work);
-	enum led_brightness old_brightness[LG_G15_BRIGHTNESS_MAX];
-	enum led_brightness brightness[LG_G15_BRIGHTNESS_MAX];
+	led_brightness old_brightness[LG_G15_BRIGHTNESS_MAX];
+	led_brightness brightness[LG_G15_BRIGHTNESS_MAX];
 	int i, ret;
 
 	mutex_lock(&g15->mutex);
@@ -226,7 +226,7 @@ static int lg_g510_get_initial_led_brightness(struct lg_g15_data *g15, int i)
 /* Must be called with g15->mutex locked */
 static int lg_g510_kbd_led_write(struct lg_g15_data *g15,
 				 struct lg_g15_led *g15_led,
-				 enum led_brightness brightness)
+				 led_brightness brightness)
 {
 	int ret;
 
@@ -255,7 +255,7 @@ static int lg_g510_kbd_led_write(struct lg_g15_data *g15,
 }
 
 static int lg_g510_kbd_led_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
+			       led_brightness brightness)
 {
 	struct lg_g15_led *g15_led =
 		container_of(led_cdev, struct lg_g15_led, cdev);
@@ -273,7 +273,7 @@ static int lg_g510_kbd_led_set(struct led_classdev *led_cdev,
 	return ret;
 }
 
-static enum led_brightness lg_g510_kbd_led_get(struct led_classdev *led_cdev)
+static led_brightness lg_g510_kbd_led_get(struct led_classdev *led_cdev)
 {
 	struct lg_g15_led *g15_led =
 		container_of(led_cdev, struct lg_g15_led, cdev);
@@ -378,12 +378,12 @@ static int lg_g510_update_mkey_led_brightness(struct lg_g15_data *g15)
 	return 0;
 }
 
-static enum led_brightness lg_g510_mkey_led_get(struct led_classdev *led_cdev)
+static led_brightness lg_g510_mkey_led_get(struct led_classdev *led_cdev)
 {
 	struct lg_g15_led *g15_led =
 		container_of(led_cdev, struct lg_g15_led, cdev);
 	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
-	enum led_brightness brightness;
+	led_brightness brightness;
 
 	mutex_lock(&g15->mutex);
 	lg_g510_update_mkey_led_brightness(g15);
@@ -394,7 +394,7 @@ static enum led_brightness lg_g510_mkey_led_get(struct led_classdev *led_cdev)
 }
 
 static int lg_g510_mkey_led_set(struct led_classdev *led_cdev,
-				enum led_brightness brightness)
+				led_brightness brightness)
 {
 	struct lg_g15_led *g15_led =
 		container_of(led_cdev, struct lg_g15_led, cdev);
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5e6a0cef2a06..90e8607f54b3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1112,7 +1112,7 @@ static void lg4ff_set_leds(struct hid_device *hid, u8 leds)
 }
 
 static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
@@ -1147,7 +1147,7 @@ static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
 	}
 }
 
-static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
+static led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index 6b505a753511..59150760ba96 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -48,7 +48,7 @@ void picolcd_leds_set(struct picolcd_data *data)
 }
 
 static void picolcd_led_set_brightness(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct device *dev;
 	struct hid_device *hdev;
@@ -75,7 +75,7 @@ static void picolcd_led_set_brightness(struct led_classdev *led_cdev,
 	}
 }
 
-static enum led_brightness picolcd_led_get_brightness(struct led_classdev *led_cdev)
+static led_brightness picolcd_led_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev;
 	struct hid_device *hdev;
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b3722c51ec78..4fc2d3c41a43 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1984,7 +1984,7 @@ static void sony_set_leds(struct sony_sc *sc)
 }
 
 static void sony_led_set_brightness(struct led_classdev *led,
-				    enum led_brightness value)
+				    led_brightness value)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
@@ -2026,7 +2026,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	}
 }
 
-static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
+static led_brightness sony_led_get_brightness(struct led_classdev *led)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 37353c41cba7..e6a616acc6da 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -135,7 +135,7 @@ static void steelseries_srws1_set_leds(struct hid_device *hdev, __u16 leds)
 }
 
 static void steelseries_srws1_led_all_set_brightness(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
@@ -154,7 +154,7 @@ static void steelseries_srws1_led_all_set_brightness(struct led_classdev *led_cd
 	steelseries_srws1_set_leds(hid, drv_data->led_state);
 }
 
-static enum led_brightness steelseries_srws1_led_all_get_brightness(struct led_classdev *led_cdev)
+static led_brightness steelseries_srws1_led_all_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
@@ -171,7 +171,7 @@ static enum led_brightness steelseries_srws1_led_all_get_brightness(struct led_c
 }
 
 static void steelseries_srws1_led_set_brightness(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
@@ -199,7 +199,7 @@ static void steelseries_srws1_led_set_brightness(struct led_classdev *led_cdev,
 	}
 }
 
-static enum led_brightness steelseries_srws1_led_get_brightness(struct led_classdev *led_cdev)
+static led_brightness steelseries_srws1_led_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hid = to_hid_device(dev);
diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 95e0807878c7..63b265212646 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -164,7 +164,7 @@ static int u2fzero_blink(struct led_classdev *ldev)
 }
 
 static int u2fzero_brightness_set(struct led_classdev *ldev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	ldev->brightness = LED_OFF;
 	if (brightness)
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 213c58bf2495..c46364699a52 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -291,7 +291,7 @@ static const struct wiimod_ops wiimod_battery = {
  * State is managed by wiimote core.
  */
 
-static enum led_brightness wiimod_led_get(struct led_classdev *led_dev)
+static led_brightness wiimod_led_get(struct led_classdev *led_dev)
 {
 	struct device *dev = led_dev->dev->parent;
 	struct wiimote_data *wdata = dev_to_wii(dev);
@@ -312,7 +312,7 @@ static enum led_brightness wiimod_led_get(struct led_classdev *led_dev)
 }
 
 static void wiimod_led_set(struct led_classdev *led_dev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct device *dev = led_dev->dev->parent;
 	struct wiimote_data *wdata = dev_to_wii(dev);
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 203d27d198b8..b815da0a0587 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -233,7 +233,7 @@ void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value);
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report);
 void wacom_battery_work(struct work_struct *work);
-enum led_brightness wacom_leds_brightness_get(struct wacom_led *led);
+led_brightness wacom_leds_brightness_get(struct wacom_led *led);
 struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group,
 				 unsigned int id);
 struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 57bfa0ae9836..f409d24a531e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1302,7 +1302,7 @@ static int wacom_devm_kfifo_alloc(struct wacom *wacom)
 	return 0;
 }
 
-enum led_brightness wacom_leds_brightness_get(struct wacom_led *led)
+led_brightness wacom_leds_brightness_get(struct wacom_led *led)
 {
 	struct wacom *wacom = led->wacom;
 
@@ -1316,7 +1316,7 @@ enum led_brightness wacom_leds_brightness_get(struct wacom_led *led)
 	return LED_FULL;
 }
 
-static enum led_brightness __wacom_led_brightness_get(struct led_classdev *cdev)
+static led_brightness __wacom_led_brightness_get(struct led_classdev *cdev)
 {
 	struct wacom_led *led = container_of(cdev, struct wacom_led, cdev);
 	struct wacom *wacom = led->wacom;
@@ -1328,7 +1328,7 @@ static enum led_brightness __wacom_led_brightness_get(struct led_classdev *cdev)
 }
 
 static int wacom_led_brightness_set(struct led_classdev *cdev,
-				    enum led_brightness brightness)
+				    led_brightness brightness)
 {
 	struct wacom_led *led = container_of(cdev, struct wacom_led, cdev);
 	struct wacom *wacom = led->wacom;
@@ -1356,7 +1356,7 @@ static int wacom_led_brightness_set(struct led_classdev *cdev,
 }
 
 static void wacom_led_readonly_brightness_set(struct led_classdev *cdev,
-					       enum led_brightness brightness)
+					       led_brightness brightness)
 {
 }
 
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index c31759794a29..fdd123fc224d 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -968,7 +968,7 @@ static void applesmc_backlight_set(struct work_struct *work)
 static DECLARE_WORK(backlight_work, &applesmc_backlight_set);
 
 static void applesmc_brightness_set(struct led_classdev *led_cdev,
-						enum led_brightness value)
+						led_brightness value)
 {
 	int ret;
 
diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index 5668d8305b78..1b913e4b0319 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -365,7 +365,7 @@ static int ibm_cffps_read_word_data(struct i2c_client *client, int page,
 }
 
 static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	int rc;
 	u8 next_led_state;
diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 0b11990ade46..6bf2c3d62503 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -47,7 +47,7 @@ struct input_leds {
 	struct input_led leds[];
 };
 
-static enum led_brightness input_leds_brightness_get(struct led_classdev *cdev)
+static led_brightness input_leds_brightness_get(struct led_classdev *cdev)
 {
 	struct input_led *led = container_of(cdev, struct input_led, cdev);
 	struct input_dev *input = led->handle->dev;
@@ -56,7 +56,7 @@ static enum led_brightness input_leds_brightness_get(struct led_classdev *cdev)
 }
 
 static void input_leds_brightness_set(struct led_classdev *cdev,
-				      enum led_brightness brightness)
+				      led_brightness brightness)
 {
 	struct input_led *led = container_of(cdev, struct input_led, cdev);
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 29de8412e416..11229a897f6e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1433,7 +1433,7 @@ static void xpad_identify_controller(struct usb_xpad *xpad)
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
-			 enum led_brightness value)
+			 led_brightness value)
 {
 	struct xpad_led *xpad_led = container_of(led_cdev,
 						 struct xpad_led, led_cdev);
diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index eda1b23002b5..972cfa2b0940 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -918,7 +918,7 @@ static int applespi_set_capsl_led(struct applespi_data *applespi,
 }
 
 static void applespi_set_bl_level(struct led_classdev *led_cdev,
-				  enum led_brightness value)
+				  led_brightness value)
 {
 	struct applespi_data *applespi =
 		container_of(led_cdev, struct applespi_data, backlight_info);
diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 688e2bef682e..14d124f50678 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -229,7 +229,7 @@ static void cap11xx_input_close(struct input_dev *idev)
 
 #ifdef CONFIG_LEDS_CLASS
 static int cap11xx_led_set(struct led_classdev *cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
 	struct cap11xx_priv *priv = led->priv;
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 6c38d034ec6e..ddb1bb56196b 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -495,7 +495,7 @@ static void lm8323_pwm_work(struct work_struct *work)
 }
 
 static void lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
+				      led_brightness brightness)
 {
 	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
 	struct lm8323_chip *lm = pwm->chip;
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 32d4a076eaa3..2f7cb7d58bd4 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -47,7 +47,7 @@ struct qt2160_led {
 	struct led_classdev cdev;
 	char name[32];
 	int id;
-	enum led_brightness brightness;
+	led_brightness brightness;
 };
 #endif
 
@@ -68,7 +68,7 @@ static int qt2160_write(struct i2c_client *client, u8 reg, u8 data);
 #ifdef CONFIG_LEDS_CLASS
 
 static int qt2160_led_set(struct led_classdev *cdev,
-			  enum led_brightness value)
+			  led_brightness value)
 {
 	struct qt2160_led *led = container_of(cdev, struct qt2160_led, cdev);
 	struct qt2160_data *qt2160 = led->qt2160;
diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 6218b1c682ef..8e2ecff50cc7 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -84,7 +84,7 @@ static const struct touchkey_variant tc360_touchkey_variant = {
 };
 
 static int tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
-					    enum led_brightness brightness)
+					    led_brightness brightness)
 {
 	struct tm2_touchkey_data *touchkey =
 		container_of(led_dev, struct tm2_touchkey_data, led_dev);
diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index 7276657ad7ca..645f2c6f7850 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -112,7 +112,7 @@ static void apanel_poll(struct input_dev *idev)
 }
 
 static int mail_led_set(struct led_classdev *led,
-			 enum led_brightness value)
+			 led_brightness value)
 {
 	struct apanel *ap = container_of(led, struct apanel, mail_led);
 	u16 led_bits = value != LED_OFF ? 0x8000 : 0x0000;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6f38aa23a1ff..2f69007a3588 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -945,7 +945,7 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 #define IMS_PCU_MAX_BRIGHTNESS		31998
 
 static int ims_pcu_backlight_set_brightness(struct led_classdev *cdev,
-					    enum led_brightness value)
+					    led_brightness value)
 {
 	struct ims_pcu_backlight *backlight =
 			container_of(cdev, struct ims_pcu_backlight, cdev);
@@ -968,7 +968,7 @@ static int ims_pcu_backlight_set_brightness(struct led_classdev *cdev,
 	return error;
 }
 
-static enum led_brightness
+static led_brightness
 ims_pcu_backlight_get_brightness(struct led_classdev *cdev)
 {
 	struct ims_pcu_backlight *backlight =
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 80dfd72a02d3..bf2e393889d2 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -1037,14 +1037,14 @@ static bool bluetooth_enabled;
 
  /* led management */
 static void wistron_mail_led_set(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	bios_set_state(MAIL_LED, (value != LED_OFF) ? 1 : 0);
 }
 
 /* same as setting up wifi card, but for laptops on which the led is managed */
 static void wistron_wifi_led_set(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	bios_set_state(WIFI, (value != LED_OFF) ? 1 : 0);
 }
diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index bc11203c9cf7..7edb4a267ac6 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -107,7 +107,7 @@ struct stmfts_data {
 };
 
 static int stmfts_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness value)
+					led_brightness value)
 {
 	struct stmfts_data *sdata = container_of(led_cdev,
 					struct stmfts_data, led_cdev);
@@ -131,7 +131,7 @@ static int stmfts_brightness_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
-static enum led_brightness stmfts_brightness_get(struct led_classdev *led_cdev)
+static led_brightness stmfts_brightness_get(struct led_classdev *led_cdev)
 {
 	struct stmfts_data *sdata = container_of(led_cdev,
 						struct stmfts_data, led_cdev);
diff --git a/drivers/leds/TODO b/drivers/leds/TODO
index bfa60fa1d812..e1d771513b98 100644
--- a/drivers/leds/TODO
+++ b/drivers/leds/TODO
@@ -1,7 +1,7 @@
 -*- org -*-
 
 * On/off LEDs should have max_brightness of 1
-* Get rid of enum led_brightness
+* Get rid of led_brightness
 
 It is really an integer, as maximum is configurable. Get rid of it, or
 make it into typedef or something.
diff --git a/drivers/leds/blink/leds-lgm-sso.c b/drivers/leds/blink/leds-lgm-sso.c
index 7eb2f44f16be..fd8aaea03e03 100644
--- a/drivers/leds/blink/leds-lgm-sso.c
+++ b/drivers/leds/blink/leds-lgm-sso.c
@@ -230,7 +230,7 @@ static void sso_led_freq_set(struct sso_led_priv *priv, u32 pin, int freq_idx)
 }
 
 static void sso_led_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct sso_led_priv *priv;
 	struct sso_led_desc *desc;
@@ -263,11 +263,11 @@ static void sso_led_brightness_set(struct led_classdev *led_cdev,
 		gpiod_set_value(led->gpiod, val);
 }
 
-static enum led_brightness sso_led_brightness_get(struct led_classdev *led_cdev)
+static led_brightness sso_led_brightness_get(struct led_classdev *led_cdev)
 {
 	struct sso_led *led = cdev_to_sso_led_data(led_cdev);
 
-	return (enum led_brightness)led->desc.brightness;
+	return (led_brightness)led->desc.brightness;
 }
 
 static int
diff --git a/drivers/leds/flash/leds-rt4505.c b/drivers/leds/flash/leds-rt4505.c
index ee129ab7255d..7d015ce35c7d 100644
--- a/drivers/leds/flash/leds-rt4505.c
+++ b/drivers/leds/flash/leds-rt4505.c
@@ -50,7 +50,7 @@ struct rt4505_priv {
 };
 
 static int rt4505_torch_brightness_set(struct led_classdev *lcdev,
-				       enum led_brightness level)
+				       led_brightness level)
 {
 	struct rt4505_priv *priv =
 		container_of(lcdev, struct rt4505_priv, flash.led_cdev);
@@ -77,7 +77,7 @@ static int rt4505_torch_brightness_set(struct led_classdev *lcdev,
 	return ret;
 }
 
-static enum led_brightness rt4505_torch_brightness_get(
+static led_brightness rt4505_torch_brightness_get(
 						struct led_classdev *lcdev)
 {
 	struct rt4505_priv *priv =
diff --git a/drivers/leds/flash/leds-rt8515.c b/drivers/leds/flash/leds-rt8515.c
index 590bfa180d10..dd26374404c9 100644
--- a/drivers/leds/flash/leds-rt8515.c
+++ b/drivers/leds/flash/leds-rt8515.c
@@ -88,7 +88,7 @@ static void rt8515_gpio_brightness_commit(struct gpio_desc *gpiod,
 
 /* This is setting the torch light level */
 static int rt8515_led_brightness_set(struct led_classdev *led,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct led_classdev_flash *fled = lcdev_to_flcdev(led);
 	struct rt8515 *rt = to_rt8515(fled);
diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index e317408583df..06bee59c76db 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -13,7 +13,7 @@
 #include "leds.h"
 
 int led_mc_calc_color_components(struct led_classdev_mc *mcled_cdev,
-				 enum led_brightness brightness)
+				 led_brightness brightness)
 {
 	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
 	int i;
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 4e7b78a84149..c87b3e59436e 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -375,7 +375,7 @@ EXPORT_SYMBOL_GPL(devm_led_trigger_register);
 /* Simple LED Trigger Interface */
 
 void led_trigger_event(struct led_trigger *trig,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	struct led_classdev *led_cdev;
 	unsigned long flags;
diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
index 508d0d859f2e..b7a5f7428aac 100644
--- a/drivers/leds/leds-88pm860x.c
+++ b/drivers/leds/leds-88pm860x.c
@@ -64,7 +64,7 @@ static int led_power_set(struct pm860x_chip *chip, int port, int on)
 }
 
 static int pm860x_led_set(struct led_classdev *cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct pm860x_led *led = container_of(cdev, struct pm860x_led, cdev);
 	struct pm860x_chip *chip;
diff --git a/drivers/leds/leds-aat1290.c b/drivers/leds/leds-aat1290.c
index 589484b22c79..225f3f948887 100644
--- a/drivers/leds/leds-aat1290.c
+++ b/drivers/leds/leds-aat1290.c
@@ -55,7 +55,7 @@ struct aat1290_led_config_data {
 	/* external strobe capability */
 	bool has_external_strobe;
 	/* max LED brightness level */
-	enum led_brightness max_brightness;
+	led_brightness max_brightness;
 };
 
 struct aat1290_led {
@@ -138,7 +138,7 @@ static void aat1290_set_flash_safety_timer(struct aat1290_led *led,
 /* LED subsystem callbacks */
 
 static int aat1290_led_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct led_classdev_flash *fled_cdev = led_cdev_to_fled_cdev(led_cdev);
 	struct aat1290_led *led = fled_cdev_to_led(fled_cdev);
@@ -370,7 +370,7 @@ static void aat1290_init_flash_timeout(struct aat1290_led *led,
 }
 
 #if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
-static enum led_brightness aat1290_intensity_to_brightness(
+static led_brightness aat1290_intensity_to_brightness(
 					struct v4l2_flash *v4l2_flash,
 					s32 intensity)
 {
@@ -386,7 +386,7 @@ static enum led_brightness aat1290_intensity_to_brightness(
 }
 
 static s32 aat1290_brightness_to_intensity(struct v4l2_flash *v4l2_flash,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct led_classdev_flash *fled_cdev = v4l2_flash->fled_cdev;
 	struct aat1290_led *led = fled_cdev_to_led(fled_cdev);
diff --git a/drivers/leds/leds-acer-a500.c b/drivers/leds/leds-acer-a500.c
index 8cf0b11f4390..8bc7741cd337 100644
--- a/drivers/leds/leds-acer-a500.c
+++ b/drivers/leds/leds-acer-a500.c
@@ -35,7 +35,7 @@ static const struct reg_sequence a500_ec_orange_led_enable_seq[] = {
 };
 
 static int a500_ec_led_brightness_set(struct led_classdev *led_cdev,
-				      enum led_brightness value)
+				      led_brightness value)
 {
 	struct a500_led *led = container_of(led_cdev, struct a500_led, cdev);
 	struct reg_sequence control_seq[2];
diff --git a/drivers/leds/leds-adp5520.c b/drivers/leds/leds-adp5520.c
index 5a0cc7af2df8..7809e4b2eabd 100644
--- a/drivers/leds/leds-adp5520.c
+++ b/drivers/leds/leds-adp5520.c
@@ -27,7 +27,7 @@ struct adp5520_led {
 };
 
 static int adp5520_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct adp5520_led *led;
 
diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index a0df1fb28774..3d1b3ee8ab5e 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -79,7 +79,7 @@ struct an30259a {
 };
 
 static int an30259a_brightness_set(struct led_classdev *cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct an30259a_led *led;
 	int ret;
diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
index c409b80c236d..d3fc7aaed12b 100644
--- a/drivers/leds/leds-apu.c
+++ b/drivers/leds/leds-apu.c
@@ -64,7 +64,7 @@ struct apu_led_priv {
 /* LED profile */
 struct apu_led_profile {
 	const char *name;
-	enum led_brightness brightness;
+	led_brightness brightness;
 	unsigned long offset; /* for devm_ioremap */
 };
 
@@ -103,7 +103,7 @@ static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
 };
 MODULE_DEVICE_TABLE(dmi, apu_led_dmi_table);
 
-static void apu1_led_brightness_set(struct led_classdev *led, enum led_brightness value)
+static void apu1_led_brightness_set(struct led_classdev *led, led_brightness value)
 {
 	struct apu_led_priv *pled = cdev_to_priv(led);
 
diff --git a/drivers/leds/leds-ariel.c b/drivers/leds/leds-ariel.c
index 49e1bddaa15e..40982e594402 100644
--- a/drivers/leds/leds-ariel.c
+++ b/drivers/leds/leds-ariel.c
@@ -31,7 +31,7 @@ struct ariel_led {
 
 #define led_cdev_to_ariel_led(c) container_of(c, struct ariel_led, led_cdev)
 
-static enum led_brightness ariel_led_get(struct led_classdev *led_cdev)
+static led_brightness ariel_led_get(struct led_classdev *led_cdev)
 {
 	struct ariel_led *led = led_cdev_to_ariel_led(led_cdev);
 	unsigned int led_status = 0;
@@ -46,7 +46,7 @@ static enum led_brightness ariel_led_get(struct led_classdev *led_cdev)
 }
 
 static void ariel_led_set(struct led_classdev *led_cdev,
-			  enum led_brightness brightness)
+			  led_brightness brightness)
 {
 	struct ariel_led *led = led_cdev_to_ariel_led(led_cdev);
 
diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
index aa3f82be0a9c..80ad2f68e80d 100644
--- a/drivers/leds/leds-as3645a.c
+++ b/drivers/leds/leds-as3645a.c
@@ -309,7 +309,7 @@ static unsigned int as3645a_current_to_reg(struct as3645a *flash, bool is_flash,
 }
 
 static int as3645a_set_indicator_brightness(struct led_classdev *iled_cdev,
-					    enum led_brightness brightness)
+					    led_brightness brightness)
 {
 	struct as3645a *flash = iled_cdev_to_as3645a(iled_cdev);
 	int rval;
@@ -324,7 +324,7 @@ static int as3645a_set_indicator_brightness(struct led_classdev *iled_cdev,
 }
 
 static int as3645a_set_assist_brightness(struct led_classdev *fled_cdev,
-					 enum led_brightness brightness)
+					 led_brightness brightness)
 {
 	struct led_classdev_flash *fled = lcdev_to_flcdev(fled_cdev);
 	struct as3645a *flash = fled_to_as3645a(fled);
diff --git a/drivers/leds/leds-asic3.c b/drivers/leds/leds-asic3.c
index 8cbc1b8bafa5..d12d6dfbc445 100644
--- a/drivers/leds/leds-asic3.c
+++ b/drivers/leds/leds-asic3.c
@@ -34,7 +34,7 @@ static const unsigned int led_n_base[ASIC3_NUM_LEDS] = {
 };
 
 static void brightness_set(struct led_classdev *cdev,
-	enum led_brightness value)
+	led_brightness value)
 {
 	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 80d937454aee..4c5e9cab7ddf 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -150,7 +150,7 @@ static bool aw2013_chip_in_use(struct aw2013 *chip)
 }
 
 static int aw2013_brightness_set(struct led_classdev *cdev,
-				 enum led_brightness brightness)
+				 led_brightness brightness)
 {
 	struct aw2013_led *led = container_of(cdev, struct aw2013_led, cdev);
 	int ret, num;
diff --git a/drivers/leds/leds-bcm6328.c b/drivers/leds/leds-bcm6328.c
index 2d4d87957a30..50f912351346 100644
--- a/drivers/leds/leds-bcm6328.c
+++ b/drivers/leds/leds-bcm6328.c
@@ -125,7 +125,7 @@ static void bcm6328_led_mode(struct bcm6328_led *led, unsigned long value)
 }
 
 static void bcm6328_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct bcm6328_led *led =
 		container_of(led_cdev, struct bcm6328_led, cdev);
diff --git a/drivers/leds/leds-bcm6358.c b/drivers/leds/leds-bcm6358.c
index 9d2e487fa08a..684a99989033 100644
--- a/drivers/leds/leds-bcm6358.c
+++ b/drivers/leds/leds-bcm6358.c
@@ -73,7 +73,7 @@ static unsigned long bcm6358_led_busy(void __iomem *mem)
 }
 
 static void bcm6358_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct bcm6358_led *led =
 		container_of(led_cdev, struct bcm6358_led, cdev);
diff --git a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
index 8bbaef5a2986..222dfe42dd58 100644
--- a/drivers/leds/leds-bd2802.c
+++ b/drivers/leds/leds-bd2802.c
@@ -516,7 +516,7 @@ static struct device_attribute *bd2802_attributes[] = {
 
 #define BD2802_CONTROL_RGBS(name, id, clr)				\
 static int bd2802_set_##name##_brightness(struct led_classdev *led_cdev,\
-					enum led_brightness value)	\
+					led_brightness value)	\
 {									\
 	struct bd2802_led *led =					\
 		container_of(led_cdev, struct bd2802_led, cdev_##name);	\
diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
index bd7d0d5cf3b6..fe097c4bece3 100644
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -420,7 +420,7 @@ static int blinkm_transfer_hw(struct i2c_client *client, int cmd)
 }
 
 static int blinkm_led_common_set(struct led_classdev *led_cdev,
-				 enum led_brightness value, int color)
+				 led_brightness value, int color)
 {
 	/* led_brightness is 0, 127 or 255 - we just use it here as-is */
 	struct blinkm_led *led = cdev_to_blmled(led_cdev);
@@ -461,19 +461,19 @@ static int blinkm_led_common_set(struct led_classdev *led_cdev,
 }
 
 static int blinkm_led_red_set(struct led_classdev *led_cdev,
-			       enum led_brightness value)
+			       led_brightness value)
 {
 	return blinkm_led_common_set(led_cdev, value, RED);
 }
 
 static int blinkm_led_green_set(struct led_classdev *led_cdev,
-				 enum led_brightness value)
+				 led_brightness value)
 {
 	return blinkm_led_common_set(led_cdev, value, GREEN);
 }
 
 static int blinkm_led_blue_set(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	return blinkm_led_common_set(led_cdev, value, BLUE);
 }
diff --git a/drivers/leds/leds-clevo-mail.c b/drivers/leds/leds-clevo-mail.c
index f512e99b976b..9b4deac29eb0 100644
--- a/drivers/leds/leds-clevo-mail.c
+++ b/drivers/leds/leds-clevo-mail.c
@@ -93,7 +93,7 @@ static const struct dmi_system_id clevo_mail_led_dmi_table[] __initconst = {
 MODULE_DEVICE_TABLE(dmi, clevo_mail_led_dmi_table);
 
 static void clevo_mail_led_set(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	i8042_lock_chip();
 
diff --git a/drivers/leds/leds-cobalt-qube.c b/drivers/leds/leds-cobalt-qube.c
index ef22e1e94048..f4faa55214e9 100644
--- a/drivers/leds/leds-cobalt-qube.c
+++ b/drivers/leds/leds-cobalt-qube.c
@@ -18,7 +18,7 @@ static void __iomem *led_port;
 static u8 led_value;
 
 static void qube_front_led_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
+			       led_brightness brightness)
 {
 	if (brightness)
 		led_value = LED_FRONT_LEFT | LED_FRONT_RIGHT;
diff --git a/drivers/leds/leds-cobalt-raq.c b/drivers/leds/leds-cobalt-raq.c
index 045c239c7328..7c13af9d67a8 100644
--- a/drivers/leds/leds-cobalt-raq.c
+++ b/drivers/leds/leds-cobalt-raq.c
@@ -21,7 +21,7 @@ static u8 led_value;
 static DEFINE_SPINLOCK(led_value_lock);
 
 static void raq_web_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness brightness)
+			    led_brightness brightness)
 {
 	unsigned long flags;
 
@@ -42,7 +42,7 @@ static struct led_classdev raq_web_led = {
 };
 
 static void raq_power_off_led_set(struct led_classdev *led_cdev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	unsigned long flags;
 
diff --git a/drivers/leds/leds-cpcap.c b/drivers/leds/leds-cpcap.c
index 7d41ce8c9bb1..0ab3247c9414 100644
--- a/drivers/leds/leds-cpcap.c
+++ b/drivers/leds/leds-cpcap.c
@@ -100,7 +100,7 @@ static int cpcap_led_set_power(struct cpcap_led *led, bool status)
 	return 0;
 }
 
-static int cpcap_led_set(struct led_classdev *ledc, enum led_brightness value)
+static int cpcap_led_set(struct led_classdev *ledc, led_brightness value)
 {
 	struct cpcap_led *led = container_of(ledc, struct cpcap_led, led);
 	int brightness;
diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index d03cfd3c0bfb..e25e700b8fc9 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -160,7 +160,7 @@ static void cr0014114_recount_work(struct work_struct *work)
 }
 
 static int cr0014114_set_sync(struct led_classdev *ldev,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	int			ret;
 	struct cr0014114_led    *led = container_of(ldev,
diff --git a/drivers/leds/leds-da903x.c b/drivers/leds/leds-da903x.c
index 2b5fb00438a2..3f61e8444ff8 100644
--- a/drivers/leds/leds-da903x.c
+++ b/drivers/leds/leds-da903x.c
@@ -38,7 +38,7 @@ struct da903x_led {
 #define DA9034_LED_OFFSET(id)	((id) - DA9034_ID_LED_1)
 
 static int da903x_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct da903x_led *led =
 			container_of(led_cdev, struct da903x_led, cdev);
diff --git a/drivers/leds/leds-da9052.c b/drivers/leds/leds-da9052.c
index 04060c862bf9..0e963f78d3d8 100644
--- a/drivers/leds/leds-da9052.c
+++ b/drivers/leds/leds-da9052.c
@@ -37,7 +37,7 @@ static unsigned char led_reg[] = {
 };
 
 static int da9052_set_led_brightness(struct da9052_led *led,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	u8 val;
 	int error;
@@ -52,7 +52,7 @@ static int da9052_set_led_brightness(struct da9052_led *led,
 }
 
 static int da9052_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct da9052_led *led =
 			container_of(led_cdev, struct da9052_led, cdev);
diff --git a/drivers/leds/leds-dac124s085.c b/drivers/leds/leds-dac124s085.c
index 20dc9b9d7dea..a02ee0007c40 100644
--- a/drivers/leds/leds-dac124s085.c
+++ b/drivers/leds/leds-dac124s085.c
@@ -31,7 +31,7 @@ struct dac124s085 {
 #define POWER_DOWN_OUTPUT	(3 << 12)
 
 static int dac124s085_set_brightness(struct led_classdev *ldev,
-				      enum led_brightness brightness)
+				      led_brightness brightness)
 {
 	struct dac124s085_led *led = container_of(ldev, struct dac124s085_led,
 						  ldev);
diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
index 76b455e87574..0ec8d62f871c 100644
--- a/drivers/leds/leds-el15203000.c
+++ b/drivers/leds/leds-el15203000.c
@@ -128,7 +128,7 @@ static int el15203000_cmd(struct el15203000_led *led, u8 brightness)
 }
 
 static int el15203000_set_blocking(struct led_classdev *ldev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct el15203000_led *led = to_el15203000_led(ldev);
 
diff --git a/drivers/leds/leds-fsg.c b/drivers/leds/leds-fsg.c
index bc6b420637d6..84dac4a372ee 100644
--- a/drivers/leds/leds-fsg.c
+++ b/drivers/leds/leds-fsg.c
@@ -30,7 +30,7 @@ static unsigned short latch_value;
 
 
 static void fsg_led_wlan_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	if (value) {
 		latch_value &= ~(1 << FSG_LED_WLAN_BIT);
@@ -42,7 +42,7 @@ static void fsg_led_wlan_set(struct led_classdev *led_cdev,
 }
 
 static void fsg_led_wan_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	if (value) {
 		latch_value &= ~(1 << FSG_LED_WAN_BIT);
@@ -54,7 +54,7 @@ static void fsg_led_wan_set(struct led_classdev *led_cdev,
 }
 
 static void fsg_led_sata_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	if (value) {
 		latch_value &= ~(1 << FSG_LED_SATA_BIT);
@@ -66,7 +66,7 @@ static void fsg_led_sata_set(struct led_classdev *led_cdev,
 }
 
 static void fsg_led_usb_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	if (value) {
 		latch_value &= ~(1 << FSG_LED_USB_BIT);
@@ -78,7 +78,7 @@ static void fsg_led_usb_set(struct led_classdev *led_cdev,
 }
 
 static void fsg_led_sync_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	if (value) {
 		latch_value &= ~(1 << FSG_LED_SYNC_BIT);
@@ -90,7 +90,7 @@ static void fsg_led_sync_set(struct led_classdev *led_cdev,
 }
 
 static void fsg_led_ring_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	if (value) {
 		latch_value &= ~(1 << FSG_LED_RING_BIT);
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index b5d5e22d2d1e..417bc44477f6 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -32,7 +32,7 @@ static inline struct gpio_led_data *
 }
 
 static void gpio_led_set(struct led_classdev *led_cdev,
-	enum led_brightness value)
+	led_brightness value)
 {
 	struct gpio_led_data *led_dat = cdev_to_gpio_led_data(led_cdev);
 	int level;
@@ -55,7 +55,7 @@ static void gpio_led_set(struct led_classdev *led_cdev,
 }
 
 static int gpio_led_set_blocking(struct led_classdev *led_cdev,
-	enum led_brightness value)
+	led_brightness value)
 {
 	gpio_led_set(led_cdev, value);
 	return 0;
diff --git a/drivers/leds/leds-hp6xx.c b/drivers/leds/leds-hp6xx.c
index 54af9e63c09c..e328a47fd1fa 100644
--- a/drivers/leds/leds-hp6xx.c
+++ b/drivers/leds/leds-hp6xx.c
@@ -15,7 +15,7 @@
 #include <mach/hp6xx.h>
 
 static void hp6xxled_green_set(struct led_classdev *led_cdev,
-			       enum led_brightness value)
+			       led_brightness value)
 {
 	u8 v8;
 
@@ -27,7 +27,7 @@ static void hp6xxled_green_set(struct led_classdev *led_cdev,
 }
 
 static void hp6xxled_red_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	u16 v16;
 
diff --git a/drivers/leds/leds-ip30.c b/drivers/leds/leds-ip30.c
index 1f952bad0fe8..927a7e6115be 100644
--- a/drivers/leds/leds-ip30.c
+++ b/drivers/leds/leds-ip30.c
@@ -18,7 +18,7 @@ struct ip30_led {
 };
 
 static void ip30led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct ip30_led *led = container_of(led_cdev, struct ip30_led, cdev);
 
diff --git a/drivers/leds/leds-ipaq-micro.c b/drivers/leds/leds-ipaq-micro.c
index 504a95b6ef45..e855987501b7 100644
--- a/drivers/leds/leds-ipaq-micro.c
+++ b/drivers/leds/leds-ipaq-micro.c
@@ -19,7 +19,7 @@
 #define LED_ALWAYS   (1 << 6) /* LED Interrupt Mask 0:No mask, 1:mask         */
 
 static int micro_leds_brightness_set(struct led_classdev *led_cdev,
-				      enum led_brightness value)
+				      led_brightness value)
 {
 	struct ipaq_micro *micro = dev_get_drvdata(led_cdev->dev->parent->parent);
 	/*
diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 4161b9dd7e48..d994c55a1129 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -108,7 +108,7 @@ static const struct of_device_id of_is31fl319x_match[] = {
 MODULE_DEVICE_TABLE(of, of_is31fl319x_match);
 
 static int is31fl319x_brightness_set(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct is31fl319x_led *led = container_of(cdev, struct is31fl319x_led,
 						  cdev);
diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index 3b55af9a8c58..4e1fe2759cb9 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -221,7 +221,7 @@ static int is31fl3216_software_shutdown(struct is31fl32xx_priv *priv,
  * register writes up to that point.
  */
 static int is31fl32xx_brightness_set(struct led_classdev *led_cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	const struct is31fl32xx_led_data *led_data =
 		container_of(led_cdev, struct is31fl32xx_led_data, cdev);
diff --git a/drivers/leds/leds-ktd2692.c b/drivers/leds/leds-ktd2692.c
index f341da1503a4..6f5ea1ff41d7 100644
--- a/drivers/leds/leds-ktd2692.c
+++ b/drivers/leds/leds-ktd2692.c
@@ -68,7 +68,7 @@ struct ktd2692_led_config_data {
 	/* maximum flash timeout */
 	u32 flash_max_timeout;
 	/* max LED brightness level */
-	enum led_brightness max_brightness;
+	led_brightness max_brightness;
 };
 
 struct ktd2692_context {
@@ -83,7 +83,7 @@ struct ktd2692_context {
 	struct gpio_desc *ctrl_gpio;
 
 	enum ktd2692_led_mode mode;
-	enum led_brightness torch_brightness;
+	led_brightness torch_brightness;
 };
 
 static struct ktd2692_context *fled_cdev_to_led(
@@ -154,7 +154,7 @@ static void ktd2692_expresswire_write(struct ktd2692_context *led, u8 value)
 }
 
 static int ktd2692_led_brightness_set(struct led_classdev *led_cdev,
-				       enum led_brightness brightness)
+				       led_brightness brightness)
 {
 	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(led_cdev);
 	struct ktd2692_context *led = fled_cdev_to_led(fled_cdev);
diff --git a/drivers/leds/leds-lm3530.c b/drivers/leds/leds-lm3530.c
index e72393534b72..754db3ef45e1 100644
--- a/drivers/leds/leds-lm3530.c
+++ b/drivers/leds/leds-lm3530.c
@@ -108,7 +108,7 @@ struct lm3530_data {
 	struct lm3530_platform_data *pdata;
 	enum lm3530_mode mode;
 	struct regulator *regulator;
-	enum led_brightness brightness;
+	led_brightness brightness;
 	bool enable;
 };
 
@@ -302,7 +302,7 @@ static int lm3530_init_registers(struct lm3530_data *drvdata)
 }
 
 static void lm3530_brightness_set(struct led_classdev *led_cdev,
-				     enum led_brightness brt_val)
+				     led_brightness brt_val)
 {
 	int err;
 	struct lm3530_data *drvdata =
diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index beb53040e09e..9c39d38c6c5d 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -344,7 +344,7 @@ static int lm3532_led_disable(struct lm3532_led *led_data)
 }
 
 static int lm3532_brightness_set(struct led_classdev *led_cdev,
-				 enum led_brightness brt_val)
+				 led_brightness brt_val)
 {
 	struct lm3532_led *led =
 			container_of(led_cdev, struct lm3532_led, led_dev);
diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 43d5970d96aa..f415a3071947 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -116,7 +116,7 @@ static int lm3533_led_pattern_enable(struct lm3533_led *led, int enable)
 }
 
 static int lm3533_led_set(struct led_classdev *cdev,
-						enum led_brightness value)
+						led_brightness value)
 {
 	struct lm3533_led *led = to_lm3533_led(cdev);
 
@@ -128,7 +128,7 @@ static int lm3533_led_set(struct led_classdev *cdev,
 	return lm3533_ctrlbank_set_brightness(&led->cb, value);
 }
 
-static enum led_brightness lm3533_led_get(struct led_classdev *cdev)
+static led_brightness lm3533_led_get(struct led_classdev *cdev)
 {
 	struct lm3533_led *led = to_lm3533_led(cdev);
 	u8 val;
diff --git a/drivers/leds/leds-lm355x.c b/drivers/leds/leds-lm355x.c
index 2d3e11845ba5..4a14d6552f10 100644
--- a/drivers/leds/leds-lm355x.c
+++ b/drivers/leds/leds-lm355x.c
@@ -306,7 +306,7 @@ static int lm355x_control(struct lm355x_chip_data *chip,
 /* torch */
 
 static int lm355x_torch_brightness_set(struct led_classdev *cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct lm355x_chip_data *chip =
 	    container_of(cdev, struct lm355x_chip_data, cdev_torch);
@@ -321,7 +321,7 @@ static int lm355x_torch_brightness_set(struct led_classdev *cdev,
 /* flash */
 
 static int lm355x_strobe_brightness_set(struct led_classdev *cdev,
-					 enum led_brightness brightness)
+					 led_brightness brightness)
 {
 	struct lm355x_chip_data *chip =
 	    container_of(cdev, struct lm355x_chip_data, cdev_flash);
@@ -336,7 +336,7 @@ static int lm355x_strobe_brightness_set(struct led_classdev *cdev,
 /* indicator */
 
 static int lm355x_indicator_brightness_set(struct led_classdev *cdev,
-					    enum led_brightness brightness)
+					    led_brightness brightness)
 {
 	struct lm355x_chip_data *chip =
 	    container_of(cdev, struct lm355x_chip_data, cdev_indicator);
diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
index d0e1d4814042..d1670b7fbf85 100644
--- a/drivers/leds/leds-lm3601x.c
+++ b/drivers/leds/leds-lm3601x.c
@@ -168,7 +168,7 @@ static int lm3601x_read_faults(struct lm3601x_led *led)
 }
 
 static int lm3601x_brightness_set(struct led_classdev *cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(cdev);
 	struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
diff --git a/drivers/leds/leds-lm36274.c b/drivers/leds/leds-lm36274.c
index e009b6d17915..0272f59a28f3 100644
--- a/drivers/leds/leds-lm36274.c
+++ b/drivers/leds/leds-lm36274.c
@@ -42,7 +42,7 @@ struct lm36274 {
 };
 
 static int lm36274_brightness_set(struct led_classdev *led_cdev,
-				  enum led_brightness brt_val)
+				  led_brightness brt_val)
 {
 	struct lm36274 *chip = container_of(led_cdev, struct lm36274, led_dev);
 
diff --git a/drivers/leds/leds-lm3642.c b/drivers/leds/leds-lm3642.c
index 435309154e6b..c97b28010c4a 100644
--- a/drivers/leds/leds-lm3642.c
+++ b/drivers/leds/leds-lm3642.c
@@ -196,7 +196,7 @@ static ssize_t torch_pin_store(struct device *dev,
 static DEVICE_ATTR_WO(torch_pin);
 
 static int lm3642_torch_brightness_set(struct led_classdev *cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct lm3642_chip_data *chip =
 	    container_of(cdev, struct lm3642_chip_data, cdev_torch);
@@ -243,7 +243,7 @@ static ssize_t strobe_pin_store(struct device *dev,
 static DEVICE_ATTR_WO(strobe_pin);
 
 static int lm3642_strobe_brightness_set(struct led_classdev *cdev,
-					 enum led_brightness brightness)
+					 led_brightness brightness)
 {
 	struct lm3642_chip_data *chip =
 	    container_of(cdev, struct lm3642_chip_data, cdev_flash);
@@ -258,7 +258,7 @@ static int lm3642_strobe_brightness_set(struct led_classdev *cdev,
 
 /* indicator */
 static int lm3642_indicator_brightness_set(struct led_classdev *cdev,
-					    enum led_brightness brightness)
+					    led_brightness brightness)
 {
 	struct lm3642_chip_data *chip =
 	    container_of(cdev, struct lm3642_chip_data, cdev_indicator);
diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index a02756d7ed8f..e19cf9c3f139 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -323,7 +323,7 @@ static int lm3692x_leds_disable(struct lm3692x_led *led)
 }
 
 static int lm3692x_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness brt_val)
+				led_brightness brt_val)
 {
 	struct lm3692x_led *led =
 			container_of(led_cdev, struct lm3692x_led, led_dev);
@@ -362,7 +362,7 @@ static int lm3692x_brightness_set(struct led_classdev *led_cdev,
 	return ret;
 }
 
-static enum led_brightness lm3692x_max_brightness(struct lm3692x_led *led,
+static led_brightness lm3692x_max_brightness(struct lm3692x_led *led,
 						  u32 max_cur)
 {
 	u32 max_code;
diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
index 970a4f34791b..3ef3a6945a80 100644
--- a/drivers/leds/leds-lm3697.c
+++ b/drivers/leds/leds-lm3697.c
@@ -115,7 +115,7 @@ static const struct regmap_config lm3697_regmap_config = {
 };
 
 static int lm3697_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness brt_val)
+				led_brightness brt_val)
 {
 	struct lm3697_led *led = container_of(led_cdev, struct lm3697_led,
 					      led_dev);
diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
index 42dc46e3f00f..d89abad2c7a2 100644
--- a/drivers/leds/leds-locomo.c
+++ b/drivers/leds/leds-locomo.c
@@ -15,7 +15,7 @@
 #include <asm/hardware/locomo.h>
 
 static void locomoled_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness value, int offset)
+				led_brightness value, int offset)
 {
 	struct locomo_dev *locomo_dev = LOCOMO_DEV(led_cdev->dev->parent);
 	unsigned long flags;
@@ -29,13 +29,13 @@ static void locomoled_brightness_set(struct led_classdev *led_cdev,
 }
 
 static void locomoled_brightness_set0(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT0);
 }
 
 static void locomoled_brightness_set1(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	locomoled_brightness_set(led_cdev, value, LOCOMO_LPT1);
 }
diff --git a/drivers/leds/leds-lp3944.c b/drivers/leds/leds-lp3944.c
index 437c711b2a27..a6d42136b7ae 100644
--- a/drivers/leds/leds-lp3944.c
+++ b/drivers/leds/leds-lp3944.c
@@ -277,7 +277,7 @@ static int lp3944_led_set_blink(struct led_classdev *led_cdev,
 }
 
 static int lp3944_led_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
+				      led_brightness brightness)
 {
 	struct lp3944_led_data *led = ldev_to_led(led_cdev);
 
@@ -321,7 +321,7 @@ static int lp3944_configure(struct i2c_client *client,
 
 			/* to expose the default value to userspace */
 			led->ldev.brightness =
-					(enum led_brightness) pled->status;
+					(led_brightness) pled->status;
 
 			/* Set the default led status */
 			err = lp3944_led_set(led, pled->status);
diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
index 6ee9131fbf25..2631c5ed5f75 100644
--- a/drivers/leds/leds-lp3952.c
+++ b/drivers/leds/leds-lp3952.c
@@ -56,7 +56,7 @@ static void lp3952_on_off(struct lp3952_led_array *priv,
  * values 0-4. 0 meaning turn off.
  */
 static int lp3952_set_brightness(struct led_classdev *cdev,
-				 enum led_brightness value)
+				 led_brightness value)
 {
 	unsigned int reg, shift_val;
 	struct lp3952_ctrl_hdl *led = container_of(cdev,
diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 401df1e2e05d..2cf25efeb45a 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -303,7 +303,7 @@ static struct lp50xx_led *mcled_cdev_to_led(struct led_classdev_mc *mc_cdev)
 }
 
 static int lp50xx_brightness_set(struct led_classdev *cdev,
-			     enum led_brightness brightness)
+			     led_brightness brightness)
 {
 	struct led_classdev_mc *mc_dev = lcdev_to_mccdev(cdev);
 	struct lp50xx_led *led = mcled_cdev_to_led(mc_dev);
diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index d1657c46ee2f..2f7978102fa5 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -135,7 +135,7 @@ static struct attribute *lp55xx_led_attrs[] = {
 ATTRIBUTE_GROUPS(lp55xx_led);
 
 static int lp55xx_set_mc_brightness(struct led_classdev *cdev,
-				    enum led_brightness brightness)
+				    led_brightness brightness)
 {
 	struct led_classdev_mc *mc_dev = lcdev_to_mccdev(cdev);
 	struct lp55xx_led *led = mcled_cdev_to_led(mc_dev);
@@ -147,7 +147,7 @@ static int lp55xx_set_mc_brightness(struct led_classdev *cdev,
 }
 
 static int lp55xx_set_brightness(struct led_classdev *cdev,
-			     enum led_brightness brightness)
+			     led_brightness brightness)
 {
 	struct lp55xx_led *led = cdev_to_lp55xx_led(cdev);
 	struct lp55xx_device_config *cfg = led->chip->cfg;
diff --git a/drivers/leds/leds-lp8788.c b/drivers/leds/leds-lp8788.c
index 9b9525ccca15..134673b5267c 100644
--- a/drivers/leds/leds-lp8788.c
+++ b/drivers/leds/leds-lp8788.c
@@ -86,7 +86,7 @@ static int lp8788_led_enable(struct lp8788_led *led,
 }
 
 static int lp8788_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness val)
+				led_brightness val)
 {
 	struct lp8788_led *led =
 			container_of(led_cdev, struct lp8788_led, led_dev);
diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 3c693d5e3b44..d9d733556856 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -203,7 +203,7 @@ static int lp8860_fault_check(struct lp8860_led *led)
 }
 
 static int lp8860_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness brt_val)
+				led_brightness brt_val)
 {
 	struct lp8860_led *led =
 			container_of(led_cdev, struct lp8860_led, led_dev);
diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
index 3bb52d3165d9..90627b412d24 100644
--- a/drivers/leds/leds-lt3593.c
+++ b/drivers/leds/leds-lt3593.c
@@ -19,7 +19,7 @@ struct lt3593_led_data {
 };
 
 static int lt3593_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct lt3593_led_data *led_dat =
 		container_of(led_cdev, struct lt3593_led_data, cdev);
diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
index 1eeac56b0014..51809e407cf0 100644
--- a/drivers/leds/leds-max77650.c
+++ b/drivers/leds/leds-max77650.c
@@ -45,7 +45,7 @@ static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
 }
 
 static int max77650_led_brightness_set(struct led_classdev *cdev,
-				       enum led_brightness brightness)
+				       led_brightness brightness)
 {
 	struct max77650_led *led = max77650_to_led(cdev);
 	int val, mask;
diff --git a/drivers/leds/leds-max77693.c b/drivers/leds/leds-max77693.c
index 5c1faeb55a31..a79d99aa11bb 100644
--- a/drivers/leds/leds-max77693.c
+++ b/drivers/leds/leds-max77693.c
@@ -459,7 +459,7 @@ static int max77693_setup(struct max77693_led_device *led,
 
 /* LED subsystem callbacks */
 static int max77693_led_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness value)
+					led_brightness value)
 {
 	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(led_cdev);
 	struct max77693_sub_led *sub_led = flcdev_to_sub_led(fled_cdev);
diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
index c0bddb33888d..7cd0b7887822 100644
--- a/drivers/leds/leds-max8997.c
+++ b/drivers/leds/leds-max8997.c
@@ -114,7 +114,7 @@ static void max8997_led_enable(struct max8997_led *led, bool enable)
 }
 
 static void max8997_led_set_current(struct max8997_led *led,
-				enum led_brightness value)
+				led_brightness value)
 {
 	int ret;
 	struct i2c_client *client = led->iodev->i2c;
@@ -146,7 +146,7 @@ static void max8997_led_set_current(struct max8997_led *led,
 }
 
 static void max8997_led_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	struct max8997_led *led =
 			container_of(led_cdev, struct max8997_led, cdev);
diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index 675502c15c2b..ec839541a4cf 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -50,7 +50,7 @@ static unsigned int mc13xxx_max_brightness(int id)
 }
 
 static int mc13xxx_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct mc13xxx_led *led =
 		container_of(led_cdev, struct mc13xxx_led, cdev);
diff --git a/drivers/leds/leds-menf21bmc.c b/drivers/leds/leds-menf21bmc.c
index 6b1b47160602..3122de6788f3 100644
--- a/drivers/leds/leds-menf21bmc.c
+++ b/drivers/leds/leds-menf21bmc.c
@@ -50,7 +50,7 @@ static struct menf21bmc_led leds[] = {
 static DEFINE_MUTEX(led_lock);
 
 static void
-menf21bmc_led_set(struct led_classdev *led_cdev, enum led_brightness value)
+menf21bmc_led_set(struct led_classdev *led_cdev, led_brightness value)
 {
 	int led_val;
 	struct menf21bmc_led *led = container_of(led_cdev,
diff --git a/drivers/leds/leds-mlxcpld.c b/drivers/leds/leds-mlxcpld.c
index 1355c84a2919..4209bea434f8 100644
--- a/drivers/leds/leds-mlxcpld.c
+++ b/drivers/leds/leds-mlxcpld.c
@@ -99,7 +99,7 @@ struct mlxcpld_led_profile {
 	u8 offset;
 	u8 mask;
 	u8 base_color;
-	enum led_brightness brightness;
+	led_brightness brightness;
 	const char *name;
 };
 
@@ -280,7 +280,7 @@ static void mlxcpld_led_store_hw(u8 mask, u8 off, u8 vset)
 }
 
 static void mlxcpld_led_brightness_set(struct led_classdev *led,
-				       enum led_brightness value)
+				       led_brightness value)
 {
 	struct mlxcpld_led_priv *pled = cdev_to_priv(led);
 
diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c93bd72..5a242ca81e45 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -95,7 +95,7 @@ mlxreg_led_store_hw(struct mlxreg_led_data *led_data, u8 vset)
 	return ret;
 }
 
-static enum led_brightness
+static led_brightness
 mlxreg_led_get_hw(struct mlxreg_led_data *led_data)
 {
 	struct mlxreg_led_priv_data *priv = led_data->data_parent;
@@ -133,7 +133,7 @@ mlxreg_led_get_hw(struct mlxreg_led_data *led_data)
 }
 
 static int
-mlxreg_led_brightness_set(struct led_classdev *cled, enum led_brightness value)
+mlxreg_led_brightness_set(struct led_classdev *cled, led_brightness value)
 {
 	struct mlxreg_led_data *led_data = cdev_to_priv(cled);
 
@@ -143,7 +143,7 @@ mlxreg_led_brightness_set(struct led_classdev *cled, enum led_brightness value)
 		return mlxreg_led_store_hw(led_data, MLXREG_LED_IS_OFF);
 }
 
-static enum led_brightness
+static led_brightness
 mlxreg_led_brightness_get(struct led_classdev *cled)
 {
 	struct mlxreg_led_data *led_data = cdev_to_priv(cled);
@@ -188,7 +188,7 @@ static int mlxreg_led_config(struct mlxreg_led_priv_data *priv)
 	struct mlxreg_core_data *data = led_pdata->data;
 	struct mlxreg_led_data *led_data;
 	struct led_classdev *led_cdev;
-	enum led_brightness brightness;
+	led_brightness brightness;
 	u32 regval;
 	int i;
 	int err;
diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index f59e0e8bda8b..464d1096d2ed 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -83,7 +83,7 @@ struct mt6323_led {
 	int			id;
 	struct mt6323_leds	*parent;
 	struct led_classdev	cdev;
-	enum led_brightness	current_brightness;
+	led_brightness	current_brightness;
 };
 
 /**
@@ -105,7 +105,7 @@ struct mt6323_leds {
 };
 
 static int mt6323_led_hw_brightness(struct led_classdev *cdev,
-				    enum led_brightness brightness)
+				    led_brightness brightness)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
 	struct mt6323_leds *leds = led->parent;
@@ -153,7 +153,7 @@ static int mt6323_led_hw_off(struct led_classdev *cdev)
 	return 0;
 }
 
-static enum led_brightness
+static led_brightness
 mt6323_get_led_hw_brightness(struct led_classdev *cdev)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
@@ -185,7 +185,7 @@ mt6323_get_led_hw_brightness(struct led_classdev *cdev)
 }
 
 static int mt6323_led_hw_on(struct led_classdev *cdev,
-			    enum led_brightness brightness)
+			    led_brightness brightness)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
 	struct mt6323_leds *leds = led->parent;
@@ -306,7 +306,7 @@ static int mt6323_led_set_blink(struct led_classdev *cdev,
 }
 
 static int mt6323_led_set_brightness(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
 	struct mt6323_leds *leds = led->parent;
diff --git a/drivers/leds/leds-net48xx.c b/drivers/leds/leds-net48xx.c
index a93468c13772..a963e51acb65 100644
--- a/drivers/leds/leds-net48xx.c
+++ b/drivers/leds/leds-net48xx.c
@@ -23,7 +23,7 @@
 static struct platform_device *pdev;
 
 static void net48xx_error_led_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
+		led_brightness value)
 {
 	scx200_gpio_ops.gpio_set(NET48XX_ERROR_LED_GPIO, value ? 1 : 0);
 }
diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d..fd9c07f545a0 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -166,7 +166,7 @@ static int netxbig_led_blink_set(struct led_classdev *led_cdev,
 }
 
 static void netxbig_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct netxbig_led_data *led_dat =
 		container_of(led_cdev, struct netxbig_led_data, cdev);
diff --git a/drivers/leds/leds-nic78bx.c b/drivers/leds/leds-nic78bx.c
index f196f52eec1e..98764072afca 100644
--- a/drivers/leds/leds-nic78bx.c
+++ b/drivers/leds/leds-nic78bx.c
@@ -42,7 +42,7 @@ static inline struct nic78bx_led *to_nic78bx_led(struct led_classdev *cdev)
 }
 
 static void nic78bx_brightness_set(struct led_classdev *cdev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	struct nic78bx_led *nled = to_nic78bx_led(cdev);
 	unsigned long flags;
@@ -62,7 +62,7 @@ static void nic78bx_brightness_set(struct led_classdev *cdev,
 	spin_unlock_irqrestore(&nled->data->lock, flags);
 }
 
-static enum led_brightness nic78bx_brightness_get(struct led_classdev *cdev)
+static led_brightness nic78bx_brightness_get(struct led_classdev *cdev)
 {
 	struct nic78bx_led *nled = to_nic78bx_led(cdev);
 	unsigned long flags;
diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index 1677d66d8b0e..7ffa6c4d7563 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -101,7 +101,7 @@ static void ns2_led_set_mode(struct ns2_led *led, enum ns2_led_modes mode)
 }
 
 static void ns2_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct ns2_led *led = container_of(led_cdev, struct ns2_led, cdev);
 	enum ns2_led_modes mode;
@@ -117,7 +117,7 @@ static void ns2_led_set(struct led_classdev *led_cdev,
 }
 
 static int ns2_led_set_blocking(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	ns2_led_set(led_cdev, value);
 	return 0;
diff --git a/drivers/leds/leds-ot200.c b/drivers/leds/leds-ot200.c
index 12af1127d9b7..9244d6fcafc1 100644
--- a/drivers/leds/leds-ot200.c
+++ b/drivers/leds/leds-ot200.c
@@ -90,7 +90,7 @@ static u8 leds_back;
 static u8 leds_front;
 
 static void ot200_led_brightness_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
+		led_brightness value)
 {
 	struct ot200_led *led = container_of(led_cdev, struct ot200_led, cdev);
 	u8 *val;
diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index 017794bb87ae..b76a4fb4ede4 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -114,7 +114,7 @@ static struct i2c_driver pca9532_driver = {
  * leds that are not ON/OFF.
  * */
 static int pca9532_calcpwm(struct i2c_client *client, int pwm, int blink,
-	enum led_brightness value)
+	led_brightness value)
 {
 	int a = 0, b = 0, i = 0;
 	struct pca9532_data *data = i2c_get_clientdata(client);
@@ -172,7 +172,7 @@ static void pca9532_setled(struct pca9532_led *led)
 }
 
 static int pca9532_set_brightness(struct led_classdev *led_cdev,
-	enum led_brightness value)
+	led_brightness value)
 {
 	int err = 0;
 	struct pca9532_led *led = ldev_to_led(led_cdev);
diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 7087ca4592fc..11262219dc9b 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -237,7 +237,7 @@ static int pca955x_read_ls(struct i2c_client *client, int n, u8 *val)
 }
 
 static int pca955x_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct pca955x_led *pca955x_led;
 	struct pca955x *pca955x;
diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 00aecd67e348..de4d196890d3 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -114,7 +114,7 @@ struct pca963x {
 };
 
 static int pca963x_brightness(struct pca963x_led *led,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	struct i2c_client *client = led->chip->client;
 	struct pca963x_chipdef *chipdef = led->chip->chipdef;
@@ -202,7 +202,7 @@ static int pca963x_power_state(struct pca963x_led *led)
 }
 
 static int pca963x_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct pca963x_led *led;
 	int ret;
diff --git a/drivers/leds/leds-pm8058.c b/drivers/leds/leds-pm8058.c
index fb2ab72c0c40..f9eb27272c50 100644
--- a/drivers/leds/leds-pm8058.c
+++ b/drivers/leds/leds-pm8058.c
@@ -26,7 +26,7 @@ struct pm8058_led {
 };
 
 static void pm8058_led_set(struct led_classdev *cled,
-	enum led_brightness value)
+	led_brightness value)
 {
 	struct pm8058_led *led;
 	int ret = 0;
@@ -53,7 +53,7 @@ static void pm8058_led_set(struct led_classdev *cled,
 		pr_err("Failed to set LED brightness\n");
 }
 
-static enum led_brightness pm8058_led_get(struct led_classdev *cled)
+static led_brightness pm8058_led_get(struct led_classdev *cled)
 {
 	struct pm8058_led *led;
 	int ret;
@@ -94,7 +94,7 @@ static int pm8058_led_probe(struct platform_device *pdev)
 	int ret;
 	struct regmap *map;
 	const char *state;
-	enum led_brightness maxbright;
+	led_brightness maxbright;
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index 743e2cdd0891..61019b3e04f3 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -74,7 +74,7 @@ static int powernv_get_led_type(const char *led_type_desc)
  * scheduled. This function can sleep at opal_async_wait_response call.
  */
 static int powernv_led_set(struct powernv_led_data *powernv_led,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	int rc, token;
 	u64 led_mask, led_value = 0;
@@ -128,7 +128,7 @@ static int powernv_led_set(struct powernv_led_data *powernv_led,
  * This function fetches the LED state for a given LED type for
  * mentioned LED classdev structure.
  */
-static enum led_brightness powernv_led_get(struct powernv_led_data *powernv_led)
+static led_brightness powernv_led_get(struct powernv_led_data *powernv_led)
 {
 	int rc;
 	__be64 mask, value, max_type;
@@ -171,7 +171,7 @@ static enum led_brightness powernv_led_get(struct powernv_led_data *powernv_led)
  * to update LED state.
  */
 static int powernv_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness value)
+				   led_brightness value)
 {
 	struct powernv_led_data *powernv_led =
 		container_of(led_cdev, struct powernv_led_data, cdev);
@@ -190,7 +190,7 @@ static int powernv_brightness_set(struct led_classdev *led_cdev,
 }
 
 /* LED classdev 'brightness_get' function */
-static enum led_brightness powernv_brightness_get(struct led_classdev *led_cdev)
+static led_brightness powernv_brightness_get(struct led_classdev *led_cdev)
 {
 	struct powernv_led_data *powernv_led =
 		container_of(led_cdev, struct powernv_led_data, cdev);
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index d71e9fa5c8de..f1d490fa183f 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -37,7 +37,7 @@ struct led_pwm_priv {
 };
 
 static int led_pwm_set(struct led_classdev *led_cdev,
-		       enum led_brightness brightness)
+		       led_brightness brightness)
 {
 	struct led_pwm_data *led_dat =
 		container_of(led_cdev, struct led_pwm_data, cdev);
diff --git a/drivers/leds/leds-rb532.c b/drivers/leds/leds-rb532.c
index b6447c1721b4..9a5d10085969 100644
--- a/drivers/leds/leds-rb532.c
+++ b/drivers/leds/leds-rb532.c
@@ -17,7 +17,7 @@
 #include <asm/mach-rc32434/rb.h>
 
 static void rb532_led_set(struct led_classdev *cdev,
-			  enum led_brightness brightness)
+			  led_brightness brightness)
 {
 	if (brightness)
 		set_latch_u5(LO_ULED, 0);
@@ -25,7 +25,7 @@ static void rb532_led_set(struct led_classdev *cdev,
 		set_latch_u5(0, LO_ULED);
 }
 
-static enum led_brightness rb532_led_get(struct led_classdev *cdev)
+static led_brightness rb532_led_get(struct led_classdev *cdev)
 {
 	return (get_latch_u5() & LO_ULED) ? LED_FULL : LED_OFF;
 }
diff --git a/drivers/leds/leds-regulator.c b/drivers/leds/leds-regulator.c
index 208c98918433..bb23d7f2cc65 100644
--- a/drivers/leds/leds-regulator.c
+++ b/drivers/leds/leds-regulator.c
@@ -46,7 +46,7 @@ static inline int led_regulator_get_max_brightness(struct regulator *supply)
 }
 
 static int led_regulator_get_voltage(struct regulator *supply,
-		enum led_brightness brightness)
+		led_brightness brightness)
 {
 	if (brightness == 0)
 		return -EINVAL;
@@ -88,7 +88,7 @@ static void regulator_led_disable(struct regulator_led *led)
 }
 
 static int regulator_led_brightness_set(struct led_classdev *led_cdev,
-					 enum led_brightness value)
+					 led_brightness value)
 {
 	struct regulator_led *led = to_regulator_led(led_cdev);
 	int voltage;
diff --git a/drivers/leds/leds-s3c24xx.c b/drivers/leds/leds-s3c24xx.c
index 3c0c7aa63b8c..664301273cde 100644
--- a/drivers/leds/leds-s3c24xx.c
+++ b/drivers/leds/leds-s3c24xx.c
@@ -30,7 +30,7 @@ static inline struct s3c24xx_gpio_led *to_gpio(struct led_classdev *led_cdev)
 }
 
 static void s3c24xx_led_set(struct led_classdev *led_cdev,
-			    enum led_brightness value)
+			    led_brightness value)
 {
 	struct s3c24xx_gpio_led *led = to_gpio(led_cdev);
 
diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index e199ea15e406..62bdbc374aa5 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -84,7 +84,7 @@ static u32 sc27xx_led_get_offset(struct sc27xx_led *leds)
 	return leds->priv->base + SC27XX_LEDS_OFFSET * leds->line;
 }
 
-static int sc27xx_led_enable(struct sc27xx_led *leds, enum led_brightness value)
+static int sc27xx_led_enable(struct sc27xx_led *leds, led_brightness value)
 {
 	u32 base = sc27xx_led_get_offset(leds);
 	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
@@ -114,7 +114,7 @@ static int sc27xx_led_disable(struct sc27xx_led *leds)
 			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
 }
 
-static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
+static int sc27xx_led_set(struct led_classdev *ldev, led_brightness value)
 {
 	struct sc27xx_led *leds = to_sc27xx_led(ldev);
 	int err;
diff --git a/drivers/leds/leds-sgm3140.c b/drivers/leds/leds-sgm3140.c
index f4f831570f11..736641efa16e 100644
--- a/drivers/leds/leds-sgm3140.c
+++ b/drivers/leds/leds-sgm3140.c
@@ -97,7 +97,7 @@ static const struct led_flash_ops sgm3140_flash_ops = {
 };
 
 static int sgm3140_brightness_set(struct led_classdev *led_cdev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(led_cdev);
 	struct sgm3140 *priv = flcdev_to_sgm3140(fled_cdev);
diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index f1964c96fb15..1a30d802a183 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -63,7 +63,7 @@ static const struct of_device_id spi_byte_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spi_byte_dt_ids);
 
 static int spi_byte_brightness_set_blocking(struct led_classdev *dev,
-					    enum led_brightness brightness)
+					    led_brightness brightness)
 {
 	struct spi_byte_led *led = container_of(dev, struct spi_byte_led, ldev);
 	u8 value;
diff --git a/drivers/leds/leds-ss4200.c b/drivers/leds/leds-ss4200.c
index fcaa34706b6c..9918de94ad52 100644
--- a/drivers/leds/leds-ss4200.c
+++ b/drivers/leds/leds-ss4200.c
@@ -217,7 +217,7 @@ static u32 nasgpio_led_get_attr(struct led_classdev *led_cdev, u32 port)
  * in this driver.
  */
 static void nasgpio_led_set_brightness(struct led_classdev *led_cdev,
-				       enum led_brightness brightness)
+				       led_brightness brightness)
 {
 	u32 setting = 0;
 	if (brightness >= LED_HALF)
diff --git a/drivers/leds/leds-sunfire.c b/drivers/leds/leds-sunfire.c
index eba7313719bf..fd89e566eeb2 100644
--- a/drivers/leds/leds-sunfire.c
+++ b/drivers/leds/leds-sunfire.c
@@ -28,7 +28,7 @@ struct sunfire_led {
 #define	to_sunfire_led(d) container_of(d, struct sunfire_led, led_cdev)
 
 static void __clockboard_set(struct led_classdev *led_cdev,
-			     enum led_brightness led_val, u8 bit)
+			     led_brightness led_val, u8 bit)
 {
 	struct sunfire_led *p = to_sunfire_led(led_cdev);
 	u8 reg = upa_readb(p->reg);
@@ -52,25 +52,25 @@ static void __clockboard_set(struct led_classdev *led_cdev,
 }
 
 static void clockboard_left_set(struct led_classdev *led_cdev,
-				enum led_brightness led_val)
+				led_brightness led_val)
 {
 	__clockboard_set(led_cdev, led_val, CLOCK_CTRL_LLED);
 }
 
 static void clockboard_middle_set(struct led_classdev *led_cdev,
-				  enum led_brightness led_val)
+				  led_brightness led_val)
 {
 	__clockboard_set(led_cdev, led_val, CLOCK_CTRL_MLED);
 }
 
 static void clockboard_right_set(struct led_classdev *led_cdev,
-				 enum led_brightness led_val)
+				 led_brightness led_val)
 {
 	__clockboard_set(led_cdev, led_val, CLOCK_CTRL_RLED);
 }
 
 static void __fhc_set(struct led_classdev *led_cdev,
-			     enum led_brightness led_val, u32 bit)
+			     led_brightness led_val, u32 bit)
 {
 	struct sunfire_led *p = to_sunfire_led(led_cdev);
 	u32 reg = upa_readl(p->reg);
@@ -94,24 +94,24 @@ static void __fhc_set(struct led_classdev *led_cdev,
 }
 
 static void fhc_left_set(struct led_classdev *led_cdev,
-			 enum led_brightness led_val)
+			 led_brightness led_val)
 {
 	__fhc_set(led_cdev, led_val, FHC_CONTROL_LLED);
 }
 
 static void fhc_middle_set(struct led_classdev *led_cdev,
-			   enum led_brightness led_val)
+			   led_brightness led_val)
 {
 	__fhc_set(led_cdev, led_val, FHC_CONTROL_MLED);
 }
 
 static void fhc_right_set(struct led_classdev *led_cdev,
-			  enum led_brightness led_val)
+			  led_brightness led_val)
 {
 	__fhc_set(led_cdev, led_val, FHC_CONTROL_RLED);
 }
 
-typedef void (*set_handler)(struct led_classdev *, enum led_brightness);
+typedef void (*set_handler)(struct led_classdev *, led_brightness);
 struct led_type {
 	const char	*name;
 	set_handler	handler;
diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index 7eddb8ecb44e..f7db154dbe58 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -33,7 +33,7 @@ struct syscon_led {
 };
 
 static void syscon_led_set(struct led_classdev *led_cdev,
-	enum led_brightness value)
+	led_brightness value)
 {
 	struct syscon_led *sled =
 		container_of(led_cdev, struct syscon_led, cdev);
diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 225b765830bd..d07fe73e332b 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -545,7 +545,7 @@ static int led_assign(struct tca6507_led *led)
 }
 
 static void tca6507_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct tca6507_led *led = container_of(led_cdev, struct tca6507_led,
 					       led_cdev);
diff --git a/drivers/leds/leds-tlc591xx.c b/drivers/leds/leds-tlc591xx.c
index cb7bd1353f9f..678d708ce9ec 100644
--- a/drivers/leds/leds-tlc591xx.c
+++ b/drivers/leds/leds-tlc591xx.c
@@ -107,7 +107,7 @@ tlc591xx_set_pwm(struct tlc591xx_priv *priv, struct tlc591xx_led *led,
 
 static int
 tlc591xx_brightness_set(struct led_classdev *led_cdev,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	struct tlc591xx_led *led = ldev_to_led(led_cdev);
 	struct tlc591xx_priv *priv = led->priv;
diff --git a/drivers/leds/leds-tps6105x.c b/drivers/leds/leds-tps6105x.c
index 09fd88a6c8f0..e34d036eff74 100644
--- a/drivers/leds/leds-tps6105x.c
+++ b/drivers/leds/leds-tps6105x.c
@@ -23,7 +23,7 @@ static void tps6105x_handle_put(void *data)
 }
 
 static int tps6105x_brightness_set(struct led_classdev *cdev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	struct tps6105x_priv *priv = container_of(cdev, struct tps6105x_priv,
 							cdev);
diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index 1adfed1c0619..8a844c5a173d 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -42,7 +42,7 @@ struct omnia_leds {
 };
 
 static int omnia_led_brightness_set_blocking(struct led_classdev *cdev,
-					     enum led_brightness brightness)
+					     led_brightness brightness)
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
 	struct omnia_leds *leds = dev_get_drvdata(cdev->dev->parent);
diff --git a/drivers/leds/leds-wm831x-status.c b/drivers/leds/leds-wm831x-status.c
index c48b80574f02..c440a21b548d 100644
--- a/drivers/leds/leds-wm831x-status.c
+++ b/drivers/leds/leds-wm831x-status.c
@@ -29,7 +29,7 @@ struct wm831x_status {
 	int blink_time;
 	int blink_cyc;
 	int src;
-	enum led_brightness brightness;
+	led_brightness brightness;
 };
 
 #define to_wm831x_status(led_cdev) \
@@ -64,7 +64,7 @@ static void wm831x_status_set(struct wm831x_status *led)
 }
 
 static int wm831x_status_brightness_set(struct led_classdev *led_cdev,
-					 enum led_brightness value)
+					 led_brightness value)
 {
 	struct wm831x_status *led = to_wm831x_status(led_cdev);
 	unsigned long flags;
diff --git a/drivers/leds/leds-wm8350.c b/drivers/leds/leds-wm8350.c
index 8f243c413723..472e2aa33f58 100644
--- a/drivers/leds/leds-wm8350.c
+++ b/drivers/leds/leds-wm8350.c
@@ -139,7 +139,7 @@ static int wm8350_led_disable(struct wm8350_led *led)
 }
 
 static int wm8350_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct wm8350_led *led = to_wm8350_led(led_cdev);
 	unsigned long flags;
diff --git a/drivers/leds/leds-wrap.c b/drivers/leds/leds-wrap.c
index 794697e16068..4c8cf1562a50 100644
--- a/drivers/leds/leds-wrap.c
+++ b/drivers/leds/leds-wrap.c
@@ -24,7 +24,7 @@
 static struct platform_device *pdev;
 
 static void wrap_power_led_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
+		led_brightness value)
 {
 	if (value)
 		scx200_gpio_set_low(WRAP_POWER_LED_GPIO);
@@ -33,7 +33,7 @@ static void wrap_power_led_set(struct led_classdev *led_cdev,
 }
 
 static void wrap_error_led_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
+		led_brightness value)
 {
 	if (value)
 		scx200_gpio_set_low(WRAP_ERROR_LED_GPIO);
@@ -42,7 +42,7 @@ static void wrap_error_led_set(struct led_classdev *led_cdev,
 }
 
 static void wrap_extra_led_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
+		led_brightness value)
 {
 	if (value)
 		scx200_gpio_set_low(WRAP_EXTRA_LED_GPIO);
diff --git a/drivers/leds/trigger/ledtrig-audio.c b/drivers/leds/trigger/ledtrig-audio.c
index f76621e88482..4681e5ca4cbc 100644
--- a/drivers/leds/trigger/ledtrig-audio.c
+++ b/drivers/leds/trigger/ledtrig-audio.c
@@ -8,15 +8,15 @@
 #include <linux/module.h>
 
 static struct led_trigger *ledtrig_audio[NUM_AUDIO_LEDS];
-static enum led_brightness audio_state[NUM_AUDIO_LEDS];
+static led_brightness audio_state[NUM_AUDIO_LEDS];
 
-enum led_brightness ledtrig_audio_get(enum led_audio type)
+led_brightness ledtrig_audio_get(enum led_audio type)
 {
 	return audio_state[type];
 }
 EXPORT_SYMBOL_GPL(ledtrig_audio_get);
 
-void ledtrig_audio_set(enum led_audio type, enum led_brightness state)
+void ledtrig_audio_set(enum led_audio type, led_brightness state)
 {
 	audio_state[type] = state;
 	led_trigger_event(ledtrig_audio[type], state);
diff --git a/drivers/leds/trigger/ledtrig-camera.c b/drivers/leds/trigger/ledtrig-camera.c
index ab1c410872ff..174c3dc9beab 100644
--- a/drivers/leds/trigger/ledtrig-camera.c
+++ b/drivers/leds/trigger/ledtrig-camera.c
@@ -19,7 +19,7 @@ DEFINE_LED_TRIGGER(ledtrig_torch);
 
 void ledtrig_flash_ctrl(bool on)
 {
-	enum led_brightness brt = on ? LED_FULL : LED_OFF;
+	led_brightness brt = on ? LED_FULL : LED_OFF;
 
 	led_trigger_event(ledtrig_flash, brt);
 }
@@ -27,7 +27,7 @@ EXPORT_SYMBOL_GPL(ledtrig_flash_ctrl);
 
 void ledtrig_torch_ctrl(bool on)
 {
-	enum led_brightness brt = on ? LED_FULL : LED_OFF;
+	led_brightness brt = on ? LED_FULL : LED_OFF;
 
 	led_trigger_event(ledtrig_torch, brt);
 }
diff --git a/drivers/leds/uleds.c b/drivers/leds/uleds.c
index 7320337b22d2..bb4b982fda9a 100644
--- a/drivers/leds/uleds.c
+++ b/drivers/leds/uleds.c
@@ -37,7 +37,7 @@ struct uleds_device {
 static struct miscdevice uleds_misc;
 
 static void uleds_brightness_set(struct led_classdev *led_cdev,
-				 enum led_brightness brightness)
+				 led_brightness brightness)
 {
 	struct uleds_device *udev = container_of(led_cdev, struct uleds_device,
 						 led_cdev);
diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index ae067ab2373d..0424d0a8886e 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -48,7 +48,7 @@ static void pmu_req_done(struct adb_request * req)
 }
 
 static void pmu_led_set(struct led_classdev *led_cdev,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	unsigned long flags;
 
diff --git a/drivers/media/radio/radio-shark.c b/drivers/media/radio/radio-shark.c
index 8230da828d0e..3e3ebdac8c16 100644
--- a/drivers/media/radio/radio-shark.c
+++ b/drivers/media/radio/radio-shark.c
@@ -180,7 +180,7 @@ static void shark_led_work(struct work_struct *work)
 }
 
 static void shark_led_set_blue(struct led_classdev *led_cdev,
-			       enum led_brightness value)
+			       led_brightness value)
 {
 	struct shark_device *shark =
 		container_of(led_cdev, struct shark_device, leds[BLUE_LED]);
@@ -192,7 +192,7 @@ static void shark_led_set_blue(struct led_classdev *led_cdev,
 }
 
 static void shark_led_set_blue_pulse(struct led_classdev *led_cdev,
-				     enum led_brightness value)
+				     led_brightness value)
 {
 	struct shark_device *shark = container_of(led_cdev,
 				struct shark_device, leds[BLUE_PULSE_LED]);
@@ -204,7 +204,7 @@ static void shark_led_set_blue_pulse(struct led_classdev *led_cdev,
 }
 
 static void shark_led_set_red(struct led_classdev *led_cdev,
-			      enum led_brightness value)
+			      led_brightness value)
 {
 	struct shark_device *shark =
 		container_of(led_cdev, struct shark_device, leds[RED_LED]);
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index d150f12382c6..2e93adaa91ee 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -165,7 +165,7 @@ static void shark_led_work(struct work_struct *work)
 }
 
 static void shark_led_set_blue(struct led_classdev *led_cdev,
-			       enum led_brightness value)
+			       led_brightness value)
 {
 	struct shark_device *shark =
 		container_of(led_cdev, struct shark_device, leds[BLUE_LED]);
@@ -176,7 +176,7 @@ static void shark_led_set_blue(struct led_classdev *led_cdev,
 }
 
 static void shark_led_set_red(struct led_classdev *led_cdev,
-			      enum led_brightness value)
+			      led_brightness value)
 {
 	struct shark_device *shark =
 		container_of(led_cdev, struct shark_device, leds[RED_LED]);
diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 2cf3377ec63a..c1473f1d1a92 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -849,7 +849,7 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 	return ret;
 }
 
-static void redrat3_brightness_set(struct led_classdev *led_dev, enum
+static void redrat3_brightness_set(struct led_classdev *led_dev,
 						led_brightness brightness)
 {
 	struct redrat3_dev *rr3 = container_of(led_dev, struct redrat3_dev,
diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 629787d53ee1..7ad0101ca4f2 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -40,7 +40,7 @@ struct ttusbir {
 	char phys[64];
 };
 
-static enum led_brightness ttusbir_brightness_get(struct led_classdev *led_dev)
+static led_brightness ttusbir_brightness_get(struct led_classdev *led_dev)
 {
 	struct ttusbir *tt = container_of(led_dev, struct ttusbir, led);
 
@@ -65,7 +65,7 @@ static void ttusbir_set_led(struct ttusbir *tt)
 	}
 }
 
-static void ttusbir_brightness_set(struct led_classdev *led_dev, enum
+static void ttusbir_brightness_set(struct led_classdev *led_dev,
 						led_brightness brightness)
 {
 	struct ttusbir *tt = container_of(led_dev, struct ttusbir, led);
diff --git a/drivers/media/rc/winbond-cir.c b/drivers/media/rc/winbond-cir.c
index aed23ca0fa6c..06180c47b7d1 100644
--- a/drivers/media/rc/winbond-cir.c
+++ b/drivers/media/rc/winbond-cir.c
@@ -255,7 +255,7 @@ wbcir_set_irqmask(struct wbcir_data *data, u8 irqmask)
 	data->irqmask = irqmask;
 }
 
-static enum led_brightness
+static led_brightness
 wbcir_led_brightness_get(struct led_classdev *led_cdev)
 {
 	struct wbcir_data *data = container_of(led_cdev,
@@ -270,7 +270,7 @@ wbcir_led_brightness_get(struct led_classdev *led_cdev)
 
 static void
 wbcir_led_brightness_set(struct led_classdev *led_cdev,
-			 enum led_brightness brightness)
+			 led_brightness brightness)
 {
 	struct wbcir_data *data = container_of(led_cdev,
 					       struct wbcir_data,
diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
index 10ddcc48aa17..d36d86021c41 100644
--- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
+++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
@@ -40,7 +40,7 @@ enum ctrl_init_data_id {
 	NUM_FLASH_CTRLS,
 };
 
-static enum led_brightness __intensity_to_led_brightness(
+static led_brightness __intensity_to_led_brightness(
 					struct v4l2_ctrl *ctrl, s32 intensity)
 {
 	intensity -= ctrl->minimum;
@@ -59,7 +59,7 @@ static enum led_brightness __intensity_to_led_brightness(
 }
 
 static s32 __led_brightness_to_intensity(struct v4l2_ctrl *ctrl,
-					 enum led_brightness brightness)
+					 led_brightness brightness)
 {
 	/*
 	 * Indicator LEDs, unlike torch LEDs, are turned on/off basing on
@@ -80,7 +80,7 @@ static void v4l2_flash_set_led_brightness(struct v4l2_flash *v4l2_flash,
 					struct v4l2_ctrl *ctrl)
 {
 	struct v4l2_ctrl **ctrls = v4l2_flash->ctrls;
-	enum led_brightness brightness;
+	led_brightness brightness;
 
 	if (has_flash_op(v4l2_flash, intensity_to_led_brightness))
 		brightness = call_flash_op(v4l2_flash,
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 5fe4528e296e..5ad6ba4ba873 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1263,7 +1263,7 @@ static const struct mmc_host_ops rtsx_usb_sdmmc_ops = {
 
 #ifdef RTSX_USB_USE_LEDS_CLASS
 static void rtsx_usb_led_control(struct led_classdev *led,
-	enum led_brightness brightness)
+	led_brightness brightness)
 {
 	struct rtsx_usb_sdmmc *host = container_of(led,
 			struct rtsx_usb_sdmmc, led);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aba6e10b8605..010f9298dbc5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -385,7 +385,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
 
 #if IS_REACHABLE(CONFIG_LEDS_CLASS)
 static void sdhci_led_control(struct led_classdev *led,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	struct sdhci_host *host = container_of(led, struct sdhci_host, led);
 	unsigned long flags;
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 3c8f665c1558..cb6d284049d9 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -64,7 +64,7 @@ module_param(clockm, int, 0);
 MODULE_LICENSE("GPL");
 
 static void led_tx_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	struct com20020_dev *card;
 	struct com20020_priv *priv;
@@ -79,7 +79,7 @@ static void led_tx_set(struct led_classdev *led_cdev,
 }
 
 static void led_recon_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	struct com20020_dev *card;
 	struct com20020_priv *priv;
diff --git a/drivers/net/dsa/hirschmann/hellcreek_ptp.c b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
index 2572c6087bb5..4449810c8631 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_ptp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
@@ -239,14 +239,14 @@ static void hellcreek_ptp_overflow_check(struct work_struct *work)
 			      HELLCREEK_OVERFLOW_PERIOD);
 }
 
-static enum led_brightness hellcreek_get_brightness(struct hellcreek *hellcreek,
+static led_brightness hellcreek_get_brightness(struct hellcreek *hellcreek,
 						    int led)
 {
 	return (hellcreek->status_out & led) ? 1 : 0;
 }
 
 static void hellcreek_set_brightness(struct hellcreek *hellcreek, int led,
-				     enum led_brightness b)
+				     led_brightness b)
 {
 	mutex_lock(&hellcreek->ptp_lock);
 
@@ -261,14 +261,14 @@ static void hellcreek_set_brightness(struct hellcreek *hellcreek, int led,
 }
 
 static void hellcreek_led_sync_good_set(struct led_classdev *ldev,
-					enum led_brightness b)
+					led_brightness b)
 {
 	struct hellcreek *hellcreek = led_to_hellcreek(ldev, led_sync_good);
 
 	hellcreek_set_brightness(hellcreek, STATUS_OUT_SYNC_GOOD, b);
 }
 
-static enum led_brightness hellcreek_led_sync_good_get(struct led_classdev *ldev)
+static led_brightness hellcreek_led_sync_good_get(struct led_classdev *ldev)
 {
 	struct hellcreek *hellcreek = led_to_hellcreek(ldev, led_sync_good);
 
@@ -276,14 +276,14 @@ static enum led_brightness hellcreek_led_sync_good_get(struct led_classdev *ldev
 }
 
 static void hellcreek_led_is_gm_set(struct led_classdev *ldev,
-				    enum led_brightness b)
+				    led_brightness b)
 {
 	struct hellcreek *hellcreek = led_to_hellcreek(ldev, led_is_gm);
 
 	hellcreek_set_brightness(hellcreek, STATUS_OUT_IS_GM, b);
 }
 
-static enum led_brightness hellcreek_led_is_gm_get(struct led_classdev *ldev)
+static led_brightness hellcreek_led_is_gm_get(struct led_classdev *ldev)
 {
 	struct hellcreek *hellcreek = led_to_hellcreek(ldev, led_is_gm);
 
diff --git a/drivers/net/wireless/ath/ath5k/led.c b/drivers/net/wireless/ath/ath5k/led.c
index 6a2a16856763..7217c676834b 100644
--- a/drivers/net/wireless/ath/ath5k/led.c
+++ b/drivers/net/wireless/ath/ath5k/led.c
@@ -111,7 +111,7 @@ void ath5k_led_off(struct ath5k_hw *ah)
 
 static void
 ath5k_led_brightness_set(struct led_classdev *led_dev,
-	enum led_brightness brightness)
+	led_brightness brightness)
 {
 	struct ath5k_led *led = container_of(led_dev, struct ath5k_led,
 		led_dev);
diff --git a/drivers/net/wireless/ath/ath9k/gpio.c b/drivers/net/wireless/ath/ath9k/gpio.c
index b457e52dd365..be7de7dfa201 100644
--- a/drivers/net/wireless/ath/ath9k/gpio.c
+++ b/drivers/net/wireless/ath/ath9k/gpio.c
@@ -49,7 +49,7 @@ static void ath_fill_led_pin(struct ath_softc *sc)
 }
 
 static void ath_led_brightness(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
+			       led_brightness brightness)
 {
 	struct ath_softc *sc = container_of(led_cdev, struct ath_softc, led_cdev);
 	u32 val = (brightness == LED_OFF);
diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 0a1634238e67..f3b4c50dff25 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -511,7 +511,7 @@ struct ath9k_htc_priv {
 	bool ps_idle;
 
 #ifdef CONFIG_MAC80211_LEDS
-	enum led_brightness brightness;
+	led_brightness brightness;
 	bool led_registered;
 	char led_name[32];
 	struct led_classdev led_cdev;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c b/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c
index ecb848b60725..e3fd7708cae5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c
@@ -234,7 +234,7 @@ void ath9k_led_work(struct work_struct *work)
 }
 
 static void ath9k_led_brightness(struct led_classdev *led_cdev,
-				 enum led_brightness brightness)
+				 led_brightness brightness)
 {
 	struct ath9k_htc_priv *priv = container_of(led_cdev,
 						   struct ath9k_htc_priv,
diff --git a/drivers/net/wireless/ath/carl9170/led.c b/drivers/net/wireless/ath/carl9170/led.c
index 2c74425f5059..659b37245bfc 100644
--- a/drivers/net/wireless/ath/carl9170/led.c
+++ b/drivers/net/wireless/ath/carl9170/led.c
@@ -104,7 +104,7 @@ static void carl9170_led_update(struct work_struct *work)
 }
 
 static void carl9170_led_set_brightness(struct led_classdev *led,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct carl9170_led *arl = container_of(led, struct carl9170_led, l);
 	struct ar9170 *ar = arl->ar;
diff --git a/drivers/net/wireless/broadcom/b43/leds.c b/drivers/net/wireless/broadcom/b43/leds.c
index 982a772a9d87..d5b78cbabe06 100644
--- a/drivers/net/wireless/broadcom/b43/leds.c
+++ b/drivers/net/wireless/broadcom/b43/leds.c
@@ -94,7 +94,7 @@ static void b43_leds_work(struct work_struct *work)
 
 /* Callback from the LED subsystem. */
 static void b43_led_brightness_set(struct led_classdev *led_dev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct b43_led *led = container_of(led_dev, struct b43_led, led_dev);
 	struct b43_wl *wl = led->wl;
diff --git a/drivers/net/wireless/broadcom/b43legacy/leds.c b/drivers/net/wireless/broadcom/b43legacy/leds.c
index 38b5be3a84e2..f1781e9938a8 100644
--- a/drivers/net/wireless/broadcom/b43legacy/leds.c
+++ b/drivers/net/wireless/broadcom/b43legacy/leds.c
@@ -54,7 +54,7 @@ static void b43legacy_led_turn_off(struct b43legacy_wldev *dev, u8 led_index,
 
 /* Callback from the LED subsystem. */
 static void b43legacy_led_brightness_set(struct led_classdev *led_dev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct b43legacy_led *led = container_of(led_dev, struct b43legacy_led,
 				    led_dev);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c1b9ac692d26..c29a84f86ec5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -33,7 +33,7 @@ static void brcms_radio_led_ctrl(struct brcms_info *wl, bool state)
 
 /* Callback from the LED subsystem. */
 static void brcms_led_brightness_set(struct led_classdev *led_dev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct brcms_info *wl = container_of(led_dev,
 		struct brcms_info, led_dev);
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 219fed91cac5..88b5d5e4f9d8 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -510,7 +510,7 @@ il_led_cmd(struct il_priv *il, unsigned long on, unsigned long off)
 
 static void
 il_led_brightness_set(struct led_classdev *led_cdev,
-		      enum led_brightness brightness)
+		      led_brightness brightness)
 {
 	struct il_priv *il = container_of(led_cdev, struct il_priv, led);
 	unsigned long on = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index e8a4d604b910..890579ecdc6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -134,7 +134,7 @@ static int iwl_led_cmd(struct iwl_priv *priv,
 }
 
 static void iwl_led_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct iwl_priv *priv = container_of(led_cdev, struct iwl_priv, led);
 	unsigned long on = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/led.c b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
index 1ea7c44250d4..77962a1b5b1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
@@ -43,7 +43,7 @@ static void iwl_mvm_led_set(struct iwl_mvm *mvm, bool on)
 }
 
 static void iwl_led_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct iwl_mvm *mvm = container_of(led_cdev, struct iwl_mvm, led);
 
diff --git a/drivers/net/wireless/intersil/p54/led.c b/drivers/net/wireless/intersil/p54/led.c
index 4bc77010f9c1..45a45e4c4730 100644
--- a/drivers/net/wireless/intersil/p54/led.c
+++ b/drivers/net/wireless/intersil/p54/led.c
@@ -62,7 +62,7 @@ static void p54_update_leds(struct work_struct *work)
 }
 
 static void p54_led_brightness_set(struct led_classdev *led_dev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct p54_led_dev *led = container_of(led_dev, struct p54_led_dev,
 					       led_dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 031d39a48a55..d273a1bf30ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -370,7 +370,7 @@ static int mt7603_led_set_blink(struct led_classdev *led_cdev,
 }
 
 static void mt7603_led_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
+				      led_brightness brightness)
 {
 	struct mt76_dev *mt76 = container_of(led_cdev, struct mt76_dev,
 					     led_cdev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index a2465b49ecd0..24019e95441b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -118,7 +118,7 @@ mt7615_led_set_blink(struct led_classdev *led_cdev,
 
 static void
 mt7615_led_set_brightness(struct led_classdev *led_cdev,
-			  enum led_brightness brightness)
+			  led_brightness brightness)
 {
 	if (!brightness)
 		mt7615_led_set_config(led_cdev, 0, 0xff);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ccdbab341271..7f5224cc3b37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -127,7 +127,7 @@ mt76x02_led_set_blink(struct led_classdev *led_cdev,
 
 static void
 mt76x02_led_set_brightness(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
+			   led_brightness brightness)
 {
 	struct mt76_dev *mdev = container_of(led_cdev, struct mt76_dev,
 					     led_cdev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index dec6ffdf07c4..2e545de974fd 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -200,7 +200,7 @@ static int rt2400pci_rfkill_poll(struct rt2x00_dev *rt2x00dev)
 
 #ifdef CONFIG_RT2X00_LIB_LEDS
 static void rt2400pci_brightness_set(struct led_classdev *led_cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct rt2x00_led *led =
 	    container_of(led_cdev, struct rt2x00_led, led_dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index 8faa0a80e73a..639f04e5f6bf 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -200,7 +200,7 @@ static int rt2500pci_rfkill_poll(struct rt2x00_dev *rt2x00dev)
 
 #ifdef CONFIG_RT2X00_LIB_LEDS
 static void rt2500pci_brightness_set(struct led_classdev *led_cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct rt2x00_led *led =
 	    container_of(led_cdev, struct rt2x00_led, led_dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index bb5ed6630645..68e2875ee409 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -263,7 +263,7 @@ static int rt2500usb_rfkill_poll(struct rt2x00_dev *rt2x00dev)
 
 #ifdef CONFIG_RT2X00_LIB_LEDS
 static void rt2500usb_brightness_set(struct led_classdev *led_cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct rt2x00_led *led =
 	    container_of(led_cdev, struct rt2x00_led, led_dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index deddb0afd312..e8817c1a734b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1517,7 +1517,7 @@ EXPORT_SYMBOL_GPL(rt2800_rfkill_poll);
 
 #ifdef CONFIG_RT2X00_LIB_LEDS
 static void rt2800_brightness_set(struct led_classdev *led_cdev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	struct rt2x00_led *led =
 	    container_of(led_cdev, struct rt2x00_led, led_dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 82cfc2aadc2b..4938e96762be 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -238,7 +238,7 @@ static int rt61pci_rfkill_poll(struct rt2x00_dev *rt2x00dev)
 
 #ifdef CONFIG_RT2X00_LIB_LEDS
 static void rt61pci_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct rt2x00_led *led =
 	    container_of(led_cdev, struct rt2x00_led, led_dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index 5ff2c740c3ea..7dfed2090026 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -183,7 +183,7 @@ static int rt73usb_rfkill_poll(struct rt2x00_dev *rt2x00dev)
 
 #ifdef CONFIG_RT2X00_LIB_LEDS
 static void rt73usb_brightness_set(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct rt2x00_led *led =
 	   container_of(led_cdev, struct rt2x00_led, led_dev);
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
index 49421d10e22b..56fcbc803a35 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
@@ -97,7 +97,7 @@ static void led_turn_off(struct work_struct *work)
 
 /* Callback from the LED subsystem. */
 static void rtl8187_led_brightness_set(struct led_classdev *led_dev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct rtl8187_led *led = container_of(led_dev, struct rtl8187_led,
 					       led_dev);
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index aa409f0201fb..57916a3bd5e4 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -21,7 +21,7 @@
 #define ACPI_KEYBOARD_BACKLIGHT_MAX		100
 
 static void keyboard_led_set_brightness(struct led_classdev *cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	union acpi_object param;
 	struct acpi_object_list input;
@@ -39,7 +39,7 @@ static void keyboard_led_set_brightness(struct led_classdev *cdev,
 			status);
 }
 
-static enum led_brightness
+static led_brightness
 keyboard_led_get_brightness(struct led_classdev *cdev)
 {
 	unsigned long long brightness;
diff --git a/drivers/platform/chrome/wilco_ec/keyboard_leds.c b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
index 6ce9c6782065..ef970fb81248 100644
--- a/drivers/platform/chrome/wilco_ec/keyboard_leds.c
+++ b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
@@ -76,7 +76,7 @@ static int send_kbbl_msg(struct wilco_ec_device *ec,
 	return 0;
 }
 
-static int set_kbbl(struct wilco_ec_device *ec, enum led_brightness brightness)
+static int set_kbbl(struct wilco_ec_device *ec, led_brightness brightness)
 {
 	struct wilco_keyboard_leds_msg request;
 	struct wilco_keyboard_leds_msg response;
@@ -163,7 +163,7 @@ static int kbbl_init(struct wilco_ec_device *ec)
 }
 
 static int wilco_keyboard_leds_set(struct led_classdev *cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct wilco_keyboard_leds *wkl =
 		container_of(cdev, struct wilco_keyboard_leds, keyboard);
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 85db9403cc14..c6123a201db9 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1440,7 +1440,7 @@ static void __init acer_commandline_init(void)
  * LED device (Mail LED only, no other LEDs known yet)
  */
 static void mail_led_set(struct led_classdev *led_cdev,
-enum led_brightness value)
+led_brightness value)
 {
 	set_u32(value, ACER_CAP_MAILLED);
 }
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 4d2d32bfbe2a..ab0940692a2f 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -552,7 +552,7 @@ static int asus_led_set(struct asus_laptop *asus, const char *method,
  */
 /* /sys/class/led handlers */
 static void asus_led_cdev_set(struct led_classdev *led_cdev,
-			 enum led_brightness value)
+			 led_brightness value)
 {
 	struct asus_led *led = container_of(led_cdev, struct asus_led, led);
 	struct asus_laptop *asus = led->asus;
@@ -569,7 +569,7 @@ static void asus_led_cdev_update(struct work_struct *work)
 	asus_led_set(asus, led->method, led->wk);
 }
 
-static enum led_brightness asus_led_cdev_get(struct led_classdev *led_cdev)
+static led_brightness asus_led_cdev_get(struct led_classdev *led_cdev)
 {
 	return led_cdev->brightness;
 }
@@ -613,7 +613,7 @@ static int asus_kled_set(struct asus_laptop *asus, int kblv)
 }
 
 static void asus_kled_cdev_set(struct led_classdev *led_cdev,
-			      enum led_brightness value)
+			      led_brightness value)
 {
 	struct asus_led *led = container_of(led_cdev, struct asus_led, led);
 	struct asus_laptop *asus = led->asus;
@@ -630,7 +630,7 @@ static void asus_kled_cdev_update(struct work_struct *work)
 	asus_kled_set(asus, led->wk);
 }
 
-static enum led_brightness asus_kled_cdev_get(struct led_classdev *led_cdev)
+static led_brightness asus_kled_cdev_get(struct led_classdev *led_cdev)
 {
 	struct asus_led *led = container_of(led_cdev, struct asus_led, led);
 	struct asus_laptop *asus = led->asus;
diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index d3e7171928e5..c58a5f51f32f 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -74,7 +74,7 @@ static acpi_status asus_wireless_method(acpi_handle handle, const char *method,
 	return s;
 }
 
-static enum led_brightness led_state_get(struct led_classdev *led)
+static led_brightness led_state_get(struct led_classdev *led)
 {
 	struct asus_wireless_data *data;
 	acpi_status s;
@@ -98,7 +98,7 @@ static void led_state_update(struct work_struct *work)
 			     data->led_state, &ret);
 }
 
-static void led_state_set(struct led_classdev *led, enum led_brightness value)
+static void led_state_set(struct led_classdev *led, led_brightness value)
 {
 	struct asus_wireless_data *data;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ebaeb7bb80f5..250b456d0b9b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -540,7 +540,7 @@ static void tpd_led_update(struct work_struct *work)
 }
 
 static void tpd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct asus_wmi *asus;
 
@@ -555,7 +555,7 @@ static int read_tpd_led_state(struct asus_wmi *asus)
 	return asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_TOUCHPAD_LED);
 }
 
-static enum led_brightness tpd_led_get(struct led_classdev *led_cdev)
+static led_brightness tpd_led_get(struct led_classdev *led_cdev)
 {
 	struct asus_wmi *asus;
 
@@ -612,7 +612,7 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
 }
 
 static void kbd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	/* Prevent disabling keyboard backlight on module unregister */
 	if (led_cdev->flags & LED_UNREGISTERING)
@@ -621,7 +621,7 @@ static void kbd_led_set(struct led_classdev *led_cdev,
 	do_kbd_led_set(led_cdev, value);
 }
 
-static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightness value)
+static void kbd_led_set_by_kbd(struct asus_wmi *asus, led_brightness value)
 {
 	struct led_classdev *led_cdev = &asus->kbd_led;
 
@@ -629,7 +629,7 @@ static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightness value)
 	led_classdev_notify_brightness_hw_changed(led_cdev, asus->kbd_led_wk);
 }
 
-static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
+static led_brightness kbd_led_get(struct led_classdev *led_cdev)
 {
 	struct asus_wmi *asus;
 	int retval, value;
@@ -664,7 +664,7 @@ static void wlan_led_update(struct work_struct *work)
 }
 
 static void wlan_led_set(struct led_classdev *led_cdev,
-			 enum led_brightness value)
+			 led_brightness value)
 {
 	struct asus_wmi *asus;
 
@@ -674,7 +674,7 @@ static void wlan_led_set(struct led_classdev *led_cdev,
 	queue_work(asus->led_workqueue, &asus->wlan_led_work);
 }
 
-static enum led_brightness wlan_led_get(struct led_classdev *led_cdev)
+static led_brightness wlan_led_get(struct led_classdev *led_cdev)
 {
 	struct asus_wmi *asus;
 	u32 result;
@@ -697,7 +697,7 @@ static void lightbar_led_update(struct work_struct *work)
 }
 
 static void lightbar_led_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	struct asus_wmi *asus;
 
@@ -707,7 +707,7 @@ static void lightbar_led_set(struct led_classdev *led_cdev,
 	queue_work(asus->led_workqueue, &asus->lightbar_led_work);
 }
 
-static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
+static led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 {
 	struct asus_wmi *asus;
 	u32 result;
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index f21248255529..a64a356017a8 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -368,7 +368,7 @@ static int wmax_brightness(int brightness)
 }
 
 static void global_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
+			   led_brightness brightness)
 {
 	int ret;
 	global_brightness = brightness;
@@ -380,7 +380,7 @@ static void global_led_set(struct led_classdev *led_cdev,
 		pr_err("LED brightness update failed\n");
 }
 
-static enum led_brightness global_led_get(struct led_classdev *led_cdev)
+static led_brightness global_led_get(struct led_classdev *led_cdev)
 {
 	return global_brightness;
 }
diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 8230e7a68a5e..2bf008e2e80d 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -967,7 +967,7 @@ static void touchpad_led_off(void)
 }
 
 static void touchpad_led_set(struct led_classdev *led_cdev,
-	enum led_brightness value)
+	led_brightness value)
 {
 	if (value > 0)
 		touchpad_led_on();
@@ -1191,7 +1191,7 @@ static u8 kbd_previous_mode_bit;
 
 static bool kbd_led_present;
 static DEFINE_MUTEX(kbd_led_mutex);
-static enum led_brightness kbd_led_level;
+static led_brightness kbd_led_level;
 
 /*
  * NOTE: there are three ways to set the keyboard backlight level.
@@ -1986,7 +1986,7 @@ static const struct attribute_group *kbd_led_groups[] = {
 	NULL,
 };
 
-static enum led_brightness kbd_led_level_get(struct led_classdev *led_cdev)
+static led_brightness kbd_led_level_get(struct led_classdev *led_cdev)
 {
 	int ret;
 	u16 num;
@@ -2018,9 +2018,9 @@ static enum led_brightness kbd_led_level_get(struct led_classdev *led_cdev)
 }
 
 static int kbd_led_level_set(struct led_classdev *led_cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
-	enum led_brightness new_value = value;
+	led_brightness new_value = value;
 	struct kbd_state state;
 	struct kbd_state new_state;
 	u16 num;
@@ -2091,7 +2091,7 @@ static int __init kbd_led_init(struct device *dev)
 }
 
 static void brightness_set_exit(struct led_classdev *led_cdev,
-				enum led_brightness value)
+				led_brightness value)
 {
 	/* Don't change backlight level on exit */
 };
@@ -2108,7 +2108,7 @@ static int dell_laptop_notifier_call(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
 	bool changed = false;
-	enum led_brightness new_kbd_led_level;
+	led_brightness new_kbd_led_level;
 
 	switch (action) {
 	case DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED:
@@ -2137,7 +2137,7 @@ static struct notifier_block dell_laptop_notifier = {
 };
 
 static int micmute_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
+			   led_brightness brightness)
 {
 	struct calling_interface_buffer buffer;
 	struct calling_interface_token *token;
diff --git a/drivers/platform/x86/dell/dell-wmi-led.c b/drivers/platform/x86/dell/dell-wmi-led.c
index 5bedaf7f0633..d19f0769a992 100644
--- a/drivers/platform/x86/dell/dell-wmi-led.c
+++ b/drivers/platform/x86/dell/dell-wmi-led.c
@@ -120,7 +120,7 @@ static int led_blink(unsigned char on_eighths, unsigned char off_eighths)
 }
 
 static void dell_led_set(struct led_classdev *led_cdev,
-			 enum led_brightness value)
+			 led_brightness value)
 {
 	if (value == LED_OFF)
 		led_off();
diff --git a/drivers/platform/x86/dell/dell-wmi-privacy.c b/drivers/platform/x86/dell/dell-wmi-privacy.c
index 074b7e68c227..4e5ff47a8859 100644
--- a/drivers/platform/x86/dell/dell-wmi-privacy.c
+++ b/drivers/platform/x86/dell/dell-wmi-privacy.c
@@ -241,7 +241,7 @@ static int get_current_status(struct wmi_device *wdev)
 }
 
 static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct privacy_wmi_data *priv = led_to_priv(led_cdev);
 	static char *acpi_method = (char *)"ECAK";
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index ba08c9235f76..0e5c9df5e85c 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -492,7 +492,7 @@ static void tpd_led_update(struct work_struct *work)
 }
 
 static void tpd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct eeepc_laptop *eeepc;
 
@@ -502,7 +502,7 @@ static void tpd_led_set(struct led_classdev *led_cdev,
 	queue_work(eeepc->led_workqueue, &eeepc->tpd_led_work);
 }
 
-static enum led_brightness tpd_led_get(struct led_classdev *led_cdev)
+static led_brightness tpd_led_get(struct led_classdev *led_cdev)
 {
 	struct eeepc_laptop *eeepc;
 
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 80929380ec7e..27a1e2480872 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -578,7 +578,7 @@ static void fujitsu_laptop_platform_remove(struct acpi_device *device)
 }
 
 static int logolamp_set(struct led_classdev *cdev,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int poweron = FUNC_LED_ON, always = FUNC_LED_ON;
@@ -597,7 +597,7 @@ static int logolamp_set(struct led_classdev *cdev,
 	return call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_ALWAYS, always);
 }
 
-static enum led_brightness logolamp_get(struct led_classdev *cdev)
+static led_brightness logolamp_get(struct led_classdev *cdev)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int ret;
@@ -614,7 +614,7 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
 }
 
 static int kblamps_set(struct led_classdev *cdev,
-		       enum led_brightness brightness)
+		       led_brightness brightness)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 
@@ -626,10 +626,10 @@ static int kblamps_set(struct led_classdev *cdev,
 				      FUNC_LED_OFF);
 }
 
-static enum led_brightness kblamps_get(struct led_classdev *cdev)
+static led_brightness kblamps_get(struct led_classdev *cdev)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
-	enum led_brightness brightness = LED_OFF;
+	led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device,
 			   FUNC_LEDS, 0x2, KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
@@ -639,7 +639,7 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
 }
 
 static int radio_led_set(struct led_classdev *cdev,
-			 enum led_brightness brightness)
+			 led_brightness brightness)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 
@@ -651,10 +651,10 @@ static int radio_led_set(struct led_classdev *cdev,
 				      0x0);
 }
 
-static enum led_brightness radio_led_get(struct led_classdev *cdev)
+static led_brightness radio_led_get(struct led_classdev *cdev)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
-	enum led_brightness brightness = LED_OFF;
+	led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_FLAGS, 0x4, 0x0, 0x0) & RADIO_LED_ON)
 		brightness = LED_FULL;
@@ -663,7 +663,7 @@ static enum led_brightness radio_led_get(struct led_classdev *cdev)
 }
 
 static int eco_led_set(struct led_classdev *cdev,
-		       enum led_brightness brightness)
+		       led_brightness brightness)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int curr;
@@ -677,10 +677,10 @@ static int eco_led_set(struct led_classdev *cdev,
 				      curr & ~ECO_LED_ON);
 }
 
-static enum led_brightness eco_led_get(struct led_classdev *cdev)
+static led_brightness eco_led_get(struct led_classdev *cdev)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
-	enum led_brightness brightness = LED_OFF;
+	led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0) & ECO_LED_ON)
 		brightness = LED_FULL;
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 8c0867bda828..518a1033ecce 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -37,10 +37,10 @@
 struct delayed_led_classdev {
 	struct led_classdev led_classdev;
 	struct work_struct work;
-	enum led_brightness new_brightness;
+	led_brightness new_brightness;
 
 	unsigned int led;		/* For driver */
-	void (*set_brightness)(struct delayed_led_classdev *data, enum led_brightness value);
+	void (*set_brightness)(struct delayed_led_classdev *data, led_brightness value);
 };
 
 static inline void delayed_set_status_worker(struct work_struct *work)
@@ -52,7 +52,7 @@ static inline void delayed_set_status_worker(struct work_struct *work)
 }
 
 static inline void delayed_sysfs_set(struct led_classdev *led_cdev,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	struct delayed_led_classdev *data = container_of(led_cdev,
 			     struct delayed_led_classdev, led_classdev);
@@ -255,7 +255,7 @@ static const struct dmi_system_id lis3lv02d_dmi_ids[] = {
  */
 };
 
-static void hpled_set(struct delayed_led_classdev *led_cdev, enum led_brightness value)
+static void hpled_set(struct delayed_led_classdev *led_cdev, led_brightness value)
 {
 	struct acpi_device *dev = lis3_dev.bus_priv;
 	unsigned long long ret; /* Not used when writing */
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index a2d846c4a7ee..40be9d3edb34 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -254,7 +254,7 @@ static int huawei_wmi_cmd(u64 arg, u8 *buf, size_t buflen)
 /* LEDs */
 
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
-		enum led_brightness brightness)
+		led_brightness brightness)
 {
 	/* This is a workaround until the "legacy" interface is implemented. */
 	if (quirks && quirks->ec_micmute) {
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 784326bd72f0..4bc46a50e739 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1274,7 +1274,7 @@ static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
 	return !!test_bit(HALS_KBD_BL_STATE_BIT, &hals);
 }
 
-static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
+static led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
 {
 	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
 
@@ -1294,7 +1294,7 @@ static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned
 }
 
 static int ideapad_kbd_bl_led_cdev_brightness_set(struct led_classdev *led_cdev,
-						  enum led_brightness brightness)
+						  led_brightness brightness)
 {
 	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
 
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 20145b539335..64dfd3a025e3 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -516,7 +516,7 @@ static const struct attribute_group dev_attribute_group = {
 };
 
 static void tpad_led_set(struct led_classdev *cdev,
-			 enum led_brightness brightness)
+			 led_brightness brightness)
 {
 	union acpi_object *r;
 
@@ -524,7 +524,7 @@ static void tpad_led_set(struct led_classdev *cdev,
 	kfree(r);
 }
 
-static enum led_brightness tpad_led_get(struct led_classdev *cdev)
+static led_brightness tpad_led_get(struct led_classdev *cdev)
 {
 	return ggov(GOV_TLED) > 0 ? LED_ON : LED_OFF;
 }
@@ -532,7 +532,7 @@ static enum led_brightness tpad_led_get(struct led_classdev *cdev)
 static LED_DEVICE(tpad_led, 1);
 
 static void kbd_backlight_set(struct led_classdev *cdev,
-			      enum led_brightness brightness)
+			      led_brightness brightness)
 {
 	u32 val;
 	union acpi_object *r;
@@ -546,7 +546,7 @@ static void kbd_backlight_set(struct led_classdev *cdev,
 	kfree(r);
 }
 
-static enum led_brightness kbd_backlight_get(struct led_classdev *cdev)
+static led_brightness kbd_backlight_get(struct led_classdev *cdev)
 {
 	union acpi_object *r;
 	int val;
diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 7ee010aa740a..de6dacbafc92 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1113,7 +1113,7 @@ static void kbd_led_update(struct work_struct *work)
 }
 
 static void kbd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+			led_brightness value)
 {
 	struct samsung_laptop *samsung;
 
@@ -1128,7 +1128,7 @@ static void kbd_led_set(struct led_classdev *led_cdev,
 	queue_work(samsung->led_workqueue, &samsung->kbd_led_work);
 }
 
-static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
+static led_brightness kbd_led_get(struct led_classdev *led_cdev)
 {
 	struct samsung_laptop *samsung;
 
diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index c14fd22ba196..60fb0ea3560f 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -21,8 +21,8 @@ struct system76_data {
 	struct acpi_device *acpi_dev;
 	struct led_classdev ap_led;
 	struct led_classdev kb_led;
-	enum led_brightness kb_brightness;
-	enum led_brightness kb_toggle_brightness;
+	led_brightness kb_brightness;
+	led_brightness kb_toggle_brightness;
 	int kb_color;
 };
 
@@ -33,7 +33,7 @@ static const struct acpi_device_id device_ids[] = {
 MODULE_DEVICE_TABLE(acpi, device_ids);
 
 // Array of keyboard LED brightness levels
-static const enum led_brightness kb_levels[] = {
+static const led_brightness kb_levels[] = {
 	48,
 	72,
 	96,
@@ -89,7 +89,7 @@ static int system76_set(struct system76_data *data, char *method, int value)
 }
 
 // Get the airplane mode LED brightness
-static enum led_brightness ap_led_get(struct led_classdev *led)
+static led_brightness ap_led_get(struct led_classdev *led)
 {
 	struct system76_data *data;
 	int value;
@@ -97,13 +97,13 @@ static enum led_brightness ap_led_get(struct led_classdev *led)
 	data = container_of(led, struct system76_data, ap_led);
 	value = system76_get(data, "GAPL");
 	if (value > 0)
-		return (enum led_brightness)value;
+		return (led_brightness)value;
 	else
 		return LED_OFF;
 }
 
 // Set the airplane mode LED brightness
-static int ap_led_set(struct led_classdev *led, enum led_brightness value)
+static int ap_led_set(struct led_classdev *led, led_brightness value)
 {
 	struct system76_data *data;
 
@@ -112,7 +112,7 @@ static int ap_led_set(struct led_classdev *led, enum led_brightness value)
 }
 
 // Get the last set keyboard LED brightness
-static enum led_brightness kb_led_get(struct led_classdev *led)
+static led_brightness kb_led_get(struct led_classdev *led)
 {
 	struct system76_data *data;
 
@@ -121,7 +121,7 @@ static enum led_brightness kb_led_get(struct led_classdev *led)
 }
 
 // Set the keyboard LED brightness
-static int kb_led_set(struct led_classdev *led, enum led_brightness value)
+static int kb_led_set(struct led_classdev *led, led_brightness value)
 {
 	struct system76_data *data;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 603156a6e3ed..f0bba481c69c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5322,7 +5322,7 @@ static struct ibm_struct video_driver_data = {
  * Keyboard backlight subdriver
  */
 
-static enum led_brightness kbdlight_brightness;
+static led_brightness kbdlight_brightness;
 static DEFINE_MUTEX(kbdlight_mutex);
 
 static int kbdlight_set_level(int level)
@@ -5406,12 +5406,12 @@ static bool kbdlight_is_supported(void)
 }
 
 static int kbdlight_sysfs_set(struct led_classdev *led_cdev,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	return kbdlight_set_level(brightness);
 }
 
-static enum led_brightness kbdlight_sysfs_get(struct led_classdev *led_cdev)
+static led_brightness kbdlight_sysfs_get(struct led_classdev *led_cdev)
 {
 	int level;
 
@@ -5588,13 +5588,13 @@ static int light_set_status(int status)
 }
 
 static int light_sysfs_set(struct led_classdev *led_cdev,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	return light_set_status((brightness != LED_OFF) ?
 				TPACPI_LED_ON : TPACPI_LED_OFF);
 }
 
-static enum led_brightness light_sysfs_get(struct led_classdev *led_cdev)
+static led_brightness light_sysfs_get(struct led_classdev *led_cdev)
 {
 	return (light_get_status() == 1) ? LED_FULL : LED_OFF;
 }
@@ -5918,7 +5918,7 @@ static int led_set_status(const unsigned int led,
 }
 
 static int led_sysfs_set(struct led_classdev *led_cdev,
-			enum led_brightness brightness)
+			led_brightness brightness)
 {
 	struct tpacpi_led_classdev *data = container_of(led_cdev,
 			     struct tpacpi_led_classdev, led_classdev);
@@ -5951,7 +5951,7 @@ static int led_sysfs_blink_set(struct led_classdev *led_cdev,
 	return led_set_status(data->led, TPACPI_LED_BLINK);
 }
 
-static enum led_brightness led_sysfs_get(struct led_classdev *led_cdev)
+static led_brightness led_sysfs_get(struct led_classdev *led_cdev)
 {
 	int rc;
 
@@ -9318,13 +9318,13 @@ static int tpacpi_led_set(int whichled, bool on)
 }
 
 static int tpacpi_led_mute_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
+			       led_brightness brightness)
 {
 	return tpacpi_led_set(LED_AUDIO_MUTE, brightness != LED_OFF);
 }
 
 static int tpacpi_led_micmute_set(struct led_classdev *led_cdev,
-				  enum led_brightness brightness)
+				  led_brightness brightness)
 {
 	return tpacpi_led_set(LED_AUDIO_MICMUTE, brightness != LED_OFF);
 }
@@ -10686,7 +10686,7 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		}
 	}
 	if (tp_features.kbdlight && hkey_event == TP_HKEY_EV_KBD_LIGHT) {
-		enum led_brightness brightness;
+		led_brightness brightness;
 
 		mutex_lock(&kbdlight_mutex);
 
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index f7761d98c0fd..83e062212676 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -35,13 +35,13 @@ struct topstar_laptop {
  * LED
  */
 
-static enum led_brightness topstar_led_get(struct led_classdev *led)
+static led_brightness topstar_led_get(struct led_classdev *led)
 {
 	return led->brightness;
 }
 
 static int topstar_led_set(struct led_classdev *led,
-		enum led_brightness state)
+		led_brightness state)
 {
 	struct topstar_laptop *topstar = container_of(led,
 			struct topstar_laptop, led);
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 352508d30467..8c7d5207a899 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -473,7 +473,7 @@ static void toshiba_illumination_available(struct toshiba_acpi_dev *dev)
 }
 
 static void toshiba_illumination_set(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, led_dev);
@@ -492,7 +492,7 @@ static void toshiba_illumination_set(struct led_classdev *cdev,
 		pr_err("ACPI call for illumination failed\n");
 }
 
-static enum led_brightness toshiba_illumination_get(struct led_classdev *cdev)
+static led_brightness toshiba_illumination_get(struct led_classdev *cdev)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, led_dev);
@@ -591,7 +591,7 @@ static int toshiba_kbd_illum_status_get(struct toshiba_acpi_dev *dev, u32 *time)
 	return result == TOS_SUCCESS ? 0 : -EIO;
 }
 
-static enum led_brightness toshiba_kbd_backlight_get(struct led_classdev *cdev)
+static led_brightness toshiba_kbd_backlight_get(struct led_classdev *cdev)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, kbd_led);
@@ -611,7 +611,7 @@ static enum led_brightness toshiba_kbd_backlight_get(struct led_classdev *cdev)
 }
 
 static void toshiba_kbd_backlight_set(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, kbd_led);
@@ -699,7 +699,7 @@ static void toshiba_eco_mode_available(struct toshiba_acpi_dev *dev)
 	}
 }
 
-static enum led_brightness
+static led_brightness
 toshiba_eco_mode_get_status(struct led_classdev *cdev)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
@@ -721,7 +721,7 @@ toshiba_eco_mode_get_status(struct led_classdev *cdev)
 }
 
 static void toshiba_eco_mode_set_status(struct led_classdev *cdev,
-				     enum led_brightness brightness)
+				     led_brightness brightness)
 {
 	struct toshiba_acpi_dev *dev = container_of(cdev,
 			struct toshiba_acpi_dev, eco_led);
diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 87d36948c610..7afd98c48ff9 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -429,7 +429,7 @@ static int __gb_lights_brightness_set(struct gb_channel *channel)
 }
 
 static int gb_brightness_set(struct led_classdev *cdev,
-			     enum led_brightness value)
+			     led_brightness value)
 {
 	struct gb_channel *channel = get_channel_from_cdev(cdev);
 
@@ -438,7 +438,7 @@ static int gb_brightness_set(struct led_classdev *cdev,
 	return __gb_lights_brightness_set(channel);
 }
 
-static enum led_brightness gb_brightness_get(struct led_classdev *cdev)
+static led_brightness gb_brightness_get(struct led_classdev *cdev)
 
 {
 	struct gb_channel *channel = get_channel_from_cdev(cdev);
diff --git a/drivers/staging/nvec/nvec_paz00.c b/drivers/staging/nvec/nvec_paz00.c
index 8b4da95081c8..83fd8b54f504 100644
--- a/drivers/staging/nvec/nvec_paz00.c
+++ b/drivers/staging/nvec/nvec_paz00.c
@@ -27,7 +27,7 @@ struct nvec_led {
 };
 
 static void nvec_led_brightness_set(struct led_classdev *led_cdev,
-				    enum led_brightness value)
+				    led_brightness value)
 {
 	struct nvec_led *led = to_nvec_led(led_cdev);
 	unsigned char buf[] = NVEC_LED_REQ;
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 8ec19425671f..84337d88d718 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -97,7 +97,7 @@ struct adp8860_led {
 	struct led_classdev	cdev;
 	struct work_struct	work;
 	struct i2c_client	*client;
-	enum led_brightness	new_brightness;
+	led_brightness	new_brightness;
 	int			id;
 	int			flags;
 };
@@ -186,7 +186,7 @@ static void adp8860_led_work(struct work_struct *work)
 }
 
 static void adp8860_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct adp8860_led *led;
 
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 8b5213a39527..f5c61d005598 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -120,7 +120,7 @@ struct adp8870_led {
 	struct led_classdev	cdev;
 	struct work_struct	work;
 	struct i2c_client	*client;
-	enum led_brightness	new_brightness;
+	led_brightness	new_brightness;
 	int			id;
 	int			flags;
 };
@@ -201,7 +201,7 @@ static void adp8870_led_work(struct work_struct *work)
 }
 
 static void adp8870_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+			   led_brightness value)
 {
 	struct adp8870_led *led;
 
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 48c04155a5f9..d1e4fbb71e8e 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -217,7 +217,7 @@ static DEVICE_ATTR(bled_mode, S_IWUSR, NULL, lm3639_bled_mode_store);
 
 /* torch */
 static void lm3639_torch_brightness_set(struct led_classdev *cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	int ret;
 	unsigned int reg_val;
@@ -254,7 +254,7 @@ static void lm3639_torch_brightness_set(struct led_classdev *cdev,
 
 /* flash */
 static void lm3639_flash_brightness_set(struct led_classdev *cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	int ret;
 	unsigned int reg_val;
diff --git a/include/linux/led-class-multicolor.h b/include/linux/led-class-multicolor.h
index 210d57bcd767..3de0ec7f11a6 100644
--- a/include/linux/led-class-multicolor.h
+++ b/include/linux/led-class-multicolor.h
@@ -56,7 +56,7 @@ void led_classdev_multicolor_unregister(struct led_classdev_mc *mcled_cdev);
 
 /* Calculate brightness for the monochrome LED cluster */
 int led_mc_calc_color_components(struct led_classdev_mc *mcled_cdev,
-				 enum led_brightness brightness);
+				 led_brightness brightness);
 
 int devm_led_classdev_multicolor_register_ext(struct device *parent,
 					  struct led_classdev_mc *mcled_cdev,
@@ -75,7 +75,7 @@ static inline int led_classdev_multicolor_register_ext(struct device *parent,
 
 static inline void led_classdev_multicolor_unregister(struct led_classdev_mc *mcled_cdev) {};
 static inline int led_mc_calc_color_components(struct led_classdev_mc *mcled_cdev,
-					       enum led_brightness brightness)
+					       led_brightness brightness)
 {
 	return 0;
 }
diff --git a/include/linux/leds-regulator.h b/include/linux/leds-regulator.h
index 899f816073a1..0b693b7dbedc 100644
--- a/include/linux/leds-regulator.h
+++ b/include/linux/leds-regulator.h
@@ -36,7 +36,7 @@
 
 struct led_regulator_platform_data {
 	char *name;                     /* LED name as expected by LED class */
-	enum led_brightness brightness; /* initial brightness value */
+	led_brightness brightness; /* initial brightness value */
 };
 
 #endif /* __LINUX_LEDS_REGULATOR_H */
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 329fd914cf24..43f823a8aff3 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -26,12 +26,11 @@ struct device_node;
  */
 
 /* This is obsolete/useless. We now support variable maximum brightness. */
-enum led_brightness {
-	LED_OFF		= 0,
-	LED_ON		= 1,
-	LED_HALF	= 127,
-	LED_FULL	= 255,
-};
+typedef u8 led_brightness;
+#define LED_OFF 0
+#define LED_ON 1
+#define LED_HALF 127
+#define LED_FULL 255
 
 struct led_init_data {
 	/* device fwnode handle */
@@ -95,15 +94,15 @@ struct led_classdev {
 	 * that can sleep while setting brightness.
 	 */
 	void		(*brightness_set)(struct led_classdev *led_cdev,
-					  enum led_brightness brightness);
+					  led_brightness brightness);
 	/*
 	 * Set LED brightness level immediately - it can block the caller for
 	 * the time required for accessing a LED device register.
 	 */
 	int (*brightness_set_blocking)(struct led_classdev *led_cdev,
-				       enum led_brightness brightness);
+				       led_brightness brightness);
 	/* Get LED brightness level */
-	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
+	led_brightness (*brightness_get)(struct led_classdev *led_cdev);
 
 	/*
 	 * Activate hardware accelerated blink, delays are in milliseconds
@@ -381,7 +380,7 @@ int devm_led_trigger_register(struct device *dev,
 void led_trigger_register_simple(const char *name,
 				struct led_trigger **trigger);
 void led_trigger_unregister_simple(struct led_trigger *trigger);
-void led_trigger_event(struct led_trigger *trigger,  enum led_brightness event);
+void led_trigger_event(struct led_trigger *trigger,  led_brightness event);
 void led_trigger_blink(struct led_trigger *trigger, unsigned long *delay_on,
 		       unsigned long *delay_off);
 void led_trigger_blink_oneshot(struct led_trigger *trigger,
@@ -434,7 +433,7 @@ static inline void led_trigger_register_simple(const char *name,
 					struct led_trigger **trigger) {}
 static inline void led_trigger_unregister_simple(struct led_trigger *trigger) {}
 static inline void led_trigger_event(struct led_trigger *trigger,
-				enum led_brightness event) {}
+				led_brightness event) {}
 static inline void led_trigger_blink(struct led_trigger *trigger,
 				      unsigned long *delay_on,
 				      unsigned long *delay_off) {}
@@ -566,7 +565,7 @@ void led_classdev_notify_brightness_hw_changed(
 	struct led_classdev *led_cdev, unsigned int brightness);
 #else
 static inline void led_classdev_notify_brightness_hw_changed(
-	struct led_classdev *led_cdev, enum led_brightness brightness) { }
+	struct led_classdev *led_cdev, led_brightness brightness) { }
 #endif
 
 /**
@@ -586,15 +585,15 @@ enum led_audio {
 };
 
 #if IS_ENABLED(CONFIG_LEDS_TRIGGER_AUDIO)
-enum led_brightness ledtrig_audio_get(enum led_audio type);
-void ledtrig_audio_set(enum led_audio type, enum led_brightness state);
+led_brightness ledtrig_audio_get(enum led_audio type);
+void ledtrig_audio_set(enum led_audio type, led_brightness state);
 #else
-static inline enum led_brightness ledtrig_audio_get(enum led_audio type)
+static inline led_brightness ledtrig_audio_get(enum led_audio type)
 {
 	return LED_OFF;
 }
 static inline void ledtrig_audio_set(enum led_audio type,
-				     enum led_brightness state)
+				     led_brightness state)
 {
 }
 #endif
diff --git a/include/linux/mfd/wm8350/pmic.h b/include/linux/mfd/wm8350/pmic.h
index 04b09a2ddb28..416286ad49fe 100644
--- a/include/linux/mfd/wm8350/pmic.h
+++ b/include/linux/mfd/wm8350/pmic.h
@@ -712,7 +712,7 @@ struct wm8350_led {
 	struct platform_device *pdev;
 	struct work_struct work;
 	spinlock_t value_lock;
-	enum led_brightness value;
+	led_brightness value;
 	struct led_classdev cdev;
 	int max_uA_index;
 	int enabled;
diff --git a/include/media/v4l2-flash-led-class.h b/include/media/v4l2-flash-led-class.h
index b106e7a74e87..1705064b278a 100644
--- a/include/media/v4l2-flash-led-class.h
+++ b/include/media/v4l2-flash-led-class.h
@@ -15,7 +15,7 @@
 struct led_classdev_flash;
 struct led_classdev;
 struct v4l2_flash;
-enum led_brightness;
+led_brightness;
 
 /**
  * struct v4l2_flash_ctrl_data - flash control initialization data, filled
@@ -43,10 +43,10 @@ struct v4l2_flash_ctrl_data {
 struct v4l2_flash_ops {
 	int (*external_strobe_set)(struct v4l2_flash *v4l2_flash,
 					bool enable);
-	enum led_brightness (*intensity_to_led_brightness)
+	led_brightness (*intensity_to_led_brightness)
 		(struct v4l2_flash *v4l2_flash, s32 intensity);
 	s32 (*led_brightness_to_intensity)
-		(struct v4l2_flash *v4l2_flash, enum led_brightness);
+		(struct v4l2_flash *v4l2_flash, led_brightness);
 };
 
 /**
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index ac15a944573f..107433336db3 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -174,7 +174,7 @@ static struct work_struct rfkill_global_led_trigger_work;
 
 static void rfkill_global_led_trigger_worker(struct work_struct *work)
 {
-	enum led_brightness brightness = LED_OFF;
+	led_brightness brightness = LED_OFF;
 	struct rfkill *rfkill;
 
 	mutex_lock(&rfkill_global_mutex);
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index e97d00585e8e..f249f65521a7 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3915,7 +3915,7 @@ static int parse_mic_boost(struct hda_codec *codec)
 
 static int create_mute_led_cdev(struct hda_codec *codec,
 				int (*callback)(struct led_classdev *,
-						enum led_brightness),
+						led_brightness),
 				bool micmute)
 {
 	struct led_classdev *cdev;
@@ -3941,7 +3941,7 @@ static int create_mute_led_cdev(struct hda_codec *codec,
  */
 int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 				  int (*callback)(struct led_classdev *,
-						  enum led_brightness))
+						  led_brightness))
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int err;
@@ -3978,7 +3978,7 @@ EXPORT_SYMBOL_GPL(snd_hda_gen_add_mute_led_cdev);
  */
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
-						     enum led_brightness))
+						     led_brightness))
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int err;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index d4dd1b8a2e7e..e09c7c28a673 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -346,9 +346,9 @@ int snd_hda_gen_fix_pin_power(struct hda_codec *codec, hda_nid_t pin);
 
 int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 				  int (*callback)(struct led_classdev *,
-						  enum led_brightness));
+						  led_brightness));
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
-						     enum led_brightness));
+						     led_brightness));
 
 #endif /* __SOUND_HDA_GENERIC_H */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d111258c6f45..1ee2a8d932c8 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -138,7 +138,7 @@ static void cx_auto_vmaster_hook(void *private_data, int enabled)
 
 /* turn on/off EAPD according to Master switch (inversely!) for mute LED */
 static int cx_auto_vmaster_mute_led(struct led_classdev *led_cdev,
-				    enum led_brightness brightness)
+				    led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct conexant_spec *spec = codec->spec;
@@ -651,7 +651,7 @@ static void cxt_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 
 /* turn on/off mute LED via GPIO per vmaster hook */
 static int cxt_gpio_mute_update(struct led_classdev *led_cdev,
-				enum led_brightness brightness)
+				led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct conexant_spec *spec = codec->spec;
@@ -662,7 +662,7 @@ static int cxt_gpio_mute_update(struct led_classdev *led_cdev,
 
 /* turn on/off mic-mute LED via GPIO per capture hook */
 static int cxt_gpio_micmute_update(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct conexant_spec *spec = codec->spec;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1389cfd5e0db..ce2d5b3647b0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4191,7 +4191,7 @@ static void alc_update_vref_led(struct hda_codec *codec, hda_nid_t pin,
 
 /* update mute-LED according to the speaker mute state via mic VREF pin */
 static int vref_mute_led_set(struct led_classdev *led_cdev,
-			     enum led_brightness brightness)
+			     led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct alc_spec *spec = codec->spec;
@@ -4288,7 +4288,7 @@ static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 
 /* turn on/off mute LED via GPIO per vmaster hook */
 static int gpio_mute_led_set(struct led_classdev *led_cdev,
-			     enum led_brightness brightness)
+			     led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct alc_spec *spec = codec->spec;
@@ -4300,7 +4300,7 @@ static int gpio_mute_led_set(struct led_classdev *led_cdev,
 
 /* turn on/off mic-mute LED via GPIO per capture hook */
 static int micmute_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
+			   led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct alc_spec *spec = codec->spec;
@@ -4364,7 +4364,7 @@ static void alc287_fixup_hp_gpio_led(struct hda_codec *codec,
 
 /* turn on/off mic-mute LED per capture hook via VREF change */
 static int vref_micmute_led_set(struct led_classdev *led_cdev,
-				enum led_brightness brightness)
+				led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct alc_spec *spec = codec->spec;
@@ -4469,7 +4469,7 @@ static void alc_update_coef_led(struct hda_codec *codec,
 
 /* update mute-LED according to the speaker mute state via COEF bit */
 static int coef_mute_led_set(struct led_classdev *led_cdev,
-			     enum led_brightness brightness)
+			     led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct alc_spec *spec = codec->spec;
@@ -4513,7 +4513,7 @@ static void alc236_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
-				enum led_brightness brightness)
+				led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct alc_spec *spec = codec->spec;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3bd592e126a3..3fac00cc97ff 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -321,7 +321,7 @@ static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
 
 /* hook for controlling mic-mute LED GPIO */
 static int stac_capture_led_update(struct led_classdev *led_cdev,
-				   enum led_brightness brightness)
+				   led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct sigmatel_spec *spec = codec->spec;
@@ -396,7 +396,7 @@ static void stac_update_led_status(struct hda_codec *codec, bool muted)
 
 /* vmaster hook to update mute LED */
 static int stac_vmaster_hook(struct led_classdev *led_cdev,
-			     enum led_brightness brightness)
+			     led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 4e5693c97aa4..f60d42e033a6 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -294,7 +294,7 @@ static void toneport_update_led(struct usb_line6_toneport *toneport)
 }
 
 static void toneport_led_brightness_set(struct led_classdev *led_cdev,
-					enum led_brightness brightness)
+					led_brightness brightness)
 {
 	struct toneport_led *leds =
 		container_of(led_cdev, struct toneport_led, dev);
-- 
2.31.1

