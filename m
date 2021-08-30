Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAAB3FB49E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhH3Lcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:32:45 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46051 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236496AbhH3Lco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:32:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id BCAF33200954;
        Mon, 30 Aug 2021 07:31:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Aug 2021 07:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cJ47mKhS1WR6Lt4wRG1v2N6QjxIV/UuvvmqI1cxcJBQ=; b=Y5lyEUg/
        M3rfK5t+cvW8rs1x9HRL91DEoRYBcL1nwGAJX5TEXEoZAN19GgdLBUvzC+EFph4d
        igylBZdekG7Fijfnsqqn0WldCJfp/lY9ulIjlRFqn8Ov4yfNFQyA0/tuArLXId7g
        2MUcjzpDP9ugVKsSWGIEzyI2oQPGggWluZr7uqgP3PsZVqHLhxxK+pn0gY/ymv5m
        u86PFlanKLUV1+khmmaT9Edsenfitn0GOCgzHBhHZMSBEFWTYRuBV98qJ6W5MVWD
        0He1fuzKyHB+iBcyhh9GV6Qh7AIyWrQMl607crV7q75JMcp/7QFy/4ksYoVFafQA
        tHsW1bv7lXVV/g==
X-ME-Sender: <xms:psEsYZ2bunFmmsF8ozQ0kA7-k_FyPDCXChsneJs8oGDhpBfZ5DGYWw>
    <xme:psEsYQFs9fbvnoPeCs5OFImpjt6zRkkFLNzGX8dRMMwLPgxdypWx41cQ6dh1StywZ
    Z5qLD95vcsht2DtkLY>
X-ME-Received: <xmr:psEsYZ461Asy-2uj5Tfq63Vcr6WmIXVc73AGj3QJsgixQTNx_BDwWudX1fvV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpedvteekvdeuhedthfeuudelheejie
    fhvddtteelleeghfekhfeugfehgeekffdtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:psEsYW1VkggonjrqFXy492CU9aeqKtiqXxxNbHy2fN4woCe9Sz_cBA>
    <xmx:psEsYcERzqGS9o3TXOR_j2vhqf-2mZwmKwGzo-T4EvLCiyDDsfcNFg>
    <xmx:psEsYX-Rg0XUpzk7P7KQCU09vej0tM9VQrVViC_BCXxeJQMxuPCZ5Q>
    <xmx:psEsYQAIV3tCozmqXR-B3QpqKGBNpwd8sixLd62PAJoIn6QEOF2LqA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Aug 2021 07:31:47 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v7] asus-wmi: Add support for custom fan curves
Date:   Mon, 30 Aug 2021 23:31:37 +1200
Message-Id: <20210830113137.1338683-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830113137.1338683-1-luke@ljones.dev>
References: <20210830113137.1338683-1-luke@ljones.dev>
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

This patch adds two blocks of attributes to the hwmon sysfs,
1 block each for CPU and GPU fans.

When the user switches profiles the associated curve data for that
profile is then show/store enabled to allow users to rotate through
the profiles and set a fan curve for each profile which then
activates on profile switch if enabled.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 568 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 566 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cc5811844012..b594c2475034 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -106,8 +106,18 @@ module_param(fnlock_default, bool, 0444);
 
 #define WMI_EVENT_MASK			0xFFFF
 
+/* The number of ASUS_THROTTLE_THERMAL_POLICY_* available */
+#define FAN_CURVE_PROFILE_NUM	(ASUS_THROTTLE_THERMAL_POLICY_SILENT + 1)
+#define FAN_CURVE_POINTS		8
+#define FAN_CURVE_DEV_CPU		0x00
+#define FAN_CURVE_DEV_GPU		0x01
+/* Mask to determine if setting temperature or percentage */
+#define FAN_CURVE_PWM_MASK		0x04
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
+static int throttle_thermal_policy_write(struct asus_wmi *);
+
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -122,7 +132,8 @@ struct bios_args {
 	u32 arg0;
 	u32 arg1;
 	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
-	u32 arg4;
+	u32 arg3;
+	u32 arg4; /* Some ROG laptops require a full 5 input args */
 	u32 arg5;
 } __packed;
 
@@ -173,6 +184,17 @@ enum fan_type {
 	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
 };
 
+/*
+ * The related ACPI method for testing availability also returns the factory
+ * default fan curves. We save them here so that a user can reset custom
+ * settings if required.
+ */
+struct fan_curve_data {
+	bool enabled;
+	u8 temps[FAN_CURVE_POINTS];
+	u8 percents[FAN_CURVE_POINTS];
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -220,6 +242,11 @@ struct asus_wmi {
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
+	bool cpu_fan_curve_available;
+	bool gpu_fan_curve_available;
+	/* [throttle modes][fan count] */
+	struct fan_curve_data throttle_fan_curves[FAN_CURVE_PROFILE_NUM][2];
+
 	struct platform_profile_handler platform_profile_handler;
 	bool platform_profile_support;
 
@@ -285,6 +312,84 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
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
+ */
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
+	if (obj && obj->type == ACPI_TYPE_BUFFER)
+		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
+
+	kfree(obj);
+
+	return 0;
+}
+
 static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 {
 	struct acpi_buffer input;
@@ -2043,6 +2148,440 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
 static DEVICE_ATTR_RW(fan_boost_mode);
 
+/* Custom fan curves per-profile **********************************************/
+
+static void init_fan_curve(struct fan_curve_data *data, u8 *buf)
+{
+	int i;
+
+	for (i = 0; i < FAN_CURVE_POINTS; i++)
+		data->temps[i] = buf[i];
+
+	for (i = 0; i < FAN_CURVE_POINTS; i++)
+		data->percents[i] = buf[i + 8];
+}
+
+/*
+ * Check if the ability to set fan curves on either fan exists, and populate
+ * with system defaults to provide users with a starting point.
+ *
+ * "dev" is either CPU_FAN_CURVE or GPU_FAN_CURVE.
+ */
+static int custom_fan_check_present(struct asus_wmi *asus,
+				    bool *available, u32 dev)
+{
+	struct fan_curve_data *curves;
+	u8 buf[FAN_CURVE_POINTS * 2];
+	int fan_idx = 0;
+	int err;
+
+	*available = false;
+	if (dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
+		fan_idx = 1;
+
+	/* Balanced default */
+	curves = &asus->throttle_fan_curves
+			[ASUS_THROTTLE_THERMAL_POLICY_DEFAULT][fan_idx];
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, buf);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+	init_fan_curve(curves, buf);
+
+	/*
+	 * Quiet default. The index num for ACPI method does not match the
+	 * throttle_thermal number, same for Performance.
+	 */
+	curves = &asus->throttle_fan_curves
+			[ASUS_THROTTLE_THERMAL_POLICY_SILENT][fan_idx];
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, buf);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+	init_fan_curve(curves, buf);
+
+	/* Performance default */
+	curves = &asus->throttle_fan_curves
+			[ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST][fan_idx];
+	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, buf);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+	init_fan_curve(curves, buf);
+
+	*available = true;
+	return 0;
+}
+
+static struct fan_curve_data *fan_curve_attr_data_select(struct device *dev,
+				struct device_attribute *attr)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->throttle_thermal_policy_mode;
+
+	int nr = to_sensor_dev_attr_2(attr)->nr;
+	int fan = nr & FAN_CURVE_DEV_GPU;
+
+	return &asus->throttle_fan_curves[mode][fan];
+}
+
+static ssize_t fan_curve_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct fan_curve_data *data = fan_curve_attr_data_select(dev, attr);
+	int value;
+
+	int index = to_sensor_dev_attr_2(attr)->index;
+	int nr = to_sensor_dev_attr_2(attr)->nr;
+	int pwm = nr & FAN_CURVE_PWM_MASK;
+
+	if (pwm)
+		value = 255 * data->percents[index] / 100;
+	else
+		value = data->temps[index];
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+/*
+ * "dev" is the related WMI method such as ASUS_WMI_DEVID_CPU_FAN_CURVE.
+ */
+static int fan_curve_write(struct asus_wmi *asus, u32 dev,
+					struct fan_curve_data *data)
+{
+	int ret, i, shift = 0;
+	u32 arg1, arg2, arg3, arg4;
+
+	arg1 = arg2 = arg3 = arg4 = 0;
+
+	for (i = 0; i < FAN_CURVE_POINTS / 2; i++) {
+		arg1 += data->temps[i] << shift;
+		arg2 += data->temps[i + 4] << shift;
+		arg3 += data->percents[0] << shift;
+		arg4 += data->percents[i + 4] << shift;
+		shift += 8;
+	}
+
+	return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
+					arg1, arg2, arg3, arg4, &ret);
+}
+
+/*
+ * Called only by throttle_thermal_policy_write()
+ */
+static int fan_curve_write_data(struct asus_wmi *asus)
+{
+	struct fan_curve_data *cpu;
+	struct fan_curve_data *gpu;
+	int err, mode;
+
+	mode = asus->throttle_thermal_policy_mode;
+	cpu = &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_CPU];
+	gpu = &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_GPU];
+
+	if (cpu->enabled) {
+		err = fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, cpu);
+		if (err)
+			return err;
+	}
+
+	if (gpu->enabled) {
+		err = fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, gpu);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int fan_curve_verify(struct fan_curve_data *data)
+{
+	int i = 0;
+	u8 tmp = 0;
+	u8 prev_tmp = 0;
+
+
+	for (i = 0; i < FAN_CURVE_POINTS; i++) {
+		tmp = data->temps[i];
+		if (tmp < prev_tmp)
+			return -EINVAL;
+		prev_tmp = tmp;
+	}
+
+	tmp = 0;
+	prev_tmp = 0;
+	for (i = 0; i < FAN_CURVE_POINTS; i++) {
+		tmp = data->percents[i];
+		if (tmp < prev_tmp)
+			return -EINVAL;
+		prev_tmp = tmp;
+	}
+
+	return 0;
+}
+
+static ssize_t fan_curve_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct fan_curve_data *data = fan_curve_attr_data_select(dev, attr);
+	u8 value, old_value;
+	int err;
+
+	int index = to_sensor_dev_attr_2(attr)->index;
+	int nr = to_sensor_dev_attr_2(attr)->nr;
+	int pwm = nr & FAN_CURVE_PWM_MASK;
+
+	err = kstrtou8(buf, 10, &value);
+	if (err < 0)
+		return err;
+
+	if (pwm) {
+		old_value = data->percents[index];
+		data->percents[index] = 100 * value / 255;
+	} else {
+		old_value = data->temps[index];
+		data->temps[index] = value;
+	}
+	/*
+	 * The check here forces writing a curve graph in reverse,
+	 * from highest to lowest.
+	 */
+	err = fan_curve_verify(data);
+	if (err) {
+		if (pwm) {
+			dev_err(dev, "a fan curve percentage was higher than the next in sequence\n");
+			data->percents[index] = old_value;
+		} else {
+			dev_err(dev, "a fan curve temperature was higher than the next in sequence\n");
+			data->temps[index] = old_value;
+		}
+		return err;
+	}
+
+	return count;
+}
+
+static ssize_t fan_curve_enable_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct fan_curve_data *data = fan_curve_attr_data_select(dev, attr);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", data->enabled);
+}
+
+static ssize_t fan_curve_enable_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct fan_curve_data *data = fan_curve_attr_data_select(dev, attr);
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	err = kstrtobool(buf, &value);
+	if (err < 0)
+		return err;
+
+	data->enabled = value;
+	throttle_thermal_policy_write(asus);
+
+	return count;
+}
+
+/* CPU */
+// TODO: enable
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, fan_curve_enable,
+				FAN_CURVE_DEV_CPU);
+// (name, function, fan, point) TODO: need to mask if temp or percent
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point6_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point7_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_temp, fan_curve,
+				FAN_CURVE_DEV_CPU, 7);
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point6_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point7_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_pwm, fan_curve,
+			FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 7);
+
+/* GPU */
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, fan_curve_enable,
+				FAN_CURVE_DEV_GPU);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point5_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point6_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point7_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_temp, fan_curve,
+				FAN_CURVE_DEV_GPU, 7);
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point5_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point6_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point7_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_pwm, fan_curve,
+			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
+
+static struct attribute *fan_curve_attributes[] = {
+	/* CPU */
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point6_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point7_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point8_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point6_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point7_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point8_pwm.dev_attr.attr,
+	/* GPU */
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point5_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point6_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point7_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point8_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point5_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point6_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point7_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point8_pwm.dev_attr.attr,
+	NULL
+};
+
+static umode_t fan_curve_sysfs_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int idx)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct asus_wmi *asus = dev_get_drvdata(dev->parent);
+
+	if (attr == &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point6_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point7_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point8_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point6_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point7_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm1_auto_point8_pwm.dev_attr.attr) {
+		if (!asus->cpu_fan_curve_available)
+			return 0;
+	}
+
+	if (attr == &sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point5_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point6_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point7_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point8_temp.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point4_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point5_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point6_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point7_pwm.dev_attr.attr
+	|| attr == &sensor_dev_attr_pwm2_auto_point8_pwm.dev_attr.attr) {
+		if (!asus->gpu_fan_curve_available)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group fan_curve_attribute_group = {
+	.is_visible = fan_curve_sysfs_is_visible,
+	.attrs = fan_curve_attributes
+};
+__ATTRIBUTE_GROUPS(fan_curve_attribute);
+
+static int asus_wmi_fan_curve_init(struct asus_wmi *asus)
+{
+	struct device *dev = &asus->platform_device->dev;
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_groups(dev, "asus", asus,
+						fan_curve_attribute_groups);
+
+	if (IS_ERR(hwmon)) {
+		pr_err("Could not register asus fan_curve device\n");
+		return PTR_ERR(hwmon);
+	}
+
+	return 0;
+}
+
 /* Throttle thermal policy ****************************************************/
 
 static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
@@ -2053,8 +2592,8 @@ static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
 	asus->throttle_thermal_policy_available = false;
 
 	err = asus_wmi_get_devstate(asus,
-				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
-				    &result);
+		ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+		&result);
 	if (err) {
 		if (err == -ENODEV)
 			return 0;
@@ -2092,6 +2631,12 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 		return -EIO;
 	}
 
+	if (asus->cpu_fan_curve_available || asus->gpu_fan_curve_available) {
+		err = fan_curve_write_data(asus);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -2904,7 +3449,7 @@ static int show_call(struct seq_file *m, void *data)
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	obj = (union acpi_object *)output.pointer;
+	obj = output.pointer;
 	if (obj && obj->type == ACPI_TYPE_INTEGER)
 		seq_printf(m, "%#x(%#x, %#x) = %#x\n", asus->debug.method_id,
 			   asus->debug.dev_id, asus->debug.ctrl_param,
@@ -3016,6 +3561,16 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else
 		throttle_thermal_policy_set_default(asus);
 
+	err = custom_fan_check_present(asus, &asus->cpu_fan_curve_available,
+				       ASUS_WMI_DEVID_CPU_FAN_CURVE);
+	if (err)
+		goto fail_custom_fan_curve;
+
+	err = custom_fan_check_present(asus, &asus->gpu_fan_curve_available,
+				       ASUS_WMI_DEVID_GPU_FAN_CURVE);
+	if (err)
+		goto fail_custom_fan_curve;
+
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -3038,6 +3593,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_hwmon;
 
+	err = asus_wmi_fan_curve_init(asus);
+	if (err)
+		goto fail_custom_fan_curve;
+
 	err = asus_wmi_led_init(asus);
 	if (err)
 		goto fail_leds;
@@ -3109,6 +3668,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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

