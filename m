Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E84136B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhIUPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:54:36 -0400
Received: from mail.ispras.ru ([83.149.199.84]:50732 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234319AbhIUPyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:54:14 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id 40BFC40755E9;
        Tue, 21 Sep 2021 15:52:44 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v2 3/3] hwmon: (w83793) Fix NULL pointer dereference by removing unnecessary structure field
Date:   Tue, 21 Sep 2021 18:51:53 +0300
Message-Id: <20210921155153.28098-3-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210921155153.28098-1-lutovinova@ispras.ru>
References: <20210921155153.28098-1-lutovinova@ispras.ru>
In-Reply-To: <20210811181844.GB3138792@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver read tmp value sufficient for 
(tmp & 0x08) && (!(tmp & 0x80)) && ((tmp & 0x7) == ((tmp >> 4) & 0x7))
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
 drivers/hwmon/w83793.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index e7d0484eabe4..4ee96756ed49 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -202,7 +202,6 @@ static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
 }
 
 struct w83793_data {
-	struct i2c_client *lm75[2];
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
@@ -1566,7 +1565,6 @@ w83793_detect_subclients(struct i2c_client *client)
 	int address = client->addr;
 	u8 tmp;
 	struct i2c_adapter *adapter = client->adapter;
-	struct w83793_data *data = i2c_get_clientdata(client);
 
 	id = i2c_adapter_id(adapter);
 	if (force_subclients[0] == id && force_subclients[1] == address) {
@@ -1586,20 +1584,21 @@ w83793_detect_subclients(struct i2c_client *client)
 	}
 
 	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
+
+	if (!(tmp & 0x88) && (tmp & 0x7) == ((tmp >> 4) & 0x7)) {
+		dev_err(&client->dev,
+			"duplicate addresses 0x%x, use force_subclient\n",
+				0x48 + (tmp & 0x7));
+		return -ENODEV;
+	}
+
 	if (!(tmp & 0x08))
-		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
-							  0x48 + (tmp & 0x7));
-	if (!(tmp & 0x80)) {
-		if (!IS_ERR(data->lm75[0])
-		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
-			dev_err(&client->dev,
-				"duplicate addresses 0x%x, "
-				"use force_subclients\n", data->lm75[0]->addr);
-			return -ENODEV;
-		}
-		data->lm75[1] = devm_i2c_new_dummy_device(&client->dev, adapter,
-							  0x48 + ((tmp >> 4) & 0x7));
-	}
+		devm_i2c_new_dummy_device(&client->dev, adapter,
+						0x48 + (tmp & 0x7));
+
+	if (!(tmp & 0x80))
+		devm_i2c_new_dummy_device(&client->dev, adapter,
+						0x48 + ((tmp >> 4) & 0x7));
 
 	return 0;
 }
-- 
2.17.1

