Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF8632D15E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhCDLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:01:01 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54887 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbhCDLAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:45 -0500
Received: by mail-wm1-f53.google.com with SMTP id u187so7621004wmg.4;
        Thu, 04 Mar 2021 03:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UA1xOo+7lSBsreIAb0OwBzKlvaeXYlH2J9yBywuvyqU=;
        b=U3On3lI2hzw0Ewi+cYWoOXQ/xO8HfbP4XYUNutJDF9jHEBwqULfSSpJ1YGbfBbP+or
         FHIzIEsiVWyvYhbs7m17YOsvn1ihGX7NWsMlbw2O9UQZOfqxRMWv73GT1B8Z2YUKUkwc
         JRWwE88UIyFx9kL1gPCnyXsR40Ml9HZ33jSPB5eAdjEAVb1a7jF79CQLDCR8o1+ofdqT
         L8wZ5GoHfATtppJmpteXyl8cua6P7Sti0aJLgY1p+S6B+KAMlW4TFQGadATWh6JSB8a9
         Sd4P86vBxwgnJKXaEvifF4In4WHKfWluWGzbrjVMEuDJhzyFL6INLaW+56Ll19Gkmb+q
         u6Xg==
X-Gm-Message-State: AOAM532+YCS25St/gLcTl8R1gh6J9d+CFTwS/FtiRC7ubveI8YPvp1b+
        3m8l2MrtjZ1Iu2NMHBp0yfsjcxEZ0Jg2/A==
X-Google-Smtp-Source: ABdhPJwf70HWklqACtsSmsyVd6d86C6J9i8jKQmGi/2+MqN8VwJlvVkWOaympweSqBfqQ2D4g2yAbA==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr3244192wmr.179.1614855604117;
        Thu, 04 Mar 2021 03:00:04 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id s16sm7952093wru.91.2021.03.04.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:03 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] hwmon: (max31790) Allow setting pulses
Date:   Thu,  4 Mar 2021 11:58:26 +0100
Message-Id: <20210304105830.507176-3-kubernat@cesnet.cz>
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

In the old code, the value calculated RPM_FROM_REG is misleading. The
left-hand side of the division is correct (as per the datasheet, page
11). The misleading part is the right-hand side: the datasheet says it
is should be "number of pulses * TACH count". The TACH count is the
value of the register which is a 11-bit left-justified value. This means
that the register value should be shifted by 5 if we want the actual
value. However, in the old code, the value is shifted by 4 with no way
to set the pulses per revolution. This essentially means, that the
default pulses per revolution is 2, because shifting the right-hand side
one less bit means that the final value is doubled by 2. In the end,
what happens is, that the old code works as if fan*_pulses had the
default value of 2 all the time. This is somewhat correct, but in my
opinion the intention isn't entirely clear, at first glance, shifting by
4 instead of 5 seems like a bug (after one checks the datasheet).

Pulses per revolution should be a configurable because otherwise there's
no way to correctly calculate the RPM of the fan. This patch adds the
option to set pulses per revolution.

The hwmon documentation for fan*_pulses says that it shouldn't be
present unless the chip has a register to save this value. This seems
non-sensical, because setting the pulses is essential to properly
calculate RPM. The value is saved inside the driver's data structure.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst |  1 +
 drivers/hwmon/max31790.c         | 57 +++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 8979c8a02cd1..8d86698b25de 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -36,6 +36,7 @@ Sysfs entries
 
 ================== === =============================================================
 fan[1-12]_enable   RW  enable fan speed monitoring
+fan[1-12]_pulses   RW  pulses per fan revolution (default: 2)
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-6]_target    RW  desired fan speed in RPM
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index eca5ec615734..74a81e5e3383 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -41,10 +41,12 @@
 #define FAN_RPM_MAX			7864320
 #define MAX_PWM				0XFF80
 
-#define RPM_FROM_REG(reg, sr)		(((reg) >> 4) ? \
-					 ((60 * (sr) * 8192) / ((reg) >> 4)) : \
-					 FAN_RPM_MAX)
-#define RPM_TO_REG(rpm, sr)		((60 * (sr) * 8192) / ((rpm) * 2))
+#define RPM_FROM_REG(reg, sr, pulses) \
+	(((reg) >> 5) ? \
+	 ((60 * (sr) * 8192) / ((reg) >> 5) / (pulses)) : \
+	 FAN_RPM_MAX)
+#define RPM_TO_REG(rpm, sr, pulses) \
+	((60 * (sr) * 8192) / ((rpm) * (pulses)))
 
 #define NR_CHANNEL			6
 
@@ -81,6 +83,7 @@ struct max31790_data {
 	bool valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 	bool full_speed[NR_CHANNEL];
+	u8 pulses[NR_CHANNEL];
 
 	/* register values */
 	u8 fan_config[NR_CHANNEL];
@@ -217,12 +220,16 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	switch (attr) {
 	case hwmon_fan_input:
 		sr = get_tach_period(data->fan_dynamics[channel]);
-		rpm = RPM_FROM_REG(data->tach[channel], sr);
+		rpm = RPM_FROM_REG(data->tach[channel],
+				   sr,
+				   data->pulses[channel]);
 		*val = rpm;
 		return 0;
 	case hwmon_fan_target:
 		sr = get_tach_period(data->fan_dynamics[channel]);
-		rpm = RPM_FROM_REG(data->target_count[channel], sr);
+		rpm = RPM_FROM_REG(data->target_count[channel],
+				   sr,
+				   data->pulses[channel]);
 		*val = rpm;
 		return 0;
 	case hwmon_fan_fault:
@@ -231,6 +238,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_enable:
 		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
 		return 0;
+	case hwmon_fan_pulses:
+		*val = data->pulses[channel];
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -264,7 +274,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 			break;
 
 		sr = get_tach_period(data->fan_dynamics[channel]);
-		target_count = RPM_TO_REG(val, sr);
+		target_count = RPM_TO_REG(val, sr, data->pulses[channel]);
 		target_count = clamp_val(target_count, 0x1, 0x7FF);
 
 		data->target_count[channel] = target_count << 5;
@@ -285,6 +295,9 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 				   MAX31790_REG_FAN_CONFIG(channel),
 				   data->fan_config[channel]);
 		break;
+	case hwmon_fan_pulses:
+		data->pulses[channel] = val;
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -317,6 +330,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
 		return 0;
+	case hwmon_fan_pulses:
+		if (channel < NR_CHANNEL)
+			return 0644;
+		return 0;
 	default:
 		return 0;
 	}
@@ -486,18 +503,18 @@ static umode_t max31790_is_visible(const void *data,
 
 static const struct hwmon_channel_info *max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
 	HWMON_CHANNEL_INFO(pwm,
 		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
@@ -534,6 +551,8 @@ static int max31790_init_client(struct regmap *regmap,
 
 		data->full_speed[i] = false;
 
+		data->pulses[i] = 2;
+
 		rv = regmap_read(regmap,
 				 MAX31790_REG_FAN_DYNAMICS(i),
 				 &val);
-- 
2.30.1

