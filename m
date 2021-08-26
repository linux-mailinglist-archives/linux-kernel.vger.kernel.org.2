Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110FB3F9104
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbhHZXoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:44:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60923 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhHZXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:44:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C865B32008FA;
        Thu, 26 Aug 2021 19:43:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Aug 2021 19:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=izNnTBhh9lWCdGRAv+aICPXNMvxcwBxB6UVMSw+oYU0=; b=bEd1tVum
        /5lHslYefPQ0CGClWBzfHyFrPeY20EvnXVh3pFG6IOD3QYkhDzYHUM+haasOGHxc
        mMimI8FwuhDuUxRqmqdYpFKzq1kExtK+Ivy17UpFm6YXICYAVs4AEEvyjCcv+Ikq
        wmPuC6dipR+Fd4mIVB6T0m1hyG5sGuGENf9RMqUOI5TUSANMfC4du9tn+hW17hST
        J9QiIOT6nLIAAJCAXXLh2sKTVkXpmQey9gIihHhd8aiT+CAB3oVSASMMjlqW3mhj
        ydrHxk9pO9neiOfqw8i1yql40pMRD8LRifs/3KYDrIMb9U4CVNamSOBbHbCkkwqg
        +65/cX+/kn1iLg==
X-ME-Sender: <xms:FCcoYd89z7z0KkA4WdtiEg6v520WRHnuiJnTXFyZeCGr2v8Z82fhCA>
    <xme:FCcoYRvOXUnxWBhwV6mVhI6MPToQ9hpPe7Sxn0zS3bKNqKYNNovHlUUAIJICaz1si
    KGWIv-neHapAY7Wve8>
X-ME-Received: <xmr:FCcoYbBbYeZ3oW5V00o-iw0BGV2PHQgZeLWT4OlxcfF6ECO6KBpAyavu4cRx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpedvteekvdeuhedthfeuudelheejie
    fhvddtteelleeghfekhfeugfehgeekffdtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:FCcoYReW9_qSRkP2IPfHHHE6c6VckKqesgHap0prVGPiV6e4n_oYLw>
    <xmx:FCcoYSNWu9cq0Jjmp4JZwvEVwEzmMgXPI95QfXHJ5N1BTtmw_ckq3g>
    <xmx:FCcoYTm7UW3aX3JbmykaIsAH6fERwdJWYRyGKDQCrZ-ZPRNfA0Z-MQ>
    <xmx:FCcoYbbkfxY7KrlxDBxL_jzxztFSSt7Eu9Orq1rCD0fwGfaL2chvJg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 19:43:13 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v5] asus-wmi: Add support for custom fan curves
Date:   Fri, 27 Aug 2021 11:42:59 +1200
Message-Id: <20210826234259.5980-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826234259.5980-1-luke@ljones.dev>
References: <20210826234259.5980-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for custom fan curves found on some ASUS ROG laptops.

These laptops have the ability to set a custom curve for the CPU
and GPU fans via an ACPI method call. This patch enables this,
additionally enabling custom fan curves per-profile, where profile
here means each of the 3 levels of "throttle_thermal_policy".

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 616 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 616 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cc5811844012..944644ae0acd 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -108,6 +108,11 @@ module_param(fnlock_default, bool, 0444);
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
+static int throttle_thermal_policy_write(struct asus_wmi*);
+static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
+								size_t count, u32 dev, char **curve,
+								char *default_curve);
+
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -122,7 +127,8 @@ struct bios_args {
 	u32 arg0;
 	u32 arg1;
 	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
-	u32 arg4;
+	u32 arg3;
+	u32 arg4; /* Some ROG laptops require a full 5 input args */
 	u32 arg5;
 } __packed;
 
@@ -173,6 +179,21 @@ enum fan_type {
 	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
 };
 
+struct fan_curve {
+	char *balanced;
+	char *balanced_default;
+	char *performance;
+	char *performance_default;
+	char *quiet;
+	char *quiet_default;
+};
+
+struct enabled_fan_curves {
+	bool balanced;
+	bool performance;
+	bool quiet;
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -220,6 +241,14 @@ struct asus_wmi {
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
+	bool cpu_fan_curve_available;
+	struct fan_curve cpu_fan_curve;
+
+    bool gpu_fan_curve_available;
+	struct fan_curve gpu_fan_curve;
+
+	struct enabled_fan_curves enabled_fan_curve_profiles;
+
 	struct platform_profile_handler platform_profile_handler;
 	bool platform_profile_support;
 
@@ -285,6 +314,85 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 }
 EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
 
+static int asus_wmi_evaluate_method5(u32 method_id,
+		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
+{
+	struct bios_args args = {
+		.arg0 = arg0,
+		.arg1 = arg1,
+		.arg2 = arg2,
+		.arg3 = arg3,
+		.arg4 = arg4,
+	};
+	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	union acpi_object *obj;
+	u32 tmp = 0;
+
+	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
+				     &input, &output);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = (union acpi_object *)output.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		tmp = (u32) obj->integer.value;
+
+	if (retval)
+		*retval = tmp;
+
+	kfree(obj);
+
+	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
+		return -ENODEV;
+
+	return 0;
+}
+
+/*
+ * Returns as an error if the method output is not a buffer. Typically this
+ * means that the method called is unsupported.
+*/
+static int asus_wmi_evaluate_method_buf(u32 method_id,
+		u32 arg0, u32 arg1, u8 *ret_buffer)
+{
+	struct bios_args args = {
+		.arg0 = arg0,
+		.arg1 = arg1,
+		.arg2 = 0,
+	};
+	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	union acpi_object *obj;
+	u32 int_tmp = 0;
+
+	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
+				     &input, &output);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = (union acpi_object *)output.pointer;
+
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
+		int_tmp = (u32) obj->integer.value;
+		if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
+			return -ENODEV;
+		return int_tmp;
+	}
+
+	if (obj && obj->type == ACPI_TYPE_BUFFER) {
+		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
+	}
+
+	kfree(obj);
+
+	return 0;
+}
+
 static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 {
 	struct acpi_buffer input;
@@ -1813,7 +1921,7 @@ static ssize_t fan1_label_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
+	return sprintf(buf, "%s", ASUS_FAN_DESC);
 }
 
 static ssize_t asus_hwmon_temp1(struct device *dev,
@@ -2043,6 +2151,458 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
 static DEVICE_ATTR_RW(fan_boost_mode);
 
+/* Custom fan curves per-profile **********************************************/
+
+/*
+ * Check if the ability to set fan curves on either fan exists, and store the
+ * defaults for recall later plus to provide users with a starting point.
+ *
+ * "dev" is either CPU_FAN_CURVE or GPU_FAN_CURVE.
+*/
+static int custom_fan_check_present(struct asus_wmi *asus,
+									bool *available, u32 dev)
+{
+	struct fan_curve *curves = &asus->cpu_fan_curve;
+	u8 *buf = kzalloc(16 * sizeof(u8), GFP_KERNEL);
+	/* 15 punctuation marks + 16 sets of numbers up to 3 char each */
+	int str_len = 15 + 16 * 3;
+	int err;
+
+	*available = false;
+
+	if (dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
+		curves = &asus->gpu_fan_curve;
+
+	/* Balanced default */
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, buf);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	curves->balanced = kzalloc(str_len * sizeof(char), GFP_KERNEL);
+	if (!curves->balanced)
+		return -ENOMEM;
+
+	curves->balanced_default = kzalloc(str_len * sizeof(char), GFP_KERNEL);
+	if (!curves->balanced_default)
+		return -ENOMEM;
+
+	sprintf(curves->balanced, "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
+		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
+		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]);
+	sprintf(curves->balanced_default, curves->balanced);
+
+	/* Quiet default */
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, buf);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	curves->quiet = kzalloc(str_len * sizeof(char), GFP_KERNEL);
+	if (!curves->quiet)
+		return -ENOMEM;
+
+	curves->quiet_default = kzalloc(str_len * sizeof(char), GFP_KERNEL);
+	if (!curves->quiet_default)
+		return -ENOMEM;
+
+	sprintf(curves->quiet, "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
+		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
+		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]);
+	sprintf(curves->quiet_default, curves->quiet);
+
+	/* Performance default */
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, buf);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	curves->performance = kzalloc(str_len * sizeof(char), GFP_KERNEL);
+	if (!curves->performance)
+		return -ENOMEM;
+
+	curves->performance_default = kzalloc(str_len * sizeof(char), GFP_KERNEL);
+	if (!curves->performance_default)
+		return -ENOMEM;
+
+	sprintf(curves->performance,
+		"%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
+		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
+		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]);
+	sprintf(curves->performance_default, curves->performance);
+
+	kfree(buf);
+
+	*available = true;
+	return 0;
+}
+
+/*
+ * The expected input is of the format
+ *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
+ * where a pair is 30:1, with 30 = temperature, and 1 = percentage
+*/
+static int fan_curve_write(struct asus_wmi *asus, u32 dev, char *curve)
+{
+    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
+    int err, ret;
+
+	char *set_delimiter = ",";
+	char *pair_delimiter = ":";
+	bool half_complete = false;
+	bool pair_start = true;
+	u32 prev_percent = 0;
+	u32 prev_temp = 0;
+	u32 percent = 0;
+	u32 shift = 0;
+	u32 temp = 0;
+    u32 arg1 = 0;
+    u32 arg2 = 0;
+    u32 arg3 = 0;
+    u32 arg4 = 0;
+
+    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
+
+	while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
+		pair_tmp = kstrdup(set, GFP_KERNEL);
+        pair_start = true;
+		while( (pair = strsep(&pair_tmp, pair_delimiter)) != NULL ) {
+			err = kstrtouint(pair, 10, &ret);
+            if (err) {
+                kfree(pair_tmp);
+                kfree(buf);
+                return err;
+            }
+
+            if (pair_start) {
+                temp = ret;
+                pair_start = false;
+            } else {
+                percent = ret;
+            }
+		}
+		kfree(pair_tmp);
+
+		if (temp < prev_temp || percent < prev_percent || percent > 100) {
+            pr_info("Fan curve invalid");
+			pr_info("A value is sequentially lower or percentage is > 100");
+            kfree(buf);
+            return -EINVAL;
+        }
+
+        prev_temp = temp;
+        prev_percent = percent;
+
+        if (!half_complete) {
+            arg1 += temp << shift;
+            arg3 += percent << shift;
+        } else {
+            arg2 += temp << shift;
+            arg4 += percent << shift;
+        }
+        shift += 8;
+
+        if (shift == 32) {
+            shift = 0;
+            half_complete = true;
+        }
+	}
+	kfree(buf);
+
+    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
+									 arg1, arg2, arg3, arg4, &ret);
+}
+
+static int fan_curve_cpu_write(struct asus_wmi *asus)
+{
+	char *curve = NULL;
+	int err, mode;
+
+	mode = asus->throttle_thermal_policy_mode;
+
+	if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
+					&& asus->enabled_fan_curve_profiles.balanced) {
+		curve = asus->cpu_fan_curve.balanced;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
+					&& asus->enabled_fan_curve_profiles.performance) {
+		curve = asus->cpu_fan_curve.performance;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT
+					&& asus->enabled_fan_curve_profiles.quiet) {
+		curve = asus->cpu_fan_curve.quiet;
+	}
+
+	if (curve != NULL) {
+		err = fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, curve);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+
+static int fan_curve_gpu_write(struct asus_wmi *asus)
+{
+	char *curve = NULL;
+	int err, mode;
+
+	mode = asus->throttle_thermal_policy_mode;
+
+	if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
+					&& asus->enabled_fan_curve_profiles.balanced) {
+		curve = asus->gpu_fan_curve.balanced;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
+					&& asus->enabled_fan_curve_profiles.performance) {
+		curve = asus->gpu_fan_curve.performance;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT
+					&& asus->enabled_fan_curve_profiles.quiet) {
+		curve = asus->gpu_fan_curve.quiet;
+	}
+
+	if (curve != NULL) {
+		err = fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, curve);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
+								size_t count, u32 dev, char **curve,
+								char *default_curve)
+{
+    int err;
+
+	/* Allow a user to write "" or " " to erase a curve setting */
+	if (strlen(buf) <= 1 || strcmp(buf, " \n") == 0) {
+		kfree(*curve);
+		*curve = kstrdup(default_curve, GFP_KERNEL);
+		err = throttle_thermal_policy_write(asus);
+		if (err)
+			return err;
+		return count;
+	}
+
+	if (*curve)
+		kfree(*curve);
+    *curve = kstrdup(buf, GFP_KERNEL);
+
+	/* Maybe activate fan curve if in associated mode */
+	err = throttle_thermal_policy_write(asus);
+	if (err) {
+		kfree(*curve);
+		*curve = kstrdup(default_curve, GFP_KERNEL);
+		return err;
+	}
+
+    return count;
+}
+
+/*
+ * CPU Fan Curves
+*/
+
+static ssize_t cpu_fan_curve_balanced_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.balanced);
+}
+
+static ssize_t cpu_fan_curve_balanced_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
+							&asus->cpu_fan_curve.balanced,
+							asus->cpu_fan_curve.balanced_default);
+}
+
+static DEVICE_ATTR_RW(cpu_fan_curve_balanced);
+
+static ssize_t cpu_fan_curve_performance_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.performance);
+}
+
+static ssize_t cpu_fan_curve_performance_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
+							&asus->cpu_fan_curve.performance,
+							asus->cpu_fan_curve.performance_default);
+}
+
+static DEVICE_ATTR_RW(cpu_fan_curve_performance);
+
+static ssize_t cpu_fan_curve_quiet_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.quiet);
+}
+
+static ssize_t cpu_fan_curve_quiet_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
+							&asus->cpu_fan_curve.quiet,
+							asus->cpu_fan_curve.quiet_default);
+}
+
+static DEVICE_ATTR_RW(cpu_fan_curve_quiet);
+
+/*
+ * GPU Fan Curves
+*/
+
+static ssize_t gpu_fan_curve_balanced_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.balanced);
+}
+
+static ssize_t gpu_fan_curve_balanced_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
+							&asus->gpu_fan_curve.balanced,
+							asus->gpu_fan_curve.balanced_default);
+}
+
+static DEVICE_ATTR_RW(gpu_fan_curve_balanced);
+
+static ssize_t gpu_fan_curve_performance_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.performance);
+}
+
+static ssize_t gpu_fan_curve_performance_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
+							&asus->gpu_fan_curve.performance,
+							asus->gpu_fan_curve.performance_default);
+}
+
+static DEVICE_ATTR_RW(gpu_fan_curve_performance);
+
+static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.quiet);
+}
+
+static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
+							&asus->gpu_fan_curve.quiet,
+							asus->gpu_fan_curve.quiet_default);
+}
+
+static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
+
+/*
+ * Profiles with enabled fan curve setting
+*/
+
+static int enabled_fan_curve_profiles_write(struct asus_wmi *asus,
+											const char *names)
+{
+    char *buf, *set, *set_end;
+    int err;
+
+    buf = set_end = kstrdup(names, GFP_KERNEL);
+
+	/* Reset before checking */
+	asus->enabled_fan_curve_profiles.balanced = false;
+	asus->enabled_fan_curve_profiles.quiet = false;
+	asus->enabled_fan_curve_profiles.performance = false;
+
+	while( (set = strsep(&set_end, " ")) != NULL ) {
+		if (set == NULL)
+			set = buf;
+
+		if (strcmp(set, "balanced") == 0
+				|| strcmp(set, "balanced\n") == 0)
+			asus->enabled_fan_curve_profiles.balanced = true;
+
+		if (strcmp(set, "quiet") == 0
+				|| strcmp(set, "quiet\n") == 0)
+			asus->enabled_fan_curve_profiles.quiet = true;
+
+		if (strcmp(set, "performance") == 0
+				|| strcmp(set, "performance\n") == 0)
+			asus->enabled_fan_curve_profiles.performance = true;
+	}
+
+	err = throttle_thermal_policy_write(asus);
+	if (err)
+		return err;
+
+	kfree(buf);
+
+	return 0;
+}
+
+static ssize_t enabled_fan_curve_profiles_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int len = 0;
+
+	if (asus->enabled_fan_curve_profiles.balanced)
+		len += sysfs_emit_at(buf, len, "balanced ");
+
+	if (asus->enabled_fan_curve_profiles.performance)
+		len += sysfs_emit_at(buf, len, "performance ");
+
+	if (asus->enabled_fan_curve_profiles.quiet)
+		len += sysfs_emit_at(buf, len, "quiet ");
+
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+
+static ssize_t enabled_fan_curve_profiles_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+	int err;
+
+	err = enabled_fan_curve_profiles_write(asus, buf);
+	if (err)
+		return err;
+
+    return count;
+}
+
+static DEVICE_ATTR_RW(enabled_fan_curve_profiles);
+
 /* Throttle thermal policy ****************************************************/
 
 static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
@@ -2092,6 +2652,26 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 		return -EIO;
 	}
 
+	if (asus->cpu_fan_curve_available) {
+		err = fan_curve_cpu_write(asus);
+		if (err) {
+			dev_warn(&asus->platform_device->dev,
+				"Failed to set custom CPU curve for thermal policy: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	if (asus->gpu_fan_curve_available) {
+		err = fan_curve_gpu_write(asus);
+		if (err) {
+			dev_warn(&asus->platform_device->dev,
+				"Failed to set custom GPU curve for thermal policy: %d\n",
+				err);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
@@ -2711,6 +3291,13 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
+	&dev_attr_cpu_fan_curve_balanced.attr,
+	&dev_attr_cpu_fan_curve_performance.attr,
+	&dev_attr_cpu_fan_curve_quiet.attr,
+    &dev_attr_gpu_fan_curve_balanced.attr,
+	&dev_attr_gpu_fan_curve_performance.attr,
+	&dev_attr_gpu_fan_curve_quiet.attr,
+	&dev_attr_enabled_fan_curve_profiles.attr,
 	&dev_attr_panel_od.attr,
 	NULL
 };
@@ -2741,6 +3328,20 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
+	else if (attr == &dev_attr_cpu_fan_curve_balanced.attr)
+		ok = asus->cpu_fan_curve_available;
+	else if (attr == &dev_attr_cpu_fan_curve_performance.attr)
+		ok = asus->cpu_fan_curve_available;
+	else if (attr == &dev_attr_cpu_fan_curve_quiet.attr)
+		ok = asus->cpu_fan_curve_available;
+    else if (attr == &dev_attr_gpu_fan_curve_balanced.attr)
+		ok = asus->gpu_fan_curve_available;
+	else if (attr == &dev_attr_gpu_fan_curve_performance.attr)
+		ok = asus->gpu_fan_curve_available;
+	else if (attr == &dev_attr_gpu_fan_curve_quiet.attr)
+		ok = asus->gpu_fan_curve_available;
+	else if (attr == &dev_attr_enabled_fan_curve_profiles.attr)
+		ok = asus->cpu_fan_curve_available || asus->gpu_fan_curve_available;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 
@@ -3016,6 +3617,16 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = custom_fan_check_present(asus, &asus->cpu_fan_curve_available,
+			ASUS_WMI_DEVID_CPU_FAN_CURVE);
+	if (err)
+		goto fail_custom_fan_curve;
+
+    err = custom_fan_check_present(asus, &asus->gpu_fan_curve_available,
+			ASUS_WMI_DEVID_GPU_FAN_CURVE);
+	if (err)
+		goto fail_custom_fan_curve;
+
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -3109,6 +3720,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
 fail_throttle_thermal_policy:
+fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
 		platform_profile_remove();
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 17dc5cb6f3f2..a571b47ff362 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -77,6 +77,8 @@
 #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
 #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
 #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
+#define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
+#define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 
 /* Power */
 #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
-- 
2.31.1

