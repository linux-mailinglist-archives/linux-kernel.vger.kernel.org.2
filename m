Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB503F0E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhHRXGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:06:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35227 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhHRXGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:06:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A15545C013C;
        Wed, 18 Aug 2021 19:06:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 18 Aug 2021 19:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UdnrWzL5g3J+VMbBy
        Iq+htKyKrGRNVON/KauVp/8MQU=; b=DWln8Oe0K43L9FBxYfJRW8jKncjnHZbaY
        nF5/+vQKwIqI960sndWZN5whY3Z0cjBt8N30ojek4Oner4mQOvKuxj7Z0WdhBqL0
        aNiBM6aOfIv7/CUyioYzpt0prfSv4uUCgIvRf4Oo1hP7nPTV/TtKSPpMsAjg4Gee
        8tVdGmA3W/KxnwrOLPTxmNz5TcYkdIUWmlHpgJqQBpA3Z0yCYUq6LqdZXdW9slmT
        C2Y4ZbNYESigal7IJ95ohKA752++ol/aXy2+Wc/L15KlzH0P8OBYqa31BajATucZ
        yS51gWYBI/01KaJzPTMT0adhOIUpJU91Slvs7fTGG2f3JR32lOdOQ==
X-ME-Sender: <xms:WJIdYTNuj9_gNdcUgGD7HU-sjZ_j62upxM_4R15Px6IQVB7RN-SOTg>
    <xme:WJIdYd_ZDSaWHn1WLtG90_Cd4GUesXwelLflJzZNcPSKKixxXVcEN-sdkjhP5L38k
    r4kkHtfhP1I-6kYEMk>
X-ME-Received: <xmr:WJIdYSR2mNid1SeCyWCP4-TSs_kxlTLXb9eYmdlRsqhJrkzSMJRvwhTshS8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeukeegte
    eigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:WJIdYXsRIpm7EPPdQTxZKeaj7XFC90m66hOaU7JbktgOHHgsyHlnWA>
    <xmx:WJIdYbe33dID1wTGqmevkpGUbm8u0vPkieq0PhnjHu2c3L8Wt_PaPg>
    <xmx:WJIdYT0_EIt8oS6cJTkuJFk5gL6bJ7FPSP9ld6b7UgFfji4HbiXpXA>
    <xmx:WZIdYcpk7db2tkFGndFQRds34NXxBZL2uZj36pLiYtW1k0Z8G4pikw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 19:05:58 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Add support for custom fan curves
Date:   Thu, 19 Aug 2021 11:05:52 +1200
Message-Id: <20210818230552.760886-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
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
 drivers/platform/x86/asus-wmi.c            | 489 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 491 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cc5811844012..dba51c9d4af4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -122,6 +122,7 @@ struct bios_args {
 	u32 arg0;
 	u32 arg1;
 	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
+	u32 arg3;
 	u32 arg4;
 	u32 arg5;
 } __packed;
@@ -173,6 +174,12 @@ enum fan_type {
 	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
 };
 
+struct fan_curve {
+	char *balanced;
+	char *performance;
+	char *quiet;
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -220,6 +227,12 @@ struct asus_wmi {
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
+	bool cpu_fan_curve_available;
+	struct fan_curve cpu_fan_curve;
+
+    bool gpu_fan_curve_available;
+	struct fan_curve gpu_fan_curve;
+
 	struct platform_profile_handler platform_profile_handler;
 	bool platform_profile_support;
 
@@ -285,6 +298,90 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
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
+		u32 arg0, u32 arg1, u8 **ret_buffer)
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
+	u8 *buf_tmp;
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
+
+		return int_tmp;
+	}
+
+	if (obj && obj->type == ACPI_TYPE_BUFFER) {
+		buf_tmp = obj->buffer.pointer;
+	}
+
+	if (ret_buffer)
+		ret_buffer = &buf_tmp;
+
+	kfree(obj);
+
+	return 0;
+}
+
 static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 {
 	struct acpi_buffer input;
@@ -2043,6 +2140,302 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
 static DEVICE_ATTR_RW(fan_boost_mode);
 
+/* Custom fan curves per-profile **********************************************/
+
+static int custom_fan_check_present(struct asus_wmi *asus,
+									bool *available, u32 dev)
+{
+	u8 *buffer;
+	int err;
+
+	*available = false;
+
+	/*
+	 * We don't do anything with the buffer from this call except ensure that
+	 * it is a buffer. A fail or unsupported returns an int (from ACPI)
+	*/
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, &buffer);
+	if (err)
+		return err;
+
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, &buffer);
+	if (err)
+		return err;
+
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, &buffer);
+	if (err)
+		return err;
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
+static int fan_curve_check_valid(const char *curve)
+{
+    char * buf, *set, *set_end, *pair_tmp, *pair, *pair_end;
+	int err, ret;
+
+	char *set_delimiter = ",";
+	char *pair_delimiter = ":";
+    bool pair_start = true;
+	u32 prev_percent = 0;
+	u32 prev_temp = 0;
+    u32 percent = 0;
+	u32 temp = 0;
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
+        if (temp < prev_temp || percent < prev_percent || percent > 100) {
+            pr_info("Fan curve invalid");
+			pr_info("A value is sequentially lower or percentage is > 100");
+            kfree(buf);
+            return -EINVAL;
+        }
+
+        prev_temp = temp;
+        prev_percent = percent;
+	}
+	kfree(buf);
+
+    return 0;
+}
+
+static int fan_curve_write(struct asus_wmi *asus, u32 dev, char *curve)
+{
+    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
+    int err, ret;
+
+	char *set_delimiter = ",";
+	char *pair_delimiter = ":";
+	bool half_complete = false;
+	bool pair_start = true;
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
+static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
+								size_t count, u32 dev, char **curve,
+								u32 throttle_policy)
+{
+    int err;
+
+	/* Allow a user to write "" or " " to erase a curve setting */
+	if (strlen(buf) <= 1 || strcmp(buf, " \n") == 0) {
+		kfree(*curve);
+		*curve = NULL;
+		return count;
+	}
+
+    err = fan_curve_check_valid(buf);
+    if (err)
+        return err;
+
+	/* Always save fan curve if it is valid */
+    *curve = kstrdup(buf, GFP_KERNEL);
+
+	/* Maybe activate fan curve if in associated mode */
+    if (asus->throttle_thermal_policy_mode == throttle_policy) {
+        err = fan_curve_write(asus, dev, *curve);
+        if (err)
+            return err;
+    }
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
+	return scnprintf(buf, PAGE_SIZE, "%s\n", asus->cpu_fan_curve.balanced);
+}
+
+static ssize_t cpu_fan_curve_balanced_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
+							&asus->cpu_fan_curve.balanced,
+                            ASUS_THROTTLE_THERMAL_POLICY_DEFAULT);
+}
+
+static DEVICE_ATTR_RW(cpu_fan_curve_balanced);
+
+static ssize_t cpu_fan_curve_performance_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", asus->cpu_fan_curve.performance);
+}
+
+static ssize_t cpu_fan_curve_performance_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
+							&asus->cpu_fan_curve.performance,
+                            ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST);
+}
+
+static DEVICE_ATTR_RW(cpu_fan_curve_performance);
+
+static ssize_t cpu_fan_curve_quiet_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", asus->cpu_fan_curve.quiet);
+}
+
+static ssize_t cpu_fan_curve_quiet_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
+							&asus->cpu_fan_curve.quiet,
+                            ASUS_THROTTLE_THERMAL_POLICY_SILENT);
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
+	return scnprintf(buf, PAGE_SIZE, "%s\n", asus->gpu_fan_curve.balanced);
+}
+
+static ssize_t gpu_fan_curve_balanced_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
+							&asus->gpu_fan_curve.balanced,
+                            ASUS_THROTTLE_THERMAL_POLICY_DEFAULT);
+}
+
+static DEVICE_ATTR_RW(gpu_fan_curve_balanced);
+
+static ssize_t gpu_fan_curve_performance_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", asus->gpu_fan_curve.performance);
+}
+
+static ssize_t gpu_fan_curve_performance_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
+							&asus->gpu_fan_curve.performance,
+                            ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST);
+}
+
+static DEVICE_ATTR_RW(gpu_fan_curve_performance);
+
+static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", asus->gpu_fan_curve.quiet);
+}
+
+static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+    struct asus_wmi *asus = dev_get_drvdata(dev);
+    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
+							&asus->gpu_fan_curve.quiet,
+                            ASUS_THROTTLE_THERMAL_POLICY_SILENT);
+}
+
+static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
+
 /* Throttle thermal policy ****************************************************/
 
 static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
@@ -2067,6 +2460,53 @@ static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
 	return 0;
 }
 
+static int throttle_thermal_policy_write_cpu_curves(struct asus_wmi *asus)
+{
+	char *curve = NULL;
+	int err, mode;
+
+	mode = asus->throttle_thermal_policy_mode;
+
+	if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT) {
+		curve = asus->cpu_fan_curve.balanced;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST) {
+		curve = asus->cpu_fan_curve.performance;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT) {
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
+static int throttle_thermal_policy_write_gpu_curves(struct asus_wmi *asus)
+{
+	char *curve = NULL;
+	int err, mode;
+
+	mode = asus->throttle_thermal_policy_mode;
+
+	if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT) {
+		curve = asus->gpu_fan_curve.balanced;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST) {
+		curve = asus->gpu_fan_curve.performance;
+	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT) {
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
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
 	int err;
@@ -2092,6 +2532,26 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 		return -EIO;
 	}
 
+	if (asus->cpu_fan_curve_available) {
+		err = throttle_thermal_policy_write_cpu_curves(asus);
+		if (err) {
+			dev_warn(&asus->platform_device->dev,
+				"Failed to set custom CPU curve for thermal policy: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	if (asus->gpu_fan_curve_available) {
+		err = throttle_thermal_policy_write_gpu_curves(asus);
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
 
@@ -2711,6 +3171,12 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
+	&dev_attr_cpu_fan_curve_balanced.attr,
+	&dev_attr_cpu_fan_curve_performance.attr,
+	&dev_attr_cpu_fan_curve_quiet.attr,
+    &dev_attr_gpu_fan_curve_balanced.attr,
+	&dev_attr_gpu_fan_curve_performance.attr,
+	&dev_attr_gpu_fan_curve_quiet.attr,
 	&dev_attr_panel_od.attr,
 	NULL
 };
@@ -2741,6 +3207,18 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 
@@ -3016,6 +3494,16 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = custom_fan_check_present(asus, &asus->cpu_fan_curve_available,
+			ASUS_WMI_DEVID_CPU_FAN_CURVE);
+	if (err)
+		goto fail_throttle_fan_curve;
+
+    err = custom_fan_check_present(asus, &asus->gpu_fan_curve_available,
+			ASUS_WMI_DEVID_GPU_FAN_CURVE);
+	if (err)
+		goto fail_throttle_fan_curve;
+
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -3109,6 +3597,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
 fail_throttle_thermal_policy:
+fail_throttle_fan_curve:
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

