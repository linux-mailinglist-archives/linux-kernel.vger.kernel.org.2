Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15C3BAF59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhGDWZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 18:25:03 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60263 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhGDWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:25:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C471C3200916;
        Sun,  4 Jul 2021 18:22:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Jul 2021 18:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=yopX1zJC3c35b0q5DtgYgCWOOW4d7xGsXAOBALaxekM=; b=W+stt/W3
        1OskvE9gPOIRuf1jYxWDSHFQ0NUvA42z/J6wG6/Y0RdM1snFCf3/lwDFSLujtOeZ
        G8C4neeo6J1wC1QRw1G5/+h6Rig3E1Gbn1U7p6O6bDDazJ4tUszesHq3xdXf8eKv
        bUPqOp/XLEun+riyDm28q5B/bnM6YzYRoPfiQColoTU9X7zIvF6xHGYE5RWJ/OfU
        Qh2eiBazc28hkUMbcMkA1+CWhWkfbjpc4gVB8Rt7HR+a+6pMEsEI9KGaH+SuTckk
        dUBAtkCGg84XPzIXzKBOYIW420jm2mnMI6vJsRFFs5XHbmbO80+zA+i3MXRy38Hs
        Kbyt2rfDeT1iPw==
X-ME-Sender: <xms:oDTiYBPDl-311lcrJbrW_YZk4BwYauB_39WNr2nNHxcukBPr88V_Ug>
    <xme:oDTiYD89WxrLWKXCVuPR1wsUgZAmcGROpYwwHC5KOIiim42GYKSS4kar7e_hCz9BI
    wPizXDTD4asy0iIPdQ>
X-ME-Received: <xmr:oDTiYAQGVEHeZDoSZQvvW4Nv2M1Usowx26vl-7YVKnI9MWTx02kMqUcYF4h4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpedvteekvdeuhedthfeuudelheejie
    fhvddtteelleeghfekhfeugfehgeekffdtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:oDTiYNuTwZYOYGjWsjeK6GmFeoqDwKjD5UlppFIE_MfFImoGRqwL2A>
    <xmx:oDTiYJd6ao_pWOiXwgeWKHs-4AEBytKSWRy4u6rgiCApBpAuX0xOCw>
    <xmx:oDTiYJ14lDCsCWoPcSqrqLPZ5HPO-I5h6V0N4Ox6SNXDFklUyT4VCQ>
    <xmx:oTTiYCGurlzfxBbePzt9ucK70YgXqwuVsjDukzIZ5dSxhqsA0RCWlA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jul 2021 18:22:21 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/3] asus-wmi: Add dgpu disable method
Date:   Mon,  5 Jul 2021 10:21:47 +1200
Message-Id: <20210704222148.880848-3-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210704222148.880848-1-luke@ljones.dev>
References: <20210704222148.880848-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Windows the ASUS Armory Crate progrm can enable or disable the
dGPU via a WMI call. This functions much the same as various Linux
methods in software where the dGPU is removed from the device tree.

However the WMI call saves the state of dGPU enabled or not and this
then changes the dGPU visibility in Linux with no way for Linux
users to re-enable it. We expose the WMI method so users can see
and change the dGPU ACPI state.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 98 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 101 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2468076d6cd8..8dc3f7ed021f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -210,6 +210,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool dgpu_disable_available;
+	u8 dgpu_disable_mode;
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
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->dgpu_disable_available = true;
+		asus->dgpu_disable_mode = result & ASUS_WMI_DSTS_STATUS_BIT;
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
+	value = asus->dgpu_disable_mode;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
+			"dgpu_disable");
+
+	if (err) {
+		pr_warn("Failed to set dgpu disable: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1 || retval < 0) {
+		pr_warn("Failed to set dgpu disable (retval): 0x%x\n",
+			retval);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static ssize_t dgpu_disable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->dgpu_disable_mode;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t dgpu_disable_store(struct device *dev,
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
+	asus->dgpu_disable_mode = disable;
+	/*
+	 * The ACPI call used does not save the mode unless the call is run twice.
+	 * Once to disable, then once to check status and save - this is two code
+	 * paths in the method in the ACPI dumps.
+	*/
+	dgpu_disable_write(asus);
+	dgpu_disable_write(asus);
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

