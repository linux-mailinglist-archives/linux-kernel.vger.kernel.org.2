Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B632D169
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhCDLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:01:24 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45982 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbhCDLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:51 -0500
Received: by mail-wr1-f51.google.com with SMTP id e10so26893195wro.12;
        Thu, 04 Mar 2021 03:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j11ELa20Vtg3isYzKy25uBKJEW/3+jwmRaEWBM3QmLE=;
        b=EielAtLuBt7I/4vibrAXxL1zF7aQmMYc6Nb58ubh7EaXivAC6WBA7GWJvUWSOIxSFd
         31TPdKzFqyIurIBFnZrevT+xRuCm9C0sb7thK9DXd/XdGkV3ks1UaAf7sjrEnygW785b
         wKon9FVOryOiMz4F6zHTP9i9wogkgpjCYumgXnHYRusVrVAfqT6HpRtccXcRAU6oU8F8
         sZgfS4KfZKeBkEgLtcqFbRBqo49ya3YHdZlPOeB5Eq/XD11vFLUNZsB+Jg2iEbwxpftF
         w61PB3u3eN2AmAkXLIO1FhVYF15SMwYMfz6FcpnGivIPWqgC095RX35Ox2ugTPCTsE4T
         18uQ==
X-Gm-Message-State: AOAM533lIkfWPw0hSQdn7F/38hRKBBsUg2hQXZnOya3dZEnOFbhhHzVi
        +A3+H2SoZWjWyHvzon4fxBY=
X-Google-Smtp-Source: ABdhPJzsVXvIh0xa6gr7OSr1ofLBYNBmFNIrxTNrsazVAQV8bVFC5uVtLPX9SSpzJs7QkIcLXR0E7A==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr3581784wrr.30.1614855610437;
        Thu, 04 Mar 2021 03:00:10 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id s16sm7952579wru.91.2021.03.04.03.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:10 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] hwmon: (max31790) Allow setting fan*_div
Date:   Thu,  4 Mar 2021 11:58:29 +0100
Message-Id: <20210304105830.507176-6-kubernat@cesnet.cz>
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

Right now, the divisor (which determines the speed range) is only set
when in RPM mode. However, the speed range also affects the input RPM,
which means, to get more accurate readings, this speed range needs to be
set.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst |  1 +
 drivers/hwmon/max31790.c         | 46 +++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 8d86698b25de..627816fa45fb 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -39,6 +39,7 @@ fan[1-12]_enable   RW  enable fan speed monitoring
 fan[1-12]_pulses   RW  pulses per fan revolution (default: 2)
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
+fan[1-12]_div      RW  set the measurable speed range, not available in RPM mode
 fan[1-6]_target    RW  desired fan speed in RPM
 pwm[1-6]_enable    RW  regulator mode, 0=full speed, 1=manual (pwm) mode, 2=rpm mode
                        setting rpm mode sets fan*_enable to 1
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index d4f259dd4e19..12eab8817c8a 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -57,7 +57,8 @@
 #define U16_LSB(num)			((num) & 0x00FF)
 
 #define FAN_INFO_1_TO_6 \
-	(HWMON_F_PULSES | \
+	(HWMON_F_DIV | \
+	HWMON_F_PULSES | \
 	HWMON_F_ENABLE | \
 	HWMON_F_INPUT | \
 	HWMON_F_TARGET | \
@@ -221,6 +222,26 @@ static u8 bits_for_tach_period(int rpm)
 	return bits;
 }
 
+static int bits_for_speed_range(int speed_range)
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
@@ -264,6 +285,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_pulses:
 		*val = data->pulses[channel];
 		return 0;
+	case hwmon_fan_div:
+		*val = get_tach_period(data->fan_config[channel]);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -321,6 +345,25 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 	case hwmon_fan_pulses:
 		data->pulses[channel] = val;
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
+		data->fan_dynamics[channel] =
+			((data->fan_dynamics[channel] &
+			  ~MAX31790_FAN_DYN_SR_MASK) |
+			 (sr << MAX31790_FAN_DYN_SR_SHIFT));
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_DYNAMICS(channel),
+				   data->fan_dynamics[channel]);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -353,6 +396,7 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
 		return 0;
+	case hwmon_fan_div:
 	case hwmon_fan_pulses:
 		if (channel < NR_CHANNEL)
 			return 0644;
-- 
2.30.1

