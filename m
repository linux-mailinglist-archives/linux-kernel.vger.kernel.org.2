Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A73981A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhFBG4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhFBG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:56:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354FC061574;
        Tue,  1 Jun 2021 23:54:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 29so1428996pgu.11;
        Tue, 01 Jun 2021 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Crx9sLZBvOfFAmJqEn4FIAmK6q+0yYB5yGvDbssvRNg=;
        b=GeJrLFeBJdz4hF9XAH74L8gv2akvyIEAgScrms+tlJ1YkqOAMuP0CLPwlL5CBWpHzi
         0AIAt0zUwDWlHT3Ntq4DxJoDd4spZY+MOhdXMywWtKrcsS38mGNTwKg0qgyt5Negg+PQ
         jrNOQ0/Qf6B4xrW11D5JRjuS//5+KMvSuAOGXIrMKXt+L5HyTeLAYCaMMmCUDb7hbFQQ
         7HO59iOTIRZujWpWTauWaCvOh/RXDRFbB4HZWjy6Rv5l4XBfzEC7To4DDjADdKNvnWKX
         3ql4VoBzyQX/JbWOqQuGApkIvAA42qdL4ZxS+QdV75la5mCDGKEn+3ULC80YhW++5pGk
         iehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Crx9sLZBvOfFAmJqEn4FIAmK6q+0yYB5yGvDbssvRNg=;
        b=hIIDsvplxGoygXHXCEd1/8zAFFD/TsmHxMjqTpOFxfSsX8Pl4jcsbPWywtI01fZNjy
         4Qz/W6hVRT1wukZ/eNfvIcgxToS8AScTjBMmO2iJKJim7CMld2MoSX5ux5KpilKBvlC0
         g0F30NuHPSm/uvejlk1Sk9nO2KvX60wf7D2MdhBbOCSt6Pu57kgrpmAr72+1DSNMEnVd
         y6olrANjHwi8lwRwSrbDJd/DWT3UUqm5mlPsDyGqXTg6QDho91+3MU3ab9+36KB5mD4L
         v9QkY9jrMNfuK06EKudgYVR776nv/8FginjrDcVQ5ioZrn2rGIAJEG2HADQv4v/n6I54
         nsqA==
X-Gm-Message-State: AOAM530rVlP9y212PbLtFG6mPJv5EHqL8tWhADJ3Z3O6GeuveNi6C11f
        OOtOyhB3I5Q8rkcfvannJGikPA5dbO1ugA==
X-Google-Smtp-Source: ABdhPJzCU+z70LQ0ilBeUwva54QO79RDKIyharRgeqqOfn0NKm2jtN0GuGXPy/u2+hWVZTSur4OVTg==
X-Received: by 2002:a63:7945:: with SMTP id u66mr20236610pgc.200.1622616887025;
        Tue, 01 Jun 2021 23:54:47 -0700 (PDT)
Received: from localhost.localdomain (1-171-13-27.dynamic-ip.hinet.net. [1.171.13.27])
        by smtp.gmail.com with ESMTPSA id h6sm15190351pjs.15.2021.06.01.23.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 23:54:46 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, gene_chen@richtek.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene.chen.richtek@gmail.com
Subject: [PATCH 2/2] regulator: mt6360: Add power off sequence config for default-on power
Date:   Wed,  2 Jun 2021 14:54:35 +0800
Message-Id: <1622616875-22740-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
References: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add power off sequence config for default-on power.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

Originally, we think it must write in platform dependent code like as bootloader.
But after the evaluation, it must write only when system normal halt or power_off.
For the other cases, just follow HW immediate off by default.
---
 drivers/regulator/mt6360-regulator.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 4d34be9..6625f8f 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -9,12 +9,17 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
 #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
 
+#define MT6360_REG_BUCK1_SEQTD	0x117
+#define MT6360_SEQOFF_REGNUM	4
+
 enum {
 	MT6360_REGULATOR_BUCK1 = 0,
 	MT6360_REGULATOR_BUCK2,
@@ -45,6 +50,9 @@ struct mt6360_regulator_desc {
 struct mt6360_regulator_data {
 	struct device *dev;
 	struct regmap *regmap;
+	struct notifier_block reboot_notifier;
+	/* Only for BUCK1/BUCK2/LDO7/LDO6, these are default on power */
+	u8 power_off_seq[MT6360_SEQOFF_REGNUM];
 };
 
 static irqreturn_t mt6360_pgb_event_handler(int irq, void *data)
@@ -394,10 +402,28 @@ static int mt6360_regulator_irq_register(struct platform_device *pdev,
 	return 0;
 }
 
+static int reboot_notify_call(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct mt6360_regulator_data *mrd = container_of(nb, struct mt6360_regulator_data,
+							 reboot_notifier);
+	int ret;
+
+	if (action != SYS_HALT && action != SYS_POWER_OFF)
+		return NOTIFY_DONE;
+
+	ret = regmap_raw_write(mrd->regmap, MT6360_REG_BUCK1_SEQTD, mrd->power_off_seq,
+			       MT6360_SEQOFF_REGNUM);
+	if (ret)
+		dev_err(mrd->dev, "Failed to apply the power off sequence\n");
+
+	return NOTIFY_DONE;
+}
+
 static int mt6360_regulator_probe(struct platform_device *pdev)
 {
 	struct mt6360_regulator_data *mrd;
 	struct regulator_config config = {};
+	struct fwnode_handle *fwnode;
 	int i, ret;
 
 	mrd = devm_kzalloc(&pdev->dev, sizeof(*mrd), GFP_KERNEL);
@@ -434,7 +460,16 @@ static int mt6360_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	return 0;
+	fwnode = device_get_named_child_node(pdev->dev.parent, "regulator");
+	if (fwnode) {
+		ret = fwnode_property_read_u8_array(fwnode, "mediatek,power-off-sequence",
+						    mrd->power_off_seq, MT6360_SEQOFF_REGNUM);
+		if (ret)
+			dev_warn(&pdev->dev, "Use no delay immediate off by default [%d]\n", ret);
+	}
+
+	mrd->reboot_notifier.notifier_call = reboot_notify_call;
+	return devm_register_reboot_notifier(&pdev->dev, &mrd->reboot_notifier);
 }
 
 static const struct platform_device_id mt6360_regulator_id_table[] = {
-- 
2.7.4

