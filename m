Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DECD3EC084
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 06:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhHNEbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 00:31:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43605 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhHNEbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 00:31:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 49FB65C00F2;
        Sat, 14 Aug 2021 00:31:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 14 Aug 2021 00:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=C8mRcPU6F1hT2AMRUcY/4d3cw8x4CxEO/5x1OavtN/8=; b=uS4Fe4Da
        6mx3YIQpclVnkOk3EvIeRAthhZDx5a+S44+1y5dcA4nDkZyfHnT5BtNQdcDIviM7
        Kn6dUSLSleFn8hxfoH9hUYnyi9JFEmlh9HpLM3CWg8+YJ7CpocrBdVtOtpLwqrjf
        GO94k/9/EA+Ge8yjOeiWF8ITijF8vySYIIUQrmxe2tyo78pwLuS+1BPSj0Hv8ASw
        4b4Rs2rqG/Kw1f85GXfvlhKngR3nSZr9SCFMN/RQHOuc7m7Y8f9a1Y5IG4cgOVxA
        DDcDlzu2UaV4tXMlSL6ERHFgi9io/s9CaWipcXzUuPmJgeHX8f8QkZV7ucnPJ4Oi
        ibgxdUrz3Gc28A==
X-ME-Sender: <xms:FkcXYT7bt_ti4s9AqYwJPSLMKGJv9iKAJu408c_npE79Z082L994KQ>
    <xme:FkcXYY4pYIWPZXqrqQ4_4gnr47_PzpIQr2HyfEdovx3aW0amGnnlf3EN6PatIw_-e
    yeawf23ZW3DvPx2TtU>
X-ME-Received: <xmr:FkcXYaedj5nN0ZQLwIkHwGARA3hC0HqYKiC8AcKGfBxkFDnq_3VS7wMaKvSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvdetkedvueehtdfhueduleehjeeihf
    dvtdetleelgefhkefhuefgheegkefftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:FkcXYUKWodauXzhO_WBI2DfYV2vI1r6RPbiSXFjf7GWWHDs7fh_DOw>
    <xmx:FkcXYXIK6IyRp8RZum-bmCNDlrQwzHNkMKQ93GpvoMuJhXKI0Me4eQ>
    <xmx:FkcXYdx6LXYcDbI5c5pKmByR27ZJzkmxvG2IAfq9PDX_xFdNNrUmbQ>
    <xmx:FkcXYeUzq1VZMkpcEX9nUV1GENYBcrDF-ZvknNPCLtgY3QVnVbUy9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Aug 2021 00:31:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
Date:   Sat, 14 Aug 2021 16:31:03 +1200
Message-Id: <20210814043103.2535842-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210814043103.2535842-1-luke@ljones.dev>
References: <20210814043103.2535842-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c | 139 +++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 90a6a0d00deb..909fc2663008 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -26,6 +26,7 @@
 #include <linux/rfkill.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/platform_profile.h>
 #include <linux/power_supply.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -219,6 +220,9 @@ struct asus_wmi {
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
+	struct platform_profile_handler platform_profile_handler;
+	bool platform_profile_support;
+
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
@@ -2103,12 +2107,23 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
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
+	 * that platform_profile and throttle_thermal_policy_mode are in sync
+	 */
+	platform_profile_notify();
+
+	return 0;
 }
 
 static ssize_t throttle_thermal_policy_show(struct device *dev,
@@ -2124,9 +2139,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
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
@@ -2136,7 +2152,15 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
-	throttle_thermal_policy_write(asus);
+	err = throttle_thermal_policy_write(asus);
+	if (err)
+		return err;
+
+	/*
+	 * Ensure that platform_profile updates userspace with the change to ensure
+	 * that platform_profile and throttle_thermal_policy_mode are in sync
+	 */
+	platform_profile_notify();
 
 	return count;
 }
@@ -2144,6 +2168,103 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
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
+	/* All possible toggles like throttle_thermal_policy here */
+	if (asus->throttle_thermal_policy_available) {
+		tp = asus->throttle_thermal_policy_mode;
+	} else {
+		return -1;
+	}
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
+		return -1;
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
+	if (asus->throttle_thermal_policy_available) {
+		pr_info("Using throttle_thermal_policy for platform_profile support\n");
+	} else {
+		/*
+		 * Not an error if a component platform_profile relies on is unavailable
+		 * so early return, skipping the setup of platform_profile.
+		*/
+		return 0;
+	}
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
@@ -2904,6 +3025,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = platform_profile_setup(asus);
+	if (err)
+		goto fail_platform_profile_setup;
+
 	err = panel_od_check_present(asus);
 	if (err)
 		goto fail_panel_od;
@@ -2993,6 +3118,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
 fail_throttle_thermal_policy:
+fail_platform_profile_setup:
+	if (asus->platform_profile_support)
+		platform_profile_remove();
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
@@ -3017,6 +3145,9 @@ static int asus_wmi_remove(struct platform_device *device)
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

