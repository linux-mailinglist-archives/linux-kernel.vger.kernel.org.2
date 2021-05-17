Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA392383C32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhEQSZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhEQSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:25:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:24:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so132093pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FI246W5m9EGcLjbkDUbXs1YNpVMm1UcSABT6//sFJdY=;
        b=vUVwmCgU4hLWgn6ulLZB7O3P+TiuGG+24Xl/SDTPLSCwyakGO0GYF/YYIQrDxlXbtu
         SDH8Oz9pmrbNM4DlFzNC+AwAxVzTy0ge6/Cf61TwNyMXKO6OPJkeND1A5DMtW3vgJjSI
         ehkx0XmUOKx2LNRhtTW7+b0/uUd4aYcH01Z/cg6zdr5L5hgO2TL4shq98NbjgyfvVOXp
         avUWuf5Rf0SgVQgXCJxKVmmPA5qoWra5WBxNMYHrmOBKwrOWPeZImHInQJKyBcKK9d4j
         X57CAfGdrgyFV+yVMI0tlmhB4zbjsLBSrnE45caboECPWGX7QBYoJwBJKELJ3/OOUjl8
         D9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FI246W5m9EGcLjbkDUbXs1YNpVMm1UcSABT6//sFJdY=;
        b=GhCb0+91j6nIZOJ1cZjj3o976gHARE816Gg83esrR+ZhZ3GWnjvJ9NVS2o6BCtRM/R
         afzpBLwfH9TUBpKfcX2vLiH1eTRSV4ZmLFBHpc1JGjEsweSMTn4BCXjgNgfRjS46BjBA
         OYdribCsVbpIbxiN9nxDLi9Yv+T91PEYB4oQy4wgASZDJq79USb7a2hA86RdMoURbGQw
         gLgtGxqqhgUeY1FCrvkzxUw8opAmlkfcaEJQ2roAdC0U11Nn8Qw5q+52WVrCEyleVccs
         KUVxncwXDTVddAYBBp7KAPbZlgxI3xy6drBQ+qiBA8YtcHuS0YrFKq2WK/JRDa3TRCnT
         vLzQ==
X-Gm-Message-State: AOAM531leggkwFGSglitJa0HbEtmJKoMRiH+f1Vt+772FXdb+UixFZlw
        e2/o0oTjWB9y5/qBL4keX8NYUw==
X-Google-Smtp-Source: ABdhPJxuKhRpA9d+ZG4n25RnpFrOVY8RUylM/mc8vcVjZ2gtu539kniy2/cqE8oZJT155RENGTSMYg==
X-Received: by 2002:a17:902:8bcb:b029:ec:a192:21cf with SMTP id r11-20020a1709028bcbb02900eca19221cfmr1368936plo.71.1621275880082;
        Mon, 17 May 2021 11:24:40 -0700 (PDT)
Received: from srv7.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id a16sm10545417pfa.95.2021.05.17.11.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 11:24:39 -0700 (PDT)
From:   Ashwin H <ashwin@pensando.io>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, snelson@pensando.io,
        Ashwin H <ashwin@pensando.io>
Subject: [PATCH] hwmon: (adt7462) Add settings for manual fan control.
Date:   Mon, 17 May 2021 11:24:27 -0700
Message-Id: <20210517182427.12904-1-ashwin@pensando.io>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7462 can operate in manual mode for fan control.
Currently if we want to read fan speed,
there is a check if TACH measurement is enabled for a fan.
(In fan_enabled function).
There is no way to enable TACH measurement currently.
This is addressed in this commit.

Along with the above support few more features are enabled
- Support for setting fan presence.
- Support for setting low and high frequency mode.
- Support for setting easy config option.
- Support for setting the duration of the fan startup timeout.
- Once the setting is done, there is a setup complete bit in cfg1 register.
  Settings this bit will start the monitoring of all selected channels.
  Added support for that.

Based on this, below is the flow to set/get fan speed (example:pwm1)

echo 1 > pwm1_enable            #Set to manual mode
echo 1 > pwm_freq_mode          #High freq mode (optional.newly added)
echo 1 > fan1_presence          #Set fan 1 as present(newly added)
echo 1 > fan1_tach_enable       #Start TACH measurement-fan1(newly added)
echo 1 > setup_complete         #Mark as setup complete (newly added)
cat fan1_input                  #Read Fan1 RPM.
echo 192 > pwm1                 #Change PWM1(has fan1) to 75%(192/255).

This is tested on x86 CPU which connects via PCIE to FGPA which has I2C Controller.
ADT7462 is connected to the I2C controller(on FPGA).

Signed-off-by: Ashwin H <ashwin@pensando.io>
---
 Documentation/hwmon/adt7462.rst |  22 ++-
 drivers/hwmon/adt7462.c         | 308 ++++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/adt7462.rst b/Documentation/hwmon/adt7462.rst
index 139e19696188..a4418ed6f2fa 100644
--- a/Documentation/hwmon/adt7462.rst
+++ b/Documentation/hwmon/adt7462.rst
@@ -56,7 +56,7 @@ Configuration Notes
 
 Besides standard interfaces driver adds the following:
 
-* PWM Control
+* PWM Auto Control
 
 * pwm#_auto_point1_pwm and temp#_auto_point1_temp and
 * pwm#_auto_point2_pwm and temp#_auto_point2_temp -
@@ -68,3 +68,23 @@ The ADT7462 will scale the pwm between the lower and higher pwm speed when
 the temperature is between the two temperature boundaries.  PWM values range
 from 0 (off) to 255 (full speed).  Fan speed will be set to maximum when the
 temperature sensor associated with the PWM control exceeds temp#_max.
+
+* PWM Manual Control
+The ADT7462 can operate in manual mode for PWM control.
+Below is the typical flow to contol PWM manually.
+(Example for PWM1 which controls fan1)
+
+  - Set PWM to manual mode
+    - echo 1 > pwm1_enable
+  - Enable High Freq Mode (optional)
+    -  echo 1 > pwm_freq_mode
+  - Set fan1 as present
+    - echo 1 > fan1_presence
+  - Start TACH measurement for fan1
+    - echo 1 > fan1_tach_enable
+  - Mark as setup complete. This will start monitoring of all enabled channels.
+    - echo 1 > setup_complete
+  - Read fan1 RPM
+    -  cat fan1_input
+  - Change PWM1 to 75% (192/255)
+    - echo 192 > pwm1
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index e75bbd87ad09..d9faa1224ed8 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -39,8 +39,12 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define ADT7462_REG_FAN_MIN_BASE_ADDR		0x78
 #define ADT7462_REG_FAN_MIN_MAX_ADDR		0x7F
 
+#define ADT7462_REG_CFG1			0x01
+#define		ADT7462_SETUP_COMPLETE_MASK	0x20
+
 #define ADT7462_REG_CFG2			0x02
 #define		ADT7462_FSPD_MASK		0x20
+#define		ADT7462_PWM_FREQ_MODE_MASK      0x04
 
 #define ADT7462_REG_PWM_BASE_ADDR		0xAA
 #define ADT7462_REG_PWM_MAX_ADDR		0xAD
@@ -58,6 +62,7 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define ADT7462_REG_PWM_CFG_MAX_ADDR		0x24
 #define		ADT7462_PWM_CHANNEL_MASK	0xE0
 #define		ADT7462_PWM_CHANNEL_SHIFT	5
+#define		ADT7462_SPINUP_TIMEOUT_MASK     0x07
 
 #define ADT7462_REG_PIN_CFG_BASE_ADDR		0x10
 #define ADT7462_REG_PIN_CFG_MAX_ADDR		0x13
@@ -84,6 +89,10 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define		ADT7462_PIN28_SHIFT		4	/* cfg3 */
 #define		ADT7462_PIN28_VOLT		0x5
 
+#define ADT7462_REG_EASY_CONFIG                 0x14
+
+#define ADT7462_REG_FAN_PRESENCE                0x1D
+
 #define ADT7462_REG_ALARM1			0xB8
 #define	ADT7462_LT_ALARM			0x02
 #define		ADT7462_R1T_ALARM		0x04
@@ -203,8 +212,11 @@ struct adt7462_data {
 	u8			temp_max[ADT7462_TEMP_COUNT];
 	u16			fan[ADT7462_FAN_COUNT];
 	u8			fan_enabled;
+	u8			fan_presence;
 	u8			fan_min[ADT7462_FAN_COUNT];
+	u8			cfg1;
 	u8			cfg2;
+	u8			easy_config;
 	u8			pwm[ADT7462_PWM_COUNT];
 	u8			pin_cfg[ADT7462_PIN_CFG_REG_COUNT];
 	u8			voltages[ADT7462_VOLT_COUNT];
@@ -700,6 +712,9 @@ static struct adt7462_data *adt7462_update_device(struct device *dev)
 	data->fan_enabled = i2c_smbus_read_byte_data(client,
 					ADT7462_REG_FAN_ENABLE);
 
+	data->fan_presence = i2c_smbus_read_byte_data(client,
+					ADT7462_REG_FAN_PRESENCE);
+
 	for (i = 0; i < ADT7462_PWM_COUNT; i++)
 		data->pwm[i] = i2c_smbus_read_byte_data(client,
 						ADT7462_REG_PWM(i));
@@ -765,8 +780,13 @@ static struct adt7462_data *adt7462_update_device(struct device *dev)
 
 	data->pwm_max = i2c_smbus_read_byte_data(client, ADT7462_REG_PWM_MAX);
 
+	data->cfg1 = i2c_smbus_read_byte_data(client, ADT7462_REG_CFG1);
+
 	data->cfg2 = i2c_smbus_read_byte_data(client, ADT7462_REG_CFG2);
 
+	data->easy_config = i2c_smbus_read_byte_data(client,
+						ADT7462_REG_EASY_CONFIG);
+
 	data->limits_last_updated = local_jiffies;
 	data->limits_valid = 1;
 
@@ -1049,6 +1069,117 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 		       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
 }
 
+static ssize_t fan_tach_show(struct device *dev,
+			      struct device_attribute *devattr,
+			      char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7462_data *data = adt7462_update_device(dev);
+
+	return sprintf(buf, "%d\n", fan_enabled(data, attr->index) ? 1 : 0);
+}
+
+static ssize_t fan_tach_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	long temp;
+	u8   reg;
+
+	if (kstrtol(buf, 10, &temp))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	reg = i2c_smbus_read_byte_data(client, ADT7462_REG_FAN_ENABLE);
+
+	if (temp)
+		reg |= (1 << attr->index);
+	else
+		reg &= (~(1 << attr->index));
+	data->fan_enabled = reg;
+
+	i2c_smbus_write_byte_data(client, ADT7462_REG_FAN_ENABLE, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t fan_presence_show(struct device *dev,
+				  struct device_attribute *devattr,
+				  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7462_data *data = adt7462_update_device(dev);
+
+	return sprintf(buf, "%d\n", ((data->fan_presence >> attr->index) & 1) ? 1 : 0);
+}
+
+static ssize_t fan_presence_store(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	long temp;
+	u8   reg;
+
+	if (kstrtol(buf, 10, &temp))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	reg = i2c_smbus_read_byte_data(client, ADT7462_REG_FAN_PRESENCE);
+
+	if (temp)
+		reg |= (1 << attr->index);
+	else
+		reg &= (~(1 << attr->index));
+	data->fan_presence = reg;
+
+	i2c_smbus_write_byte_data(client, ADT7462_REG_FAN_PRESENCE, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t setup_complete_show(struct device *dev,
+				    struct device_attribute *devattr,
+				    char *buf)
+{
+	struct adt7462_data *data = adt7462_update_device(dev);
+
+	return sprintf(buf, "%d\n", (data->cfg1 & ADT7462_SETUP_COMPLETE_MASK ? 1 : 0));
+}
+
+static ssize_t setup_complete_store(struct device *dev,
+				     struct device_attribute *devattr,
+				     const char *buf,
+				     size_t count)
+{
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	long temp;
+	u8 reg;
+
+	if (kstrtol(buf, 10, &temp))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	reg = i2c_smbus_read_byte_data(client, ADT7462_REG_CFG1);
+	if (temp)
+		reg |= ADT7462_SETUP_COMPLETE_MASK;
+	else
+		reg &= ~ADT7462_SETUP_COMPLETE_MASK;
+	data->cfg1 = reg;
+	i2c_smbus_write_byte_data(client, ADT7462_REG_CFG1, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
 static ssize_t force_pwm_max_show(struct device *dev,
 				  struct device_attribute *devattr, char *buf)
 {
@@ -1081,6 +1212,75 @@ static ssize_t force_pwm_max_store(struct device *dev,
 	return count;
 }
 
+static ssize_t pwm_freq_mode_show(struct device *dev,
+				   struct device_attribute *devattr,
+				   char *buf)
+{
+	struct adt7462_data *data = adt7462_update_device(dev);
+
+	return sprintf(buf, "%d\n", (data->cfg2 & ADT7462_PWM_FREQ_MODE_MASK ? 1 : 0));
+}
+
+static ssize_t pwm_freq_mode_store(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf,
+				    size_t count)
+{
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	long temp;
+	u8 reg;
+
+	if (kstrtol(buf, 10, &temp))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	reg = i2c_smbus_read_byte_data(client, ADT7462_REG_CFG2);
+	if (temp)
+		reg |= ADT7462_PWM_FREQ_MODE_MASK;
+	else
+		reg &= ~ADT7462_PWM_FREQ_MODE_MASK;
+
+	data->cfg2 = reg;
+	i2c_smbus_write_byte_data(client, ADT7462_REG_CFG2, reg);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
+static ssize_t easy_config_show(struct device *dev,
+				 struct device_attribute *devattr,
+				 char *buf)
+{
+	struct adt7462_data *data = adt7462_update_device(dev);
+
+	return sprintf(buf, "%d\n", data->easy_config);
+}
+
+static ssize_t easy_config_store(struct device *dev,
+				  struct device_attribute *devattr,
+				  const char *buf,
+				  size_t count)
+{
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	long temp;
+
+	if (kstrtol(buf, 10, &temp))
+		return -EINVAL;
+	/* Only 1 bit needs to be set and set bit should be below bit 5. */
+
+	if (((temp & (temp - 1)) != 0) || (temp > 16))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->easy_config = temp;
+	i2c_smbus_write_byte_data(client, ADT7462_REG_EASY_CONFIG, temp);
+	mutex_unlock(&data->lock);
+
+	return count;
+}
+
 static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
@@ -1339,6 +1539,56 @@ static ssize_t pwm_auto_store(struct device *dev,
 	}
 }
 
+static ssize_t pwm_spinup_timeout_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7462_data *data = adt7462_update_device(dev);
+	int cfg = data->pwm_cfg[attr->index] & ADT7462_SPINUP_TIMEOUT_MASK;
+
+	return sprintf(buf, "%d\n", cfg);
+
+}
+
+static void pwm_spinup_timeout_reg_store(struct i2c_client *client,
+					  struct adt7462_data *data,
+					  int which,
+					  int value)
+{
+	int temp = data->pwm_cfg[which] & ~ADT7462_SPINUP_TIMEOUT_MASK;
+
+	temp |= value;
+
+	mutex_lock(&data->lock);
+	data->pwm_cfg[which] = temp;
+	i2c_smbus_write_byte_data(client, ADT7462_REG_PWM_CFG(which), temp);
+	mutex_unlock(&data->lock);
+}
+
+static ssize_t pwm_spinup_timeout_store(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf,
+					 size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	long temp;
+
+	if (kstrtol(buf, 10, &temp))
+		return -EINVAL;
+	/* Only 3 bits are valid. */
+	if (temp > 7)
+		return -EINVAL;
+
+	pwm_spinup_timeout_reg_store(client, data, attr->index, temp);
+
+	return count;
+}
+
+
+
 static ssize_t pwm_auto_temp_show(struct device *dev,
 				  struct device_attribute *devattr, char *buf)
 {
@@ -1540,8 +1790,32 @@ static SENSOR_DEVICE_ATTR_RO(fan7_alarm, alarm,
 static SENSOR_DEVICE_ATTR_RO(fan8_alarm, alarm,
 			     ADT7462_ALARM4 | ADT7462_F7_ALARM);
 
+static SENSOR_DEVICE_ATTR_RW(fan1_tach_enable, fan_tach, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_tach_enable, fan_tach, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_tach_enable, fan_tach, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_tach_enable, fan_tach, 3);
+static SENSOR_DEVICE_ATTR_RW(fan5_tach_enable, fan_tach, 4);
+static SENSOR_DEVICE_ATTR_RW(fan6_tach_enable, fan_tach, 5);
+static SENSOR_DEVICE_ATTR_RW(fan7_tach_enable, fan_tach, 6);
+static SENSOR_DEVICE_ATTR_RW(fan8_tach_enable, fan_tach, 7);
+
+static SENSOR_DEVICE_ATTR_RW(fan1_presence, fan_presence, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_presence, fan_presence, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_presence, fan_presence, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_presence, fan_presence, 3);
+static SENSOR_DEVICE_ATTR_RW(fan5_presence, fan_presence, 4);
+static SENSOR_DEVICE_ATTR_RW(fan6_presence, fan_presence, 5);
+static SENSOR_DEVICE_ATTR_RW(fan7_presence, fan_presence, 6);
+static SENSOR_DEVICE_ATTR_RW(fan8_presence, fan_presence, 7);
+
 static SENSOR_DEVICE_ATTR_RW(force_pwm_max, force_pwm_max, 0);
 
+static SENSOR_DEVICE_ATTR_RW(setup_complete, setup_complete, 0);
+
+static SENSOR_DEVICE_ATTR_RW(pwm_freq_mode, pwm_freq_mode, 0);
+
+static SENSOR_DEVICE_ATTR_RW(easy_config, easy_config, 0);
+
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
 static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
@@ -1582,6 +1856,11 @@ static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_auto, 1);
 static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_auto, 2);
 static SENSOR_DEVICE_ATTR_RW(pwm4_enable, pwm_auto, 3);
 
+static SENSOR_DEVICE_ATTR_RW(pwm1_spinup_timeout, pwm_spinup_timeout, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_spinup_timeout, pwm_spinup_timeout, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_spinup_timeout, pwm_spinup_timeout, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_spinup_timeout, pwm_spinup_timeout, 3);
+
 static SENSOR_DEVICE_ATTR_RW(pwm1_auto_channels_temp, pwm_auto_temp, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm2_auto_channels_temp, pwm_auto_temp, 1);
 static SENSOR_DEVICE_ATTR_RW(pwm3_auto_channels_temp, pwm_auto_temp, 2);
@@ -1710,12 +1989,36 @@ static struct attribute *adt7462_attrs[] = {
 	&sensor_dev_attr_fan7_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan8_alarm.dev_attr.attr,
 
+	&sensor_dev_attr_fan1_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan2_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan3_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan4_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan5_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan6_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan7_tach_enable.dev_attr.attr,
+	&sensor_dev_attr_fan8_tach_enable.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_presence.dev_attr.attr,
+	&sensor_dev_attr_fan2_presence.dev_attr.attr,
+	&sensor_dev_attr_fan3_presence.dev_attr.attr,
+	&sensor_dev_attr_fan4_presence.dev_attr.attr,
+	&sensor_dev_attr_fan5_presence.dev_attr.attr,
+	&sensor_dev_attr_fan6_presence.dev_attr.attr,
+	&sensor_dev_attr_fan7_presence.dev_attr.attr,
+	&sensor_dev_attr_fan8_presence.dev_attr.attr,
+
+
 	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
+	&sensor_dev_attr_pwm_freq_mode.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm4.dev_attr.attr,
 
+	&sensor_dev_attr_setup_complete.dev_attr.attr,
+
+	&sensor_dev_attr_easy_config.dev_attr.attr,
+
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
@@ -1751,6 +2054,11 @@ static struct attribute *adt7462_attrs[] = {
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
 
+	&sensor_dev_attr_pwm1_spinup_timeout.dev_attr.attr,
+	&sensor_dev_attr_pwm2_spinup_timeout.dev_attr.attr,
+	&sensor_dev_attr_pwm3_spinup_timeout.dev_attr.attr,
+	&sensor_dev_attr_pwm4_spinup_timeout.dev_attr.attr,
+
 	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
-- 
2.31.1

