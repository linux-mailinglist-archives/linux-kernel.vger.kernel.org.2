Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0361397AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhFAUDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:03:54 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:9434 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhFAUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:03:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622577710; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CV9/bp7WXRgQIpOEAf0uIbklDaSZwfa4g/C4qRaVgW1DxIR59vZjwd3sM+Fy0BUZz4
    qYdiITQFpRRxyWRzx/nxrv3cHF+LCqeiq0hXMrkwkCvvFzKqmbSfkh41KgoUldpF0jMn
    G/l0Oi9FoW15q8ZCRC0+X/JDnYQ1uU0KnyeyUNNlfuwu/qUeXj0WkZAxeeS4n3sk4uRR
    ta+LpokSDCWPedzCwSnR3kkAAFqCzD1jIEVTjubD/4pYixxSczN9EnLJWmejrdyswxzm
    FCXQro1RlzxgekMlr4J9WiC6cTkIVFkakYYx5gRw2T6DX0TkHd6VmiRZouwCeDbeFTdV
    0M6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577710;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3g1ODHVVDts0jr4v4Fxy1Wy7/kFKGQfRgNltKW1OyWE=;
    b=kb7DQ+6r5FzU6l+aAJAoMq40rin5FacrU5EMcVb/BnTyRY5PufJMF/9iW4wQ/nOjz/
    aaD2og4mQln5Sg2X+E6cUA6I0XJr60VLSIWFNyw9DKD0f849P+KjE96PgDVPxrosX/iz
    nxzE7tGz8IBEhwjS8L3JArBMnfqtDlnoAsYLOPx2nDQW1bNyic95qKAekxFpEQ4iNHgT
    zgB0Y1Y70E+O9A7ULZU3bp/ZXN48n4yXHnkLShMztvGPdI20enlqqZtAzmwE33Ov0wP0
    PEdxUjoO1M1V6ZlLSm8pzd6e+s888Jxfk4TtcFTE1CYRhEPIp7DLLxBeeKOF426/7AaT
    yDuQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577710;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3g1ODHVVDts0jr4v4Fxy1Wy7/kFKGQfRgNltKW1OyWE=;
    b=PyWH1pOs9ZBevri9YuJ/xu3ChEJl8cY0+tpegKSQsU0Qq/tMz/sgxEYpt6Pu5vOhuQ
    +E885mQ4gU81/IVvvCdJAuTJ77AM8K2Zyixbu+nWkoDIaNVH+XG0sh4YSM525f2Td2YR
    ln8s0gXiTX0oaUVUl+EA9AMyHKQZI06zp+2enNakImqilXnhrWPP0oSE4q5nIrDT5ujj
    91h9ASAKq7OGxUsxoFSqbJxv24ZG9orVAHr1HB+KMJHG6UgFBowEsvVPkoPiZ3ckORG1
    2pUjk5UEjv3HgB0xxSWjpj8CJpusG0rYMAsiCBHMNnNvkmx2QqZRsYDSjiySi42BQw4a
    88CQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6Na3kD"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x51K1nWn2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Jun 2021 22:01:49 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use chip-specific struct
Date:   Tue,  1 Jun 2021 22:00:06 +0200
Message-Id: <20210601200007.218802-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601200007.218802-1-stephan@gerhold.net>
References: <20210601200007.218802-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
enum sm5504_types with a struct sm5504_type that stores the chip-specific
definitions. This struct can then be defined separately for SM5504
without having to add if (type == TYPE_SM5504) everywhere in the code.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: New patch to simplify diff on next patch
---
 drivers/extcon/extcon-sm5502.c | 64 +++++++++++++++++++++-------------
 drivers/extcon/extcon-sm5502.h |  4 ---
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 9f40bb9f1f81..951f6ca4c479 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -40,17 +40,13 @@ struct sm5502_muic_info {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
 
+	const struct sm5502_type *type;
 	struct regmap_irq_chip_data *irq_data;
-	struct muic_irq *muic_irqs;
-	unsigned int num_muic_irqs;
 	int irq;
 	bool irq_attach;
 	bool irq_detach;
 	struct work_struct irq_work;
 
-	struct reg_data *reg_data;
-	unsigned int num_reg_data;
-
 	struct mutex mutex;
 
 	/*
@@ -62,6 +58,17 @@ struct sm5502_muic_info {
 	struct delayed_work wq_detcable;
 };
 
+struct sm5502_type {
+	struct muic_irq *muic_irqs;
+	unsigned int num_muic_irqs;
+	const struct regmap_irq_chip *irq_chip;
+
+	struct reg_data *reg_data;
+	unsigned int num_reg_data;
+
+	int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
+};
+
 /* Default value of SM5502 register to bring up MUIC device. */
 static struct reg_data sm5502_reg_data[] = {
 	{
@@ -502,11 +509,11 @@ static irqreturn_t sm5502_muic_irq_handler(int irq, void *data)
 	struct sm5502_muic_info *info = data;
 	int i, irq_type = -1, ret;
 
-	for (i = 0; i < info->num_muic_irqs; i++)
-		if (irq == info->muic_irqs[i].virq)
-			irq_type = info->muic_irqs[i].irq;
+	for (i = 0; i < info->type->num_muic_irqs; i++)
+		if (irq == info->type->muic_irqs[i].virq)
+			irq_type = info->type->muic_irqs[i].irq;
 
-	ret = sm5502_parse_irq(info, irq_type);
+	ret = info->type->parse_irq(info, irq_type);
 	if (ret < 0) {
 		dev_warn(info->dev, "cannot handle is interrupt:%d\n",
 				    irq_type);
@@ -551,14 +558,14 @@ static void sm5502_init_dev_type(struct sm5502_muic_info *info)
 			    version_id, vendor_id);
 
 	/* Initiazle the register of SM5502 device to bring-up */
-	for (i = 0; i < info->num_reg_data; i++) {
+	for (i = 0; i < info->type->num_reg_data; i++) {
 		unsigned int val = 0;
 
-		if (!info->reg_data[i].invert)
-			val |= ~info->reg_data[i].val;
+		if (!info->type->reg_data[i].invert)
+			val |= ~info->type->reg_data[i].val;
 		else
-			val = info->reg_data[i].val;
-		regmap_write(info->regmap, info->reg_data[i].reg, val);
+			val = info->type->reg_data[i].val;
+		regmap_write(info->regmap, info->type->reg_data[i].reg, val);
 	}
 }
 
@@ -579,10 +586,9 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 	info->dev = &i2c->dev;
 	info->i2c = i2c;
 	info->irq = i2c->irq;
-	info->muic_irqs = sm5502_muic_irqs;
-	info->num_muic_irqs = ARRAY_SIZE(sm5502_muic_irqs);
-	info->reg_data = sm5502_reg_data;
-	info->num_reg_data = ARRAY_SIZE(sm5502_reg_data);
+	info->type = device_get_match_data(info->dev);
+	if (!info->type)
+		return -EINVAL;
 
 	mutex_init(&info->mutex);
 
@@ -598,16 +604,17 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 
 	/* Support irq domain for SM5502 MUIC device */
 	irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_SHARED;
-	ret = devm_regmap_add_irq_chip(info->dev, info->regmap, info->irq, irq_flags,
-				       0, &sm5502_muic_irq_chip, &info->irq_data);
+	ret = devm_regmap_add_irq_chip(info->dev, info->regmap, info->irq,
+				       irq_flags, 0, info->type->irq_chip,
+				       &info->irq_data);
 	if (ret != 0) {
 		dev_err(info->dev, "failed to request IRQ %d: %d\n",
 				    info->irq, ret);
 		return ret;
 	}
 
-	for (i = 0; i < info->num_muic_irqs; i++) {
-		struct muic_irq *muic_irq = &info->muic_irqs[i];
+	for (i = 0; i < info->type->num_muic_irqs; i++) {
+		struct muic_irq *muic_irq = &info->type->muic_irqs[i];
 		int virq = 0;
 
 		virq = regmap_irq_get_virq(info->irq_data, muic_irq->irq);
@@ -659,8 +666,17 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
+static const struct sm5502_type sm5502_data = {
+	.muic_irqs = sm5502_muic_irqs,
+	.num_muic_irqs = ARRAY_SIZE(sm5502_muic_irqs),
+	.irq_chip = &sm5502_muic_irq_chip,
+	.reg_data = sm5502_reg_data,
+	.num_reg_data = ARRAY_SIZE(sm5502_reg_data),
+	.parse_irq = sm5502_parse_irq,
+};
+
 static const struct of_device_id sm5502_dt_match[] = {
-	{ .compatible = "siliconmitus,sm5502-muic" },
+	{ .compatible = "siliconmitus,sm5502-muic", .data = &sm5502_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sm5502_dt_match);
@@ -691,7 +707,7 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
 			 sm5502_muic_suspend, sm5502_muic_resume);
 
 static const struct i2c_device_id sm5502_i2c_id[] = {
-	{ "sm5502", TYPE_SM5502 },
+	{ "sm5502", (kernel_ulong_t)&sm5502_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index ce1f1ec310c4..d187205df7b3 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -8,10 +8,6 @@
 #ifndef __LINUX_EXTCON_SM5502_H
 #define __LINUX_EXTCON_SM5502_H
 
-enum sm5502_types {
-	TYPE_SM5502,
-};
-
 /* SM5502 registers */
 enum sm5502_reg {
 	SM5502_REG_DEVICE_ID = 0x01,
-- 
2.31.1

