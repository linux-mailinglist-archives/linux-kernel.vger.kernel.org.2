Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528913E32C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhHGChm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:37:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33095 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230208AbhHGChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:37:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 688BA5C00CB;
        Fri,  6 Aug 2021 22:37:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 06 Aug 2021 22:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hSxoQ5QwkOdnrxMyjq8ktMP+fWz/F/9K0OSuaEvh5T8=; b=MPSjsu+/
        bMXUJMOQMGK6n2JvW+FYUSe0tXCRHqoUsP9wkSfYwb0GNHWox+mAoLrqXkhn3wWH
        CZ3pjkcSE26WHpoouuZsIvOnu0WnULK0Z4/BXdjnW5/AyA5sC4blkNxEduPKm5uC
        b1ei8hnZ78oROdyoliFOBSPS3qYzkpHjLbZQEnfJ3BVw280lMi/woJKyiahZPPLL
        b3Jo2FFBG8fdrO8/dEzyk9bQpMGWOVPzEpsP59McGB0fsor+MOdJTgJ8T6UGeXkB
        BdQQ+xwW4HMT6x0hKId0NFmaO/RH8uzFRvtcKxRW+stVpm4kdOqbl4YZNHjNwItF
        MpqRrB5FNW6lWw==
X-ME-Sender: <xms:4_ENYQo-FtI91MOZDFkQ7Vo4kYKT7ZRSH6bNOEMhKuo35P_6tc1vlA>
    <xme:4_ENYWqCY5Q5hyCh3QXTZrfHRRaVbSskX1ZNgYAtTyWsACfRBivWq1wAPmyQiQX41
    1xoOIx9t9GgXJNU-Z4>
X-ME-Received: <xmr:4_ENYVMborLDh0f8VWxjO4SIPAmH-BezfnmopAmJG0qXLO6jv_i2HmVH56eJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvdetkedvueehtdfhueduleehjeeihf
    dvtdetleelgefhkefhuefgheegkefftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:4_ENYX6g-SIdXONHlmSUX3nicPScfTtjc8DbnZqCPdzuRCuHclR3XA>
    <xmx:4_ENYf5N5p5sbQj8ehVYecoodTsgcu8Vk8qp-6mZTlmA_WMYE1V6BQ>
    <xmx:4_ENYXgFMD1MmByBe66lP87WXk6s5Vz0AhOYf6h3Sm7jkaHWAxX5Qw>
    <xmx:5PENYRmilu7UhUfvZRsc9Raui6zZybcUQE8ZRqpi-EhiDn6iNjXDWQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 22:37:20 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        corentin.chary@gmail.com, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 2/3] asus-wmi: Add dgpu disable method
Date:   Sat,  7 Aug 2021 14:36:55 +1200
Message-Id: <20210807023656.25020-3-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210807023656.25020-1-luke@ljones.dev>
References: <20210807023656.25020-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Windows the ASUS Armory Crate program can enable or disable the
dGPU via a WMI call. This functions much the same as various Linux
methods in software where the dGPU is removed from the device tree.

However the WMI call saves the state of dGPU (enabled or not) and
this then changes the dGPU visibility in Linux with no way for
Linux users to re-enable it. We expose the WMI method so users can
see and change the dGPU ACPI state.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 98 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 101 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cbf91a9134fd..bee22a12bf3d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -210,6 +210,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool dgpu_disable_available;
+	bool dgpu_disable;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -427,6 +430,93 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 	}
 }
 
+/* dGPU ********************************************************************/
+static int dgpu_disable_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->dgpu_disable_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->dgpu_disable_available = true;
+		asus->dgpu_disable = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int dgpu_disable_write(struct asus_wmi *asus)
+{
+	u32 retval;
+	u8 value;
+	int err;
+
+	/* Don't rely on type conversion */
+	value = asus->dgpu_disable ? 1 : 0;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
+	if (err) {
+		pr_warn("Failed to set dgpu disable: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1 || retval < 0) {
+		pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_disable");
+
+	return 0;
+}
+
+static ssize_t dgpu_disable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->dgpu_disable;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+/*
+ * A user may be required to store the value twice, typcial store first, then
+ * rescan PCI bus to activate power, then store a second time to save correctly.
+ * The reason for this is that an extra code path in the ACPI is enabled when
+ * the device and bus are powered.
+ */
+static ssize_t dgpu_disable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool disable;
+	int result;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &disable);
+	if (result)
+		return result;
+
+	asus->dgpu_disable = disable;
+
+	result = dgpu_disable_write(asus);
+	if (result)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(dgpu_disable);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -2412,6 +2502,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
+	&dev_attr_dgpu_disable.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -2438,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -2699,6 +2792,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	err = dgpu_disable_check_present(asus);
+	if (err)
+		goto fail_dgpu_disable;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -2799,6 +2896,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_sysfs:
 fail_throttle_thermal_policy:
 fail_fan_boost_mode:
+fail_dgpu_disable:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 428aea701c7b..a528f9d0e4b7 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -90,6 +90,9 @@
 /* Keyboard dock */
 #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
 
+/* dgpu on/off */
+#define ASUS_WMI_DEVID_DGPU		0x00090020
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.31.1

