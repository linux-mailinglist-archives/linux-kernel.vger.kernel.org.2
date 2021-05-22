Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646CB38D30A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhEVCbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhEVCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:31:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 19:30:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so7992737pjo.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 19:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+CM7cTLKEsj9ZLnZRvlEBbY52cGcy9hEe3esBBDAjU=;
        b=QFveLeE5RT6/ksPPI9fdIgNdasgv4NbSM4IIHgqTJBX6hkFRlis0UhbejN91CgvM9P
         OHEx3/2DFLRMImof0CHadv7b7wVIidiqIEKkb81vurEHECbctrbdNsUO4olIbzsZdc7D
         1Yxu1p9NiFh9XDnyzElKOizu+FUta49gP/oF1pEozlQfF45ZJm1iwl93G2FlMHOePbYD
         YLaOLN9ZVy/FiMmfvvS66jGO6DcAN7D7qvi69zni7yWIbPCNu5g7Zfy822jQdvTHy876
         eiUtWRskuv0K5la2ug0sFjrNwqADg/ybEk1s/jclmNfRX7MzJ4ZSx04CuUR3yF6cC2Tw
         utPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+CM7cTLKEsj9ZLnZRvlEBbY52cGcy9hEe3esBBDAjU=;
        b=dWoTWVk0eb3SMU9Y8WNC/Jgov/OxlS7MjQgloYY28nbeNnei2v2djAMEmUY4/Qj5LT
         V61UpGgZ00E/5aADUTNhTDrofJuDhEQQBfxpX/HHOWIUSDfvtZFedVbx2aWUzjjVk7XX
         i6HSkI9N0cXqFwhXw8OLN/kHHplhTs/mCtzVdbakQTdFte2HgPWpVMyT0ynrdrjpHuX7
         KsnHa9UwvycZmygMVDqHl2ksxhAKsuKs4m5baba4yBdA26PJwykp88+Mprba36qzc+11
         u0SIjO+QXqv66EpM83MQoeDlm2CdPuqe15p/XNXksTus9uJGwMlP6sx7Gnvl2fefZAp0
         MVdw==
X-Gm-Message-State: AOAM533de/ffHAlfH3Z5b3wIp6XTKad7E9s7hUi4gB5rDcK6fenqOGZr
        ciV0MGYO/i/uujDS/jcNWEojoXR6KHTMUVuC
X-Google-Smtp-Source: ABdhPJxGTYKjZ8UwE70VbpDuc7xgPYBqNC4yJvjy6zoYCN6TOoEPfQ2Q+Rvrc2edBJFFFvr6RngBJA==
X-Received: by 2002:a17:902:f68c:b029:f0:c1be:5651 with SMTP id l12-20020a170902f68cb02900f0c1be5651mr15077309plg.24.1621650627606;
        Fri, 21 May 2021 19:30:27 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id y26sm5556426pge.94.2021.05.21.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 19:30:27 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mp5416: Convert to use regulator_set_ramp_delay_regmap
Date:   Sat, 22 May 2021 10:30:18 +0800
Message-Id: <20210522023018.2025188-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mp5416.c | 44 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 67ce1b52a1a1..39cebec0edb6 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -67,6 +67,10 @@
 		.vsel_mask = MP5416_MASK_VSET,				\
 		.enable_reg = MP5416_REG_BUCK ## _id,			\
 		.enable_mask = MP5416_REGULATOR_EN,			\
+		.ramp_reg = MP5416_REG_CTL2,				\
+		.ramp_mask = MP5416_MASK_DVS_SLEWRATE,			\
+		.ramp_delay_table = mp5416_buck_ramp_table,		\
+		.n_ramp_values = ARRAY_SIZE(mp5416_buck_ramp_table),	\
 		.active_discharge_on	= _dval,			\
 		.active_discharge_reg	= _dreg,			\
 		.active_discharge_mask	= _dval,			\
@@ -123,7 +127,16 @@ static const unsigned int mp5416_I_limits2[] = {
 	2200000, 3200000, 4200000, 5200000
 };
 
-static int mp5416_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay);
+/*
+ * DVS ramp rate BUCK1 to BUCK4
+ * 00: 32mV/us
+ * 01: 16mV/us
+ * 10: 8mV/us
+ * 11: 4mV/us
+ */
+static const unsigned int mp5416_buck_ramp_table[] = {
+	32000, 16000, 8000, 4000
+};
 
 static const struct regulator_ops mp5416_ldo_ops = {
 	.enable			= regulator_enable_regmap,
@@ -147,7 +160,7 @@ static const struct regulator_ops mp5416_buck_ops = {
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
-	.set_ramp_delay		= mp5416_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 };
 
 static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
@@ -161,33 +174,6 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
 	MP5416LDO("ldo4", 4, BIT(1)),
 };
 
-/*
- * DVS ramp rate BUCK1 to BUCK4
- * 00: 32mV/us
- * 01: 16mV/us
- * 10: 8mV/us
- * 11: 4mV/us
- */
-static int mp5416_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	unsigned int ramp_val;
-
-	if (ramp_delay > 32000 || ramp_delay < 0)
-		return -EINVAL;
-
-	if (ramp_delay <= 4000)
-		ramp_val = 3;
-	else if (ramp_delay <= 8000)
-		ramp_val = 2;
-	else if (ramp_delay <= 16000)
-		ramp_val = 1;
-	else
-		ramp_val = 0;
-
-	return regmap_update_bits(rdev->regmap, MP5416_REG_CTL2,
-				  MP5416_MASK_DVS_SLEWRATE, ramp_val << 6);
-}
-
 static int mp5416_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-- 
2.25.1

