Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C841ABE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhI1Jc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbhI1JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:21 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Sep 2021 02:30:38 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F67C061604;
        Tue, 28 Sep 2021 02:30:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E70B1C2D;
        Tue, 28 Sep 2021 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821032;
        bh=tXLdw8+7XyyaNC2nx8/azLFD8tnijRO/sXuXLjMDFfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuJx3h8+xeOXqjn30yyHApPuhrufZusIfYS8iPa+FVxQ9JuO80EkpegS3MeE7Ch2s
         I15GhwuMLy77uLvQkXlTpbS0ao/WpoymxODxEBEePZg43oejKsZl8OEPnpC4n/GQAm
         ZUAMTya33ECDRvM8YguzsWoJ4+biEduXdAH9j7Zg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] hwmon: (pmbus/lm25066) Add OF device ID table
Date:   Tue, 28 Sep 2021 02:22:40 -0700
Message-Id: <20210928092242.30036-7-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See commit 8881a19187e4 ("hwmon: (ucd9000) Add OF device ID table")
for reasoning.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/pmbus/lm25066.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index dbbf8571c437..18d5a76f346d 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/log2.h>
+#include <linux/of_device.h>
 #include "pmbus.h"
 
 enum chips { lm25056, lm25066, lm5064, lm5066, lm5066i };
@@ -444,12 +445,24 @@ static const struct i2c_device_id lm25066_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, lm25066_id);
 
+static const struct of_device_id __maybe_unused lm25066_of_match[] = {
+	{ .compatible = "ti,lm25056", .data = (void*)lm25056, },
+	{ .compatible = "ti,lm25066", .data = (void*)lm25066, },
+	{ .compatible = "ti,lm5064",  .data = (void*)lm5064,  },
+	{ .compatible = "ti,lm5066",  .data = (void*)lm5066,  },
+	{ .compatible = "ti,lm5066i", .data = (void*)lm5066i, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lm25066_of_match);
+
 static int lm25066_probe(struct i2c_client *client)
 {
 	int config;
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
 	const struct __coeff *coeff;
+	const struct of_device_id *of_id;
+	const struct i2c_device_id *i2c_id;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
@@ -464,7 +477,15 @@ static int lm25066_probe(struct i2c_client *client)
 	if (config < 0)
 		return config;
 
-	data->id = i2c_match_id(lm25066_id, client)->driver_data;
+	i2c_id = i2c_match_id(lm25066_id, client);
+
+	of_id = of_match_device(lm25066_of_match, &client->dev);
+	if (of_id && (enum chips)of_id->data != i2c_id->driver_data)
+		dev_notice(&client->dev,
+		           "Device mismatch: %s in device tree, %s detected\n",
+		           of_id->name, i2c_id->name);
+
+	data->id = i2c_id->driver_data;
 	info = &data->info;
 
 	info->pages = 1;
@@ -521,7 +542,8 @@ static int lm25066_probe(struct i2c_client *client)
 static struct i2c_driver lm25066_driver = {
 	.driver = {
 		   .name = "lm25066",
-		   },
+		   .of_match_table = of_match_ptr(lm25066_of_match),
+	},
 	.probe_new = lm25066_probe,
 	.id_table = lm25066_id,
 };
-- 
2.33.0

