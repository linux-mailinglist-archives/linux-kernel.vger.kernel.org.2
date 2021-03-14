Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A407C33A4CC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhCNMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:43:14 -0400
Received: from mout01.posteo.de ([185.67.36.65]:42817 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234871AbhCNMm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:42:57 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 801D2160063
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615725770; bh=/Ic6WEflnqJllMz9ve7T62NAIALn6UJ9yDr3wRtHabM=;
        h=Date:From:To:Cc:Subject:From;
        b=o6eBK6k7iiUwpXtaT2bQGZDjo0cgh+H879EjT20Cl7VIJserBqa4NsKuaAiPIlgvN
         lZgLO933mRmuApnEcnm7e1hTrEGF9SFRJlrItWEDu2jrL57s1Ka5bjcKxQJ5ekiv42
         TQIIcE2zJosqfO+4tT7PzT9H0leXhfBqGNrI04p2HgY/itJ4Kp2HOL9MkA5BEcVX+i
         0QiVrkXeLdfuviw7HJNQTkDa2810juhkPNi+c80vj0Gz9XwInt0qEwlPRP+Bbo2lli
         T7ViZpeIjhGwGhTsdSwx04JFt17OqwkmgQE+5gnRM3T/4ADv18X7eL/raxhRY1YZ3d
         G27NFt4hcaJNg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DyzjP1kyJz9rxN;
        Sun, 14 Mar 2021 13:42:49 +0100 (CET)
Date:   Sun, 14 Mar 2021 13:42:47 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: add support for critical values
Message-ID: <YE4Ex4cslcSZsHHs@monster.powergraphx.local>
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
vrm temp:     +46.2°C  (crit = +70.0°C)
case temp:    +39.8°C  (crit = +70.0°C)
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
 Documentation/hwmon/corsair-psu.rst |  13 +-
 drivers/hwmon/corsair-psu.c         | 185 ++++++++++++++++++++++------
 2 files changed, 157 insertions(+), 41 deletions(-)

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
index b0953eeeb2d3..141a5079ea7e 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -53,11 +53,21 @@
 #define CMD_TIMEOUT_MS		250
 #define SECONDS_PER_HOUR	(60 * 60)
 #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
+#define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
+#define CRIT_VALUES_COUNT	11 /* 2 temp crit + 6 rail volts (low and high) + 3 rails amps */
+#define TEMP_HCRIT		0
+#define VOLTS_RAIL_HCRIT	2
+#define VOLTS_RAIL_LCRIT	5
+#define AMPS_RAIL_HCRIT		8
 
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
@@ -113,6 +123,7 @@ struct corsairpsu_data {
 	struct dentry *debugfs;
 	struct completion wait_completion;
 	struct mutex lock; /* for locking access to cmd_buffer */
+	long crit_values[CRIT_VALUES_COUNT];
 	u8 *cmd_buffer;
 	char vendor[REPLY_SIZE];
 	char product[REPLY_SIZE];
@@ -193,7 +204,10 @@ static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, voi
 
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
@@ -229,9 +243,13 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
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
@@ -256,18 +274,70 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	return ret;
 }
 
+static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
+{
+	long tmp;
+	int rail;
+	int ret;
+
+	ret = corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, 0, &tmp);
+	if (ret < 0)
+		pr_debug("%s: unable to read temp0 critical value\n", DRIVER_NAME);
+	else
+		priv->crit_values[TEMP_HCRIT] = tmp;
+
+	ret = corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, 1, &tmp);
+	if (ret < 0)
+		pr_debug("%s: unable to read temp1 cirtical value\n", DRIVER_NAME);
+	else
+		priv->crit_values[TEMP_HCRIT + 1] = tmp;
+
+	for (rail = 0; rail < RAIL_COUNT; ++rail) {
+		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp);
+		if (ret < 0) {
+			pr_debug("%s: unable to read volts rail %d high critical value\n",
+				 DRIVER_NAME, rail);
+		} else {
+			priv->crit_values[VOLTS_RAIL_HCRIT + rail] = tmp;
+		}
+	}
+
+	for (rail = 0; rail < RAIL_COUNT; ++rail) {
+		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp);
+		if (ret < 0) {
+			pr_debug("%s: unable to read volts rail %d low critical value\n",
+				 DRIVER_NAME, rail);
+		} else {
+			priv->crit_values[VOLTS_RAIL_LCRIT + rail] = tmp;
+		}
+	}
+
+	for (rail = 0; rail < RAIL_COUNT; ++rail) {
+		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp);
+		if (ret < 0) {
+			pr_debug("%s: unable to read amps rail %d hight critical value\n",
+				 DRIVER_NAME, rail);
+		} else {
+			priv->crit_values[AMPS_RAIL_HCRIT + rail] = tmp;
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
@@ -277,11 +347,18 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
 				     int channel, long *val)
 {
 	struct corsairpsu_data *priv = dev_get_drvdata(dev);
-	int ret;
-
-	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
-		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
-					   val);
+	int ret = 0;
+
+	if (type == hwmon_temp && channel < 2) {
+		if (attr == hwmon_temp_input) {
+			ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0,
+						   channel, val);
+		} else if (attr == hwmon_temp_crit) {
+			if (priv->crit_values[TEMP_HCRIT + channel] != -EOPNOTSUPP)
+				*val = priv->crit_values[TEMP_HCRIT + channel];
+			else
+				ret = -EOPNOTSUPP;
+		}
 	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
 		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
 	} else if (type == hwmon_power && attr == hwmon_power_input) {
@@ -295,27 +372,48 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
 		default:
 			return -EOPNOTSUPP;
 		}
-	} else if (type == hwmon_in && attr == hwmon_in_input) {
-		switch (channel) {
-		case 0:
-			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
-			break;
-		case 1 ... 3:
-			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, val);
-			break;
-		default:
-			return -EOPNOTSUPP;
+	} else if (type == hwmon_in) {
+		if (attr == hwmon_in_input) {
+			switch (channel) {
+			case 0:
+				ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
+				break;
+			case 1 ... 3:
+				ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1,
+							   val);
+				break;
+			default:
+				return -EOPNOTSUPP;
+			}
+		} else if (attr == hwmon_in_crit && channel > 0 && channel < 4) {
+			if (priv->crit_values[VOLTS_RAIL_HCRIT + channel - 1] != -EOPNOTSUPP)
+				*val = priv->crit_values[VOLTS_RAIL_HCRIT + channel - 1];
+			else
+				ret = -EOPNOTSUPP;
+		} else if (attr == hwmon_in_lcrit && channel > 0 && channel < 4) {
+			if (priv->crit_values[VOLTS_RAIL_LCRIT + channel - 1] != -EOPNOTSUPP)
+				*val = priv->crit_values[VOLTS_RAIL_LCRIT + channel - 1];
+			else
+				ret = -EOPNOTSUPP;
 		}
-	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
-		switch (channel) {
-		case 0:
-			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
-			break;
-		case 1 ... 3:
-			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
-			break;
-		default:
-			return -EOPNOTSUPP;
+	} else if (type == hwmon_curr) {
+		if (attr == hwmon_curr_input) {
+			switch (channel) {
+			case 0:
+				ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
+				break;
+			case 1 ... 3:
+				ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1,
+							   val);
+				break;
+			default:
+				return -EOPNOTSUPP;
+			}
+		} else if (attr == hwmon_curr_crit && channel > 0 && channel < 4) {
+			if (priv->crit_values[AMPS_RAIL_HCRIT + channel - 1] != -EOPNOTSUPP)
+				*val = priv->crit_values[AMPS_RAIL_HCRIT + channel - 1];
+			else
+				ret = -EOPNOTSUPP;
 		}
 	} else {
 		return -EOPNOTSUPP;
@@ -360,8 +458,8 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
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
@@ -371,14 +469,14 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
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
 
@@ -472,6 +570,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
 static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct corsairpsu_data *priv;
+	int i;
 	int ret;
 
 	priv = devm_kzalloc(&hdev->dev, sizeof(struct corsairpsu_data), GFP_KERNEL);
@@ -482,6 +581,9 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 	if (!priv->cmd_buffer)
 		return -ENOMEM;
 
+	for (i = 0; i < CRIT_VALUES_COUNT; ++i)
+		priv->crit_values[i] = -EOPNOTSUPP;
+
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
@@ -513,6 +615,9 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 		goto fail_and_stop;
 	}
 
+	/* this can fail and is considered non-fatal */
+	corsairpsu_get_criticals(priv);
+
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
 							  &corsairpsu_chip_info, 0);
 
-- 
2.30.2

