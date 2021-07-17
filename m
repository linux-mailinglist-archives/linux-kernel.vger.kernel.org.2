Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFF3CC1FA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhGQIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 04:17:36 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45443 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231657AbhGQIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:16:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EE67F3200928;
        Sat, 17 Jul 2021 04:13:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 17 Jul 2021 04:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nsW/hzWMdNu73a9AEfLvZ9T6JWvERx9gWen+hfJQzNw=; b=H97G0sGk
        LHuBur4yGJc3VX9v3fpwiT1Cl6Sq6cILM1eAZvN4hzmM0h6O9mfrdgjJU02e6kuT
        lC1DtV3JVscJDNxn355jQQPoDrkSxzkYzZxR0l7MjsKkuCn/vgdpfxwNP/0d93JR
        WE2JMzwGbo/H0gKHw3khLNX/OmLkVsAOUzLCQuxS9tN7r4jP3D3+3meAzN7ZVpns
        wsE21OPy65jgyjCs3sab0q7joQArYBqQWjvKONb4SLllrfGJKE1kqHXCAXXjEjtD
        J8XjY92qwLWWtxyqaPjPGpZSfc1Jp6/YApUae74A5nblZFZV9ax5o+r36Jx6CQAe
        ZhcAjKTpetPtjA==
X-ME-Sender: <xms:OZHyYI5Zseie0AegNG7EOO6oyM5m0FiW4-zLWaBSarh_w8gSs3odLQ>
    <xme:OZHyYJ7R1mR5QnOSKQHLU9z3IPifA9YbNw2DtQbNbcM2pBAV33lbdge0vEDy5jfPc
    igpiKtVajhFnO8wmqI>
X-ME-Received: <xmr:OZHyYHeM0ygzFeP-g2LSllGCfVNTGVEaWvbrDFlGX8hUSbf6COx0bfvufKA7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvdetkedvueehtdfhueduleehjeeihf
    dvtdetleelgefhkefhuefgheegkefftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:OZHyYNIk3Wbm-0Adu572nx0dQSG1a0-47w6hKvKETbY6ovW7Wa-RGg>
    <xmx:OZHyYMIdGcVxTzjYrxdKCii1pH2cNMgO1lFOGWD9BiBdI2O4nZt6iA>
    <xmx:OZHyYOyTLKg2v19cIRo1sp19g5Jjl6XB771gIz2oplON2_Rzv0pVRw>
    <xmx:OZHyYGgdxlXd5p-bmhU1YNM5hazz1ZeBYnu7uOKYMzuei494miEAng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jul 2021 04:13:42 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/4] asus-wmi: Add egpu enable method
Date:   Sat, 17 Jul 2021 20:13:23 +1200
Message-Id: <20210717081323.7925-3-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210717081323.7925-1-luke@ljones.dev>
References: <20210717081323.7925-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X13 Flow laptops can utilise an external GPU. This requires
toggling an ACPI method which will first disable the internal
dGPU, and then enable the eGPU.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 91 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 94 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 02762a60d27a..ee5d8656641e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -210,6 +210,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool egpu_enable_available; // 0 = enable
+	bool egpu_enable;
+
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
@@ -430,6 +433,86 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 	}
 }
 
+/* eGPU ********************************************************************/
+static int egpu_enable_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->egpu_enable_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_EGPU, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->egpu_enable_available = true;
+		asus->egpu_enable = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int egpu_enable_write(struct asus_wmi *asus)
+{
+	int err;
+	u8 value;
+	u32 retval;
+
+	value = asus->egpu_enable;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, value, &retval);
+
+	if (err) {
+		pr_warn("Failed to set egpu disable: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1 || retval < 0) {
+		pr_warn("Failed to set egpu disable (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "egpu_enable");
+
+	return 0;
+}
+
+static ssize_t egpu_enable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	bool mode = asus->egpu_enable;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+static ssize_t egpu_enable_store(struct device *dev,
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
+	asus->egpu_enable = disable;
+
+	result = egpu_enable_write(asus);
+	if (result != 0)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(egpu_enable);
+
 /* dGPU ********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
@@ -2502,6 +2585,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
+	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
@@ -2529,6 +2613,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_egpu_enable.attr)
+		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
@@ -2792,6 +2878,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	err = egpu_enable_check_present(asus);
+	if (err)
+		goto fail_egpu_enable;
+
 	err = dgpu_disable_check_present(asus);
 	if (err)
 		goto fail_dgpu_disable;
@@ -2896,6 +2986,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_sysfs:
 fail_throttle_thermal_policy:
 fail_fan_boost_mode:
+fail_egpu_enable:
 fail_dgpu_disable:
 fail_platform:
 fail_panel_od:
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a528f9d0e4b7..17dc5cb6f3f2 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -90,6 +90,9 @@
 /* Keyboard dock */
 #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
 
+/* dgpu on/off */
+#define ASUS_WMI_DEVID_EGPU		0x00090019
+
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
-- 
2.31.1

