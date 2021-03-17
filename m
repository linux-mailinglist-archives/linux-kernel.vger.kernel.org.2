Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42433F059
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQM3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:29:54 -0400
Received: from m12-12.163.com ([220.181.12.12]:52278 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhCQM3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9cjI4
        6KIUwJPi3dj/xODR2gX9GEx6dK7Vt1xYNu/AJU=; b=CYhka/JoywrptsQ7BjMEb
        mHwK1CZTZ18T6CRuk3YbHkOPeQKnQxBa+3P2ghMvcmthD6XVrPHrGJHQc9DHceKS
        Nb+5nxWb+U4jJsSavXw2UZHUHJaq7EFBpYSbxj72Q9FFb2ITglgvlHTHKkT6R4ur
        FkgCFuMw1Mh23XvHYmJPx4=
Received: from COOL-20200916KH.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowADXbcIl9lFgHW30VA--.14392S2;
        Wed, 17 Mar 2021 20:29:29 +0800 (CST)
From:   qiumibaozi_1@163.com
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, ganjisheng <ganjisheng@yulong.com>
Subject: [PATCH 3/3] Remove redundant assignment
Date:   Wed, 17 Mar 2021 20:29:22 +0800
Message-Id: <20210317122922.551-1-qiumibaozi_1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADXbcIl9lFgHW30VA--.14392S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4rAFWUur1xtw1UtF4fZrb_yoW8Cw43pF
        y3WFyDCrZ5J3Wfuw4vvFs3ZF15tF1xtFZxAay8Jw1I9wn8ta1SkFyYkFyjvry3GF98GF47
        Xa1FyayrCF12vaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jGJP_UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5tlxzxxedr6xjbr6il2tof0z/xtbBRgpY2F3l+7nhGQAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ganjisheng <ganjisheng@yulong.com>

Signed-off-by: ganjisheng <ganjisheng@yulong.com>
---
 drivers/mfd/88pm860x-i2c.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index a000aed..c4852c9 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -34,10 +34,8 @@ int pm860x_reg_write(struct i2c_client *i2c, int reg,
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	struct regmap *map = (i2c == chip->client) ? chip->regmap
 				: chip->regmap_companion;
-	int ret;
 
-	ret = regmap_write(map, reg, data);
-	return ret;
+	return regmap_write(map, reg, data);
 }
 EXPORT_SYMBOL(pm860x_reg_write);
 
@@ -47,10 +45,8 @@ int pm860x_bulk_read(struct i2c_client *i2c, int reg,
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	struct regmap *map = (i2c == chip->client) ? chip->regmap
 				: chip->regmap_companion;
-	int ret;
 
-	ret = regmap_raw_read(map, reg, buf, count);
-	return ret;
+	return regmap_raw_read(map, reg, buf, count);
 }
 EXPORT_SYMBOL(pm860x_bulk_read);
 
@@ -60,10 +56,8 @@ int pm860x_bulk_write(struct i2c_client *i2c, int reg,
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	struct regmap *map = (i2c == chip->client) ? chip->regmap
 				: chip->regmap_companion;
-	int ret;
 
-	ret = regmap_raw_write(map, reg, buf, count);
-	return ret;
+	return regmap_raw_write(map, reg, buf, count);
 }
 EXPORT_SYMBOL(pm860x_bulk_write);
 
@@ -73,10 +67,8 @@ int pm860x_set_bits(struct i2c_client *i2c, int reg,
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	struct regmap *map = (i2c == chip->client) ? chip->regmap
 				: chip->regmap_companion;
-	int ret;
 
-	ret = regmap_update_bits(map, reg, mask, data);
-	return ret;
+	return regmap_update_bits(map, reg, mask, data);
 }
 EXPORT_SYMBOL(pm860x_set_bits);
 
-- 
1.9.1


