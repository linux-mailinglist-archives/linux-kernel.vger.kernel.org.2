Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081113BAF55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGDWY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 18:24:56 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49207 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229732AbhGDWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:24:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 293533200913;
        Sun,  4 Jul 2021 18:22:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 04 Jul 2021 18:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ldb6qyK4IThrrQN5irTjCjWw8EaN4BN9P995P3a4Vko=; b=THJ4/X57
        XAHVeqhwo9vFT8dOdBqV4JVyiPw+/tDtzIMmDou/fB8HUv08AfnrFxkxt+USMWZe
        DsfbTVd5cYiWASzcHNBNEWXX/41HL3Td7RFzhQkV4QWwKF8BhmSom1sM2OfUdHqu
        jbByQHDlUdCVQFjTaDeN99Fqgl+iI9yY2hknRV0mVghNQu3Bo/t24OrPA/s1dtrY
        w8F5ozLcV/NccN23f6S6oLHaShwYyqiAawf/13PCq/ufJc1vUVv3WuZhRPHArvO0
        a+G8IO6+D2eh5JlZ9/R/xyJ2dD1kX4tPy0ot/z8AF6n452jWK3TaiHWde97zpUb4
        sjWoJMVkt69iJA==
X-ME-Sender: <xms:mjTiYHfkJyo4LqCs_pzjqSdaE_SJLjuyvBfvpW0XvbzhaH7UcGwhtQ>
    <xme:mjTiYNNM6eGqNlU60-3psc57kONJZWZx-zD-yN1LMPfu0uVQOjQO2MVx3rTDslid7
    s54_PZwIQNcS9MUtTQ>
X-ME-Received: <xmr:mjTiYAigP4_8XyPCfGv8QiZpGQ-rq_Ozk4kgy3QSU7_GDG3Benj-_wGwfQ9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpedvteekvdeuhedthfeuudelheejie
    fhvddtteelleeghfekhfeugfehgeekffdtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:mjTiYI-_IeTC0i3Pn1Ae7umRSoAW_i8KFyruOYgSs0dudHwCAdRNJg>
    <xmx:mjTiYDvOkEp1WaBmmO8QWRXD1l0l6Fal-xmeY03wAmYJN_2EbYL2rA>
    <xmx:mjTiYHFtO6L-UYQZu0MZ1lLX3G0I2_412_XocjiHmbyiJiHLYWN2uA>
    <xmx:mjTiYJVL-T7o7PltFeIIOrYJN6tCttDKwSsaGX1dGBEVDZaW3COv7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jul 2021 18:22:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/3] asus-wmi: Add panel overdrive functionality
Date:   Mon,  5 Jul 2021 10:21:46 +1200
Message-Id: <20210704222148.880848-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210704222148.880848-1-luke@ljones.dev>
References: <20210704222148.880848-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ASUS ROG laptops have the ability to drive the display panel
a a higher rate to eliminate or reduce ghosting.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 93 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ebaeb7bb80f5..2468076d6cd8 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -216,6 +216,9 @@ struct asus_wmi {
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
+	bool panel_overdrive_available;
+	u8 panel_overdrive;
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
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->panel_overdrive_available = true;
+		asus->panel_overdrive = result & ASUS_WMI_DSTS_STATUS_BIT;
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
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
+			"panel_od");
+
+	if (err) {
+		pr_warn("Failed to set panel overdrive: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1 || retval < 0) {
+		pr_warn("Failed to set panel overdrive (retval): 0x%x\n",
+			retval);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static ssize_t panel_od_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->panel_overdrive;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t panel_od_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result;
+	u8 overdrive;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou8(buf, 10, &overdrive);
+	if (result < 0)
+		return result;
+
+	if (overdrive > 1 || overdrive < 0)
+		return -EINVAL;
+
+	asus->panel_overdrive = overdrive;
+	panel_od_write(asus);
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

