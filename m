Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93981369639
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbhDWPe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:34:28 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:44883 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbhDWPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:34:26 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 3529A1A93066
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:33:48 +0200 (CEST)
Received: from s630.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 24B962E3A4DD;
        Fri, 23 Apr 2021 17:33:48 +0200 (CEST)
Received: from s472.loopia.se (unknown [172.22.191.6])
        by s630.loopia.se (Postfix) with ESMTP id 014BB13B9442;
        Fri, 23 Apr 2021 17:33:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.5])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id scopPxdAAyzk; Fri, 23 Apr 2021 17:33:46 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.157
Received: from localhost.localdomain (h-155-4-131-157.NA.cust.bahnhof.se [155.4.131.157])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 8A60D157A052;
        Fri, 23 Apr 2021 17:33:46 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 1/2] hwmon: (pmbus/zl6100) Add support for ZLS1003, ZLS4009 and ZL8802
Date:   Fri, 23 Apr 2021 17:33:28 +0200
Message-Id: <20210423153329.33457-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210423153329.33457-1-erik.rosen@metormote.com>
References: <20210423153329.33457-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Renesas ZL8802 Dual Channel/Dual Phase PMBus DC/DC
Digital Controller as well as ZLS1003 and ZLS4009 custom DC/DC
controller chips.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/zl6100.c | 94 ++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 69120ca7aaa8..757039bb8a62 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -18,7 +18,7 @@
 #include "pmbus.h"
 
 enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105,
-	     zl9101, zl9117 };
+	     zl8802, zl9101, zl9117, zls1003, zls4009 };
 
 struct zl6100_data {
 	int id;
@@ -34,6 +34,13 @@ struct zl6100_data {
 
 #define ZL6100_MFR_XTEMP_ENABLE		BIT(7)
 
+#define ZL8802_MFR_USER_GLOBAL_CONFIG	0xe9
+#define ZL8802_MFR_TMON_ENABLE		BIT(12)
+#define ZL8802_MFR_USER_CONFIG		0xd1
+#define ZL8802_MFR_XTEMP_ENABLE_2	BIT(1)
+#define ZL8802_MFR_DDC_CONFIG		0xd3
+#define ZL8802_MFR_PHASES_MASK		0x0007
+
 #define MFR_VMON_OV_FAULT_LIMIT		0xf5
 #define MFR_VMON_UV_FAULT_LIMIT		0xf6
 #define MFR_READ_VMON			0xf7
@@ -132,7 +139,7 @@ static int zl6100_read_word_data(struct i2c_client *client, int page,
 	struct zl6100_data *data = to_zl6100_data(info);
 	int ret, vreg;
 
-	if (page > 0)
+	if (page >= info->pages)
 		return -ENXIO;
 
 	if (data->id == zl2005) {
@@ -191,7 +198,7 @@ static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
 	struct zl6100_data *data = to_zl6100_data(info);
 	int ret, status;
 
-	if (page > 0)
+	if (page >= info->pages)
 		return -ENXIO;
 
 	zl6100_wait(data);
@@ -230,7 +237,7 @@ static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
 	struct zl6100_data *data = to_zl6100_data(info);
 	int ret, vreg;
 
-	if (page > 0)
+	if (page >= info->pages)
 		return -ENXIO;
 
 	switch (reg) {
@@ -271,7 +278,7 @@ static int zl6100_write_byte(struct i2c_client *client, int page, u8 value)
 	struct zl6100_data *data = to_zl6100_data(info);
 	int ret;
 
-	if (page > 0)
+	if (page >= info->pages)
 		return -ENXIO;
 
 	zl6100_wait(data);
@@ -287,6 +294,10 @@ static const struct i2c_device_id zl6100_id[] = {
 	{"bmr462", zl2008},
 	{"bmr463", zl2008},
 	{"bmr464", zl2008},
+	{"bmr465", zls4009},
+	{"bmr466", zls1003},
+	{"bmr467", zls4009},
+	{"bmr469", zl8802},
 	{"zl2004", zl2004},
 	{"zl2005", zl2005},
 	{"zl2006", zl2006},
@@ -295,15 +306,18 @@ static const struct i2c_device_id zl6100_id[] = {
 	{"zl2106", zl2106},
 	{"zl6100", zl6100},
 	{"zl6105", zl6105},
+	{"zl8802", zl8802},
 	{"zl9101", zl9101},
 	{"zl9117", zl9117},
+	{"zls1003", zls1003},
+	{"zls4009", zls4009},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zl6100_id);
 
 static int zl6100_probe(struct i2c_client *client)
 {
-	int ret;
+	int ret, i;
 	struct zl6100_data *data;
 	struct pmbus_driver_info *info;
 	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
@@ -367,18 +381,70 @@ static int zl6100_probe(struct i2c_client *client)
 	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
 	/*
-	 * ZL2004, ZL9101M, and ZL9117M support monitoring an extra voltage
-	 * (VMON for ZL2004, VDRV for ZL9101M and ZL9117M). Report it as vmon.
+	 * ZL2004, ZL8802, ZL9101M, ZL9117M and ZLS4009 support monitoring
+	 * an extra voltage (VMON for ZL2004, ZL8802 and ZLS4009,
+	 * VDRV for ZL9101M and ZL9117M). Report it as vmon.
 	 */
-	if (data->id == zl2004 || data->id == zl9101 || data->id == zl9117)
+	if (data->id == zl2004 || data->id == zl8802 || data->id == zl9101 ||
+	    data->id == zl9117 || data->id == zls4009)
 		info->func[0] |= PMBUS_HAVE_VMON | PMBUS_HAVE_STATUS_VMON;
 
-	ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
-	if (ret < 0)
-		return ret;
+	/*
+	 * ZL8802 has two outputs that can be used either independently or in
+	 * a current sharing configuration. The driver uses the DDC_CONFIG
+	 * register to check if the module is running with independent or
+	 * shared outputs. If the module is in shared output mode, only one
+	 * output voltage will be reported.
+	 */
+	if (data->id == zl8802) {
+		info->pages = 2;
+		info->func[0] |= PMBUS_HAVE_IIN;
+
+		ret = i2c_smbus_read_word_data(client, ZL8802_MFR_DDC_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		data->access = ktime_get();
+		zl6100_wait(data);
+
+		if (ret & ZL8802_MFR_PHASES_MASK)
+			info->func[1] |= PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+		else
+			info->func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+				| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 
-	if (ret & ZL6100_MFR_XTEMP_ENABLE)
-		info->func[0] |= PMBUS_HAVE_TEMP2;
+		for (i = 0; i < 2; i++) {
+			ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
+			if (ret < 0)
+				return ret;
+
+			data->access = ktime_get();
+			zl6100_wait(data);
+
+			ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_CONFIG);
+			if (ret < 0)
+				return ret;
+
+			if (ret & ZL8802_MFR_XTEMP_ENABLE_2)
+				info->func[i] |= PMBUS_HAVE_TEMP2;
+
+			data->access = ktime_get();
+			zl6100_wait(data);
+		}
+		ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_GLOBAL_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		if (ret & ZL8802_MFR_TMON_ENABLE)
+			info->func[0] |= PMBUS_HAVE_TEMP3;
+	} else {
+		ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		if (ret & ZL6100_MFR_XTEMP_ENABLE)
+			info->func[0] |= PMBUS_HAVE_TEMP2;
+	}
 
 	data->access = ktime_get();
 	zl6100_wait(data);
-- 
2.20.1

