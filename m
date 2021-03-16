Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4233DBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbhCPR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:57:19 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36643 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbhCPR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:56:00 -0400
Received: by mail-ej1-f42.google.com with SMTP id e19so73739504ejt.3;
        Tue, 16 Mar 2021 10:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ7F8vBoziNG6fSK7dLbSv5ntc0CUAXmmoXNPgdj2OA=;
        b=YY8Ft2rMn8as5G5m6o7gHsFY3i66PbHqMhqb2h7eWUBgF4x8v2deFtB36PELYUHtI0
         QdejqW3L7RjnV9LldN6IQav1SB05MJhgACKL74L/zHnlKViVqxuPEsVwOaOKjtPabAmb
         Tvx0dyxWgRJX7tjuoB0tcuXvyXI/T1iOZQs9yivWcKw5CzTFE+8n9B6+rXe9qiFnKS7v
         IArJKsWz4/ukAJigBoSFdWabassWW0/RPQfIavx1axAKZJ8Ldn3jo9i6+poP9wx4RO5X
         R3L7Y88+2PQ33pwjBeg/oMZ/aEm1Q36r+NZ2n/TKgDT/opJMB+Tc3nlMedmgGr95uHBC
         /adw==
X-Gm-Message-State: AOAM531sn7fv5A+em9JHcgR3BoPVx9qEkcDqkftXoBxDnbrMQB1IVe1r
        y1GGcpnG16vHS1bdMVmrDzA=
X-Google-Smtp-Source: ABdhPJz7U/CmGDXcf4fafuOzJintHWY0JC5Av9g5boMOJeQXFco/IKDixTQRys1GJI2FLLH2hkKwYA==
X-Received: by 2002:a17:907:75d9:: with SMTP id jl25mr30487352ejc.452.1615917358914;
        Tue, 16 Mar 2021 10:55:58 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id v11sm10944459eds.14.2021.03.16.10.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:55:58 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] hwmon: (max31790) Fix and split pwm*_enable
Date:   Tue, 16 Mar 2021 18:54:59 +0100
Message-Id: <20210316175503.1003051-2-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316175503.1003051-1-kubernat@cesnet.cz>
References: <20210316175503.1003051-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old code, pwm*_enable does two things. Firstly, it sets whether
the chip should run in PWM or RPM mode. Secondly, it tells the chip
whether it should monitor fan RPM. However, these two settings aren't
tied together, so they shouldn't be set with a single value. In the new
code, fan*_enable now controls fan RPM monitoring (pwm*_enable no longer
controls that).

According to the sysfs hwmon documentation, pwm*_enable has three
possible values, 0 for "no control / full-speed", 1 for manual mode, and
2+ for automatic. The old code works fine for 1 and 2, but 0 only
differs from 1 in that it just turns off fan speed monitoring. The chip
actually does have a way to turn off fan controls (and only monitor),
but what that does is that it sets PWM to 0% duty cycle (which is the
opposite to full-speed) AND it also turns off fan speed monitoring.
Because of this, I implemented the 0 value by setting PWM mode to 100%.
This method does come with a problem: it is impossible to differentiate
between full-speed and PWM mode just from the values on the chip. The
new code solves this by saving a value indicating whether we're in
full-speed mode. This value is initialized to 0, so full-speed mode
won't persist across reboots.

These two changes are closely connected together, mainly because the
detection of the pwm*_enable value depended on whether fan speed
monitoring is enabled (which is now controlled as written in the first
paragraph).

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst |   8 ++-
 drivers/hwmon/max31790.c         | 105 ++++++++++++++++++++++---------
 2 files changed, 82 insertions(+), 31 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index f301385d8cef..8979c8a02cd1 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -34,10 +34,12 @@ also be configured to serve as tachometer inputs.
 Sysfs entries
 -------------
 
-================== === =======================================================
+================== === =============================================================
+fan[1-12]_enable   RW  enable fan speed monitoring
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-6]_target    RW  desired fan speed in RPM
-pwm[1-6]_enable    RW  regulator mode, 0=disabled, 1=manual mode, 2=rpm mode
+pwm[1-6]_enable    RW  regulator mode, 0=full speed, 1=manual (pwm) mode, 2=rpm mode
+                       setting rpm mode sets fan*_enable to 1
 pwm[1-6]           RW  fan target duty cycle (0-255)
-================== === =======================================================
+================== === =============================================================
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 4e5add567890..d16b77472cc1 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -39,6 +39,7 @@
 
 #define FAN_RPM_MIN			120
 #define FAN_RPM_MAX			7864320
+#define MAX_PWM				0XFF80
 
 #define RPM_FROM_REG(reg, sr)		(((reg) >> 4) ? \
 					 ((60 * (sr) * 8192) / ((reg) >> 4)) : \
@@ -88,6 +89,9 @@ static const struct regmap_config max31790_regmap_config = {
  */
 struct max31790_data {
 	struct regmap *regmap;
+
+	struct mutex update_lock; /* for full_speed */
+	bool full_speed[NR_CHANNEL];
 };
 
 static const u8 tach_period[8] = { 1, 2, 4, 8, 16, 32, 32, 32 };
@@ -157,7 +161,7 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
 	struct regmap *regmap = data->regmap;
-	int rpm, dynamics, tach, fault;
+	int rpm, dynamics, tach, fault, cfg;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -201,6 +205,13 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		else
 			*val = !!(fault & (1 << channel));
 		return 0;
+	case hwmon_fan_enable:
+		cfg = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (cfg < 0)
+			return cfg;
+
+		*val = !!(cfg & MAX31790_FAN_CFG_TACH_INPUT_EN);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -215,7 +226,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 	int err = 0;
 	u8 bits;
 	int sr;
-	int fan_dynamics;
+	int fan_dynamics, cfg;
 
 	switch (attr) {
 	case hwmon_fan_target:
@@ -246,6 +257,14 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 				     MAX31790_REG_TARGET_COUNT(channel),
 				     target_count);
 		break;
+	case hwmon_fan_enable:
+		cfg = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (val == 0)
+			cfg &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
+		else
+			cfg |= MAX31790_FAN_CFG_TACH_INPUT_EN;
+		err = regmap_write(regmap, MAX31790_REG_FAN_CONFIG(channel), cfg);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -275,6 +294,11 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 		    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
 		return 0;
+	case hwmon_fan_enable:
+		if (channel < NR_CHANNEL ||
+		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
+			return 0644;
+		return 0;
 	default:
 		return 0;
 	}
@@ -303,12 +327,14 @@ static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
 		if (read < 0)
 			return read;
 
-		if (read & MAX31790_FAN_CFG_RPM_MODE)
+		mutex_lock(&data->update_lock);
+		if (data->full_speed[channel])
+			*val = 0;
+		else if (read & MAX31790_FAN_CFG_RPM_MODE)
 			*val = 2;
-		else if (read & MAX31790_FAN_CFG_TACH_INPUT_EN)
+		else
 			*val = 1;
-		else
-			*val = 0;
+		mutex_unlock(&data->update_lock);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -325,10 +351,13 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		if (val < 0 || val > 255) {
+		mutex_lock(&data->update_lock);
+		if (data->full_speed[channel] || val < 0 || val > 255) {
 			err = -EINVAL;
 			break;
 		}
+		mutex_unlock(&data->update_lock);
+
 		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
 		break;
 	case hwmon_pwm_enable:
@@ -337,20 +366,35 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 		if (fan_config < 0)
 			return fan_config;
 
-		if (val == 0) {
-			fan_config &= ~(MAX31790_FAN_CFG_TACH_INPUT_EN |
-					MAX31790_FAN_CFG_RPM_MODE);
-		} else if (val == 1) {
-			fan_config = (fan_config |
-				      MAX31790_FAN_CFG_TACH_INPUT_EN) &
-				     ~MAX31790_FAN_CFG_RPM_MODE;
+		if (val == 0 || val == 1) {
+			fan_config &= ~MAX31790_FAN_CFG_RPM_MODE;
 		} else if (val == 2) {
-			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN |
-				      MAX31790_FAN_CFG_RPM_MODE;
+			fan_config |= MAX31790_FAN_CFG_RPM_MODE;
 		} else {
 			err = -EINVAL;
 			break;
 		}
+
+		/*
+		 * The chip sets PWM to zero when using its "monitor only" mode
+		 * and 0 means full speed.
+		 */
+		mutex_lock(&data->update_lock);
+		if (val == 0) {
+			data->full_speed[channel] = true;
+			err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), MAX_PWM);
+		} else {
+			data->full_speed[channel] = false;
+		}
+		mutex_unlock(&data->update_lock);
+
+		/*
+		 * RPM mode implies enabled TACH input, so enable it in RPM
+		 * mode.
+		 */
+		if (val == 2)
+			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
+
 		err = regmap_write(regmap,
 				   MAX31790_REG_FAN_CONFIG(channel),
 				   fan_config);
@@ -425,18 +469,18 @@ static umode_t max31790_is_visible(const void *data,
 
 static const struct hwmon_channel_info *max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT),
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
@@ -464,6 +508,7 @@ static int max31790_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct max31790_data *data;
 	struct device *hwmon_dev;
+	int i;
 
 	if (!i2c_check_functionality(adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -473,6 +518,10 @@ static int max31790_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	mutex_init(&data->update_lock);
+	for (i = 0; i < NR_CHANNEL; i++)
+		data->full_speed[i] = false;
+
 	data->regmap = devm_regmap_init_i2c(client, &max31790_regmap_config);
 
 	if (IS_ERR(data->regmap)) {
-- 
2.30.2

