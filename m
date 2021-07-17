Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF03CC1F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 10:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhGQIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 04:17:34 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52283 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233226AbhGQIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:16:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 58976320091F;
        Sat, 17 Jul 2021 04:13:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 17 Jul 2021 04:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wOVVUBRAmyrV9aWXsHDM8tXQfsI+uLgR+NVbWqufuL8=; b=gk5ojOQg
        teEY3xHnfHHQFk2dQolJaye9aK02plOpgzi/yqfNtkhoh+76FRmxuK2nYD4raNJr
        xWKgj5idpSHjieWxtWv+MfJnxXHrkBhoRvcmO2EFaSAwlfe7n9DGWgu1NX0crVTE
        Bf8/2dAmqPx9sibQUI470+NhFM0RHn+AAVtAdIOvVXvXMNj5NUHIZBW9FoPHgJQN
        MZGFyGt8sFG+wJ1cE9Lc+Jvdo7Xt9YxEPpcRYCubQY860XQcTOodFlBpGlXOfhNk
        QqdcYZjnG9JWd7B8XN2FxGl4puqsKUju3+2jnqzrIvjnMdSUoraZFh2RqyzVASAU
        FAC1Ln4hl6+hfQ==
X-ME-Sender: <xms:NJHyYLktN2NsNgLnnVuf2okfROcoDAyDw9BPeaWNuJEuTutDQPhOfw>
    <xme:NJHyYO3JFK6QcUrEYW2gpNVeb50aQrfS2hNRV_8hwFN_ac3P_VtaHwoQsaFXS5CoB
    WkXJNGnHonYfHSft6c>
X-ME-Received: <xmr:NJHyYBpAIXBwwYtGAcqrPz0BVBB_4NYmN2XpqAALvYDGa902t6y-v1kYeS2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvdetkedvueehtdfhueduleehjeeihf
    dvtdetleelgefhkefhuefgheegkefftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:NJHyYDkTm4bBInvWDk8XJVLsG_BoW3dRghqFMWqX8clM6mVIvf1Zaw>
    <xmx:NJHyYJ0pHAbjMuTutK9txg8v-WJsaH0gTLouZtyup8MGoIEZzQmAqQ>
    <xmx:NJHyYCtiA-takfE1LyhUy8v9MMdkk1Mx74szmfeKnpIlFlCGIcQOAw>
    <xmx:NJHyYB9vXGloQDOuyOSJnxenxBD6-bsyrzaLzZbQ6jrVQmCj82mVVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jul 2021 04:13:37 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/4] asus-wmi: Add dgpu disable method
Date:   Sat, 17 Jul 2021 20:13:22 +1200
Message-Id: <20210717081323.7925-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210717081323.7925-1-luke@ljones.dev>
References: <20210717081323.7925-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c            | 99 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 102 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cd881443bc2f..02762a60d27a 100644
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
 
@@ -427,6 +430,94 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
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
+	int err;
+	u8 value;
+	u32 retval;
+
+	value = asus->dgpu_disable;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
+
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
+	bool mode = asus->dgpu_disable;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+static ssize_t dgpu_disable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result;
+	bool disable;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &disable);
+	if (result == -EINVAL)
+		return result;
+
+	asus->dgpu_disable = disable;
+	/*
+	 * The ACPI call used does not save the mode unless the call is run twice.
+	 * Once to disable, then once to check status and save - this is two code
+	 * paths in the method in the ACPI dumps.
+	*/
+	result = dgpu_disable_write(asus);
+	if (result != 0)
+		return result;
+
+	result = dgpu_disable_write(asus);
+	if (result != 0)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(dgpu_disable);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -2411,6 +2502,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
+	&dev_attr_dgpu_disable.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -2437,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -2698,6 +2792,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	err = dgpu_disable_check_present(asus);
+	if (err)
+		goto fail_dgpu_disable;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -2798,6 +2896,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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

