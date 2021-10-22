Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94D43745B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhJVJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhJVJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:11:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527DFC061764;
        Fri, 22 Oct 2021 02:08:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2558183pjb.3;
        Fri, 22 Oct 2021 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfNErqYk5Tlt9nDoU4zg/bY/gOqGiwBkJPFWm5wyGxA=;
        b=exJ3C4Fu7j9J8NmI1vswjdeEpA0cue3SF4LlVF/lY4q/fnAYUasCicaBgmhTkzTsP8
         rceKW7ssIA55raGj3bCQrzGO+tJfJB4fRSrLKiczPqy0VNATWGa1t61nvdcBMxqBQNWt
         Mu6mdV6GizpOQDroQ2rM3mRH+d1NQXPHUmXrMsky48a3bbLPqT2ComXFFG8cdemueOZ5
         EsIAJvlJrBQOPyFYKOc/uwo2/UYvKo+Qovq9typg+N9hzI0lTjRo4jJ/NLWiQJdkpA3W
         534gNGjTIMT8gky9FfzjiLsZHpmALEhG9XleDzjCSQtktdzehT8l/2qX07o0CJhgVjYu
         KmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfNErqYk5Tlt9nDoU4zg/bY/gOqGiwBkJPFWm5wyGxA=;
        b=zvGcj+PYWJ/CGGZ7EfSeJ6XLQCPQ8VYIsfIC4O6z1eocX7PYdtaDw92YHN6acmV7VJ
         kGw0r4TMMnESmTpOvDJ/DEiRKfMY69OTCtbxOtQTd/H0MPqpf13FbdHqWMgJV4LwGhDL
         wz9qhHJHkL5vt3dJaVRbwib0lqMSGGwqg4azr4gXNzAox9BGnaLuX+Jqyn9CVJxCpAGF
         TiozwtebJLLbnyB5WVY2mwkmyVto8EGf3e02jjbXzPjs3Ub5G/Y9Qi703o0fVndn4u3p
         eObbnBYwHTAsv4JhzTvOA9Y7NpHTLvu57Mch6YdaIi2Wmr5v/Ex3k/UyzYE8olSdwbIs
         Y+Yg==
X-Gm-Message-State: AOAM530/0sa36a3qwrIkR0BCHGsJm2zNXbwyINucX7qi1qXmFGYD3sU5
        3mgO+Me25nJT0/94fDocZQs=
X-Google-Smtp-Source: ABdhPJw+zBXcwALtbFHNs+b3t98WUIEKjD4OCP6etY6UtCtQZ/bQCFBwT1EfHcynkwm5TV9rMiqqWQ==
X-Received: by 2002:a17:90b:3b50:: with SMTP id ot16mr13382138pjb.150.1634893738797;
        Fri, 22 Oct 2021 02:08:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x129sm9073756pfc.140.2021.10.22.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:08:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     malattia@linux.it
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platform/x86: sony-laptop: replace snprintf in show functions with sysfs_emit
Date:   Fri, 22 Oct 2021 09:08:51 +0000
Message-Id: <20211022090851.1065538-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/platform/x86/sony-laptop.c | 46 ++++++++++++------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 704813374922..d8d0c0bed5e9 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -964,7 +964,7 @@ static ssize_t sony_nc_sysfs_show(struct device *dev, struct device_attribute *a
 	if (item->validate)
 		value = item->validate(SNC_VALIDATE_OUT, value);
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
+	return sysfs_emit(buffer, "%d\n", value);
 }
 
 static ssize_t sony_nc_sysfs_store(struct device *dev,
@@ -1811,9 +1811,7 @@ static ssize_t sony_nc_kbd_backlight_mode_store(struct device *dev,
 static ssize_t sony_nc_kbd_backlight_mode_show(struct device *dev,
 		struct device_attribute *attr, char *buffer)
 {
-	ssize_t count = 0;
-	count = snprintf(buffer, PAGE_SIZE, "%d\n", kbdbl_ctl->mode);
-	return count;
+	return sysfs_emit(buffer, "%d\n", kbdbl_ctl->mode);
 }
 
 static int __sony_nc_kbd_backlight_timeout_set(u8 value)
@@ -1855,9 +1853,7 @@ static ssize_t sony_nc_kbd_backlight_timeout_store(struct device *dev,
 static ssize_t sony_nc_kbd_backlight_timeout_show(struct device *dev,
 		struct device_attribute *attr, char *buffer)
 {
-	ssize_t count = 0;
-	count = snprintf(buffer, PAGE_SIZE, "%d\n", kbdbl_ctl->timeout);
-	return count;
+	return sysfs_emit(buffer, "%d\n", kbdbl_ctl->timeout);
 }
 
 static int sony_nc_kbd_backlight_setup(struct platform_device *pd,
@@ -2051,21 +2047,18 @@ static ssize_t sony_nc_battery_care_limit_show(struct device *dev,
 		break;
 	}
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", status);
 }
 
 static ssize_t sony_nc_battery_care_health_show(struct device *dev,
 		struct device_attribute *attr, char *buffer)
 {
-	ssize_t count = 0;
 	unsigned int health;
 
 	if (sony_call_snc_handle(bcare_ctl->handle, 0x0200, &health))
 		return -EIO;
 
-	count = snprintf(buffer, PAGE_SIZE, "%d\n", health & 0xff);
-
-	return count;
+	return sysfs_emit(buffer, "%d\n", health & 0xff);
 }
 
 static int sony_nc_battery_care_setup(struct platform_device *pd,
@@ -2215,15 +2208,12 @@ static ssize_t sony_nc_thermal_mode_store(struct device *dev,
 static ssize_t sony_nc_thermal_mode_show(struct device *dev,
 		struct device_attribute *attr, char *buffer)
 {
-	ssize_t count = 0;
 	int mode = sony_nc_thermal_mode_get();
 
 	if (mode < 0)
 		return mode;
 
-	count = snprintf(buffer, PAGE_SIZE, "%s\n", snc_thermal_profiles[mode]);
-
-	return count;
+	return sysfs_emit(buffer, "%s\n", snc_thermal_profiles[mode]);
 }
 
 static int sony_nc_thermal_setup(struct platform_device *pd)
@@ -2361,7 +2351,7 @@ static ssize_t sony_nc_lid_resume_show(struct device *dev,
 
 	while (pos < LID_RESUME_MAX) {
 		if (&lid_ctl->attrs[pos].attr == &attr->attr)
-			return snprintf(buffer, PAGE_SIZE, "%d\n",
+			return sysfs_emit(buffer, "%d\n",
 					(lid_ctl->status >> pos) & 0x01);
 		pos++;
 	}
@@ -2493,7 +2483,7 @@ static ssize_t sony_nc_gfx_switch_status_show(struct device *dev,
 	if (pos < 0)
 		return pos;
 
-	return snprintf(buffer, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 					pos == SPEED ? "speed" :
 					pos == STAMINA ? "stamina" :
 					pos == AUTO ? "auto" : "unknown");
@@ -2568,7 +2558,7 @@ static ssize_t sony_nc_highspeed_charging_show(struct device *dev,
 	if (sony_call_snc_handle(0x0131, 0x0100, &result))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0x01);
+	return sysfs_emit(buffer, "%d\n", result & 0x01);
 }
 
 static int sony_nc_highspeed_charging_setup(struct platform_device *pd)
@@ -2642,7 +2632,7 @@ static ssize_t sony_nc_lowbatt_show(struct device *dev,
 	if (sony_call_snc_handle(0x0121, 0x0200, &result))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 1);
+	return sysfs_emit(buffer, "%d\n", result & 1);
 }
 
 static int sony_nc_lowbatt_setup(struct platform_device *pd)
@@ -2708,7 +2698,7 @@ static ssize_t sony_nc_hsfan_show(struct device *dev,
 	if (sony_call_snc_handle(0x0149, 0x0100, &result))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0x01);
+	return sysfs_emit(buffer, "%d\n", result & 0x01);
 }
 
 static ssize_t sony_nc_fanspeed_show(struct device *dev,
@@ -2719,7 +2709,7 @@ static ssize_t sony_nc_fanspeed_show(struct device *dev,
 	if (sony_call_snc_handle(0x0149, 0x0300, &result))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0xff);
+	return sysfs_emit(buffer, "%d\n", result & 0xff);
 }
 
 static int sony_nc_fanspeed_setup(struct platform_device *pd)
@@ -2815,7 +2805,7 @@ static ssize_t sony_nc_usb_charge_show(struct device *dev,
 	if (sony_call_snc_handle(0x0155, 0x0000, &result))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", result & 0x01);
+	return sysfs_emit(buffer, "%d\n", result & 0x01);
 }
 
 static int sony_nc_usb_charge_setup(struct platform_device *pd)
@@ -2870,7 +2860,7 @@ static ssize_t sony_nc_panelid_show(struct device *dev,
 	if (sony_call_snc_handle(0x011D, 0x0000, &result))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", result);
+	return sysfs_emit(buffer, "%d\n", result);
 }
 
 static int sony_nc_panelid_setup(struct platform_device *pd)
@@ -2998,7 +2988,7 @@ static ssize_t sony_nc_touchpad_show(struct device *dev,
 	if (sony_call_snc_handle(tp_ctl->handle, 0x000, &result))
 		return -EINVAL;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", !(result & 0x01));
+	return sysfs_emit(buffer, "%d\n", !(result & 0x01));
 }
 
 static int sony_nc_touchpad_setup(struct platform_device *pd,
@@ -3915,7 +3905,7 @@ static ssize_t sony_pic_wwanpower_show(struct device *dev,
 {
 	ssize_t count;
 	mutex_lock(&spic_dev.lock);
-	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.wwan_power);
+	count = sysfs_emit(buffer, "%d\n", spic_dev.wwan_power);
 	mutex_unlock(&spic_dev.lock);
 	return count;
 }
@@ -3954,7 +3944,7 @@ static ssize_t sony_pic_bluetoothpower_show(struct device *dev,
 {
 	ssize_t count = 0;
 	mutex_lock(&spic_dev.lock);
-	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.bluetooth_power);
+	count = sysfs_emit(buffer, "%d\n", spic_dev.bluetooth_power);
 	mutex_unlock(&spic_dev.lock);
 	return count;
 }
@@ -3996,7 +3986,7 @@ static ssize_t sony_pic_fanspeed_show(struct device *dev,
 	if (sony_pic_get_fanspeed(&value))
 		return -EIO;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
+	return sysfs_emit(buffer, "%d\n", value);
 }
 
 #define SPIC_ATTR(_name, _mode)					\
-- 
2.25.1

