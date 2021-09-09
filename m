Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2B404409
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 05:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350270AbhIIDoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:44:11 -0400
Received: from ds9.troy.rollo.name ([208.77.100.199]:40006 "EHLO
        ds9.troy.rollo.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhIIDoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:44:10 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2021 23:44:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=troy.rollo.name; s=20151118; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j2j3MTw71ZEkYRpbLc8Pg5oSXM260GcG2SLR09JDvek=; b=oZJyiy/9v1gswawAECMyPRMm+5
        ncbXn4s63XrLL2epr4Cg74g7PzFATD6nyL0/iUN6FFsBfhL/RGLzgVIuFjvwMDADAi3z6AKV+Csh2
        fXnrJaXJFuZqX1cUisL9Sk+BXqH4vrOxtYm0NJ4GC0UXxIvqu9POwagzC4rJ1oWe40jk=;
Received: from enterprise.troy.rollo.name ([202.153.212.77] helo=enterprise)
        by ds9.troy.rollo.name with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <troy@troy.rollo.name>)
        id 1mOApg-0004Ek-51; Thu, 09 Sep 2021 13:34:36 +1000
Received: from troy by enterprise with local (Exim 4.94.2)
        (envelope-from <troy@enterprise.troy.rollo.name>)
        id 1mOAq8-008Mwu-Gf; Thu, 09 Sep 2021 13:35:04 +1000
From:   Troy Rollo <linux2021@troy.rollo.name>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Troy Rollo <linux2021@troy.rollo.name>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Process tablet mode events on Dell Inspiron 2n1
Date:   Thu,  9 Sep 2021 13:35:01 +1000
Message-Id: <20210909033502.1994749-1-linux2021@troy.rollo.name>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/dell/dell-wmi-base.c | 36 ++++++++++++++++-------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 089c125e18f7..474ca05055ab 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -309,6 +309,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
  * Keymap for WMI events of type 0x0011
  */
 static const struct key_entry dell_wmi_keymap_type_0011[] = {
+	/* Reflex keyboard switch on 2n1 devices */
+	{ KE_VSW,    0xe070, { .sw  = { SW_TABLET_MODE } } },
+
 	/* Battery unplugged */
 	{ KE_IGNORE, 0xfff0, { KEY_RESERVED } },
 
@@ -344,17 +347,19 @@ static const struct key_entry dell_wmi_keymap_type_0012[] = {
 	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
 };
 
-static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
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
@@ -363,16 +368,22 @@ static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
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
+		value = !buffer[0];
+		used = 1;
+	}
+
+	sparse_keymap_report_entry(priv->input_dev, key, value, true);
 
-	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
+	return used;
 }
 
 static void dell_wmi_notify(struct wmi_device *wdev,
@@ -430,21 +441,26 @@ static void dell_wmi_notify(struct wmi_device *wdev,
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
-- 
2.30.2

