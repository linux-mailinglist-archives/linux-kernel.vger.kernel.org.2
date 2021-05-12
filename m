Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D437B383
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhELBcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:32:13 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39693 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhELBcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:32:09 -0400
Received: by mail-ed1-f48.google.com with SMTP id g14so25126880edy.6;
        Tue, 11 May 2021 18:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2LPQNpqysjiedw+vGFOOc8M6RDI6cAuhNGnMNZnU6c=;
        b=WlyE4qMxN1rchWv7alG+SsaZMGoOB/fo0cMaSBo17gJoqTOJEEZKY6EtL0sffug9cD
         XtYQy5TjDRzI7L5m4pPLTyyuIHECD71EvAVNk1wk6q9N3GqHKEtaoCyum9gq63AjRtT5
         f4pj0s3hY2UAbTg35w6Z3qsDKYZ4EvGSuOLZOFVupmuaiMxu9EyZrMftmtqN9FQ/Kfwq
         6hixGN1LSPQ9gRjvhDJyHpG2ILKrrPVQbgI8arzBkqAKhvKxvOpkUhee2ZFdbnm9Vk4P
         Ar35UaE3+zN4tNdG+HoWX+8N4o4SR6cFNUrcoFfzeGh1qv7xGnrK5FbR9e9DuytMd+3V
         hgdw==
X-Gm-Message-State: AOAM531k49581xclB20Wr6cvDfOXhBezckgSS17Zqnd1dHccjZuJZl/I
        Hc39LkuKIkgVoAkNySIDKlAqPlBPg4o+uacU
X-Google-Smtp-Source: ABdhPJzl3v0rxrX2LiFs6k/Q8CjrZtRJLam7OzZbR99ax5BEWmHbB82rNYaEg/C0qJYRw35DZszKTg==
X-Received: by 2002:a05:6402:c9b:: with SMTP id cm27mr33714666edb.258.1620783060449;
        Tue, 11 May 2021 18:31:00 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id e19sm15524069edv.10.2021.05.11.18.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 18:30:59 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
Date:   Wed, 12 May 2021 03:30:48 +0200
Message-Id: <20210512013052.903297-2-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512013052.903297-1-kubernat@cesnet.cz>
References: <20210512013052.903297-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
and what that does is that it sets PWM to 0% duty cycle. In the new
code, 0 in pwm*_enable turns off the "control" feature of the chip.

These two changes are closely connected together, mainly because the
detection of the pwm*_enable value depended on whether fan speed
monitoring is enabled (which is now controlled as written in the first
paragraph).

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst | 10 ++--
 drivers/hwmon/max31790.c         | 78 +++++++++++++++++++++-----------
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index f301385d8cef..d2ac4e926905 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -34,10 +34,14 @@ also be configured to serve as tachometer inputs.
 Sysfs entries
 -------------
 
-================== === =======================================================
+================== === =============================================================
+fan[1-12]_enable   RW  enable fan speed monitoring
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-6]_target    RW  desired fan speed in RPM
-pwm[1-6]_enable    RW  regulator mode, 0=disabled, 1=manual mode, 2=rpm mode
+pwm[1-6]_enable    RW  regulator mode, 0=no control, sets 0% PWM,
+				       1=manual (pwm) mode,
+				       2=rpm mode
+                       setting rpm mode sets fan*_enable to 1
 pwm[1-6]           RW  fan target duty cycle (0-255)
-================== === =======================================================
+================== === =============================================================
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index e3765ce4444a..5d4c551df010 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -30,6 +30,7 @@
 #define MAX31790_FAN_CFG_RPM_MODE	0x80
 #define MAX31790_FAN_CFG_TACH_INPUT_EN	0x08
 #define MAX31790_FAN_CFG_TACH_INPUT	0x01
+#define MAX31790_FAN_CFG_CTRL_MON	0x10
 
 /* Fan Dynamics register bits */
 #define MAX31790_FAN_DYN_SR_SHIFT	5
@@ -191,6 +192,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		else
 			*val = !!(fault & (1 << channel));
 		return 0;
+	case hwmon_fan_enable:
+		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -233,6 +237,15 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
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
@@ -260,6 +273,11 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
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
@@ -281,12 +299,12 @@ static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
 		*val = read >> 8;
 		return 0;
 	case hwmon_pwm_enable:
-		if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
+		if (data->fan_config[channel] & MAX31790_FAN_CFG_CTRL_MON)
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
@@ -298,35 +316,41 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
 	struct regmap *regmap = data->regmap;
-	u8 fan_config;
+	u8 fan_config = data->fan_config[channel];
 	int err = 0;
 
 	mutex_lock(&data->update_lock);
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		if (val < 0 || val > 255) {
+		if (fan_config & MAX31790_FAN_CFG_CTRL_MON || val < 0 || val > 255) {
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
+		if (val == 0)
+			fan_config |= MAX31790_FAN_CFG_CTRL_MON;
+		else if (val == 1) {
+			fan_config &= ~(MAX31790_FAN_CFG_RPM_MODE | MAX31790_FAN_CFG_CTRL_MON);
 		} else if (val == 2) {
-			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN |
-				      MAX31790_FAN_CFG_RPM_MODE;
+			fan_config &= ~(MAX31790_FAN_CFG_CTRL_MON);
+			fan_config |= MAX31790_FAN_CFG_RPM_MODE;
 		} else {
 			err = -EINVAL;
 			break;
 		}
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
@@ -400,18 +424,18 @@ static umode_t max31790_is_visible(const void *data,
 
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
-- 
2.31.1

