Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5840383B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbhEQRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243095AbhEQRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:35:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96691C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t193so5145623pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SGZLC9XHUt+lZzTU9RZd8JyaaWpbIPUIXZL+8shzcs=;
        b=kAa3R3VMavzYayCAWbgzmaYp4JMxpY+hSNqopUhEBzFXEHoaFAkofW0qq+74+L+Fn+
         0SCsuMU5FF+ao9/cA9QlnaIMXX+l1lvOEeLQR2RegcYvdaxuaZhVwZy5ka27cfU8MRrw
         MlivrWclkjQmDQcr0GStDYySsJPyIbIVRe1Xb9tEq/gUln9aSYEf1TgOFlSrRKXzl2D4
         +nRmhqzLIymGpxCCpdc4Hr80XCgcuOFjWz96crFnecuDcd04NZExEjig/7rHqTgznSZz
         dLSObErCpCrZ4OCI8/L29mOBnmzVPa9Ko8EnTSQaMW4OPTtVctuB89hb0row/NwoNmqe
         5K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SGZLC9XHUt+lZzTU9RZd8JyaaWpbIPUIXZL+8shzcs=;
        b=ZKy9WK+DGdvWw+8fdj9WkV4HyxwfEspYPzFu0bJAB/EjlTaG8cjCoiZAmwB+DBCKbH
         CQ1OBh0OSjaxaeaHXA8IzpcKmRZbxVafMi4J/Vwmh3U8WjEM6cyXSc/s1jFgPqa8qzcG
         XoygapnDFHrvFrdislQYPhjhL3+hOiWnuWN3l9RbuaP442GgFrSzb0bv9+HwdLutr+pU
         E3FXQUdN/eV/dQM98QIpZihfyUIwn26HuyxaH54yrd3gnfcuzlv1omgGhezZ+ff/sTii
         mNbynvzlJQo95bEqpki8KXXJZgvzAQIGn0+n+9HhlbjlUgxDlqZqfoI6lHl6Ld/vUJsR
         DW0A==
X-Gm-Message-State: AOAM533aBzDL/nDbhjCbAEaR8WAw2Q0xrpgDKNPzmbaKJbamDZhqASeI
        DPDPyyRIbYKuGtmQ0V4uymUoxoDLbUQ=
X-Google-Smtp-Source: ABdhPJxtusr0DXLHM6IuD2qWOgDDxxA8Yvo6b0rH9EpdnC7wmWAhSu5aLnE6r6Wv0Ktn+alzLJJaWw==
X-Received: by 2002:a65:5248:: with SMTP id q8mr651292pgp.176.1621272826253;
        Mon, 17 May 2021 10:33:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:46 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 08/10] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Tue, 18 May 2021 01:33:12 +0800
Message-Id: <20210517173314.140912-9-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 50a170065a98..cdd99770f94a 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
+		dev_err(ddata->dev, "Device not supported\n");
+		return -ENODEV;
+	}
+
+	ddata->chip_rev = info & CHIP_REV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_ddata *ddata;
-	unsigned int reg_data;
 	int i, ret;
 
 	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
@@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
-	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
+	ret = mt6360_check_vendor_info(ddata);
+	if (ret)
 		return ret;
-	}
-
-	ddata->chip_rev = reg_data & CHIP_REV_MASK;
-	if (ddata->chip_rev != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
-	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       0, 0, &mt6360_irq_chip,
-- 
2.25.1

