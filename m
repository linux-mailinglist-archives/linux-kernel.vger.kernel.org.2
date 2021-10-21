Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC3436763
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhJUQRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhJUQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:17:07 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F871C061764;
        Thu, 21 Oct 2021 09:14:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z126so1442810oiz.12;
        Thu, 21 Oct 2021 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88bO+rRoidhXyrO2Csn2W7v7IjR4W0OvBh5VSm4oxVY=;
        b=I5BsrFJutrkmk4oe+/Mp1H/DG3CqK32hU+aQXgKmvcGXbCdqey43R4BhOTznENwMFS
         T/etc54nKqfvopWBEntzwpSM6YyP52yJRbl072fdecdLGGbEwlDcYCQZfzrQA1t73b/o
         tUYH2bc3KM1uSaINBBRgi0hm7f64OEdh/a785K7/WIKhhnBwGAEgElIB5bGNQPR0JEl9
         g0Aldzuwa9UfucdZC4WIsDf+ZnADcCXaet/vhZ5+FSJbqWP7m+SDaiDSmUusOUqVLxS9
         MpGvTMZl1QaJW+Q6FJHo9X5PLM34VqJ7+s9e8w9h0bXiqy2WjbdwRtx4XkTLEI3m3LJA
         p+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=88bO+rRoidhXyrO2Csn2W7v7IjR4W0OvBh5VSm4oxVY=;
        b=SIyaFN60Nk2ybiW19J3wiCe2K4TUUQ1gO1Q34zaQkBW+/Aj4CKDwuhmsfdtQFUJXC0
         89MnpVJd0tQPd4VGoI6LAbgrwtRDdir20l8X5EkZDBvengKQ+28tZaUNmEr0Y4m4puSw
         s/+cogSbE3ev5294A9BdV2fjBpFJLHqD8GXZjyfB555Rtw0PBlP58geINpYTExy3F9dl
         7eabA5JqLTbNP5vHZkvQK0FJ+Qdz3guLC6bmuolORgGIh2fWTP+bu/cYae97sJGAP6Vg
         G1vsl70gYGN3fESTOKyY6opJ5UkoNKgyX/ygGQzqbLAEWja0QMI1y4azuuKtpGY60/RH
         xxNg==
X-Gm-Message-State: AOAM533UpvKj/182d2yyMMEz0xf3eDWkv39rUxozz+5ZXa2FSw2PabWy
        aKFnar/15/U+fYIBB2kdkws=
X-Google-Smtp-Source: ABdhPJyKaRw5jn0baL2w7t20q/b3G7W68CjrDp3U6AbjwDw17PwHY5sh8k1i1UWIaah+f/YngTsT1Q==
X-Received: by 2002:aca:acd4:: with SMTP id v203mr5294573oie.170.1634832890728;
        Thu, 21 Oct 2021 09:14:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17sm1173334otm.50.2021.10.21.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:14:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "David T . Wilson" <david.wilson@nasa.gov>
Subject: [PATCH v2 2/3] hwmon: (lm90) Add basic support for TI TMP461
Date:   Thu, 21 Oct 2021 09:14:43 -0700
Message-Id: <20211021161444.3145112-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021161444.3145112-1-linux@roeck-us.net>
References: <20211021161444.3145112-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TMP461 is almost identical to TMP451 and was actually detected as TMP451
with the existing lm90 driver if its I2C address is 0x4c. Add support
for it to the lm90 driver. At the same time, improve the chip detection
function to at least try to distinguish between TMP451 and TMP461.

As a side effect, this fixes commit 24333ac26d01 ("hwmon: (tmp401) use
smb word operations instead of 2 smb byte operations"). TMP461 does not
support word operations on temperature registers, which causes bad
temperature readings with the tmp401 driver. The lm90 driver does not
perform word operations on temperature registers and thus does not have
this problem.

Support is listed as basic because TMP461 supports a sensor resolution
of 0.0625 degrees C, while the lm90 driver assumes a resolution of 0.125
degrees C. Also, the TMP461 supports negative temperatures with its
default temperature range, which is not the case for similar chips
supported by the lm90 and the tmp401 drivers. Those limitations will be
addressed with follow-up patches.

Fixes: 24333ac26d01 ("hwmon: (tmp401) use smb word operations instead of 2 smb byte operations")
Reported-by: David T. Wilson <david.wilson@nasa.gov>
Cc: David T. Wilson <david.wilson@nasa.gov>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fixed DFC register address
    Describe support as basic, and explain reason
    Split introduction of LM90_HAVE_EXTENDED_TEMP into seperate patch

 Documentation/hwmon/lm90.rst | 10 +++++++
 drivers/hwmon/Kconfig        |  2 +-
 drivers/hwmon/lm90.c         | 54 ++++++++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 3da8c6e06a36..05391fb4042d 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -265,6 +265,16 @@ Supported chips:
 
 	       https://www.ti.com/litv/pdf/sbos686
 
+  * Texas Instruments TMP461
+
+    Prefix: 'tmp461'
+
+    Addresses scanned: I2C 0x48 through 0x4F
+
+    Datasheet: Publicly available at TI website
+
+	       https://www.ti.com/lit/gpn/tmp461
+
 Author: Jean Delvare <jdelvare@suse.de>
 
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c4578e8f34bb..ccdaeafed0bb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1317,7 +1317,7 @@ config SENSORS_LM90
 	  Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6654, MAX6657, MAX6658,
 	  MAX6659, MAX6680, MAX6681, MAX6692, MAX6695, MAX6696,
 	  ON Semiconductor NCT1008, Winbond/Nuvoton W83L771W/G/AWG/ASG,
-	  Philips SA56004, GMT G781, and Texas Instruments TMP451
+	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
 
 	  This driver can also be built as a module. If so, the module
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 1a1d7bfcb30b..618052c6cdb6 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -69,10 +69,10 @@
  * This driver also supports the G781 from GMT. This device is compatible
  * with the ADM1032.
  *
- * This driver also supports TMP451 from Texas Instruments. This device is
- * supported in both compatibility and extended mode. It's mostly compatible
- * with ADT7461 except for local temperature low byte register and max
- * conversion rate.
+ * This driver also supports TMP451 and TMP461 from Texas Instruments.
+ * Those devices are supported in both compatibility and extended mode.
+ * They are mostly compatible with ADT7461 except for local temperature
+ * low byte register and max conversion rate.
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -112,7 +112,7 @@ static const unsigned short normal_i2c[] = {
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
-	max6646, w83l771, max6696, sa56004, g781, tmp451, max6654 };
+	max6646, w83l771, max6696, sa56004, g781, tmp451, tmp461, max6654 };
 
 /*
  * The LM90 registers
@@ -168,8 +168,12 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 
 #define LM90_MAX_CONVRATE_MS	16000	/* Maximum conversion rate in ms */
 
-/* TMP451 registers */
+/* TMP451/TMP461 registers */
 #define TMP451_REG_R_LOCAL_TEMPL	0x15
+#define TMP451_REG_CONALERT		0x22
+
+#define TMP461_REG_CHEN			0x16
+#define TMP461_REG_DFC			0x24
 
 /*
  * Device flags
@@ -230,6 +234,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
 	{ "tmp451", tmp451 },
+	{ "tmp461", tmp461 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm90_id);
@@ -327,6 +332,10 @@ static const struct of_device_id __maybe_unused lm90_of_match[] = {
 		.compatible = "ti,tmp451",
 		.data = (void *)tmp451
 	},
+	{
+		.compatible = "ti,tmp461",
+		.data = (void *)tmp461
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lm90_of_match);
@@ -428,6 +437,13 @@ static const struct lm90_params lm90_params[] = {
 		.max_convrate = 9,
 		.reg_local_ext = TMP451_REG_R_LOCAL_TEMPL,
 	},
+	[tmp461] = {
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP,
+		.alert_alarms = 0x7c,
+		.max_convrate = 9,
+		.reg_local_ext = TMP451_REG_R_LOCAL_TEMPL,
+	},
 };
 
 /*
@@ -1628,18 +1644,26 @@ static int lm90_detect(struct i2c_client *client,
 		 && convrate <= 0x08)
 			name = "g781";
 	} else
-	if (address == 0x4C
-	 && man_id == 0x55) { /* Texas Instruments */
-		int local_ext;
+	if (man_id == 0x55 && chip_id == 0x00 &&
+	    (config1 & 0x1B) == 0x00 && convrate <= 0x09) {
+		int local_ext, conalert, chen, dfc;
 
 		local_ext = i2c_smbus_read_byte_data(client,
 						     TMP451_REG_R_LOCAL_TEMPL);
-
-		if (chip_id == 0x00 /* TMP451 */
-		 && (config1 & 0x1B) == 0x00
-		 && convrate <= 0x09
-		 && (local_ext & 0x0F) == 0x00)
-			name = "tmp451";
+		conalert = i2c_smbus_read_byte_data(client,
+						    TMP451_REG_CONALERT);
+		chen = i2c_smbus_read_byte_data(client, TMP461_REG_CHEN);
+		dfc = i2c_smbus_read_byte_data(client, TMP461_REG_DFC);
+
+		if ((local_ext & 0x0F) == 0x00 &&
+		    (conalert & 0xf1) == 0x01 &&
+		    (chen & 0xfc) == 0x00 &&
+		    (dfc & 0xfc) == 0x00) {
+			if (address == 0x4c && !(chen & 0x03))
+				name = "tmp451";
+			else if (address >= 0x48 && address <= 0x4f)
+				name = "tmp461";
+		}
 	}
 
 	if (!name) { /* identification failed */
-- 
2.33.0

