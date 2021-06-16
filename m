Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CADA3AA3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhFPTKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhFPTKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:10:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E85C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:08:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a21so352426ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WL54/R6Mme6e3RQT9i1sJP4MFsLSEpzvFVEMxWrfS1Y=;
        b=tbmWa/rcLp74wYJ2LayWqB9C/YypLZPStvdVzJ/UAd+40ntYpGBMsCAfD0jSrSCYr7
         FMnm9KnjfVCFTJaI+w6oqs4oFFgawx1lhwpG5Rn5AVnyEeq2wXdl0XzQNBsIX/2KJ7MK
         BOeEr/Pg93zkYoY4+KleOv4p7wO7fVp5RTKTFFNpGZaxUrZhpH0cWAK0pMMDOqCV5x1k
         iLT8b81irzStdKrDCEF59SxeC82npcORapcQSLJx/yqzMD88O607gmk59JuQsAm6dJkk
         +U3UAkdTvh4AGsVgI9t+56IULqmmOJacXetSR0uOeAQmtog/X4MCzd7YGKO0WJZAeow1
         ND7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WL54/R6Mme6e3RQT9i1sJP4MFsLSEpzvFVEMxWrfS1Y=;
        b=kov7CeXvgHT07OdwQyamrOjlk7NF2+b/xpnerbInyxzikM8odpNbOnPki6GEZa9ZFm
         DhJzyqnzdeuNi56LsbCNJzKLsGPX6o9HivwUsSpR5cTnv/B+RMcuTwL2Tudquk0T4/g8
         xSjQ+C1TLvH+zpD7sR0TKC9OUKTNqrxte2Mhw/b8vyRJQhXpVV7I5MprNKIaiCunBPxQ
         vfLL+aYRofWkXlFd1CuWnmZsrR6oqbsNjs9KUdD1ibFaeq6pbCFT+PbfzCwt3Ldwj4cJ
         AZtXXXVqhVjjpWjmQ9KmbB00xrpPNppyZs7iBtIuI7J3R81AE+bczBHm0ZOU0fMQw+lc
         y/NA==
X-Gm-Message-State: AOAM532AMlD/S2mThXXAwIkdyhU7WTZ+TA1BU5QG6nzTgIWXg21J+bYq
        hnpwXqX0CLGgzSG9zz4xcMhQrlwjyZ7pQg==
X-Google-Smtp-Source: ABdhPJzhcgr4TbHdIux4JkqfddLLFxs6eN1FhDDktz3wer1niJQitqpxkEHLQGrkr8JY7nseCtxUrQ==
X-Received: by 2002:a2e:9156:: with SMTP id q22mr1169001ljg.237.1623870505054;
        Wed, 16 Jun 2021 12:08:25 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id h22sm406939ljl.126.2021.06.16.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:08:24 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [net-next: PATCH v2 4/7] net: mvmdio: simplify clock handling
Date:   Wed, 16 Jun 2021 21:07:56 +0200
Message-Id: <20210616190759.2832033-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210616190759.2832033-1-mw@semihalf.com>
References: <20210616190759.2832033-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the mvmdio driver supports a wide range of Marvell
SoC families it must support multiple types of the
HW description and required resources.

Thanks to the devm_clk_bulk_get_optional() helper routine
the clock handling could be significantly simplified,
as it is compatible with all possible variants within
a single call.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 61 ++++++--------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index d14762d93640..ce3ddc867898 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -62,9 +62,11 @@
 #define MVMDIO_XSMI_POLL_INTERVAL_MIN	150
 #define MVMDIO_XSMI_POLL_INTERVAL_MAX	160
 
+#define MVMDIO_CLOCK_COUNT		4
+
 struct orion_mdio_dev {
 	void __iomem *regs;
-	struct clk *clk[4];
+	struct clk_bulk_data clks[MVMDIO_CLOCK_COUNT];
 	/*
 	 * If we have access to the error interrupt pin (which is
 	 * somewhat misnamed as it not only reflects internal errors
@@ -279,7 +281,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct mii_bus *bus;
 	struct orion_mdio_dev *dev;
-	int i, ret;
+	int ret;
 
 	type = (enum orion_mdio_bus_type)of_device_get_match_data(&pdev->dev);
 
@@ -319,33 +321,20 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	init_waitqueue_head(&dev->smi_busy_wait);
 
-	if (pdev->dev.of_node) {
-		for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
-			dev->clk[i] = of_clk_get(pdev->dev.of_node, i);
-			if (PTR_ERR(dev->clk[i]) == -EPROBE_DEFER) {
-				ret = -EPROBE_DEFER;
-				goto out_clk;
-			}
-			if (IS_ERR(dev->clk[i]))
-				break;
-			clk_prepare_enable(dev->clk[i]);
-		}
-
-		if (!IS_ERR(of_clk_get(pdev->dev.of_node,
-				       ARRAY_SIZE(dev->clk))))
-			dev_warn(&pdev->dev,
-				 "unsupported number of clocks, limiting to the first "
-				 __stringify(ARRAY_SIZE(dev->clk)) "\n");
-	} else {
-		dev->clk[0] = clk_get(&pdev->dev, NULL);
-		if (PTR_ERR(dev->clk[0]) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto out_clk;
-		}
-		if (!IS_ERR(dev->clk[0]))
-			clk_prepare_enable(dev->clk[0]);
-	}
+	dev->clks[0].id = "core";
+	dev->clks[1].id = "mg";
+	dev->clks[2].id = "mg_core";
+	dev->clks[3].id = "axi";
+	ret = devm_clk_bulk_get_optional(&pdev->dev, MVMDIO_CLOCK_COUNT,
+					 dev->clks);
+	if (ret)
+		return ret;
 
+	ret = clk_bulk_prepare_enable(MVMDIO_CLOCK_COUNT, dev->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot enable clocks\n");
+		return ret;
+	}
 
 	dev->err_interrupt = platform_get_irq_optional(pdev, 0);
 	if (dev->err_interrupt > 0 &&
@@ -383,14 +372,6 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	if (dev->err_interrupt > 0)
 		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 
-out_clk:
-	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
-		if (IS_ERR(dev->clk[i]))
-			break;
-		clk_disable_unprepare(dev->clk[i]);
-		clk_put(dev->clk[i]);
-	}
-
 	return ret;
 }
 
@@ -398,18 +379,12 @@ static int orion_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 	struct orion_mdio_dev *dev = bus->priv;
-	int i;
 
 	if (dev->err_interrupt > 0)
 		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 	mdiobus_unregister(bus);
 
-	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
-		if (IS_ERR(dev->clk[i]))
-			break;
-		clk_disable_unprepare(dev->clk[i]);
-		clk_put(dev->clk[i]);
-	}
+	clk_bulk_disable_unprepare(MVMDIO_CLOCK_COUNT, dev->clks);
 
 	return 0;
 }
-- 
2.29.0

