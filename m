Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA68383B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbhEQRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243142AbhEQRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:35:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82774C061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h7so3579590plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2LUwkBCn/UHUIUpN0tGBxlVhEOoLXnQJ9JqYqN767U=;
        b=ZFpepfFWH2fZl4tzbb4HErLNIDjmb5y/QqZ3WH9HmqjFiryAPKNEAOhBHLgqGRBqw+
         fRm1jK8HXdqzhX0Qm07SGqKlUfwQTp1LHDXolhvChHtIrTMp/B3swomJ9BVDS0SFkWUY
         5A5JYHrM3aNeNBIfNVCFnBDVizFf6bJJuTnm1rh6GYubxRFlzLVhIvNaLoKZkF2A6YFJ
         0Lx+1JfPQbZNg2paBUdzyz7bkqEPljrYDUvX5Pvds778aVUBYbuPzDNR2/XaMLCPo4Ti
         +jobzZq75u5L4/Gcb+72nl9F8oUnNbaXTuwgKqI7t2XDysSHmSrvMkLExIxcT6i5jHEx
         LPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2LUwkBCn/UHUIUpN0tGBxlVhEOoLXnQJ9JqYqN767U=;
        b=HtDpsnVqjvV3P6Ri8Mw35bdvqVmqJO5kn6GTJ6MtN3CdwTeDuCIAht8tT/f/7udXPe
         J0HlWuQC3YQTwKux06+8hQbC9t3T7QxEsoBaAGwZo/rm/PUSjoXrRfPFry4s2uwVWqBj
         6C9s+ZjLSMTh0bdWqbnHTUeGpQlTNTPAjUV0J8ZbRWeHWGu5P8ATn84MGGKXja1Nq7RR
         6WR7FvzArjAOkdWbnhaWQj2v/hkH7df38B1PNyoWq87BMXZKNK7arR25puPldOPT6n/y
         BQoZtT2c5yV0P+TLjcLutc1tzwie0dClTb0fVJ2cSf0DuKkhSXmU0poOVzeq32bYhmCB
         Rc6A==
X-Gm-Message-State: AOAM533Uef4XUabDa31MH1rlhT7GhlnVRoOsGBxjGqwPOalYK2hymxuX
        CJn7RUoShnAEEfFUNfvT9ZE=
X-Google-Smtp-Source: ABdhPJzUNr0X9l/F4LvvQbKVAhQ5hjETNBMVetzvzKHHW1R09teIr6XxNrTxkvngFOCY0PqtC//9OA==
X-Received: by 2002:a17:90a:5649:: with SMTP id d9mr243681pji.98.1621272823176;
        Mon, 17 May 2021 10:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:42 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 07/10] mfd: mt6360: Remove handle_post_irq callback function
Date:   Tue, 18 May 2021 01:33:11 +0800
Message-Id: <20210517173314.140912-8-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove handle_post_irq which is used to retrigger IRQ.
Set IRQ level low trigger in dtsi to keep IRQ always be handled.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 17 ++++-------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index a1d74bb302cd..50a170065a98 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -209,15 +209,8 @@ static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
 };
 
-static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
-{
-	struct mt6360_ddata *ddata = irq_drv_data;
-
-	return regmap_update_bits(ddata->regmap,
-		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
-}
-
-static struct regmap_irq_chip mt6360_irq_chip = {
+static const struct regmap_irq_chip mt6360_irq_chip = {
+	.name = "mt6360_irqs",
 	.irqs = mt6360_irqs,
 	.num_irqs = ARRAY_SIZE(mt6360_irqs),
 	.num_regs = MT6360_PMU_IRQ_REGNUM,
@@ -226,7 +219,6 @@ static struct regmap_irq_chip mt6360_irq_chip = {
 	.ack_base = MT6360_PMU_CHG_IRQ1,
 	.init_ack_masked = true,
 	.use_ack = true,
-	.handle_post_irq = mt6360_pmu_handle_post_irq,
 };
 
 static const struct regmap_config mt6360_pmu_regmap_config = {
@@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_irq_chip.irq_drv_data = ddata;
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
-				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_irq_chip, &ddata->irq_data);
+				       0, 0, &mt6360_irq_chip,
+				       &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 81bca7c2ad4d..ef8257dffe3f 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -230,7 +230,7 @@ struct mt6360_ddata {
 #define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
 
 /* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
+#define MT6360_PMU_IRQ_REGNUM	16
 #define MT6360_IRQ_RETRIG	BIT(2)
 
 #define CHIP_VEN_MASK				0xF0
-- 
2.25.1

