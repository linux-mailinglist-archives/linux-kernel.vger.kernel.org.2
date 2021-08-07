Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2C3E32C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhHGChi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:37:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32913 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhHGChg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:37:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DDBD5C00C6;
        Fri,  6 Aug 2021 22:37:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 06 Aug 2021 22:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=JGPiTdEtEpVOR+ipyc6oXN4dKe8YPmK0XAZtGQ1/m2c=; b=CwFav7eX
        yxbaaF2gtNij0+dXv9Oar/DuThkAsmn03y+ZBSilpWcOh6JLEWRlvsNGwYUFd6LQ
        6MyFCH2VlTrdL4FVOCYRgdezG1fX14XB/ruXcmYrL01l5r2sqkjmBkRdZh5GA/RV
        ZP7epRGPcopp/DAV3TPF5ftTnwOzBRFs5XwelouOfGKnNGC+ZgS1kLGyRWXqgZ9Q
        veVwaK9Fn83iHF4EN2hwN9KJyNkULx64Zmss41N+CyizK6cc9JwBdm8Gu1bkdhno
        p1RRT/8UPR4mkQwDA6SYGSkqjweTxw6BieMA1m24FxOSCglLt0HsxpwsSyoQLrVk
        7wSCY+bM8kfhOg==
X-ME-Sender: <xms:3_ENYfb39Vqo9YR9taFEV9fqjmnnB1HE9j4A4mgUFqb_XHxk0ubeXQ>
    <xme:3_ENYeazP-qJZ7Rc3jVz95Jdr42JyYgev6D_bljuKDK5judWSAvAMXWE5S3tok6mO
    W83HIwoBcEwqrQsHKI>
X-ME-Received: <xmr:3_ENYR-VKDyU8JdKs3izpmOQJzzd5tUwTbpVJ9yew1bbzcFc8gD9gcTT3uwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvdetkedvueehtdfhueduleehjeeihf
    dvtdetleelgefhkefhuefgheegkefftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:3_ENYVrEuLJoeBqI9D5cfm19LGtiOGJKQv_Nu_3JGlwOb6C1dcQkig>
    <xmx:3_ENYao6UGTM1v3L7B7u9sVTFhPAUXqZK3UqXr7_Eb6ubJA-NbSGbg>
    <xmx:3_ENYbRSfMzi2Vl6-ViCdWlMKOBYAGMk3o3VoFge0CLGxZSsOgVVdA>
    <xmx:4PENYdXaEDni5S0KBttD2zf69fEtUDA29xULMo9Wea6fvDPWMiya5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 22:37:16 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        corentin.chary@gmail.com, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/3] asus-wmi: Add panel overdrive functionality
Date:   Sat,  7 Aug 2021 14:36:54 +1200
Message-Id: <20210807023656.25020-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210807023656.25020-1-luke@ljones.dev>
References: <20210807023656.25020-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ASUS ROG laptops have the ability to drive the display panel
a higher rate to eliminate or reduce ghosting.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 93 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ebaeb7bb80f5..cbf91a9134fd 100644
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
@@ -1221,6 +1224,87 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
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
+	u32 retval;
+	u8 value;
+	int err;
+
+	/* Don't rely on type conversion */
+	value = asus->panel_overdrive ? 1 : 0;
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
+
+	return sysfs_emit(buf, "%d\n", asus->panel_overdrive);
+}
+
+static ssize_t panel_od_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool overdrive;
+	int result;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &overdrive);
+	if (result)
+		return result;
+
+	asus->panel_overdrive = overdrive;
+	result = panel_od_write(asus);
+
+	if (result)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(panel_od);
+
 /* Quirks *********************************************************************/
 
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
@@ -2332,6 +2416,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
+	&dev_attr_panel_od.attr,
 	NULL
 };
 
@@ -2357,6 +2442,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
+	else if (attr == &dev_attr_panel_od.attr)
+		ok = asus->panel_overdrive_available;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -2622,6 +2709,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = panel_od_check_present(asus);
+	if (err)
+		goto fail_panel_od;
+
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
 		goto fail_sysfs;
@@ -2709,6 +2800,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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

