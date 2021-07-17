Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307BD3CC1F3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhGQIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 04:17:09 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55307 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhGQIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:16:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 38A9732007F9;
        Sat, 17 Jul 2021 04:13:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 17 Jul 2021 04:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OL8LS2RF3uwborwIE
        ay0AbN5xC77/xl6wasXY6aVF7Q=; b=QoOhWMoyeemJfdDdqd814u3GRHQ011dDM
        grj0lsZUnX4YtcJpEeLqNzbdq3HbHEWDs3T9IqrzDNA0RY9fSThBwDZAikJKqCcR
        cFayhbwGVykP2qkXUtAH5EjV+qsg0WSlrQjj7TA2Xm1rDLOB6sTt3RrygdaebSZO
        YMPM2LwGZmHY1nUJQUgyd4IRWmsKXj9BkXlzFd7wCbP76rf6HXuRH6vOaB41W7jV
        yvAZA72YY/39Fk29Ok+o/bGPrWIU3UJfvPdbqkMvUQO2tXj1ZGjVVEAQze0TFSIx
        HGbsYpjNzuQW+hepjlYYXZjLI8yE1k7DKLeX3bIjpncSBUJBy5quA==
X-ME-Sender: <xms:LZHyYFpbhGBa2Tzc5aaZin0YdHt7OK7xi4aw9ajNMjJaPebWb88OMg>
    <xme:LZHyYHrdW40j4yZ3FB7HavPnbT1Q40LnxXlxEluCY5O8DZBgc3QF5U-ek839hWOWs
    Q8e348SdyGEgxXzjv4>
X-ME-Received: <xmr:LZHyYCNB8agK-iCYuX5neJaQHzLfHzHiqNTWofrcZWN0W9dyyjKPtFeEgn7P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeukeegte
    eigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:LZHyYA6aZVrG6ys485i6gyEs9szC5XUTMf27xOUn38FM9BmkIz8j6A>
    <xmx:LZHyYE7w1ipUnrLsDstVBJKL92pOT29C3XZKOUvtp5Ht9zK-ORpz0A>
    <xmx:LZHyYIgBOQbKqEj_Dt7TLKu1Qf1hSR6CSsipifGkfZPI1kYDTVS17A>
    <xmx:LZHyYORNRZf6QiznBU7rkycUPM3uywCheXpPMNY3o8xdV7PKCg8xmw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jul 2021 04:13:29 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/4] asus-wmi: Add panel overdrive functionality
Date:   Sat, 17 Jul 2021 20:13:21 +1200
Message-Id: <20210717081323.7925-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ASUS ROG laptops have the ability to drive the display panel
a higher rate to eliminate or reduce ghosting.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 91 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ebaeb7bb80f5..cd881443bc2f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -216,6 +216,9 @@ struct asus_wmi {
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
+	bool panel_overdrive_available;
+	bool panel_overdrive;
+
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
 	struct mutex wmi_lock;
@@ -1221,6 +1224,86 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 	return result;
 }
 
+/* Panel Overdrive ************************************************************/
+static int panel_od_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->panel_overdrive_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_PANEL_OD, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->panel_overdrive_available = true;
+		asus->panel_overdrive = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int panel_od_write(struct asus_wmi *asus)
+{
+	int err;
+	u8 value;
+	u32 retval;
+
+	value = asus->panel_overdrive;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, value, &retval);
+
+	if (err) {
+		pr_warn("Failed to set panel overdrive: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1 || retval < 0) {
+		pr_warn("Failed to set panel overdrive (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "panel_od");
+
+	return 0;
+}
+
+static ssize_t panel_od_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	bool mode = asus->panel_overdrive;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+static ssize_t panel_od_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result;
+	bool overdrive;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &overdrive);
+	if (result == -EINVAL)
+		return result;
+
+	asus->panel_overdrive = overdrive;
+	result = panel_od_write(asus);
+
+	if (result != 0)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(panel_od);
+
 /* Quirks *********************************************************************/
 
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
@@ -2332,6 +2415,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
+	&dev_attr_panel_od.attr,
 	NULL
 };
 
@@ -2357,6 +2441,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
+	else if (attr == &dev_attr_panel_od.attr)
+		ok = asus->panel_overdrive_available;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -2622,6 +2708,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = panel_od_check_present(asus);
+	if (err)
+		goto fail_panel_od;
+
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
 		goto fail_sysfs;
@@ -2709,6 +2799,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_throttle_thermal_policy:
 fail_fan_boost_mode:
 fail_platform:
+fail_panel_od:
 	kfree(asus);
 	return err;
 }
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 2f274cf52805..428aea701c7b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -61,6 +61,7 @@
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
 /* Misc */
+#define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
 
-- 
2.31.1

