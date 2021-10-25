Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9AF43A086
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhJYTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:31:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:64788 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234722AbhJYT0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:26:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="230019504"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="230019504"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:20:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="664197756"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:20:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mf5W5-000wsP-Qa;
        Mon, 25 Oct 2021 22:20:17 +0300
Date:   Mon, 25 Oct 2021 22:20:17 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <YXcDcXrUo4a/KAsT@smile.fi.intel.com>
References: <20211022200032.23267-1-pauk.denis@gmail.com>
 <20211022200032.23267-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022200032.23267-2-pauk.denis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:00:29PM +0300, Denis Pauk wrote:
> Linux HWMON sensors driver for ASUS motherboards to read
> sensors from the embedded controller.
> 
> Many ASUS motherboards do not publish all the available
> sensors via the Super I/O chip but the missing ones are
> available through the embedded controller (EC) registers.
> 
> This driver implements reading those sensor data via the
> WMI method BREC, which is known to be present in all ASUS
> motherboards based on the AMD 500 series chipsets (and
> probably is available in other models too). The driver
> needs to know exact register addresses for the sensors and
> thus support for each motherboard has to be added explicitly.
> 
> The EC registers do not provide critical values for the
> sensors and as such they are not published to the HWMON.
> 
> Supported motherboards:
> * PRIME X570-PRO
> * Pro WS X570-ACE
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING

Below is a follow up, I have not compiled it.
Feel free to take fully or partially.

From 2128d5443cab11eed4710d30a5c477e3e95567cb Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 25 Oct 2021 19:13:38 +0300
Subject: [PATCH 1/1] hwmon: asus_wmi_ec_sensors: Multiple amendments

- Fix memory leaks in asus_wmi_ec_block_read()

- Fix buffer and parameter lengths in decode and encode algorithms

- Simplify encoding in read query

- Reshuffle structures to make pointer arithmetics simpler or
  no-op in some cases

- Shuffle parameters in some functions to make it more logical

- Use temporary variable for EC info data structure

- Many indentation fixes to improve readability (breaks 80 characters rule)

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/asus_wmi_ec_sensors.c | 244 ++++++++++++++--------------
 1 file changed, 122 insertions(+), 122 deletions(-)

diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
index 87bd32487926..870de5a7f20d 100644
--- a/drivers/hwmon/asus_wmi_ec_sensors.c
+++ b/drivers/hwmon/asus_wmi_ec_sensors.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * HWMON driver for ASUS B550/X570 motherboards that publish sensor
  * values via the embedded controller registers.
@@ -7,17 +7,17 @@
  * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
  *
  * EC provides:
- * Chipset temperature,
- * CPU temperature,
- * Motherboard temperature,
- * T_Sensor temperature,
- * VRM  temperature,
- * Water In temperature,
- * Water Out temperature,
- * CPU Optional Fan RPM,
- * Chipset Fan RPM,
- * Water Flow Fan RPM,
- * CPU current.
+ * - Chipset temperature
+ * - CPU temperature
+ * - Motherboard temperature
+ * - T_Sensor temperature
+ * - VRM temperature
+ * - Water In temperature
+ * - Water Out temperature
+ * - CPU Optional Fan RPM
+ * - Chipset Fan RPM
+ * - Water Flow Fan RPM
+ * - CPU current
  */
 
 #include <linux/acpi.h>
@@ -30,23 +30,25 @@
 #include <linux/nls.h>
 #include <linux/units.h>
 #include <linux/wmi.h>
+
 #include <asm/unaligned.h>
+
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 
-#define ASUSWMI_MONITORING_GUID	"466747A0-70EC-11DE-8A39-0800200C9A66"
+#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
 #define ASUSWMI_METHODID_BLOCK_READ_EC	0x42524543 /* BREC */
 /* From the ASUS DSDT source */
-#define ASUSWMI_BREC_REGISTERS_MAX	0x10
-#define ASUSWMI_MAX_BUF_LEN	0x80
-#define SENSOR_LABEL_LEN	0x10
+#define ASUSWMI_BREC_REGISTERS_MAX	16
+#define ASUSWMI_MAX_BUF_LEN		128
+#define SENSOR_LABEL_LEN		16
 
 static u32 hwmon_attributes[] = {
-	[hwmon_chip] = HWMON_C_REGISTER_TZ,
-	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
-	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
-	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
-	[hwmon_fan] = HWMON_F_INPUT | HWMON_F_LABEL,
+	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
+	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
+	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
+	[hwmon_curr]	= HWMON_C_INPUT | HWMON_C_LABEL,
+	[hwmon_fan]	= HWMON_F_INPUT | HWMON_F_LABEL,
 };
 
 struct asus_wmi_ec_sensor_address {
@@ -58,19 +60,19 @@ struct asus_wmi_ec_sensor_address {
 #define MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) {	\
 	.size = size_i,					\
 	.bank = bank_i,					\
-	.index = index_i				\
+	.index = index_i,				\
 }
 
 struct ec_sensor_info {
+	struct asus_wmi_ec_sensor_address addr;
 	char label[SENSOR_LABEL_LEN];
 	enum hwmon_sensor_types type;
-	struct asus_wmi_ec_sensor_address addr;
 };
 
 #define EC_SENSOR(sensor_label, sensor_type, size, bank, index) {	\
+	.addr = MAKE_SENSOR_ADDRESS(size, bank, index),			\
 	.label = sensor_label,						\
 	.type = sensor_type,						\
-	.addr = MAKE_SENSOR_ADDRESS(size, bank, index)			\
 }
 
 enum known_ec_sensor {
@@ -90,17 +92,17 @@ enum known_ec_sensor {
 
 /* All known sensors for ASUS EC controllers */
 static const struct ec_sensor_info known_ec_sensors[] = {
-	[SENSOR_TEMP_CHIPSET] = EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
-	[SENSOR_TEMP_CPU] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
-	[SENSOR_TEMP_MB] = EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
-	[SENSOR_TEMP_T_SENSOR] = EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
-	[SENSOR_TEMP_VRM] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
-	[SENSOR_FAN_CPU_OPT] = EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
-	[SENSOR_FAN_CHIPSET] = EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
-	[SENSOR_FAN_WATER_FLOW] = EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
-	[SENSOR_CURR_CPU] = EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
-	[SENSOR_TEMP_WATER_IN] = EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
-	[SENSOR_TEMP_WATER_OUT] = EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+	[SENSOR_TEMP_CHIPSET]	= EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
+	[SENSOR_TEMP_CPU]	= EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
+	[SENSOR_TEMP_MB]	= EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
+	[SENSOR_TEMP_T_SENSOR]	= EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
+	[SENSOR_TEMP_VRM]	= EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
+	[SENSOR_FAN_CPU_OPT]	= EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
+	[SENSOR_FAN_CHIPSET]	= EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
+	[SENSOR_FAN_WATER_FLOW]	= EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
+	[SENSOR_CURR_CPU]	= EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
+	[SENSOR_TEMP_WATER_IN]	= EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
+	[SENSOR_TEMP_WATER_OUT]	= EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
 };
 
 struct asus_wmi_data {
@@ -178,13 +180,12 @@ static struct asus_wmi_data sensors_board_RS_X570_E_G = {
 	},
 };
 
-#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, sensors) {	\
-	.matches = {						\
-		DMI_EXACT_MATCH(DMI_BOARD_VENDOR,		\
-				"ASUSTeK COMPUTER INC."),	\
-		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),		\
-	},							\
-	.driver_data = sensors,					\
+#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, sensors) {			\
+	.matches = {								\
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),	\
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),				\
+	},									\
+	.driver_data = sensors,							\
 }
 
 static const struct dmi_system_id asus_wmi_ec_dmi_table[] = {
@@ -207,11 +208,10 @@ struct ec_sensor {
 /**
  * struct asus_wmi_ec_info - sensor info.
  * @sensors: list of sensors.
- * @read_arg: UTF-16 string to pass to BRxx() WMI function.
+ * @read_arg: UTF-16LE string to pass to BRxx() WMI function.
  * @read_buffer: decoded output from WMI result.
  * @nr_sensors: number of board EC sensors.
- * @nr_registers: number of EC registers to read (sensor might span more than
- *                         1 register).
+ * @nr_registers: number of EC registers to read (sensor might span more than 1 register).
  * @last_updated: in jiffies.
  */
 struct asus_wmi_ec_info {
@@ -224,9 +224,9 @@ struct asus_wmi_ec_info {
 };
 
 struct asus_wmi_sensors {
+	struct asus_wmi_ec_info ec;
 	/* lock access to internal cache */
 	struct mutex lock;
-	struct asus_wmi_ec_info ec;
 };
 
 static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec,
@@ -238,7 +238,7 @@ static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec,
 	ec->nr_sensors = 0;
 	ec->nr_registers = 0;
 
-	for (i = 0; i < SENSOR_MAX && bsi[i] != SENSOR_MAX; i++) {
+	for (i = 0; bsi[i] != SENSOR_MAX; i++) {
 		s[i].info_index = bsi[i];
 		ec->nr_sensors++;
 		ec->nr_registers += known_ec_sensors[bsi[i]].addr.size;
@@ -248,62 +248,54 @@ static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec,
 }
 
 /*
- * The next four functions converts to/from BRxx string argument format.
+ * The next four functions convert to or from BRxx string argument format.
  * The format of the string is as follows:
- * * The string consists of two-byte UTF-16 characters.
- * * The value of the very first byte int the string is equal to the total
+ * - The string consists of two-byte UTF-16LE characters.
+ * - The value of the very first byte in the string is equal to the total
  *   length of the next string in bytes, thus excluding the first two-byte
  *   character.
- * * The rest of the string encodes pairs of (bank, index) pairs, where both
- *   values are byte-long (0x00 to 0xFF).
- * * Numbers are encoded as UTF-16 hex values.
+ * - The rest of the string encodes the pairs of (bank, index) pairs, where
+ *   both values are byte-long (0x00 to 0xFF).
+ * - Numbers are encoded as UTF-16LE hex values.
  */
-static int asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out, u32 length)
+static int asus_wmi_ec_decode_reply_buffer(const u8 *in, u32 length, u8 *out)
 {
 	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
-	const char *pos = buffer;
-	const u8 *data = inp + 2;
 	u32 len;
 
-	/* Minimum of size of response and size of ACPI result*/
-	len = min_t(u32, inp[0] / 4, (length - 2) / 4);
-	len = min_t(u32, len, ASUSWMI_MAX_BUF_LEN);
+	/* Minimum of size of response and size of ACPI result (in bytes) */
+	len = min_t(u32, in[0], length - 2);
 
-	utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
+	utf16s_to_utf8s((wchar_t *)(in + 2), len / 2, UTF16_LITTLE_ENDIAN, buffer, sizeof(buffer));
 
-	return hex2bin(out, pos, len);
+	return hex2bin(out, buffer, len / 2);
 }
 
-static void asus_wmi_ec_encode_registers(const u16 *registers, u8 len, char *out)
+static void asus_wmi_ec_encode_registers(const u8 *in, u32 length, char *out)
 {
 	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
-	char *pos = buffer;
-	unsigned int i;
-	u8 byte;
-
-	*out++ = len * 8;
-	*out++ = 0;
-
-	for (i = 0; i < len; i++) {
-		byte = registers[i] >> 8;
-		pos = bin2hex(pos, &byte, 1);
-		byte = registers[i];
-		pos = bin2hex(pos, &byte, 1);
-	}
+	u16 len = nr_registers * 2;
+
+	put_unaligned_le16(len * 2, out);
+
+	bin2hex(buffer, in, len);
 
-	utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN, (wchar_t *)out, len * 4);
+	utf8s_to_utf16s(buffer, len * 2, UTF16_LITTLE_ENDIAN, (wchar_t *)(out + 2), len);
 }
 
 static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
 {
-	u16 registers[ASUSWMI_BREC_REGISTERS_MAX];
+	u8 registers[ASUSWMI_BREC_REGISTERS_MAX * 2];
 	const struct ec_sensor_info *si;
-	int i, j, register_idx = 0;
+	int i, j, offset;
 
+	offset = 0;
 	for (i = 0; i < ec->nr_sensors; i++) {
 		si = &known_ec_sensors[ec->sensors[i].info_index];
-		for (j = 0; j < si->addr.size; j++, register_idx++)
-			registers[register_idx] = (si->addr.bank << 8) + si->addr.index + j;
+		for (j = 0; j < si->addr.size; j++) {
+			registers[offset++] = si->addr.bank;
+			registers[offset++] = si->addr.index + j;
+		}
 	}
 
 	asus_wmi_ec_encode_registers(registers, ec->nr_registers, ec->read_arg);
@@ -315,20 +307,28 @@ static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)
 	struct acpi_buffer input;
 	union acpi_object *obj;
 	acpi_status status;
+	int ret;
 
 	/* The first byte of the BRxx() argument string has to be the string size. */
 	input.length = query[0] + 2;
 	input.pointer = query;
-	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0,
-				     method_id, &input, &output);
+	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input, &output);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
 	obj = output.pointer;
-	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 2)
+	if (!obj)
 		return -EIO;
 
-	return asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out, obj->buffer.length);
+	ret = -EIO;
+	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 2)
+		goto out_free_obj;
+
+	ret = asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, obj->buffer.length, out);
+
+out_free_obj:
+	ACPI_FREE(obj);
+	return ret;
 }
 
 static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
@@ -348,8 +348,8 @@ static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
 static void asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info *ec)
 {
 	const struct ec_sensor_info *si;
-	u8 i_sensor;
 	struct ec_sensor *s;
+	u8 i_sensor;
 	u8 *data;
 
 	data = ec->read_buffer;
@@ -389,30 +389,30 @@ static int asus_wmi_ec_find_sensor_index(const struct asus_wmi_ec_info *ec,
 	return -EINVAL;
 }
 
-static int asus_wmi_ec_get_cached_value_or_update(int sensor_index,
-						  struct asus_wmi_sensors *state,
+static int asus_wmi_ec_get_cached_value_or_update(struct asus_wmi_sensors *sensor_data,
+						  int sensor_index,
 						  u32 *value)
 {
+	struct asus_wmi_ec_info *ec = &sensor_data->ec;
 	int ret;
 
-	mutex_lock(&state->lock);
+	mutex_lock(&sensor_data->lock);
 
-	if (time_after(jiffies, state->ec.last_updated + HZ)) {
+	if (time_after(jiffies, ec->last_updated + HZ)) {
 		ret = asus_wmi_ec_block_read(ASUSWMI_METHODID_BLOCK_READ_EC,
-					     state->ec.read_arg,
-					     state->ec.read_buffer);
+					     ec->read_arg, ec->read_buffer);
 		if (ret) {
-			mutex_unlock(&state->lock);
+			mutex_unlock(&sensors_data->lock);
 			return ret;
 		}
 
-		asus_wmi_ec_update_ec_sensors(&state->ec);
-		state->ec.last_updated = jiffies;
+		asus_wmi_ec_update_ec_sensors(ec);
+		ec->last_updated = jiffies;
 	}
 
-	*value = state->ec.sensors[sensor_index].cached_value;
+	*value = ec->sensors[sensor_index].cached_value;
 
-	mutex_unlock(&state->lock);
+	mutex_unlock(&sensor_data->lock);
 
 	return 0;
 }
@@ -423,20 +423,20 @@ static int asus_wmi_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types ty
 				  u32 attr, int channel, long *val)
 {
 	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
+	struct asus_wmi_ec_info *ec = &sensor_data->ec;
 	int ret, sidx, info_index;
 	u32 value = 0;
 
-	sidx = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
+	sidx = asus_wmi_ec_find_sensor_index(ec, type, channel);
 	if (sidx < 0)
 		return sidx;
 
-	ret = asus_wmi_ec_get_cached_value_or_update(sidx, sensor_data, &value);
+	ret = asus_wmi_ec_get_cached_value_or_update(sensor_data, sidx, &value);
 	if (ret)
 		return ret;
 
-	info_index = sensor_data->ec.sensors[sidx].info_index;
-	*val = asus_wmi_ec_scale_sensor_value(value,
-					      known_ec_sensors[info_index].type);
+	info_index = ec->sensors[sidx].info_index;
+	*val = asus_wmi_ec_scale_sensor_value(value, known_ec_sensors[info_index].type);
 
 	return ret;
 }
@@ -446,10 +446,11 @@ static int asus_wmi_ec_hwmon_read_string(struct device *dev,
 					 int channel, const char **str)
 {
 	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
+	struct asus_wmi_ec_info *ec = &sensor_data->ec;
 	int sensor_index;
 
-	sensor_index = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
-	*str = known_ec_sensors[sensor_data->ec.sensors[sensor_index].info_index].label;
+	sensor_index = asus_wmi_ec_find_sensor_index(ec, type, channel);
+	*str = known_ec_sensors[ec->sensors[sensor_index].info_index].label;
 
 	return 0;
 }
@@ -459,9 +460,10 @@ static umode_t asus_wmi_ec_hwmon_is_visible(const void *drvdata,
 					    int channel)
 {
 	const struct asus_wmi_sensors *sensor_data = drvdata;
+	struct asus_wmi_ec_info *ec = &sensor_data->ec;
 	int index;
 
-	index = asus_wmi_ec_find_sensor_index(&sensor_data->ec, type, channel);
+	index = asus_wmi_ec_find_sensor_index(ec, type, channel);
 
 	return index < 0 ? 0 : 0444;
 }
@@ -494,11 +496,12 @@ static struct hwmon_chip_info asus_wmi_ec_chip_info = {
 };
 
 static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
-					      struct asus_wmi_sensors *sensor_data,
 					      const enum known_ec_sensor *bsi)
 {
+	struct asus_wmi_sensors *sensor_data = dev_get_drvdata(dev);
+	struct asus_wmi_ec_info *ec = &sensor_data->ec;
 	struct hwmon_channel_info *asus_wmi_hwmon_chan;
-	const struct hwmon_channel_info **ptr_asus_wmi_ci;
+	const struct hwmon_channel_info **asus_wmi_ci;
 	int nr_count[hwmon_max] = {}, nr_types = 0;
 	const struct hwmon_chip_info *chip_info;
 	const struct ec_sensor_info *si;
@@ -506,15 +509,15 @@ static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
 	struct device *hwdev;
 	int i, ret;
 
-	ret = asus_wmi_ec_fill_board_sensors(&sensor_data->ec, bsi);
+	ret = asus_wmi_ec_fill_board_sensors(ec, bsi);
 	if (ret)
 		return ret;
 
 	if (!sensor_data->ec.nr_sensors)
 		return -ENODEV;
 
-	for (i = 0; i < sensor_data->ec.nr_sensors; i++) {
-		si = &known_ec_sensors[sensor_data->ec.sensors[i].info_index];
+	for (i = 0; i < ec->nr_sensors; i++) {
+		si = &known_ec_sensors[ec->sensors[i].info_index];
 		if (!nr_count[si->type])
 			nr_types++;
 		nr_count[si->type]++;
@@ -529,20 +532,18 @@ static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
 	 * If we can get values for all the registers in a single query,
 	 * the query will not change from call to call.
 	 */
-	asus_wmi_ec_make_block_read_query(&sensor_data->ec);
+	asus_wmi_ec_make_block_read_query(ec);
 
-	asus_wmi_hwmon_chan = devm_kcalloc(dev, nr_types,
-					   sizeof(*asus_wmi_hwmon_chan),
+	asus_wmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*asus_wmi_hwmon_chan),
 					   GFP_KERNEL);
 	if (!asus_wmi_hwmon_chan)
 		return -ENOMEM;
 
-	ptr_asus_wmi_ci = devm_kcalloc(dev, nr_types + 1,
-				       sizeof(*ptr_asus_wmi_ci), GFP_KERNEL);
-	if (!ptr_asus_wmi_ci)
+	asus_wmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*asus_wmi_ci), GFP_KERNEL);
+	if (!asus_wmi_ci)
 		return -ENOMEM;
 
-	asus_wmi_ec_chip_info.info = ptr_asus_wmi_ci;
+	asus_wmi_ec_chip_info.info = asus_wmi_ci;
 	chip_info = &asus_wmi_ec_chip_info;
 
 	for (type = 0; type < hwmon_max; type++) {
@@ -555,12 +556,11 @@ static int asus_wmi_ec_configure_sensor_setup(struct device *dev,
 		if (ret)
 			return ret;
 
-		*ptr_asus_wmi_ci++ = asus_wmi_hwmon_chan++;
+		*asus_wmi_ci++ = asus_wmi_hwmon_chan++;
 	}
 
 	dev_dbg(dev, "board has %d EC sensors that span %d registers",
-		sensor_data->ec.nr_sensors,
-		sensor_data->ec.nr_registers);
+		ec->nr_sensors, ec->nr_registers);
 
 	hwdev = devm_hwmon_device_register_with_info(dev, "asus_wmi_ec_sensors",
 						     sensor_data, chip_info, NULL);
@@ -572,8 +572,8 @@ static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct asus_wmi_sensors *sensor_data;
 	struct asus_wmi_data *board_sensors;
-	const enum known_ec_sensor *bsi;
 	const struct dmi_system_id *dmi_id;
+	const enum known_ec_sensor *bsi;
 	struct device *dev = &wdev->dev;
 
 	dmi_id = dmi_first_match(asus_wmi_ec_dmi_table);
@@ -591,11 +591,11 @@ static int asus_wmi_probe(struct wmi_device *wdev, const void *context)
 		return -ENOMEM;
 
 	mutex_init(&sensor_data->lock);
+	sensor_data->dev = dev;
 
 	dev_set_drvdata(dev, sensor_data);
 
-	return asus_wmi_ec_configure_sensor_setup(dev,
-						  sensor_data, bsi);
+	return asus_wmi_ec_configure_sensor_setup(dev, bsi);
 }
 
 static const struct wmi_device_id asus_ec_wmi_id_table[] = {
-- 
2.33.0



-- 
With Best Regards,
Andy Shevchenko


