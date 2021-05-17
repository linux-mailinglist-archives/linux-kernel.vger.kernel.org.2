Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC838296E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhEQKJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:09:08 -0400
Received: from www.zeus03.de ([194.117.254.33]:39436 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhEQKJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=nawEMLzWlS0z6SB6yinf2i6bYvZ
        JtCd1L00esRlOOSQ=; b=iQH4JncmIEYqYR5Y5C0bayD9dUUJvz0Yj9Ux86WVo1e
        V61mXl4miun7POG6lfpDrdtxcFid5cwlLiMXcSkzSA6+LtNMebIrbX1rKYd2JCGq
        kPLj9BE8h8EKaEIMPL2V/fcno0Po4xAiX3yC0EdjWVV5+2hWqk3qpMNuw+wBTiiY
        =
Received: (qmail 2471376 invoked from network); 17 May 2021 12:07:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 May 2021 12:07:47 +0200
X-UD-Smtp-Session: l3s3148p1@8sD1w4PC/LggARa4RYY7ATBvQ5FTVwg4
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 1/2] platform/x86: samsung-laptop: use octal numbers for rwx file permissions
Date:   Mon, 17 May 2021 12:07:44 +0200
Message-Id: <20210517100746.29663-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy asked me to do it before working further on the code.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

change since v2: added Andy's tag

 drivers/platform/x86/samsung-laptop.c | 35 +++++++++++----------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index d5cec6e35bb8..763d97cbbe53 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -388,7 +388,7 @@ MODULE_PARM_DESC(force,
 		"Disable the DMI check and forces the driver to be loaded");
 
 static bool debug;
-module_param(debug, bool, S_IRUGO | S_IWUSR);
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Debug enabled or not");
 
 static int sabi_command(struct samsung_laptop *samsung, u16 command,
@@ -705,7 +705,7 @@ static ssize_t set_performance_level(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(performance_level, S_IWUSR | S_IRUGO,
+static DEVICE_ATTR(performance_level, 0644,
 		   get_performance_level, set_performance_level);
 
 static int read_battery_life_extender(struct samsung_laptop *samsung)
@@ -774,7 +774,7 @@ static ssize_t set_battery_life_extender(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(battery_life_extender, S_IWUSR | S_IRUGO,
+static DEVICE_ATTR(battery_life_extender, 0644,
 		   get_battery_life_extender, set_battery_life_extender);
 
 static int read_usb_charge(struct samsung_laptop *samsung)
@@ -843,7 +843,7 @@ static ssize_t set_usb_charge(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(usb_charge, S_IWUSR | S_IRUGO,
+static DEVICE_ATTR(usb_charge, 0644,
 		   get_usb_charge, set_usb_charge);
 
 static int read_lid_handling(struct samsung_laptop *samsung)
@@ -908,7 +908,7 @@ static ssize_t set_lid_handling(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(lid_handling, S_IWUSR | S_IRUGO,
+static DEVICE_ATTR(lid_handling, 0644,
 		   get_lid_handling, set_lid_handling);
 
 static struct attribute *platform_attributes[] = {
@@ -1291,24 +1291,17 @@ static void samsung_debugfs_init(struct samsung_laptop *samsung)
 	samsung->debug.sdiag_wrapper.data = samsung->sdiag;
 	samsung->debug.sdiag_wrapper.size = strlen(samsung->sdiag);
 
-	debugfs_create_u16("command", S_IRUGO | S_IWUSR, root,
-			   &samsung->debug.command);
-	debugfs_create_u32("d0", S_IRUGO | S_IWUSR, root,
-			   &samsung->debug.data.d0);
-	debugfs_create_u32("d1", S_IRUGO | S_IWUSR, root,
-			   &samsung->debug.data.d1);
-	debugfs_create_u16("d2", S_IRUGO | S_IWUSR, root,
-			   &samsung->debug.data.d2);
-	debugfs_create_u8("d3", S_IRUGO | S_IWUSR, root,
-			  &samsung->debug.data.d3);
-	debugfs_create_blob("data", S_IRUGO | S_IWUSR, root,
-			    &samsung->debug.data_wrapper);
-	debugfs_create_blob("f0000_segment", S_IRUSR | S_IWUSR, root,
+	debugfs_create_u16("command", 0644, root, &samsung->debug.command);
+	debugfs_create_u32("d0", 0644, root, &samsung->debug.data.d0);
+	debugfs_create_u32("d1", 0644, root, &samsung->debug.data.d1);
+	debugfs_create_u16("d2", 0644, root, &samsung->debug.data.d2);
+	debugfs_create_u8("d3", 0644, root, &samsung->debug.data.d3);
+	debugfs_create_blob("data", 0644, root, &samsung->debug.data_wrapper);
+	debugfs_create_blob("f0000_segment", 0600, root,
 			    &samsung->debug.f0000_wrapper);
-	debugfs_create_file("call", S_IFREG | S_IRUGO, root, samsung,
+	debugfs_create_file("call", S_IFREG | 0444, root, samsung,
 			    &samsung_laptop_call_fops);
-	debugfs_create_blob("sdiag", S_IRUGO | S_IWUSR, root,
-			    &samsung->debug.sdiag_wrapper);
+	debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
 }
 
 static void samsung_sabi_exit(struct samsung_laptop *samsung)
-- 
2.30.2

