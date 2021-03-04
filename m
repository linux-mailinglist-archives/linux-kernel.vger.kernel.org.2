Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452FE32D15D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbhCDLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:00:57 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53827 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbhCDLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:43 -0500
Received: by mail-wm1-f53.google.com with SMTP id e23so7618172wmh.3;
        Thu, 04 Mar 2021 03:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gITzLsPooGBCWGwALskXkLIYTlTGl7+1EaRVJt+auPo=;
        b=mODerpZspRZ1TKs3U9200cuXgFmdu65t28RrxjtQ7Zbkz00tfAwHVNpuB9zDX9rW23
         +1Be/qNU4Eml0OTHgnoYs1FSiUa12wHK50S7MGHdzY1wSPomAfxOcncvEoXJiuk9P49M
         BVlvLaInDWumasoOAbymSYoNZSqMQbD3noXKRnWw0R+Fmkm9Vi78jSN6v0osgni/SiV+
         cO7eFTagPAUfebeBdCp8vS+Jf5HJ7fnelrn0tRG1qe6Oim5DCxUfnwRjkOGMOH8amnTg
         m/S9uImu5wTUV5m+ZTknbmxnhx68BQvaGfCmbNiu0nZhhXywDf8SV+uQc1VjnOazqw3l
         FRSg==
X-Gm-Message-State: AOAM531zKIZlpm+TYL7vJBqH2X9O9g3JtVgF5JjByAydi2Y2NGLWqgdB
        gsi2YNaoaPSisixmRuZ2Vtg=
X-Google-Smtp-Source: ABdhPJwX06wnmL23sMxGTTDb1nNF7ziKKE4TP114bK7t1ZHxXwW7XChwpNk2qlVDXaCzT8aZ8v2CnQ==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr3344765wmq.102.1614855602255;
        Thu, 04 Mar 2021 03:00:02 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id h20sm9208749wmb.1.2021.03.04.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:02 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] hwmon: (max31790) Fix and split pwm*_enable
Date:   Thu,  4 Mar 2021 11:58:25 +0100
Message-Id: <20210304105830.507176-2-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304105830.507176-1-kubernat@cesnet.cz>
References: <20210304105830.507176-1-kubernat@cesnet.cz>
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
 drivers/hwmon/max31790.c         | 107 ++++++++++++++++++++++---------
 2 files changed, 80 insertions(+), 35 deletions(-)

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
index ca413985b5f9..eca5ec615734 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -39,6 +39,7 @@
 
 #define FAN_RPM_MIN			120
 #define FAN_RPM_MAX			7864320
+#define MAX_PWM				0XFF80
 
 #define RPM_FROM_REG(reg, sr)		(((reg) >> 4) ? \
 					 ((60 * (sr) * 8192) / ((reg) >> 4)) : \
@@ -79,6 +80,7 @@ struct max31790_data {
 	struct mutex update_lock;
 	bool valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	bool full_speed[NR_CHANNEL];
 
 	/* register values */
 	u8 fan_config[NR_CHANNEL];
@@ -226,6 +228,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_fault:
 		*val = !!(data->fault_status & (1 << channel));
 		return 0;
+	case hwmon_fan_enable:
+		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -271,6 +276,15 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 					bulk_val,
 					2);
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
@@ -298,6 +312,11 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
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
@@ -319,12 +338,12 @@ static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
 		*val = data->pwm[channel] >> 8;
 		return 0;
 	case hwmon_pwm_enable:
-		if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
+		if (data->full_speed[channel])
+			*val = 0;
+		else if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
 			*val = 2;
-		else if (fan_config & MAX31790_FAN_CFG_TACH_INPUT_EN)
+		else
 			*val = 1;
-		else
-			*val = 0;
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -344,7 +363,7 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		if (val < 0 || val > 255) {
+		if (data->full_speed[channel] || val < 0 || val > 255) {
 			err = -EINVAL;
 			break;
 		}
@@ -358,16 +377,10 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
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
@@ -376,6 +389,34 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 		err = regmap_write(regmap,
 				   MAX31790_REG_FAN_CONFIG(channel),
 				   fan_config);
+
+		/*
+		 * The chip sets PWM to zero when using its "monitor only" mode
+		 * and 0 means full speed.
+		 */
+		if (val == 0) {
+			data->full_speed[channel] = true;
+			data->pwm[channel] = MAX_PWM;
+			bulk_val[0] = U16_MSB(data->pwm[channel]);
+			bulk_val[1] = U16_LSB(data->pwm[channel]);
+			err = regmap_bulk_write(regmap,
+						MAX31790_REG_PWMOUT(channel),
+						bulk_val,
+						2);
+		} else {
+			data->full_speed[channel] = false;
+		}
+
+		/*
+		 * RPM mode implies enabled TACH input, so enable it in RPM
+		 * mode.
+		 */
+		if (val == 2) {
+			data->fan_config[channel] |= MAX31790_FAN_CFG_TACH_INPUT_EN;
+			err = regmap_write(regmap,
+					   MAX31790_REG_FAN_CONFIG(channel),
+					   data->fan_config[channel]);
+		}
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -445,25 +486,25 @@ static umode_t max31790_is_visible(const void *data,
 
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
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
 	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+		HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	NULL
 };
 
@@ -491,6 +532,8 @@ static int max31790_init_client(struct regmap *regmap,
 			return rv;
 		data->fan_config[i] = val;
 
+		data->full_speed[i] = false;
+
 		rv = regmap_read(regmap,
 				 MAX31790_REG_FAN_DYNAMICS(i),
 				 &val);
-- 
2.30.1

