Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4D35D593
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbhDMDCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:02:30 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41644 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhDMDC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:02:29 -0400
Received: by mail-wr1-f47.google.com with SMTP id a6so14891056wrw.8;
        Mon, 12 Apr 2021 20:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4O0qPwgrZJCnrS19darU0kP67ZKtnjW53XhCsAkkDHc=;
        b=fOVan54tXpVtbO4mI4D01+tVLWMsz6YQqo0VSHtMl7hIVekIcvcv70kqRWKvpOYb51
         +GOEaw52L3XGCsn0g62U1XEv62bFTNxMi1Hx5boTAEG2M46dZAQ4+F/HmAaYCuVgJc+/
         uFvJ9GFzgdWrhCqhDgj2zM/kZCcDwVazbgf4FywhgEJxRPfFV8hQyeqT90sj9J/XdoeX
         M2uyc1EIji2RCTqJ41+1qk5YoEk4KOOaK4cLZAGlMDKVfGYkfd2EwCZZzrRbL2/tp3eo
         3q9jHJqVAm8P5+XmEAsy7pIlMY6PoDHZVIuD06OvZbsckdAE1C0XdiPnz3Ll8H55E9H6
         ekJg==
X-Gm-Message-State: AOAM5332952SA7Ik4fkXv4No6yM7N+zWCyg+7BJn/dZ1PBr+OiM7pujF
        fD0OtC7jmDRRkLY2m9A/IKQ=
X-Google-Smtp-Source: ABdhPJzsehkaHcxhLuxDZexwGjvlylYfPWFZP+Swen+EgyuvhWvE+/E9FURL/g1bFsEh3ptHFXD0jw==
X-Received: by 2002:adf:84e6:: with SMTP id 93mr32449060wrg.376.1618282927815;
        Mon, 12 Apr 2021 20:02:07 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id k16sm18612424wro.11.2021.04.12.20.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 20:02:07 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] hwmon: (max31790) Fix and split pwm*_enable
Date:   Tue, 13 Apr 2021 04:59:45 +0200
Message-Id: <20210413025948.901867-2-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413025948.901867-1-kubernat@cesnet.cz>
References: <20210413025948.901867-1-kubernat@cesnet.cz>
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
 Documentation/hwmon/max31790.rst |  8 +--
 drivers/hwmon/max31790.c         | 87 ++++++++++++++++++++++----------
 2 files changed, 66 insertions(+), 29 deletions(-)

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
index e3765ce4444a..ecdd55e12ffe 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -39,6 +39,7 @@
 
 #define FAN_RPM_MIN			120
 #define FAN_RPM_MAX			7864320
+#define MAX_PWM				0XFF80
 
 #define RPM_FROM_REG(reg, sr)		(((reg) >> 4) ? \
 					 ((60 * (sr) * 8192) / ((reg) >> 4)) : \
@@ -90,6 +91,7 @@ struct max31790_data {
 	struct regmap *regmap;
 
 	struct mutex update_lock;
+	bool full_speed[NR_CHANNEL];
 	u8 fan_config[NR_CHANNEL];
 	u8 fan_dynamics[NR_CHANNEL];
 };
@@ -191,6 +193,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		else
 			*val = !!(fault & (1 << channel));
 		return 0;
+	case hwmon_fan_enable:
+		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -233,6 +238,15 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 				     MAX31790_REG_TARGET_COUNT(channel),
 				     target_count);
 		break;
+	case hwmon_fan_enable:
+		if (val == 0)
+			data->fan_config[channel] &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
+		else
+			data->fan_config[channel] |= MAX31790_FAN_CFG_TACH_INPUT_EN;
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_CONFIG(channel),
+				   data->fan_config[channel]);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -260,6 +274,11 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
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
@@ -281,12 +300,12 @@ static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
 		*val = read >> 8;
 		return 0;
 	case hwmon_pwm_enable:
-		if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
+		if (data->full_speed[channel])
+			*val = 0;
+		else if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
 			*val = 2;
-		else if (data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN)
+		else
 			*val = 1;
-		else
-			*val = 0;
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -305,28 +324,42 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		if (val < 0 || val > 255) {
+		if (data->full_speed[channel] || val < 0 || val > 255) {
 			err = -EINVAL;
 			break;
 		}
+
 		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
 		break;
 	case hwmon_pwm_enable:
 		fan_config = data->fan_config[channel];
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
+		if (val == 0) {
+			data->full_speed[channel] = true;
+			err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), MAX_PWM);
+		} else {
+			data->full_speed[channel] = false;
+		}
+
+		/*
+		 * RPM mode implies enabled TACH input, so enable it in RPM
+		 * mode.
+		 */
+		if (val == 2)
+			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
+
 		data->fan_config[channel] = fan_config;
 		err = regmap_write(regmap,
 				   MAX31790_REG_FAN_CONFIG(channel),
@@ -400,18 +433,18 @@ static umode_t max31790_is_visible(const void *data,
 
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
@@ -448,6 +481,8 @@ static int max31790_init_client(struct regmap *regmap,
 		if (rv < 0)
 			return rv;
 		data->fan_dynamics[i] = rv;
+
+		data->full_speed[i] = false;
 	}
 
 	return 0;
-- 
2.31.1

