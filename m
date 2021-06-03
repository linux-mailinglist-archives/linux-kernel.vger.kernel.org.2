Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6B39A1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFCNQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:16:25 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41785 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhFCNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:16:25 -0400
Received: by mail-ed1-f52.google.com with SMTP id g18so5061336edq.8;
        Thu, 03 Jun 2021 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scT1hIUpHPncOBtJqn4yX/G5/X9IBl2kc3/uzv7YyLg=;
        b=KRxF0u1stU7XueshckPqrbGBuuYuw2sqaROMtfeNjBw/3mZhmfOxAMh3ilW1TjbWaC
         H+VYrqrS/fMazOd+TTQw8gAwuWTeF71vMvLTo5KhG/0NF/cxDEyGBrWyWLjHyVRDOM6v
         oQ5ZEO6tomLbk7ObSdq8GZRtECj9HvpY8cjt/6OHPsPdbadEEdR4ZWkRsCLkkPlLnPbD
         5nm+k3fyeuDCxVgHoqrvfXX7KhwX1ZsTc57z87cvLP+ftQXR1dh0OnCjJd6coTfOe9cN
         E8mumFnm72T84k8gNj6FSoicWIY+2PYmB9YYACogDDYExypTWAn6g80W5kfClOiX7gdr
         q/8A==
X-Gm-Message-State: AOAM533epdUcjZ+S5eNLvvUv4j2DS9aMfxPeUy3bgBT/CU5mnjg9VA/c
        s2/966fsDREnz92TDwAw+cm9AJm+C22AA6tS
X-Google-Smtp-Source: ABdhPJyhGRPBYdqGdDLrF/kC2HF0ciolZyCvKTwWlxWQjtebBsJXoEuowAlSjxnvXw9QEjTmIgvusg==
X-Received: by 2002:a05:6402:3c1:: with SMTP id t1mr28652498edw.270.1622726079523;
        Thu, 03 Jun 2021 06:14:39 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id z20sm1498821ejd.18.2021.06.03.06.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:14:39 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH] hwmon: (max31790) Add support for fanX_div
Date:   Thu,  3 Jun 2021 15:14:21 +0200
Message-Id: <20210603131421.67235-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the divisor (which determines the speed range) can be only
set by setting fanX_min or fanX_target. This is fine for RPM mode, but
in other cases, it might not be enough. This patch makes it possible to
set the divisor independently.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst |  4 ++
 drivers/hwmon/max31790.c         | 68 ++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 9225c2a78b68..818e4fe8c797 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -50,6 +50,10 @@ fan[1-12]_min      RW  minimum fan speed in RPM. Equivalent to target fan speed
                        and the chip will report a fault condition if the fan
                        speed is below the target fan speed.
 fan[1-6]_target    RW  desired fan speed in RPM
+fan[1-12]_div      RW  fan speed range
+		       The value is RO for companion channels (7-12). For those
+		       channels, the value matches the value of the primary channel.
+		       Setting fanX_target or fanX_min also sets this value.
 pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
 pwm[1-6]           RW  read: current pwm duty cycle,
                        write: target pwm duty cycle (0-255)
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 39a4ece4276a..f6c38094c19c 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -160,6 +160,26 @@ static u8 bits_for_tach_period(int rpm)
 	return bits;
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
@@ -173,6 +193,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_enable:
 		*val = !!(data->fan_config[channel % NR_CHANNEL] & MAX31790_FAN_CFG_TACH_INPUT_EN);
 		return 0;
+	case hwmon_fan_div:
+		*val = get_tach_period(data->fan_dynamics[channel % NR_CHANNEL]);
+		return 0;
 	case hwmon_fan_input:
 		sr = get_tach_period(data->fan_dynamics[channel % NR_CHANNEL]);
 		if (data->tach[channel] == FAN_COUNT_REG_MAX)
@@ -293,6 +316,20 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 					MAX31790_REG_TARGET_COUNT(channel),
 					data->target_count[channel]);
 		break;
+	case hwmon_fan_div:
+		sr = bits_for_speed_range(val);
+		if (sr < 0) {
+			err = -EINVAL;
+			break;
+		}
+
+		data->fan_dynamics[channel] = ((data->fan_dynamics[channel] &
+						~MAX31790_FAN_DYN_SR_MASK) |
+					       (sr << MAX31790_FAN_DYN_SR_SHIFT));
+		err = i2c_smbus_write_byte_data(client,
+						MAX31790_REG_FAN_DYNAMICS(channel),
+						data->fan_dynamics[channel]);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -311,6 +348,7 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 	switch (attr) {
 	case hwmon_fan_min:
 	case hwmon_fan_enable:
+	case hwmon_fan_div:
 		if (channel < NR_CHANNEL)
 			return 0644;
 		if (fan_config & MAX31790_FAN_CFG_TACH_INPUT)
@@ -481,23 +519,29 @@ static umode_t max31790_is_visible(const void *data,
 static const struct hwmon_channel_info *max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_TARGET |
-				HWMON_F_FAULT,
+				HWMON_F_FAULT | HWMON_F_DIV,
 			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_TARGET |
-				HWMON_F_FAULT,
+				HWMON_F_FAULT | HWMON_F_DIV,
 			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_TARGET |
-				HWMON_F_FAULT,
+				HWMON_F_FAULT | HWMON_F_DIV,
 			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_TARGET |
-				HWMON_F_FAULT,
+				HWMON_F_FAULT | HWMON_F_DIV,
 			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_TARGET |
-				HWMON_F_FAULT,
+				HWMON_F_FAULT | HWMON_F_DIV,
 			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_TARGET |
-				HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT),
+				HWMON_F_FAULT | HWMON_F_DIV,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT |
+				HWMON_F_DIV,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT |
+				HWMON_F_DIV,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT |
+				 HWMON_F_DIV,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT |
+				 HWMON_F_DIV,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT |
+				   HWMON_F_DIV,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT |
+				   HWMON_F_DIV),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-- 
2.31.1

