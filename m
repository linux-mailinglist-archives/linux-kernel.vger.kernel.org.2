Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F810320DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBUVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBUVGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:06:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989DBC061574;
        Sun, 21 Feb 2021 13:05:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v62so12571762wmg.4;
        Sun, 21 Feb 2021 13:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sK//K0s31poyiYG87+9PljlbveG+XzuTDDaliKRPm2Y=;
        b=GpqbLRth2mV+AU+vIyJjk3DcdKSUuAq+sFxJv2mywG05x/qd96F8dUkLcZed3fATOD
         a16w2ZfeIXiyrOE8rrBBvbKRd03oJm37O/ea1y/UQivXvD+zj2hYbZd3lRfw1sUgPWpF
         XaHDtSmO5BiA4J8fPB7gnyQWkYUBeYsMnRE3gY/i6M7lLPy8t+StiZ9EVF82rwytYuTv
         OMnUu9VMBiyIk5HgcWMKPtYGR/A0DO1nnSWRxJnwlBc7Q/1iVQmHGYoVumYld+asWvM+
         ewwA5W2jrXoIN3WsKpQmog/TJX3zQsrWZQSN5AJarnpQNbs4k6ElQgM+GqxzmBisjlCA
         cuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sK//K0s31poyiYG87+9PljlbveG+XzuTDDaliKRPm2Y=;
        b=VsBG9jESr0u+kDKTe1oIceoby6dRGEnvq5eKWEPHhzrgoWOl4H8eqYvVvwwBuAsCo6
         h53l8cZmtnOlTgR2857+XrC02WmfZDU4+qS6eeooYXCGnxK1kDHDhFmSXScEUwluV0Nn
         UPdCfpIz4WBfAZAcLv9xizwUsfIjqVgCxMp/DKHaazG/MAoP/T7+EcAwGAXtXejksLPf
         zVY8tFXAP6FstE4DaM7/zteyAozVuSsxaWkpcGfndsYsWjk4+rJZx2xDqBbMa+iaElIV
         6uj21sBeWoB1T0jvvBDcxbmwDmM4wdSQczA5GxnZbXFrEUQrSa0IkSEOpfezrZGAJ3vm
         ppRw==
X-Gm-Message-State: AOAM533C8Yt8e/O4LLg7Sk3m4h2IZm0KLdYDZ1rfZyMw5XL46SxeUEhi
        SHYToFxXJgeFuE0G+RqbG+E=
X-Google-Smtp-Source: ABdhPJxf+ZxPxUBFPXP+XOa0zs8+8n6s/W9jIQqqpgdMNrD2vxbZDTYobjuH4f0iPO1sPSrixzL9Sg==
X-Received: by 2002:a1c:2d47:: with SMTP id t68mr17798100wmt.189.1613941518339;
        Sun, 21 Feb 2021 13:05:18 -0800 (PST)
Received: from localhost.localdomain (host-79-22-224-43.retail.telecomitalia.it. [79.22.224.43])
        by smtp.gmail.com with ESMTPSA id g1sm23166595wmh.9.2021.02.21.13.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 13:05:18 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: hp-wmi: add platform profile support
Date:   Sun, 21 Feb 2021 22:04:39 +0100
Message-Id: <20210221210439.68590-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.29.2
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

 drivers/platform/x86/hp-wmi.c | 96 +++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 6d7b91b8109b..d983267b252b 100644
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
 
@@ -159,6 +166,7 @@ static const struct key_entry hp_wmi_keymap[] = {
 
 static struct input_dev *hp_wmi_input_dev;
 static struct platform_device *hp_wmi_platform_dev;
+static struct platform_profile_handler platform_profile_handler;
 
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
@@ -869,23 +877,101 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 	return err;
 }
 
-static int thermal_profile_setup(struct platform_device *device)
+static int thermal_profile_get(void)
 {
-	int err, tp;
+	int tp;
 
 	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
 	if (tp < 0)
 		return tp;
 
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
+	if (tp < 0)
+		return tp;
+
 	/*
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
+	platform_profile_register(&platform_profile_handler);
 	return 0;
 }
 
@@ -900,7 +986,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
-	thermal_profile_setup(device);
+	thermal_profile_setup();
 
 	return 0;
 }
-- 
2.29.2

