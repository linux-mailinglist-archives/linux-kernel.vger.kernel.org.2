Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17C37B38A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhELBcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:32:18 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:41967 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhELBcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:32:13 -0400
Received: by mail-ej1-f54.google.com with SMTP id k10so1319568ejj.8;
        Tue, 11 May 2021 18:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WR8i/rokrQe4V/fyl2CE+ag89vjaZtSHH0UvjfhpJvg=;
        b=iI3gt5CNLk+bxd2PWL2ZS9hJdPly7pQBWr242FUhMdW7lvQV7nDznWlpivhXk2XcZR
         q62WJLXSWDSYCHD0JByIMc+hhNoLC0NjaX5c86LMz5agPPtxKblNK95URm+axjB3dvNz
         a8fkUS0xZ3O7bxMk+8GW+BnCtiEyd2htZCIl3LKF3dxqeBzREkJ0b/7p+H7molh6rYfx
         UkHeYPbaxh698InVQ9AP7hmHDd/i81MJMpq7+4labLODNZ5TIVUdtGMaSeOl1Wy9yRSK
         OQVhjUNRlypfMU8f/z9a39ow6IuY/a006bmbVV8sn3zhpiz8WWwEL9Eorvdkpah0O9Fu
         M0cg==
X-Gm-Message-State: AOAM532goJmuAa3CttQ9VDxx7SF+QxTBQAFMCzFCdqDqJefwJ9dzD88U
        qmFazD6Dcubk2fCRy0iZi80=
X-Google-Smtp-Source: ABdhPJx8nK0bEhXKYi4BSCT5Hr17+qoZha1enSj9IQhomR/frypSwQS4z45IB67UIFXzUAVFYizHng==
X-Received: by 2002:a17:906:251a:: with SMTP id i26mr35059652ejb.367.1620783065474;
        Tue, 11 May 2021 18:31:05 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id cr21sm12613160ejc.2.2021.05.11.18.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 18:31:04 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH v5 4/5] hwmon: (max31790) Allow setting fan*_div
Date:   Wed, 12 May 2021 03:30:50 +0200
Message-Id: <20210512013052.903297-4-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512013052.903297-1-kubernat@cesnet.cz>
References: <20210512013052.903297-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 drivers/hwmon/max31790.c         | 66 ++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index d2ac4e926905..35afa5f0395a 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -38,6 +38,7 @@ Sysfs entries
 fan[1-12]_enable   RW  enable fan speed monitoring
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
+fan[1-12]_div      RW  set the measurable speed range, not available in RPM mode
 fan[1-6]_target    RW  desired fan speed in RPM
 pwm[1-6]_enable    RW  regulator mode, 0=no control, sets 0% PWM,
 				       1=manual (pwm) mode,
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 6e0ffbcf0d28..8b04f4c01752 100644
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
@@ -203,6 +223,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_enable:
 		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
 		return 0;
+	case hwmon_fan_div:
+		*val = get_tach_period(data->fan_config[channel]);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -254,6 +277,24 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 				   MAX31790_REG_FAN_CONFIG(channel),
 				   data->fan_config[channel]);
 		break;
+	case hwmon_fan_div:
+		if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE) {
+			err = -EINVAL;
+			break;
+		}
+		sr = bits_for_speed_range(val);
+		if (sr < 0) {
+			err = -EINVAL;
+			break;
+		}
+
+		data->fan_dynamics[channel] = ((data->fan_dynamics[channel] &
+						~MAX31790_FAN_DYN_SR_MASK) |
+					       (sr << MAX31790_FAN_DYN_SR_SHIFT));
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_DYNAMICS(channel),
+				   data->fan_dynamics[channel]);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -282,6 +323,7 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 			return 0644;
 		return 0;
 	case hwmon_fan_enable:
+	case hwmon_fan_div:
 		if (channel < NR_CHANNEL ||
 		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
@@ -432,18 +474,18 @@ static umode_t max31790_is_visible(const void *data,
 
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
2.31.1

