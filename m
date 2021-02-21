Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41031320E41
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBUWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhBUWQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:16:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236D3C061574;
        Sun, 21 Feb 2021 14:15:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l30so1421322wrb.12;
        Sun, 21 Feb 2021 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWmiNEs97OZnCfH3+LxcVD0SeyQhZ+wmaHX9mtZJ5TU=;
        b=jmjEGhzKJdAe8dthuCi+Sd0P67T1gL/fZZTX8iPKjXFza9+Y5PuPGG5eEdyb1jpood
         JCJhVm6Nxqbijwh5KuSaMUIx2dv/cAJS7V9VxqPjmnsAE2LPnU0diPa+RN1e4BygqVt8
         AtN6BS398O+HUBK0/lLf+xYbYFV3K8Y8FfRMzS62vrnh152f9cgW/lrvRUcWzMj+pPAS
         RAk6Xr52SVilKuA7RMta5n0nGAPdnXtX7+m2LvL95IDParU7x/qPoOcTn3Hh5/6gBBbX
         QIKhxEC5lznd1m46dNPOkkh7G2XOYMNMArQhWAJT0lNvlKhJy3d7AxumCW+CyUAh3dUK
         Ygvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWmiNEs97OZnCfH3+LxcVD0SeyQhZ+wmaHX9mtZJ5TU=;
        b=Co6Kwx1LrHduq83gfhR7BF2yKSygYgcPvCU8Y34Xm8BURQ1cFgPGS3QnRDmw14pXIb
         89cwJLc5UKcIB41yWdvBOOHTrkp1w4eECxzlZRWQoyr3QN+R8scXSrdfEu1U0Hv2+72/
         ciV3LBmOS18szvEF3FA+1TQb5hkR4covJqDIPb4GJBzG5V6k1oO105OCxMtXR11+5Mzk
         c0Ch3puDbF7UOnbwEjRtAvQGI5NJ2c5RVYsJx0/k62pY0YMKTBpcvp3EkwEy8oBwyRVD
         Wdhvx8hafhTOzuQDsHvyMgzVUCsAHsbtxAqBRQKxZk/5ntIwwv9tNcAUklHsP3Ljuzjg
         JACA==
X-Gm-Message-State: AOAM532E1z20+A9FqDC47pSh7buZI7x7lL+VPI/D//NbV9yDQ7h7FIZo
        6AvxO8jo7GO6m37hEQClNYo=
X-Google-Smtp-Source: ABdhPJwowhgc63ULwqi1ptjDgHV3SsxPZtcnUFL/kseNnwpRF3WBNlEgzQ4HEtWbrwgeNF5H+4nRZQ==
X-Received: by 2002:adf:e809:: with SMTP id o9mr18793183wrm.137.1613945722917;
        Sun, 21 Feb 2021 14:15:22 -0800 (PST)
Received: from localhost.localdomain (host-79-22-224-43.retail.telecomitalia.it. [79.22.224.43])
        by smtp.gmail.com with ESMTPSA id h18sm30446261wrm.54.2021.02.21.14.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:15:22 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] platform/x86: hp-wmi: add platform profile support
Date:   Sun, 21 Feb 2021 23:13:40 +0100
Message-Id: <20210221221339.12395-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <nVb9zC39HBbC5-iweNmNol7ymCjT4iD91ydsZVuo_Upqh2_3eVKaF1X1rbYpZGva-NyrGUW_W2uJIc5RHu1KhBGy7-ejGNYZJyRttjhJT-s=@protonmail.com>
References: <nVb9zC39HBbC5-iweNmNol7ymCjT4iD91ydsZVuo_Upqh2_3eVKaF1X1rbYpZGva-NyrGUW_W2uJIc5RHu1KhBGy7-ejGNYZJyRttjhJT-s=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
v3: apply Barnabás suggestions

 drivers/platform/x86/hp-wmi.c | 97 +++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 6d7b91b8109b..027a1467d009 100644
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
+static bool platform_profile_support;
 
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
@@ -869,11 +878,74 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 	return err;
 }
 
-static int thermal_profile_setup(struct platform_device *device)
+static int thermal_profile_get(void)
+{
+	return hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
+}
+
+static int thermal_profile_set(int thermal_profile)
+{
+	return hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &thermal_profile,
+							   sizeof(thermal_profile), 0);
+}
+
+static int platform_profile_get(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile)
+{
+	int tp;
+
+	tp = thermal_profile_get();
+	if (tp < 0)
+		return tp;
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
 {
 	int err, tp;
 
-	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
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
 
@@ -881,11 +953,23 @@ static int thermal_profile_setup(struct platform_device *device)
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
+	platform_profile_support = true;
+
 	return 0;
 }
 
@@ -900,7 +984,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
-	thermal_profile_setup(device);
+	thermal_profile_setup();
 
 	return 0;
 }
@@ -927,6 +1011,9 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 		rfkill_destroy(wwan_rfkill);
 	}
 
+	if (platform_profile_support)
+		platform_profile_remove();
+
 	return 0;
 }
 
-- 
2.29.2

