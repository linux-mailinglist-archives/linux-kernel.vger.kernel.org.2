Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1E4104CF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhIRHg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:36:28 -0400
Received: from ds9.troy.rollo.name ([208.77.100.199]:57858 "EHLO
        ds9.troy.rollo.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIRHg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=troy.rollo.name; s=20151118; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5YF8qUyL/Z0S+zvPuJUJ/IZTj4Gp5JFGgIljFMXbdq4=; b=ihqdRYFhx/H6pHc2v2LAIk0MHL
        lV/99+/t3QCurmZXRufGXzk9be695yr0Cx/Ipy+xOx0ZfXYKgcx4nM0SIrbZBwPrewQacJXaIy2GG
        gA+N9Rdz94/eDIUZ73mlicHBWhyInGocBgNJ55WYJBOiIoRPOWqsOrCpmgdBg6StPtg4=;
Received: from enterprise.troy.rollo.name ([202.153.212.77] helo=enterprise)
        by ds9.troy.rollo.name with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <troy@troy.rollo.name>)
        id 1mRUqa-00052i-5J; Sat, 18 Sep 2021 17:33:16 +1000
Received: from troy by enterprise with local (Exim 4.94.2)
        (envelope-from <troy@enterprise.troy.rollo.name>)
        id 1mRUr3-00CRx7-Jp; Sat, 18 Sep 2021 17:33:46 +1000
From:   Troy Rollo <linux2021@troy.rollo.name>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Troy Rollo <linux2021@troy.rollo.name>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi: Recognise or support new switches
Date:   Sat, 18 Sep 2021 17:31:30 +1000
Message-Id: <20210918073131.2966942-1-linux2021@troy.rollo.name>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for:

- Dell Inspiron 2in1 tablet mode switch notifications. These are
  delivered by a type 0x0011 message with code 0xe070, followed by a
  flag (1 for laptop mode, 0 for tablet mode).

- Recognising (but not otherwise processing) the Dell Ultra Performance
  mode request switch. This is delivered by a type 0x0012 message with
  code 0x000d, followed by a parameter that is either 1 or 2. It is
  not clear what (if anything) should be done with this notification, so
  it is ignored.

Signed-off-by: Troy Rollo <linux2021@troy.rollo.name>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 76 ++++++++++++++++++++---
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 089c125e18f7..e07d3ba85a3f 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -40,6 +40,7 @@ static bool wmi_requires_smbios_request;
 
 struct dell_wmi_priv {
 	struct input_dev *input_dev;
+	struct input_dev *tabletswitch_dev;
 	u32 interface_version;
 };
 
@@ -309,6 +310,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
  * Keymap for WMI events of type 0x0011
  */
 static const struct key_entry dell_wmi_keymap_type_0011[] = {
+	/* Reflex keyboard switch on 2n1 devices */
+	{ KE_IGNORE, 0xe070, { KEY_RESERVED } },
+
 	/* Battery unplugged */
 	{ KE_IGNORE, 0xfff0, { KEY_RESERVED } },
 
@@ -340,21 +344,55 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
  * They are events with extended data
  */
 static const struct key_entry dell_wmi_keymap_type_0012[] = {
+	/* Ultra-performance mode switch request */
+	{ KE_IGNORE, 0x000d, { KEY_RESERVED } },
+
 	/* Fn-lock button pressed */
 	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
 };
 
-static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
+static void dell_wmi_switch_event(struct input_dev **subdev,
+				  const char *devname,
+				  int switchid,
+				  int value)
+{
+	if (!*subdev) {
+		struct input_dev *dev = input_allocate_device();
+
+		if (!dev) {
+			pr_warn("could not allocate device for %s\n", devname);
+			return;
+		}
+		__set_bit(EV_SW, (dev)->evbit);
+		__set_bit(switchid, (dev)->swbit);
+
+		(dev)->name = devname;
+		(dev)->id.bustype = BUS_HOST;
+		if (input_register_device(dev)) {
+			input_free_device(dev);
+			pr_warn("could not register device for %s\n", devname);
+			return;
+		}
+		*subdev = dev;
+	}
+
+	input_report_switch(*subdev, switchid, value);
+	input_sync(*subdev);
+}
+
+static int dell_wmi_process_key(struct wmi_device *wdev, int type, int code, u16 *buffer, int remaining)
 {
 	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	const struct key_entry *key;
+	int used = 0;
+	int value = 1;
 
 	key = sparse_keymap_entry_from_scancode(priv->input_dev,
 						(type << 16) | code);
 	if (!key) {
 		pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n",
 			type, code);
-		return;
+		return 0;
 	}
 
 	pr_debug("Key with type 0x%04x and code 0x%04x pressed\n", type, code);
@@ -363,16 +401,27 @@ static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
 	if ((key->keycode == KEY_BRIGHTNESSUP ||
 	     key->keycode == KEY_BRIGHTNESSDOWN) &&
 	    acpi_video_handles_brightness_key_presses())
-		return;
+		return 0;
 
 	if (type == 0x0000 && code == 0xe025 && !wmi_requires_smbios_request)
-		return;
+		return 0;
 
-	if (key->keycode == KEY_KBDILLUMTOGGLE)
+	if (key->keycode == KEY_KBDILLUMTOGGLE) {
 		dell_laptop_call_notifier(
 			DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED, NULL);
+	} else if (type == 0x0011 && code == 0xe070 && remaining > 0) {
+		dell_wmi_switch_event(&priv->tabletswitch_dev,
+				      "Dell tablet mode switch",
+				      SW_TABLET_MODE, !buffer[0]);
+		return 1;
+	} else if (type == 0x0012 && code == 0x000d && remaining > 0) {
+		value = (buffer[2] == 2);
+		used = 1;
+	}
 
-	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
+	sparse_keymap_report_entry(priv->input_dev, key, value, true);
+
+	return used;
 }
 
 static void dell_wmi_notify(struct wmi_device *wdev,
@@ -430,21 +479,26 @@ static void dell_wmi_notify(struct wmi_device *wdev,
 		case 0x0000: /* One key pressed or event occurred */
 			if (len > 2)
 				dell_wmi_process_key(wdev, buffer_entry[1],
-						     buffer_entry[2]);
+						     buffer_entry[2],
+						     buffer_entry + 3,
+						     len - 3);
 			/* Extended data is currently ignored */
 			break;
 		case 0x0010: /* Sequence of keys pressed */
 		case 0x0011: /* Sequence of events occurred */
 			for (i = 2; i < len; ++i)
-				dell_wmi_process_key(wdev, buffer_entry[1],
-						     buffer_entry[i]);
+				i += dell_wmi_process_key(wdev, buffer_entry[1],
+							  buffer_entry[i],
+							  buffer_entry + i,
+							  len - i - 1);
 			break;
 		case 0x0012:
 			if ((len > 4) && dell_privacy_process_event(buffer_entry[1], buffer_entry[3],
 								    buffer_entry[4]))
 				/* dell_privacy_process_event has handled the event */;
 			else if (len > 2)
-				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
+				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2],
+						     buffer_entry + 3, len - 3);
 			break;
 		default: /* Unknown event */
 			pr_info("Unknown WMI event type 0x%x\n",
@@ -661,6 +715,8 @@ static void dell_wmi_input_destroy(struct wmi_device *wdev)
 	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 
 	input_unregister_device(priv->input_dev);
+	if (priv->tabletswitch_dev)
+		input_unregister_device(priv->tabletswitch_dev);
 }
 
 /*
-- 
2.30.2

