Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0083A1FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFIWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:10:44 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37530 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:10:44 -0400
Received: by mail-ed1-f46.google.com with SMTP id b11so30342061edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Abq3ume9tcRdbWNrmPU6YWx3UjQiIgmgWGQkr6g/HEY=;
        b=bSkz0/cQA0EaKYiwcnASCFJ2210b7eTEEC4/HDNtaLkdrihAgMkq3SlEwoKX3NbYB0
         UvOzGe5DS0QUorSjVwucr+dBPAsLEMvD1QrxpQACw52Uj+YX73rU9JEYrwW/NRtEGmR4
         RcupyI/LPe9VVJGxFarCV82a++4Q1Ve4D+ye2b+a6lJx09FsKPg5EwuNjHZgrNX7ofma
         /m/esgTOp7hw+VDIsdyX4Iy/q7fewzUkcImUUyNfcdQ2lu+5+yTRW1nEwUxBpf8wOCS6
         0Am1l76FsrEzKpfZNQKsyz2sbY1aEe33Gfg6Ibrl/dPm1py8jPUhne9XKBFjSuthLz/z
         bbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Abq3ume9tcRdbWNrmPU6YWx3UjQiIgmgWGQkr6g/HEY=;
        b=PpY6kT8BCoMK5z61Iu5wzQe85ka9ctv0xhhzAIhd5M1aygbPnbX325Anb28panL6ii
         mrhk/Js/xFF/ZN8G5D/8MojsvI1JXxXyst2+1CuZgGWeEoDQHcvvwgX7T1jeHRhTjP/p
         ZADOgGeTur8gNzIHYslUz7LhrafcEUAZLRskqqV6swifYD2JW7VZ0snZ021V/0/t+K5i
         YpioP1Vm0X1vsromjJc5gKp7Y8BczY3EbGnLgtwK8Yh7Kt2ItAYBqMFDGvwtZjUXuPKu
         S43ocxrybn3DTuYJb2uux/M460aZBhV9c4IR7R6iX0BW+eZpZo5DTGIFltwhx9NwNmHi
         u32A==
X-Gm-Message-State: AOAM531xhW3d7PAZ3a4izbzNWRumkvwjLAaDeBWmGo/EZw6zU/eeBLXM
        0sxmYDUj8ypkjnyXLd4fOQaCVDojbfGV2A==
X-Google-Smtp-Source: ABdhPJx+ulvJl3UoFjiz3fLECQ/p5FfhneASlY3mav2q/8dbeMpyE5lfsuUw23fbd2wneMkaCIHQvg==
X-Received: by 2002:a05:6402:5207:: with SMTP id s7mr1468627edd.363.1623276455531;
        Wed, 09 Jun 2021 15:07:35 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id q16sm409770edt.26.2021.06.09.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:07:35 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] hwmon: (tps23861) set current shunt value
Date:   Thu, 10 Jun 2021 00:07:27 +0200
Message-Id: <20210609220728.499879-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609220728.499879-1-robert.marko@sartura.hr>
References: <20210609220728.499879-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS23861 has a configuration bit for setting of the
current shunt value used on the board.
Its bit 0 of the General Mask 1 register.

According to the datasheet bit values are:
0 for 255 mOhm (Default)
1 for 250 mOhm

So, configure the bit before registering the hwmon
device according to the value passed in the DTS or
default one if none is passed.

This caused potentially reading slightly skewed values
due to max current value being 1.02A when 250mOhm shunt
is used instead of 1.0A when 255mOhm is used.

Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/hwmon/tps23861.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index fd0be8883829..c3685b7e9e82 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -99,6 +99,9 @@
 #define POWER_ENABLE			0x19
 #define TPS23861_NUM_PORTS		4
 
+#define TPS23861_GENERAL_MASK_1		0x17
+#define TPS23861_CURRENT_SHUNT_MASK	BIT(0)
+
 #define TEMPERATURE_LSB			652 /* 0.652 degrees Celsius */
 #define VOLTAGE_LSB			3662 /* 3.662 mV */
 #define SHUNT_RESISTOR_DEFAULT		255000 /* 255 mOhm */
@@ -561,6 +564,15 @@ static int tps23861_probe(struct i2c_client *client)
 	else
 		data->shunt_resistor = SHUNT_RESISTOR_DEFAULT;
 
+	if (data->shunt_resistor == SHUNT_RESISTOR_DEFAULT)
+		regmap_clear_bits(data->regmap,
+				  TPS23861_GENERAL_MASK_1,
+				  TPS23861_CURRENT_SHUNT_MASK);
+	else
+		regmap_set_bits(data->regmap,
+				TPS23861_GENERAL_MASK_1,
+				TPS23861_CURRENT_SHUNT_MASK);
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data, &tps23861_chip_info,
 							 NULL);
-- 
2.31.1

