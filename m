Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD433DBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhCPR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:57:28 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41947 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbhCPR4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:56:04 -0400
Received: by mail-ej1-f42.google.com with SMTP id lr13so73713436ejb.8;
        Tue, 16 Mar 2021 10:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3edIuyjq57ahTfo6TpK7NVyellwm078SD4itITOhAD8=;
        b=s6tTE+QYKRUkM6j8xl33XGvzsFZbgzxl9cDnDpQm1TGFeXTdqUIFpAFPtHZPvCjE11
         pYAjv2sFR/iVWitjU2BPYMIh1eYabwmbGLY2yp2UO3/TOburC6ykX009Zz3qPXUqROeJ
         URP142sjcx+6hbSw6UkzJzL+1U+dRLJkkCNkqzMXWOE5n1kwFpbkU2aFY+pjF9XRLlFi
         wFo9ZsGZfUte1jA8Jr6lrFX5zgMtd+wz7P2+J88nLPVqQVYiYcmn7HJUMeL8rm77ezcz
         foEAU6h9/jOE3HEOtsJ911XEDJWHvR/Vbcrz5WI1VoymGQSRiTXY4+tFvMFYYsHY2YPs
         087g==
X-Gm-Message-State: AOAM533PCTyq66RC7II9f2jbO+62kRlZhoI/a92yS68NJzQaRsU67N2E
        MvVU6aevn+TJdTaBG9yUY9c=
X-Google-Smtp-Source: ABdhPJw61/Q89NJaWXxCxEGc1bTkaFK4RxpWZJW72oFFH+I596OhbyQG+BTqvOg4HB2Qvge8CRxbHQ==
X-Received: by 2002:a17:906:d8d3:: with SMTP id re19mr31266952ejb.440.1615917362966;
        Tue, 16 Mar 2021 10:56:02 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id p9sm10538828eds.66.2021.03.16.10.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:56:02 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] hwmon: (max31790) Allow setting fan*_div
Date:   Tue, 16 Mar 2021 18:55:01 +0100
Message-Id: <20210316175503.1003051-4-kubernat@cesnet.cz>
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

Right now, the divisor (which determines the speed range) is only set
when in RPM mode. However, the speed range also affects the input RPM,
which means, to get more accurate readings, this speed range needs to be
set.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst |  1 +
 drivers/hwmon/max31790.c         | 79 +++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 8979c8a02cd1..2979addeac8f 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -38,6 +38,7 @@ Sysfs entries
 fan[1-12]_enable   RW  enable fan speed monitoring
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
+fan[1-12]_div      RW  set the measurable speed range, not available in RPM mode
 fan[1-6]_target    RW  desired fan speed in RPM
 pwm[1-6]_enable    RW  regulator mode, 0=full speed, 1=manual (pwm) mode, 2=rpm mode
                        setting rpm mode sets fan*_enable to 1
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 7b47797db471..235a71bbff84 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -156,6 +156,26 @@ static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
 	return regmap_bulk_write(regmap, reg, bulk_val, 2);
 }
 
+static int bits_for_speed_range(long speed_range)
+{
+	switch (speed_range) {
+	case 1:
+		return 0x0;
+	case 2:
+		return 0x1;
+	case 4:
+		return 0x2;
+	case 8:
+		return 0x3;
+	case 16:
+		return 0x4;
+	case 32:
+		return 0x5;
+	default:
+		return -1;
+	}
+}
+
 static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
@@ -228,6 +248,13 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 
 		*val = !!(cfg & MAX31790_FAN_CFG_TACH_INPUT_EN);
 		return 0;
+	case hwmon_fan_div:
+		cfg = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (cfg < 0)
+			return cfg;
+
+		*val = get_tach_period(cfg);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -281,6 +308,33 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 			cfg |= MAX31790_FAN_CFG_TACH_INPUT_EN;
 		err = regmap_write(regmap, MAX31790_REG_FAN_CONFIG(channel), cfg);
 		break;
+	case hwmon_fan_div:
+		cfg = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (cfg < 0)
+			return cfg;
+
+		if (cfg & MAX31790_FAN_CFG_RPM_MODE) {
+			err = -EINVAL;
+			break;
+		}
+		sr = bits_for_speed_range(val);
+		if (sr < 0) {
+			err = -EINVAL;
+			break;
+		}
+
+		fan_dynamics = read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(channel));
+
+		if (fan_dynamics < 0)
+			return fan_dynamics;
+
+		fan_dynamics = ((fan_dynamics &
+				 ~MAX31790_FAN_DYN_SR_MASK) |
+				(sr << MAX31790_FAN_DYN_SR_SHIFT));
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_DYNAMICS(channel),
+				   fan_dynamics);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -311,6 +365,7 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 			return 0644;
 		return 0;
 	case hwmon_fan_enable:
+	case hwmon_fan_div:
 		if (channel < NR_CHANNEL ||
 		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
@@ -485,18 +540,18 @@ static umode_t max31790_is_visible(const void *data,
 
 static const struct hwmon_channel_info *max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_DIV | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-- 
2.30.2

