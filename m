Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAD3ECBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 01:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhHOXGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 19:06:44 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36345 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhHOXGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 19:06:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BD8293200583;
        Sun, 15 Aug 2021 19:06:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 15 Aug 2021 19:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ul1m6B+rlXyb+9rDY3WY+JWriCWyJdqy7KR1/9pMJxg=; b=q2MIpVTu
        yve1PDW1SZOdvIxBamC61do5Bvj3f8AJ8oVPJWqTFe+niGIaIU3/CQqM0Kg4E2Nh
        /AExvLugUiHeqjkN7Nm4cGqnHTkg1Jav08dlsN9ZNh/0yIJAkdrJzoV/K8ULkD1o
        Qa6EWH8AlzXX0oviJ79YgjeKORhR7uQCKdAh9f8K0nclj1R5k2+5F4ia105zhWWG
        tkTm2L49WS96mfExbSCT6QmE6QkT8T9qmuCgT/1lZcEBwAJl276h5KbVuqNZ2VY1
        5cfsPyeBsSVP/ZvSOjjj+h0cOjhBMpo+Dj4ohM09Gd6D74pf4QARFheg3PW/yq76
        8lSwpZQxqZjmVQ==
X-ME-Sender: <xms:4p0ZYe31qAMWCnZJElhTKrnUuamuV788dS8jWuybW9HJVK5ymXCbug>
    <xme:4p0ZYRHAVeCwkGYk8cU69CkY4hF5_rhJiJrh05wcNYnR4ukCrHKZWW8DTBFeFwKFt
    Ja05hGNcaX_kkNQPRA>
X-ME-Received: <xmr:4p0ZYW5lHlTuRePc2tmiyII7TKZU1B8TkwjtCmC5XLQpC9RPFRHiifA_zGCO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvdetkedvueehtdfhueduleehjeeihf
    dvtdetleelgefhkefhuefgheegkefftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:4p0ZYf1vXUrynZikvyIx5d1HV5TdBMXZ6HQi_knLuznI7lmMO9tsqQ>
    <xmx:4p0ZYRHB5XvDITJu4PKZ9YtBWdgYsGsSIQwhWqHucPZ2RXxhMKznvA>
    <xmx:4p0ZYY8W22Z03AZlOzSFIdIY7D0TunUXN-o3aCaZxrthdO9Csrm_Uw>
    <xmx:450ZYWR_x95_sbZBVd-BxZ1p3izKROTqGM0qSO4oPz4mVJ57PDX7CQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Aug 2021 19:06:08 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 1/1] asus-wmi: Add support for platform_profile
Date:   Mon, 16 Aug 2021 11:05:58 +1200
Message-Id: <20210815230558.5860-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210815230558.5860-1-luke@ljones.dev>
References: <20210815230558.5860-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for platform_profile where the support is
based on availability of ASUS_THROTTLE_THERMAL_POLICY.

Because throttle_thermal_policy is used by platform_profile and is
writeable separately to platform_profile any userspace changes to
throttle_thermal_policy need to notify platform_profile.

In future throttle_thermal_policy sysfs should be removed so that
only one method controls the laptop power profile.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/Kconfig    |   1 +
 drivers/platform/x86/asus-wmi.c | 138 +++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index d12db6c316ea..46dec48a36c1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -281,6 +281,7 @@ config ASUS_WMI
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
+	select ACPI_PLATFORM_PROFILE
 	help
 	  Say Y here if you have a WMI aware Asus laptop (like Eee PCs or new
 	  Asus Notebooks).
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 90a6a0d00deb..c11ce06073d1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
  */
 
+#include <asm-generic/errno.h>
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
@@ -26,6 +27,7 @@
 #include <linux/rfkill.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/platform_profile.h>
 #include <linux/power_supply.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -219,6 +221,9 @@ struct asus_wmi {
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
+	struct platform_profile_handler platform_profile_handler;
+	bool platform_profile_support;
+
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
@@ -2103,12 +2108,23 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+	int err;
 
 	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
-	return throttle_thermal_policy_write(asus);
+	err = throttle_thermal_policy_write(asus);
+	if (err)
+		return err;
+
+	/*
+	 * Ensure that platform_profile updates userspace with the change to ensure
+	 * that platform_profile and throttle_thermal_policy_mode are in sync.
+	 */
+	platform_profile_notify();
+
+	return 0;
 }
 
 static ssize_t throttle_thermal_policy_show(struct device *dev,
@@ -2124,9 +2140,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	int result;
-	u8 new_mode;
 	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 new_mode;
+	int result;
+	int err;
 
 	result = kstrtou8(buf, 10, &new_mode);
 	if (result < 0)
@@ -2136,7 +2153,15 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
-	throttle_thermal_policy_write(asus);
+	err = throttle_thermal_policy_write(asus);
+	if (err)
+		return err;
+
+	/*
+	 * Ensure that platform_profile updates userspace with the change to ensure
+	 * that platform_profile and throttle_thermal_policy_mode are in sync.
+	 */
+	platform_profile_notify();
 
 	return count;
 }
@@ -2144,6 +2169,101 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
+/* Platform profile ***********************************************************/
+static int platform_profile_get(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile)
+{
+	struct asus_wmi *asus;
+	int tp;
+
+	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+
+	if (!asus->throttle_thermal_policy_available) {
+		return -ENODATA;
+	}
+	tp = asus->throttle_thermal_policy_mode;
+
+	if (tp < 0)
+		return tp;
+
+	switch (tp) {
+	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+		*profile = PLATFORM_PROFILE_QUIET;
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
+	struct asus_wmi *asus;
+	int tp;
+
+	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+
+	/* All possible toggles like throttle_thermal_policy here */
+	if (!asus->throttle_thermal_policy_available) {
+		return -ENODATA;
+	}
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	asus->throttle_thermal_policy_mode = tp;
+	return throttle_thermal_policy_write(asus);
+}
+
+static int platform_profile_setup(struct asus_wmi *asus)
+{
+	int err;
+
+	if (!asus->throttle_thermal_policy_available) {
+		/*
+		 * Not an error if a component platform_profile relies on is unavailable
+		 * so early return, skipping the setup of platform_profile.
+		*/
+		return 0;
+	}
+	dev_info("Using throttle_thermal_policy for platform_profile support\n");
+
+	asus->platform_profile_handler.profile_get = platform_profile_get;
+	asus->platform_profile_handler.profile_set = platform_profile_set;
+
+	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED,
+		asus->platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE,
+		asus->platform_profile_handler.choices);
+
+	err = platform_profile_register(&asus->platform_profile_handler);
+	if (err)
+		return err;
+
+	asus->platform_profile_support = true;
+	return 0;
+}
+
 /* Backlight ******************************************************************/
 
 static int read_backlight_power(struct asus_wmi *asus)
@@ -2904,6 +3024,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = platform_profile_setup(asus);
+	if (err)
+		goto fail_platform_profile_setup;
+
 	err = panel_od_check_present(asus);
 	if (err)
 		goto fail_panel_od;
@@ -2993,6 +3117,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
 fail_throttle_thermal_policy:
+fail_platform_profile_setup:
+	if (asus->platform_profile_support)
+		platform_profile_remove();
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
@@ -3017,6 +3144,9 @@ static int asus_wmi_remove(struct platform_device *device)
 	asus_fan_set_auto(asus);
 	asus_wmi_battery_exit(asus);
 
+	if (asus->platform_profile_support)
+		platform_profile_remove();
+
 	kfree(asus);
 	return 0;
 }
-- 
2.31.1

