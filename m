Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744ED32621D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBZLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBZLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:46:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843F4C061756;
        Fri, 26 Feb 2021 03:46:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v5so13355891lft.13;
        Fri, 26 Feb 2021 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1KAv7OlWQlmHNtXqUJvuaSXGHvX/OsIn970Hsnpf/A=;
        b=TxDS22rZnvG5L6X9kNeUp+/ZpGJTdLqvyhRwYy8QcqYkv1oD+suvQzXdFmIRy3Q3eN
         ZsRUs0GgoiRFV04GQKbkTY03MWn9AuOfJjrpHAj9B1yWWKBQlg84Kh09woMEhHUU2cEa
         KOY0kznD1wapAliNMasMGebofi/5C0eE2DqLp0l+EEt5mArBd2vy3Yo04ZM1kITLR6j/
         wX70BqOd7Aib09yS32yfOwpCyHt31dLYwL1XDGBWU4s5le2psBDQrNVvQWjTKIiKMDoW
         v5KEXKbA8t22moFlCgMbf7AdPqw5TNnmhnBjrgb9+VF5KcmOtRsc8X6SdQO2uMIT7bPk
         OI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1KAv7OlWQlmHNtXqUJvuaSXGHvX/OsIn970Hsnpf/A=;
        b=seKcbOr2AMQd7cK3gZfNBrgnZC7yMdlxW8WlNsoR+0fJ4D3r/jou1TI93L+L/8qFMb
         RDAWf7aV/j0oSJp1cpqxETdWxAx5tJrz8mRwUT3TkDzJQua9j5h41mJyXu5xRvHFxGLx
         AYl/xbpz/PRVx48gbgpZb2pkLYlg+k12ENK1oVZu2WEYb71nQ8Fyt8U1BXYb8N0bppMq
         Z/yUk6U7iQPbuuwRiHLu1VYLcq7vQDXGnhWr4Tn5kSCxu57wU9mBx7ZgtEbWEAnTzRX9
         4jEXlYDSX9FpP9XOxG2m9Ru4p92kyLZK4/ePm8lJMyGXlggJur4L6H+R5hZcgGFD4oce
         g1OQ==
X-Gm-Message-State: AOAM530hk3afFrdcdzhQ30dxcBYs3gObR8o+LCq7vXNMG4+OZF9mpgnd
        nmOn+nw11gESMcNuWmQDe+Y=
X-Google-Smtp-Source: ABdhPJyAD3YAi46chdRHQnkcgsM2fnWQOQ78XpWL3XF36mWSn27sOIDySATkiTjsTMQ34bzXUYQ4sg==
X-Received: by 2002:a05:6512:374c:: with SMTP id a12mr1611677lfs.34.1614339974026;
        Fri, 26 Feb 2021 03:46:14 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f16sm1380475lfk.217.2021.02.26.03.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:46:13 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] phy: bcm-ns-usb2: support updated single CRU reg DT binding
Date:   Fri, 26 Feb 2021 12:45:01 +0100
Message-Id: <20210226114501.31086-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226114501.31086-1-zajec5@gmail.com>
References: <20210226114501.31086-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Updated DT binding maps a single CRU register that is directly used for
the PHY control. Accessing common CRU reg is handled using syscon &
regmap.

The old binding has been deprecated and stays as a fallback method.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
It's a reworked version of my abonded 2019 patch:
[PATCH V2 2/2] phy: bcm-ns-usb2: support updated DT binding with the CRU syscon
https://lore.kernel.org/patchwork/patch/1029863/
---
 drivers/phy/broadcom/phy-bcm-ns-usb2.c | 52 +++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 4b015b8a71c3..98d32729a45d 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -9,17 +9,23 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 struct bcm_ns_usb2 {
 	struct device *dev;
 	struct clk *ref_clk;
 	struct phy *phy;
+	struct regmap *clkset;
+	void __iomem *base;
+
+	/* Deprecated binding */
 	void __iomem *dmu;
 };
 
@@ -27,7 +33,6 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 {
 	struct bcm_ns_usb2 *usb2 = phy_get_drvdata(phy);
 	struct device *dev = usb2->dev;
-	void __iomem *dmu = usb2->dmu;
 	u32 ref_clk_rate, usb2ctl, usb_pll_ndiv, usb_pll_pdiv;
 	int err = 0;
 
@@ -44,7 +49,10 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 		goto err_clk_off;
 	}
 
-	usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	if (usb2->base)
+		usb2ctl = readl(usb2->base);
+	else
+		usb2ctl = readl(usb2->dmu + BCMA_DMU_CRU_USB2_CONTROL);
 
 	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
 		usb_pll_pdiv = usb2ctl;
@@ -58,15 +66,24 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
 
 	/* Unlock DMU PLL settings with some magic value */
-	writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	if (usb2->clkset)
+		regmap_write(usb2->clkset, 0, 0x0000ea68);
+	else
+		writel(0x0000ea68, usb2->dmu + BCMA_DMU_CRU_CLKSET_KEY);
 
 	/* Write USB 2.0 PLL control setting */
 	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
 	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
-	writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	if (usb2->base)
+		writel(usb2ctl, usb2->base);
+	else
+		writel(usb2ctl, usb2->dmu + BCMA_DMU_CRU_USB2_CONTROL);
 
 	/* Lock DMU PLL settings */
-	writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	if (usb2->clkset)
+		regmap_write(usb2->clkset, 0, 0x00000000);
+	else
+		writel(0x00000000, usb2->dmu + BCMA_DMU_CRU_CLKSET_KEY);
 
 err_clk_off:
 	clk_disable_unprepare(usb2->ref_clk);
@@ -90,10 +107,27 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	usb2->dev = dev;
 
-	usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
-	if (IS_ERR(usb2->dmu)) {
-		dev_err(dev, "Failed to map DMU regs\n");
-		return PTR_ERR(usb2->dmu);
+	if (of_find_property(dev->of_node, "brcm,syscon-clkset", NULL)) {
+		usb2->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(usb2->base)) {
+			dev_err(dev, "Failed to map control reg\n");
+			return PTR_ERR(usb2->base);
+		}
+
+		usb2->clkset = syscon_regmap_lookup_by_phandle(dev->of_node,
+							       "brcm,syscon-clkset");
+		if (IS_ERR(usb2->clkset)) {
+			dev_err(dev, "Failed to lookup clkset regmap\n");
+			return PTR_ERR(usb2->clkset);
+		}
+	} else {
+		usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
+		if (IS_ERR(usb2->dmu)) {
+			dev_err(dev, "Failed to map DMU regs\n");
+			return PTR_ERR(usb2->dmu);
+		}
+
+		dev_warn(dev, "using deprecated DT binding\n");
 	}
 
 	usb2->ref_clk = devm_clk_get(dev, "phy-ref-clk");
-- 
2.26.2

