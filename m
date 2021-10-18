Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFC431322
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhJRJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhJRJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:20:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67066C06161C;
        Mon, 18 Oct 2021 02:17:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso14020288pjb.4;
        Mon, 18 Oct 2021 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEPTi1IjpGGaCxlyJFB6iV1bIw/FMmc/gW7AFZwRvk8=;
        b=VL3fki0KsshkeYZcxHAfMGRr4wUvB80IPXjXA24efe8jrQmG6sM91MmMumonZhw2ZX
         D/Niqk0ZJt9hL4/R2DMEa431x0b5CIRqSNEE8vNnq6WrsHc7UUhY657ufX2nKU9vdOav
         ex9Jz5NaMkuZElJIISPqrMczQfz0oe4jBzuDkCC2ejOR7Uyb225+KouEhD34gObp0dHO
         iQWi20nv4sDoDIvdj2hjRK2sZY0OB8oh/5D5l3AcWvdhYah2pSHpHenTBAL/RoiPjGg8
         WanJKHcw0ESBNjti764263+WsOo1IiTaJFaBYPdP3l5FsIgdJp6EI5J3TOEzZ2JcEmxu
         PrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEPTi1IjpGGaCxlyJFB6iV1bIw/FMmc/gW7AFZwRvk8=;
        b=BFKWkL0peKsWpsBC789pUKXvBSoe6YP0h5Xpj86aXcrnJlodM/isQS1aM+7tpwJgkx
         wTnXll+iiy74+3OAJClmdK6vxfcdH5jlststMUzYwCuvMxm00I2wQR7s9RiRtB6MBUin
         bxcAXMmryYJOtiP0S4TooyPG+MafdilYuQlPYVj1zG+TAK2lQBoWxa9zdPWQhOzGm5hy
         XUiO9BvLW8bc9D+Owj+qzFf5IF1TD6jCQV2WeX8I7/SAz+SyzJ9cHChAIwMM474nTL50
         otejDMx6UCkJL1hUgCj+cEoO9izuu/86gC/oSgCMmKi+t63kUK68MnojXrg89uH69r6c
         hMzw==
X-Gm-Message-State: AOAM533G9vR87ZH5y5PGpNg28OIUmpviKKGe0qf9irZnaBg/cIgpb9Zj
        tITomEZ3FEhw7UynaiGde2A=
X-Google-Smtp-Source: ABdhPJyTUAJsqyaPHHMhqyyIADxc6L72xpFBQjE+mWWyed6Kq2PGMb4OzU2DNRle4903v0NEAX6s2w==
X-Received: by 2002:a17:90b:4b46:: with SMTP id mi6mr31566870pjb.161.1634548676947;
        Mon, 18 Oct 2021 02:17:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u16sm12317290pfn.187.2021.10.18.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:17:56 -0700 (PDT)
From:   Ye Guojin <cgel.zte@gmail.com>
X-Google-Original-From: Ye Guojin <ye.guojin@zte.com.cn>
To:     hmh@hmh.eng.br
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, Ye Guojin <ye.guojin@zte.com.cn>
Subject: [PATCH] platform/x86: thinkpad_acpi: fix coccinelle warnings
Date:   Mon, 18 Oct 2021 09:17:50 +0000
Message-Id: <20211018091750.858826-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show
functions:

WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/platform/x86/thinkpad_acpi.c | 54 ++++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 882e994658f1..338a848d6dd0 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1277,7 +1277,7 @@ static ssize_t tpacpi_rfk_sysfs_enable_show(const enum tpacpi_rfk_id id,
 			return status;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			(status == TPACPI_RFK_RADIO_ON) ? 1 : 0);
 }
 
@@ -1370,14 +1370,14 @@ static int tpacpi_rfk_procfs_write(const enum tpacpi_rfk_id id, char *buf)
 /* interface_version --------------------------------------------------- */
 static ssize_t interface_version_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", TPACPI_SYSFS_VERSION);
+	return sysfs_emit(buf, "0x%08x\n", TPACPI_SYSFS_VERSION);
 }
 static DRIVER_ATTR_RO(interface_version);
 
 /* debug_level --------------------------------------------------------- */
 static ssize_t debug_level_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", dbg_level);
+	return sysfs_emit(buf, "0x%04x\n", dbg_level);
 }
 
 static ssize_t debug_level_store(struct device_driver *drv, const char *buf,
@@ -1397,7 +1397,7 @@ static DRIVER_ATTR_RW(debug_level);
 /* version ------------------------------------------------------------- */
 static ssize_t version_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s v%s\n",
+	return sysfs_emit(buf, "%s v%s\n",
 			TPACPI_DESC, TPACPI_VERSION);
 }
 static DRIVER_ATTR_RO(version);
@@ -1409,7 +1409,7 @@ static DRIVER_ATTR_RO(version);
 /* wlsw_emulstate ------------------------------------------------------ */
 static ssize_t wlsw_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wlsw_emulstate);
+	return sysfs_emit(buf, "%d\n", !!tpacpi_wlsw_emulstate);
 }
 
 static ssize_t wlsw_emulstate_store(struct device_driver *drv, const char *buf,
@@ -1432,7 +1432,7 @@ static DRIVER_ATTR_RW(wlsw_emulstate);
 /* bluetooth_emulstate ------------------------------------------------- */
 static ssize_t bluetooth_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_bluetooth_emulstate);
+	return sysfs_emit(buf, "%d\n", !!tpacpi_bluetooth_emulstate);
 }
 
 static ssize_t bluetooth_emulstate_store(struct device_driver *drv,
@@ -1452,7 +1452,7 @@ static DRIVER_ATTR_RW(bluetooth_emulstate);
 /* wwan_emulstate ------------------------------------------------- */
 static ssize_t wwan_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wwan_emulstate);
+	return sysfs_emit(buf, "%d\n", !!tpacpi_wwan_emulstate);
 }
 
 static ssize_t wwan_emulstate_store(struct device_driver *drv, const char *buf,
@@ -1472,7 +1472,7 @@ static DRIVER_ATTR_RW(wwan_emulstate);
 /* uwb_emulstate ------------------------------------------------- */
 static ssize_t uwb_emulstate_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_uwb_emulstate);
+	return sysfs_emit(buf, "%d\n", !!tpacpi_uwb_emulstate);
 }
 
 static ssize_t uwb_emulstate_store(struct device_driver *drv, const char *buf,
@@ -2680,7 +2680,7 @@ static ssize_t hotkey_enable_show(struct device *dev,
 	if (res)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buf, "%d\n", status);
 }
 
 static ssize_t hotkey_enable_store(struct device *dev,
@@ -2708,7 +2708,7 @@ static ssize_t hotkey_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_user_mask);
+	return sysfs_emit(buf, "0x%08x\n", hotkey_user_mask);
 }
 
 static ssize_t hotkey_mask_store(struct device *dev,
@@ -2756,7 +2756,7 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 {
 	printk_deprecated_attribute("hotkey_bios_mask",
 			"This attribute is useless.");
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_orig_mask);
+	return sysfs_emit(buf, "0x%08x\n", hotkey_orig_mask);
 }
 
 static DEVICE_ATTR_RO(hotkey_bios_mask);
@@ -2766,7 +2766,7 @@ static ssize_t hotkey_all_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+	return sysfs_emit(buf, "0x%08x\n",
 				hotkey_all_mask | hotkey_source_mask);
 }
 
@@ -2777,7 +2777,7 @@ static ssize_t hotkey_adaptive_all_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+	return sysfs_emit(buf, "0x%08x\n",
 			hotkey_adaptive_all_mask | hotkey_source_mask);
 }
 
@@ -2788,7 +2788,7 @@ static ssize_t hotkey_recommended_mask_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+	return sysfs_emit(buf, "0x%08x\n",
 			(hotkey_all_mask | hotkey_source_mask)
 			& ~hotkey_reserved_mask);
 }
@@ -2802,7 +2802,7 @@ static ssize_t hotkey_source_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_source_mask);
+	return sysfs_emit(buf, "0x%08x\n", hotkey_source_mask);
 }
 
 static ssize_t hotkey_source_mask_store(struct device *dev,
@@ -2853,7 +2853,7 @@ static ssize_t hotkey_poll_freq_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_poll_freq);
+	return sysfs_emit(buf, "%d\n", hotkey_poll_freq);
 }
 
 static ssize_t hotkey_poll_freq_store(struct device *dev,
@@ -2895,7 +2895,7 @@ static ssize_t hotkey_radio_sw_show(struct device *dev,
 	/* Opportunistic update */
 	tpacpi_rfk_update_hwblock_state((res == TPACPI_RFK_RADIO_OFF));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			(res == TPACPI_RFK_RADIO_OFF) ? 0 : 1);
 }
 
@@ -2918,7 +2918,7 @@ static ssize_t hotkey_tablet_mode_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", !!s);
+	return sysfs_emit(buf, "%d\n", !!s);
 }
 
 static DEVICE_ATTR_RO(hotkey_tablet_mode);
@@ -2935,7 +2935,7 @@ static ssize_t hotkey_wakeup_reason_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_wakeup_reason);
+	return sysfs_emit(buf, "%d\n", hotkey_wakeup_reason);
 }
 
 static DEVICE_ATTR(wakeup_reason, S_IRUGO, hotkey_wakeup_reason_show, NULL);
@@ -2951,7 +2951,7 @@ static ssize_t hotkey_wakeup_hotunplug_complete_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_autosleep_ack);
+	return sysfs_emit(buf, "%d\n", hotkey_autosleep_ack);
 }
 
 static DEVICE_ATTR(wakeup_hotunplug_complete, S_IRUGO,
@@ -2986,7 +2986,7 @@ static ssize_t adaptive_kbd_mode_show(struct device *dev,
 	if (current_mode < 0)
 		return current_mode;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", current_mode);
+	return sysfs_emit(buf, "%d\n", current_mode);
 }
 
 static ssize_t adaptive_kbd_mode_store(struct device *dev,
@@ -6350,7 +6350,7 @@ static ssize_t thermal_temp_input_show(struct device *dev,
 	if (value == TPACPI_THERMAL_SENSOR_NA)
 		return -ENXIO;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 #define THERMAL_SENSOR_ATTR_TEMP(_idxA, _idxB) \
@@ -8583,7 +8583,7 @@ static ssize_t fan_pwm1_enable_show(struct device *dev,
 	} else
 		mode = 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+	return sysfs_emit(buf, "%d\n", mode);
 }
 
 static ssize_t fan_pwm1_enable_store(struct device *dev,
@@ -8649,7 +8649,7 @@ static ssize_t fan_pwm1_show(struct device *dev,
 	if (status > 7)
 		status = 7;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", (status * 255) / 7);
+	return sysfs_emit(buf, "%u\n", (status * 255) / 7);
 }
 
 static ssize_t fan_pwm1_store(struct device *dev,
@@ -8702,7 +8702,7 @@ static ssize_t fan_fan1_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
+	return sysfs_emit(buf, "%u\n", speed);
 }
 
 static DEVICE_ATTR(fan1_input, S_IRUGO, fan_fan1_input_show, NULL);
@@ -8719,7 +8719,7 @@ static ssize_t fan_fan2_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
+	return sysfs_emit(buf, "%u\n", speed);
 }
 
 static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
@@ -8727,7 +8727,7 @@ static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
 /* sysfs fan fan_watchdog (hwmon driver) ------------------------------- */
 static ssize_t fan_watchdog_show(struct device_driver *drv, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", fan_watchdog_maxinterval);
+	return sysfs_emit(buf, "%u\n", fan_watchdog_maxinterval);
 }
 
 static ssize_t fan_watchdog_store(struct device_driver *drv, const char *buf,
-- 
2.25.1


