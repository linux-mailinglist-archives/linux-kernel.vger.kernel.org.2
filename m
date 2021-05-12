Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35B037BEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhELNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:53:39 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35948 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230182AbhELNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:53:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CDb4co005218;
        Wed, 12 May 2021 08:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0QmOZheFHfwvwnYCIaE4FwQKD6QPl/K4qpWwYDx2nwI=;
 b=Tc8q2d7D6+csQshx4l86L8l297T+fXNDAQQn3anEQCWi1VPaW8UXX+eQbYPRPc3rdP26
 +TK3KcSWaXJI2FBhpQSgqP5XvIg+t7Gu261pvUvyKxYZbAXEtA+fd4rLzynBphh4zUrl
 qO93z5V2o9wCn5y8JGAosZ/c2XilwUQvB5GM+z+nu1uZdonamGtBluiy1J3TZB/SHY6r
 yI517k0sjN60iyldbTIvvEMm8gBw5i1JDja5jtMqVE5aaoADzXxqOVTHzb5VUrKHgl93
 wqJSrZjpF5vsQnKMDCSPlF9IrdxAtYuJja06sAYDT2FGXUCiSOcTx0RzdzSwuvL2v1Gd hQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38gedgr56q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 12 May 2021 08:52:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 12 May
 2021 14:52:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 12 May 2021 14:52:25 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.171])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D8AA32BA;
        Wed, 12 May 2021 13:52:24 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH] regmap-i2c: Set regmap max raw r/w from quirks
Date:   Wed, 12 May 2021 14:52:22 +0100
Message-ID: <20210512135222.223203-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zG1f1frX5poBNkognsraX2tQ86n5Q_kA
X-Proofpoint-ORIG-GUID: zG1f1frX5poBNkognsraX2tQ86n5Q_kA
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set regmap raw read/write from i2c quirks max read/write
so regmap_raw_read/write can split the access into chunks

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-i2c.c | 45 +++++++++++++++++++++++++++-----
 drivers/base/regmap/regmap.c     |  2 ++
 include/linux/regmap.h           |  2 ++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 62b95a9212ae..980e5ce6a3a3 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -306,33 +306,64 @@ static const struct regmap_bus regmap_i2c_smbus_i2c_block_reg16 = {
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 					const struct regmap_config *config)
 {
+	const struct i2c_adapter_quirks *quirks;
+	const struct regmap_bus *bus = NULL;
+	struct regmap_bus *ret_bus;
+	u16 max_read = 0, max_write = 0;
+
 	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
-		return &regmap_i2c;
+		bus = &regmap_i2c;
 	else if (config->val_bits == 8 && config->reg_bits == 8 &&
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_I2C_BLOCK))
-		return &regmap_i2c_smbus_i2c_block;
+		bus = &regmap_i2c_smbus_i2c_block;
 	else if (config->val_bits == 8 && config->reg_bits == 16 &&
 		i2c_check_functionality(i2c->adapter,
 					I2C_FUNC_SMBUS_I2C_BLOCK))
-		return &regmap_i2c_smbus_i2c_block_reg16;
+		bus = &regmap_i2c_smbus_i2c_block_reg16;
 	else if (config->val_bits == 16 && config->reg_bits == 8 &&
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_WORD_DATA))
 		switch (regmap_get_val_endian(&i2c->dev, NULL, config)) {
 		case REGMAP_ENDIAN_LITTLE:
-			return &regmap_smbus_word;
+			bus = &regmap_smbus_word;
+			break;
 		case REGMAP_ENDIAN_BIG:
-			return &regmap_smbus_word_swapped;
+			bus = &regmap_smbus_word_swapped;
+			break;
 		default:		/* everything else is not supported */
 			break;
 		}
 	else if (config->val_bits == 8 && config->reg_bits == 8 &&
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_BYTE_DATA))
-		return &regmap_smbus_byte;
+		bus = &regmap_smbus_byte;
+
+	if (!bus)
+		return ERR_PTR(-ENOTSUPP);
+
+	quirks = i2c->adapter->quirks;
+	if (quirks) {
+		if (quirks->max_read_len &&
+		    (bus->max_raw_read == 0 || bus->max_raw_read > quirks->max_read_len))
+			max_read = quirks->max_read_len;
+
+		if (quirks->max_write_len &&
+		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
+			max_write = quirks->max_write_len;
+
+		if (max_read || max_write) {
+			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
+			if (!ret_bus)
+				return ERR_PTR(-ENOMEM);
+			ret_bus->free_on_exit = true;
+			ret_bus->max_raw_read = max_read;
+			ret_bus->max_raw_write = max_write;
+			bus = ret_bus;
+		}
+	}
 
-	return ERR_PTR(-ENOTSUPP);
+	return bus;
 }
 
 struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 297e95be25b3..0d185ec018a5 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1496,6 +1496,8 @@ void regmap_exit(struct regmap *map)
 		mutex_destroy(&map->mutex);
 	kfree_const(map->name);
 	kfree(map->patch);
+	if (map->bus && map->bus->free_on_exit)
+		kfree(map->bus);
 	kfree(map);
 }
 EXPORT_SYMBOL_GPL(regmap_exit);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f87a11a5cc4a..8c16e6fa0f66 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -502,6 +502,7 @@ typedef void (*regmap_hw_free_context)(void *context);
  *     DEFAULT, BIG is assumed.
  * @max_raw_read: Max raw read size that can be used on the bus.
  * @max_raw_write: Max raw write size that can be used on the bus.
+ * @free_on_exit: kfree this on exit of regmap
  */
 struct regmap_bus {
 	bool fast_io;
@@ -519,6 +520,7 @@ struct regmap_bus {
 	enum regmap_endian val_format_endian_default;
 	size_t max_raw_read;
 	size_t max_raw_write;
+	bool free_on_exit;
 };
 
 /*
-- 
2.31.1

