Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F493BAF5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 00:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhGDWZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 18:25:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54093 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhGDWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:25:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3D0803200925;
        Sun,  4 Jul 2021 18:22:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 04 Jul 2021 18:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3CPDjxPiq6HlBKJX4u/v/vfPupRnUlydsIxOwue4RPs=; b=T1nUo8j4
        Z5iTQO+yi8iaoXHdMWat1zgcEx+KbSrR7ztDM0ZNDm1kq7x4TDg2zE85YbGqDgGy
        nJCYOeW4qGyk0vPDBcz+DvK/48dGVyXHlujYfhrxfGmu4w6b4sDtjwbBmWsxr/qB
        o6zlInuskOF26BGNPw95m7XnS+XI6BdL13perxuncYwgJN7qUNifRl/zF1r+sOnu
        MchCkruQ3pntPEgdx9uYy7+x1uBQevC7M8Qlx+XEy4K8aDPbNLNLnuEuA2ve1GFb
        SmFLdmbDjTsl71ViwFWDblELRG4jVMC7ikhAvJgIC7owTBK9a1HjSRTYsqNdtqd5
        bhyy9S1MI4R0Yg==
X-ME-Sender: <xms:pjTiYEXBglmZPc7QSf66GlGZCPXcYuDVfirG9b4WPVsHgotW24vByQ>
    <xme:pjTiYIlk4t-ZeXF8cpszpJ6QoDlNNCTI3AdmqjJnzYDmWevkEubF56IFj7ZdkVunl
    J3MD6zXCQLqloEYbLU>
X-ME-Received: <xmr:pjTiYIY8ZC0GY9YyUFHcx7RDbGXPC78wudwMnlI1nVojP8jrRHhHINIAAf41>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpedvteekvdeuhedthfeuudelheejie
    fhvddtteelleeghfekhfeugfehgeekffdtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:pjTiYDWVeabdlkAXfgaj7aChmFJcYgC27yc7OXZY82Jkjv-7yB9DVw>
    <xmx:pjTiYOnp8dyiYu4KMtCVbzotQMEY5e8rL9pRmXRwAXoQyfSt8slXZg>
    <xmx:pjTiYIeK2pw1I5JJ8pg_xgRplBIJHLLoVn3bpwvHtaYl6QSI9G03lQ>
    <xmx:pjTiYFsQsNsZ9aMyotpNHlTz9xtKCngzOu-2doL_Cj7fNzFW7VMjkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jul 2021 18:22:27 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/3] asus-wmi: Add egpu enable method
Date:   Mon,  5 Jul 2021 10:21:48 +1200
Message-Id: <20210704222148.880848-4-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210704222148.880848-1-luke@ljones.dev>
References: <20210704222148.880848-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 8dc3f7ed021f..c9fe77456b7b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -210,6 +210,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool egpu_enable_available; // 0 = enable
+	u8 egpu_enable_mode;
+
 	bool dgpu_disable_available;
 	u8 dgpu_disable_mode;
 
@@ -430,6 +433,87 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
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
+		asus->egpu_enable_mode = result & ASUS_WMI_DSTS_STATUS_BIT;
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
+	value = asus->egpu_enable_mode;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, value, &retval);
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "egpu_enable");
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
+	return 0;
+}
+
+static ssize_t egpu_enable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->egpu_enable_mode;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t egpu_enable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result;
+	u8 disable;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou8(buf, 10, &disable);
+	if (result < 0)
+		return result;
+
+	if (disable > 1 || disable < 0)
+		return -EINVAL;
+
+	asus->egpu_enable_mode = disable;
+
+	egpu_enable_write(asus);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(egpu_enable);
+
 /* dGPU ********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
@@ -2502,6 +2586,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
+	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
@@ -2529,6 +2614,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_egpu_enable.attr)
+		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
@@ -2792,6 +2879,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	err = egpu_enable_check_present(asus);
+	if (err)
+		goto fail_egpu_enable;
+
 	err = dgpu_disable_check_present(asus);
 	if (err)
 		goto fail_dgpu_disable;
@@ -2896,6 +2987,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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

