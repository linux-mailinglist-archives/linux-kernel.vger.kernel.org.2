Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5316C4136B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhIUPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:54:30 -0400
Received: from mail.ispras.ru ([83.149.199.84]:50686 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234231AbhIUPyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:54:09 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id E5DCC40D3BFF;
        Tue, 21 Sep 2021 15:52:34 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v2 1/3] hwmon: (w83791d) Fix NULL pointer dereference by removing unnecessary structure field
Date:   Tue, 21 Sep 2021 18:51:51 +0300
Message-Id: <20210921155153.28098-1-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811181844.GB3138792@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver read val value sufficient for 
(val & 0x08) && (!(val & 0x80)) && ((val & 0x7) == ((val >> 4) & 0x7))
from device then Null pointer dereference occurs. 
(It is possible if tmp = 0b0xyz1xyz, where same literals mean same numbers)
Also lm75[] does not serve a purpose anymore after switching to
devm_i2c_new_dummy_device() in w83791d_detect_subclients().

The patch fixes possible NULL pointer dereference by removing lm75[].

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
---
v2: 
 - split one file per patch 
 - remove lm75[] instead of adding checking  
---
 drivers/hwmon/w83791d.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 37b25a1474c4..b4eae45859c1 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -273,9 +273,6 @@ struct w83791d_data {
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	/* array of 2 pointers to subclients */
-	struct i2c_client *lm75[2];
-
 	/* volts */
 	u8 in[NUMBER_OF_VIN];		/* Register value */
 	u8 in_max[NUMBER_OF_VIN];	/* Register value */
@@ -1257,7 +1254,6 @@ static const struct attribute_group w83791d_group_fanpwm45 = {
 static int w83791d_detect_subclients(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	struct w83791d_data *data = i2c_get_clientdata(client);
 	int address = client->addr;
 	int i, id;
 	u8 val;
@@ -1280,21 +1276,21 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 	}
 
 	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
+
+	if (!(val & 0x88) && (val & 0x7) == ((val >> 4) & 0x7)) {
+		dev_err(&client->dev,
+			"duplicate addresses 0x%x, use force_subclient\n",
+				0x48 + (val & 0x7));
+		return -ENODEV;
+	}
+
 	if (!(val & 0x08))
-		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
-							  0x48 + (val & 0x7));
-	if (!(val & 0x80)) {
-		if (!IS_ERR(data->lm75[0]) &&
-				((val & 0x7) == ((val >> 4) & 0x7))) {
-			dev_err(&client->dev,
-				"duplicate addresses 0x%x, "
-				"use force_subclient\n",
-				data->lm75[0]->addr);
-			return -ENODEV;
-		}
-		data->lm75[1] = devm_i2c_new_dummy_device(&client->dev, adapter,
-							  0x48 + ((val >> 4) & 0x7));
-	}
+		devm_i2c_new_dummy_device(&client->dev, adapter,
+						0x48 + (val & 0x7));
+
+	if (!(val & 0x80))
+		devm_i2c_new_dummy_device(&client->dev, adapter,
+						0x48 + ((val >> 4) & 0x7));
 
 	return 0;
 }
-- 
2.17.1

