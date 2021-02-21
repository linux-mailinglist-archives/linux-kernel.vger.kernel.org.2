Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED6D320DED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhBUVb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBUVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:31:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845FC061786;
        Sun, 21 Feb 2021 13:31:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so12237066wrh.11;
        Sun, 21 Feb 2021 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQWQp/fGjtTbL9z86k225IBSAPVnbR+Nqs5l18w+3FU=;
        b=Xjm5W1/VTQnfgCKME6kbMBu2PzVE/DKOhxB/DRQe2lHBo+y/8E0SDboDJZb39UnQJi
         OxpReZ+OJ1zzq5P76hhCeyR5LBS2Yp2ChuYMcFEN7jK7p4utHBDL8Ya8+AG2SlAmVl5w
         UawZRMQTsszjoqvsRmW/r6u2IKBLcNKaK/aY3opiDZfmpcW3HEwOhpttr8t640odzrAx
         /zLbTT0bviRZm+nqhKqnWHpd6jW3qOcemsZ3cuP0kC/Njkx0a8ae8M0KMfFcry7Bl7+X
         wMMEKK/HdMsXmzinLjGAlj/eNn7V/ZgMgJtEwkWHaUcAShQX1YBI1VqAtDm5KOVAvHMl
         y1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQWQp/fGjtTbL9z86k225IBSAPVnbR+Nqs5l18w+3FU=;
        b=Vg20EFBqwBxbR0wEUGkDFrDkf32JLfxih5xnNw/jSwGXB/I5YgR0B2h+WE8pgc6SdH
         mmSrw1+hb+Zn51JnucIpUYFW7AQXfOAr4gzu1S+Xwy5+N/BJoracC5Gv8uDZLEOS8EYy
         vBH+t647a9WGPrZuR0LwMDzejPmNMvk3HLQPPqKb75GZZNKxKOrWX6JnhK64V4iQJZ3/
         8K+wwc/5iGNWEOnPourSfGz9Kh3ndMxGFhT8l3LuGHW6AR2k/15e5zqOhj4QagF+jSSm
         f6xUM6PBuido3HSMlgWMGOfcqOnJcGFFWveKVKXenZfGQm8DqmEAq6nwMXx7UbxPXVOm
         WiEg==
X-Gm-Message-State: AOAM531dnCsXvf2UW/kRLIayCsClEDBDvzsrVMaSzAu73nEEw8YoQNHG
        MYFpmyPmG+KBV1zhjv5R2So=
X-Google-Smtp-Source: ABdhPJwAKuO5C03oxbwb8vY8eT13hgq1r8AZCRtocyK5Z7WZfAGyiIDtol+jivQvKGv7e4gDSIPI+Q==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr1605624wrm.388.1613943072580;
        Sun, 21 Feb 2021 13:31:12 -0800 (PST)
Received: from localhost.localdomain (host-79-22-224-43.retail.telecomitalia.it. [79.22.224.43])
        by smtp.gmail.com with ESMTPSA id l4sm25949193wrt.42.2021.02.21.13.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 13:31:12 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: hp-wmi: add platform profile support
Date:   Sun, 21 Feb 2021 22:30:06 +0100
Message-Id: <20210221213006.4725-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210221210439.68590-1-eliadevito@gmail.com>
References: <20210221210439.68590-1-eliadevito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for cool, balanced and performance thermal profile

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
the "quiet" profile will be implemented with a further patch

v2: added platform_profile_remove() missing call

 drivers/platform/x86/hp-wmi.c | 103 ++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 6d7b91b8109b..a33203d61cf0 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -21,6 +21,7 @@
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/platform_device.h>
+#include <linux/platform_profile.h>
 #include <linux/acpi.h>
 #include <linux/rfkill.h>
 #include <linux/string.h>
@@ -119,6 +120,12 @@ enum hp_wireless2_bits {
 	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
 };
 
+enum hp_thermal_profile {
+	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
+	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
+	HP_THERMAL_PROFILE_COOL			= 0x02
+};
+
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
 #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
 
@@ -159,6 +166,8 @@ static const struct key_entry hp_wmi_keymap[] = {
 
 static struct input_dev *hp_wmi_input_dev;
 static struct platform_device *hp_wmi_platform_dev;
+static struct platform_profile_handler platform_profile_handler;
+static int platform_profile_support = 0;
 
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
@@ -869,11 +878,80 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 	return err;
 }
 
-static int thermal_profile_setup(struct platform_device *device)
+static int thermal_profile_get(void)
 {
-	int err, tp;
+	int tp;
 
 	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
+
+	return tp;
+}
+
+static int thermal_profile_set(int thermal_profile)
+{
+	int err;
+
+	err = hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &thermal_profile,
+							   sizeof(thermal_profile), 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int platform_profile_get(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile)
+{
+	int tp = thermal_profile_get();
+
+	switch (tp) {
+	case HP_THERMAL_PROFILE_PERFORMANCE:
+		*profile =  PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case HP_THERMAL_PROFILE_DEFAULT:
+		*profile =  PLATFORM_PROFILE_BALANCED;
+		break;
+	case HP_THERMAL_PROFILE_COOL:
+		*profile =  PLATFORM_PROFILE_COOL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int platform_profile_set(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile)
+{
+	int err, tp;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		tp =  HP_THERMAL_PROFILE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		tp =  HP_THERMAL_PROFILE_DEFAULT;
+		break;
+	case PLATFORM_PROFILE_COOL:
+		tp =  HP_THERMAL_PROFILE_COOL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = thermal_profile_set(tp);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int thermal_profile_setup(void)
+{
+	int err, tp;
+
+	tp = thermal_profile_get();
 	if (tp < 0)
 		return tp;
 
@@ -881,11 +959,23 @@ static int thermal_profile_setup(struct platform_device *device)
 	 * call thermal profile write command to ensure that the firmware correctly
 	 * sets the OEM variables for the DPTF
 	 */
-	err = hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &tp,
-							   sizeof(tp), 0);
+	err = thermal_profile_set(tp);
 	if (err)
 		return err;
 
+	platform_profile_handler.profile_get = platform_profile_get,
+	platform_profile_handler.profile_set = platform_profile_set,
+
+	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
+
+	err = platform_profile_register(&platform_profile_handler);
+	if (err)
+		return err;
+
+	platform_profile_support = 1;
+
 	return 0;
 }
 
@@ -900,7 +990,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
-	thermal_profile_setup(device);
+	thermal_profile_setup();
 
 	return 0;
 }
@@ -1030,5 +1120,8 @@ static void __exit hp_wmi_exit(void)
 		platform_device_unregister(hp_wmi_platform_dev);
 		platform_driver_unregister(&hp_wmi_driver);
 	}
+
+	if (platform_profile_support)
+		platform_profile_remove();
 }
 module_exit(hp_wmi_exit);
-- 
2.29.2

