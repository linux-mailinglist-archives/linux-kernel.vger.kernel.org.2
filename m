Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76CB33BF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhCOPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:03:23 -0400
Received: from mout01.posteo.de ([185.67.36.65]:38062 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236970AbhCOPDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:03:00 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 448AD160063
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:02:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615820576; bh=wQSeOQR1BHYRV+TkRIXFCfPdxDa8ckCKtMrMa0uVmrA=;
        h=Date:From:To:Cc:Subject:From;
        b=M2u97yZC8emFlhrafaPOr4HopPYh5xqDNYlcjMesMEbCtTxOjYCQJnDrqFiGhpZFQ
         lbINr6tUmI+RSiI3wJIgQNTrrptv3flXqr+Igw/x6x7mfORhmXQVccEwd+aCl629k2
         pFs5ny8mqAQe/laDJeQ6fAznKYrbp96bDWirczfk+FCWM7Kgqdm3cd2yuvVGi9+t7+
         pLXDFVcgwHDBOzrt8phdRK3R6rDYpjP6hKEpqUXhtcS4fqaL66MgxKeetmJpZn55jV
         ZqmiaOmkuZje23FgwQnbvCcVzatyu6muGmFJCjyzOTW8a0P8VrVezDnpjzvnx58MFX
         LKx1HAdM+MXYA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dzfmb03X7z6tmT;
        Mon, 15 Mar 2021 16:02:54 +0100 (CET)
Date:   Mon, 15 Mar 2021 16:02:53 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: corsair-psu: add support for critical values
Message-ID: <YE93HebFD0acwZIX@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for reading the critical values of the temperature sensors
and the rail sensors (voltage and current) once and caches them. Updates
the naming of the constants following a more clear scheme. Also updates
the documentation and fixes a typo.

The new sensors output of a Corsair HX850i will look like this:
corsairpsu-hid-3-1
Adapter: HID adapter
v_in:        230.00 V
v_out +12v:   12.14 V  (crit min =  +8.41 V, crit max = +15.59 V)
v_out +5v:     5.03 V  (crit min =  +3.50 V, crit max =  +6.50 V)
v_out +3.3v:   3.30 V  (crit min =  +2.31 V, crit max =  +4.30 V)
psu fan:        0 RPM
vrm temp:     +46.2�C  (crit = +70.0�C)
case temp:    +39.8�C  (crit = +70.0�C)
power total: 152.00 W
power +12v:  108.00 W
power +5v:    41.00 W
power +3.3v:   5.00 W
curr in:          N/A
curr +12v:     9.00 A  (crit max = +85.00 A)
curr +5v:      8.31 A  (crit max = +40.00 A)
curr +3.3v:    1.62 A  (crit max = +40.00 A)

This patch changes:
- hwmon corsair-psu documentation
- hwmon corsair-psu driver

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v2:
  - simplified reading/caching of critical values and hwmon_ops_read function
  - removed unnecessary debug output and comments
---
 Documentation/hwmon/corsair-psu.rst |  13 +-
 drivers/hwmon/corsair-psu.c         | 223 +++++++++++++++++++++-------
 2 files changed, 185 insertions(+), 51 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index 396b95c9a76a..b77e53810a13 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -45,19 +45,30 @@ Sysfs entries
 -------------
 
 =======================	========================================================
+curr2_crit		Current max critical value on the 12v psu rail
+curr3_crit		Current max critical value on the 5v psu rail
+curr4_crit		Current max critical value on the 3.3v psu rail
 curr1_input		Total current usage
 curr2_input		Current on the 12v psu rail
 curr3_input		Current on the 5v psu rail
 curr4_input		Current on the 3.3v psu rail
 fan1_input		RPM of psu fan
+in1_crit		Voltage max critical value on the 12v psu rail
+in2_crit		Voltage max critical value on the 5v psu rail
+in3_crit		Voltage max critical value on the 3.3v psu rail
 in0_input		Voltage of the psu ac input
 in1_input		Voltage of the 12v psu rail
 in2_input		Voltage of the 5v psu rail
-in3_input		Voltage of the 3.3 psu rail
+in3_input		Voltage of the 3.3v psu rail
+in1_lcrit		Voltage min critical value on the 12v psu rail
+in2_lcrit		Voltage min critical value on the 5v psu rail
+in3_lcrit		Voltage min critical value on the 3.3v psu rail
 power1_input		Total power usage
 power2_input		Power usage of the 12v psu rail
 power3_input		Power usage of the 5v psu rail
 power4_input		Power usage of the 3.3v psu rail
+temp1_crit		Temperature max cirtical value of the psu vrm component
+temp2_crit		Temperature max critical value of psu case
 temp1_input		Temperature of the psu vrm component
 temp2_input		Temperature of the psu case
 =======================	========================================================
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index b0953eeeb2d3..a176ac6a2540 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -53,11 +53,17 @@
 #define CMD_TIMEOUT_MS		250
 #define SECONDS_PER_HOUR	(60 * 60)
 #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
+#define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
+#define TEMP_COUNT		2
 
 #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
-#define PSU_CMD_IN_VOLTS	0x88 /* the rest of the commands expect length 3 */
+#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
+#define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
+#define PSU_CMD_RAIL_AMPS_HCRIT	0x46
+#define PSU_CMD_TEMP_HCRIT	0x4F
+#define PSU_CMD_IN_VOLTS	0x88
 #define PSU_CMD_IN_AMPS		0x89
-#define PSU_CMD_RAIL_OUT_VOLTS	0x8B
+#define PSU_CMD_RAIL_VOLTS	0x8B
 #define PSU_CMD_RAIL_AMPS	0x8C
 #define PSU_CMD_TEMP0		0x8D
 #define PSU_CMD_TEMP1		0x8E
@@ -116,6 +122,14 @@ struct corsairpsu_data {
 	u8 *cmd_buffer;
 	char vendor[REPLY_SIZE];
 	char product[REPLY_SIZE];
+	long temp_crit[TEMP_COUNT];
+	long in_crit[RAIL_COUNT];
+	long in_lcrit[RAIL_COUNT];
+	long curr_crit[RAIL_COUNT];
+	u8 temp_crit_support;
+	u8 in_crit_support;
+	u8 in_lcrit_support;
+	u8 curr_crit_support;
 };
 
 /* some values are SMBus LINEAR11 data which need a conversion */
@@ -193,7 +207,10 @@ static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, voi
 
 	mutex_lock(&priv->lock);
 	switch (cmd) {
-	case PSU_CMD_RAIL_OUT_VOLTS:
+	case PSU_CMD_RAIL_VOLTS_HCRIT:
+	case PSU_CMD_RAIL_VOLTS_LCRIT:
+	case PSU_CMD_RAIL_AMPS_HCRIT:
+	case PSU_CMD_RAIL_VOLTS:
 	case PSU_CMD_RAIL_AMPS:
 	case PSU_CMD_RAIL_WATTS:
 		ret = corsairpsu_usb_cmd(priv, 2, PSU_CMD_SELECT_RAIL, rail, NULL);
@@ -229,9 +246,13 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	 */
 	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
 	switch (cmd) {
+	case PSU_CMD_RAIL_VOLTS_HCRIT:
+	case PSU_CMD_RAIL_VOLTS_LCRIT:
+	case PSU_CMD_RAIL_AMPS_HCRIT:
+	case PSU_CMD_TEMP_HCRIT:
 	case PSU_CMD_IN_VOLTS:
 	case PSU_CMD_IN_AMPS:
-	case PSU_CMD_RAIL_OUT_VOLTS:
+	case PSU_CMD_RAIL_VOLTS:
 	case PSU_CMD_RAIL_AMPS:
 	case PSU_CMD_TEMP0:
 	case PSU_CMD_TEMP1:
@@ -256,75 +277,175 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	return ret;
 }
 
+static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
+{
+	long tmp;
+	int ret;
+	u8 rail;
+
+	priv->temp_crit_support = 0;
+	priv->in_lcrit_support = 0;
+	priv->in_crit_support = 0;
+	priv->curr_crit_support = 0;
+
+	for (rail = 0; rail < TEMP_COUNT; ++rail) {
+		ret = corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp);
+		if (ret == 0) {
+			priv->temp_crit_support |= BIT(rail);
+			priv->temp_crit[rail] = tmp;
+		}
+	}
+
+	for (rail = 0; rail < RAIL_COUNT; ++rail) {
+		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp);
+		if (ret == 0) {
+			priv->in_crit_support |= BIT(rail);
+			priv->in_crit[rail] = tmp;
+		}
+
+		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp);
+		if (ret == 0) {
+			priv->in_lcrit_support |= BIT(rail);
+			priv->in_lcrit[rail] = tmp;
+		}
+
+		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp);
+		if (ret == 0) {
+			priv->curr_crit_support |= BIT(rail);
+			priv->curr_crit[rail] = tmp;
+		}
+	}
+}
+
 static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
 					       u32 attr, int channel)
 {
-	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label))
+	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label ||
+				   attr == hwmon_temp_crit))
 		return 0444;
 	else if (type == hwmon_fan && (attr == hwmon_fan_input || attr == hwmon_fan_label))
 		return 0444;
 	else if (type == hwmon_power && (attr == hwmon_power_input || attr == hwmon_power_label))
 		return 0444;
-	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label))
+	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label ||
+				      attr == hwmon_in_lcrit || attr == hwmon_in_crit))
 		return 0444;
-	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label))
+	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label ||
+					attr == hwmon_curr_crit))
 		return 0444;
 
 	return 0;
 }
 
-static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
-				     int channel, long *val)
+static int corsairpsu_hwmon_temp(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
 {
-	struct corsairpsu_data *priv = dev_get_drvdata(dev);
-	int ret;
+	int err = -EOPNOTSUPP;
+
+	if (channel < 2) {
+		switch (attr) {
+		case hwmon_temp_input:
+			return corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0,
+						    channel, val);
+		case hwmon_temp_crit:
+			if (priv->temp_crit_support & BIT(channel)) {
+				*val = priv->temp_crit[channel];
+				err = 0;
+			}
+		}
+	}
 
-	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
-		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
-					   val);
-	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
-		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
-	} else if (type == hwmon_power && attr == hwmon_power_input) {
+	return err;
+}
+
+static int corsairpsu_hwmon_power(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
+{
+	if (attr == hwmon_power_input) {
 		switch (channel) {
 		case 0:
-			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
-			break;
+			return corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
 		case 1 ... 3:
-			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);
-			break;
-		default:
-			return -EOPNOTSUPP;
+			return corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);
 		}
-	} else if (type == hwmon_in && attr == hwmon_in_input) {
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int corsairpsu_hwmon_in(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (attr) {
+	case hwmon_in_input:
 		switch (channel) {
 		case 0:
-			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
-			break;
+			return corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
 		case 1 ... 3:
-			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, val);
-			break;
-		default:
-			return -EOPNOTSUPP;
+			return corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1, val);
+		}
+		break;
+	case hwmon_in_crit:
+		if (priv->in_crit_support & BIT(channel - 1)) {
+			*val = priv->in_crit[channel - 1];
+			err = 0;
 		}
-	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
+		break;
+	case hwmon_in_lcrit:
+		if (priv->in_lcrit_support & BIT(channel - 1)) {
+			*val = priv->in_lcrit[channel - 1];
+			err = 0;
+		}
+		break;
+	}
+
+	return err;
+}
+
+static int corsairpsu_hwmon_curr(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (attr) {
+	case hwmon_curr_input:
 		switch (channel) {
 		case 0:
-			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
-			break;
+			return corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
 		case 1 ... 3:
-			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
-			break;
-		default:
-			return -EOPNOTSUPP;
+			return corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
 		}
-	} else {
-		return -EOPNOTSUPP;
+		break;
+	case hwmon_curr_crit:
+		if (priv->curr_crit_support & BIT(channel - 1)) {
+			*val = priv->curr_crit[channel - 1];
+			err = 0;
+		}
+		break;
 	}
 
-	if (ret < 0)
-		return ret;
+	return err;
+}
 
-	return 0;
+static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+				     int channel, long *val)
+{
+	struct corsairpsu_data *priv = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		return corsairpsu_hwmon_temp(priv, attr, channel, val);
+	case hwmon_fan:
+		if (attr == hwmon_fan_input)
+			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
+		return -EOPNOTSUPP;
+	case hwmon_power:
+		return corsairpsu_hwmon_power(priv, attr, channel, val);
+	case hwmon_in:
+		return corsairpsu_hwmon_in(priv, attr, channel, val);
+	case hwmon_curr:
+		return corsairpsu_hwmon_curr(priv, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum hwmon_sensor_types type,
@@ -360,8 +481,8 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL),
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
 	HWMON_CHANNEL_INFO(power,
@@ -371,14 +492,14 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
 			   HWMON_P_INPUT | HWMON_P_LABEL),
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
-			   HWMON_I_INPUT | HWMON_I_LABEL,
-			   HWMON_I_INPUT | HWMON_I_LABEL,
-			   HWMON_I_INPUT | HWMON_I_LABEL),
+			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
+			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
+			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT),
 	HWMON_CHANNEL_INFO(curr,
 			   HWMON_C_INPUT | HWMON_C_LABEL,
-			   HWMON_C_INPUT | HWMON_C_LABEL,
-			   HWMON_C_INPUT | HWMON_C_LABEL,
-			   HWMON_C_INPUT | HWMON_C_LABEL),
+			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
+			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
+			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT),
 	NULL
 };
 
@@ -513,6 +634,8 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 		goto fail_and_stop;
 	}
 
+	corsairpsu_get_criticals(priv);
+
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
 							  &corsairpsu_chip_info, 0);
 
-- 
2.30.2

