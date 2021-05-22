Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8438D567
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhEVK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:57:08 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:28590 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhEVK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:57:02 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id B4124246CFE4
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:55:34 +0200 (CEST)
Received: from s899.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id A345B2E2B88B;
        Sat, 22 May 2021 12:55:34 +0200 (CEST)
Received: from s470.loopia.se (unknown [172.22.191.6])
        by s899.loopia.se (Postfix) with ESMTP id 9ECBF2C8B9A3;
        Sat, 22 May 2021 12:55:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.6])
        by s470.loopia.se (s470.loopia.se [172.22.190.10]) (amavisd-new, port 10024)
        with LMTP id cd9Idoel1OxB; Sat, 22 May 2021 12:55:33 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 628237CE964;
        Sat, 22 May 2021 12:55:33 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 2/6] hwmon: (pmbus/pim4328) Add function for reading direct mode coefficients
Date:   Sat, 22 May 2021 12:55:24 +0200
Message-Id: <20210522105528.87629-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210522105528.87629-1-erik.rosen@metormote.com>
References: <20210522105528.87629-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the function pmbus_read_coefficients to pmbus_core to be able to
read and decode the coefficients for the direct format for a certain
command and read/write direction.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  4 ++++
 drivers/hwmon/pmbus/pmbus_core.c | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 3968924f8533..d9ed9736b480 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -499,6 +499,10 @@ int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
+int pmbus_read_coefficients(struct i2c_client *client,
+			    struct pmbus_driver_info *info,
+			    enum pmbus_sensor_classes sensor_class,
+			    u8 command);
 struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
 
 #endif /* PMBUS_H */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb885efc4fba..460cbfd716e4 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -301,6 +301,44 @@ int pmbus_update_fan(struct i2c_client *client, int page, int id,
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_update_fan, PMBUS);
 
+/*
+ * Read the coefficients for direct mode.
+ */
+int pmbus_read_coefficients(struct i2c_client *client,
+			    struct pmbus_driver_info *info,
+			    enum pmbus_sensor_classes sensor_class,
+			    u8 command)
+{
+	int rv;
+	union i2c_smbus_data data;
+	s8 R;
+	s16 m, b;
+
+	data.block[0] = 2;
+	data.block[1] = command;
+	data.block[2] = 0x01;
+
+	rv = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			    I2C_SMBUS_WRITE, PMBUS_COEFFICIENTS,
+			    I2C_SMBUS_BLOCK_PROC_CALL, &data);
+
+	if (rv < 0)
+		return rv;
+
+	if (data.block[0] != 5)
+		return -EIO;
+
+	m = data.block[1] | (data.block[2] << 8);
+	b = data.block[3] | (data.block[4] << 8);
+	R = data.block[5];
+	info->m[sensor_class] = m;
+	info->b[sensor_class] = b;
+	info->R[sensor_class] = R;
+
+	return rv;
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_read_coefficients, PMBUS);
+
 int pmbus_read_word_data(struct i2c_client *client, int page, int phase, u8 reg)
 {
 	int rv;
-- 
2.20.1

