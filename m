Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5935D597
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbhDMDCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:02:35 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41653 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhDMDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:02:32 -0400
Received: by mail-wr1-f51.google.com with SMTP id a6so14891310wrw.8;
        Mon, 12 Apr 2021 20:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STbQZp9ZUqaD/+3/ll6RetQlHF6pL3plbWel+KQmrKg=;
        b=YXSLkIcGCttYt4rDlj0Ir3gtq61WOXvSJSLy07jGVtEzMn4KLspAdGEvrS2Uvv2BVm
         Epb4LIsxuGMPx5YUxZQLyPd5qBMRsB6Z3uQtcKTPsRuF8qf275NFp5H3h5/rEZ78szRC
         S0TELOl+RllhJYyF6cPYr8/RNkumoOZOzZvkzDOU5ejYVQ0ox1DURI70rpTkZyb1walX
         3Vf26wNBFZ97Fz0veG6AON4Y/G/ZMxJpnWTGfa5DJF00Ce8FCpK2AOXx+gNWKAKoY6d2
         5fQArqGA+OOl2O57J1ASYS5BYyByVz0r7JICY+ZVFWeEkgJZx49LAuF9JYiLOO01UP3l
         1Ukg==
X-Gm-Message-State: AOAM531AEupiEH84FRmnmyLDwlMFbVC/a+3dxwUkJ159a2ooGESAh5Qn
        f/UPu/jMtdXtdw1FKqCQ2FM=
X-Google-Smtp-Source: ABdhPJy9iDHw+evX3IRTOO4FgFNqUy1rjacf8QfoInnpf8PlBhcTzfLbGuh8uzlbfUxqNbU8CePQFQ==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr10405911wrt.60.1618282932473;
        Mon, 12 Apr 2021 20:02:12 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id v4sm20886560wrf.36.2021.04.12.20.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 20:02:12 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] hwmon: (max31790) Allow setting fan*_div
Date:   Tue, 13 Apr 2021 04:59:47 +0200
Message-Id: <20210413025948.901867-4-kubernat@cesnet.cz>
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
index 4fea32ff63bb..5fdfbf0f2809 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -157,6 +157,26 @@ static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
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
@@ -204,6 +224,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_enable:
 		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
 		return 0;
+	case hwmon_fan_div:
+		*val = get_tach_period(data->fan_config[channel]);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -255,6 +278,24 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
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
@@ -283,6 +324,7 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 			return 0644;
 		return 0;
 	case hwmon_fan_enable:
+	case hwmon_fan_div:
 		if (channel < NR_CHANNEL ||
 		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
@@ -441,18 +483,18 @@ static umode_t max31790_is_visible(const void *data,
 
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

