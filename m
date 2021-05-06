Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16893752E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhEFLQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhEFLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:16:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC5C061574;
        Thu,  6 May 2021 04:15:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d4so5171503wru.7;
        Thu, 06 May 2021 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOXi5EtG92mh2v/zZTygCocGHAlghP72W6QLY75l19M=;
        b=pxzkAsfKZcA/wdsw0ENtktQOC/JOklFuvalj3l4oV2eh/0PVIRtFGwo5o94vuPiHTH
         Djx8SpTlNUe7L4KNGvCEwHWWtWg0UlV2VTBmJ9R/vNnBL3EHrxKY0dpno4luiMjgxdaB
         ds2jPVljk9Mh2X8iqqTZdcjKv5E5ZWI+sEf6dt9EA2aOypj8HWQRSEMtVV8arFmAmlCP
         935qE5O8zZKRUtSEu1A+lFMHzeSwfcPyVAucB13HRga8hPEReswn9G5k+g3BR5Bh1rLJ
         yBuf3V3EEva4jUCWi4qvyD4s2Zi5wxFrHrel4Ov1KpsYlFOSUis9eZcZQP8ps2HNxIQC
         qVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOXi5EtG92mh2v/zZTygCocGHAlghP72W6QLY75l19M=;
        b=aI70Y1fKQqFm2nycD1GTEsS/bdQvJbZseqbo9q4eXBsJMTe3YWT6an3eV8ewfVnas+
         gH8h8uFxf45Q+1YdURA1wzKUC3T5/I3I1v/zi60Vo98q1ihhlgENhRGScwrT1IoMdLlo
         Yb6YcZH9ItvOV9rDttW6hwkxDQXDq1wGXZWTTvKghhKS/76TB1MXJW1PNL5cA0+3kABn
         JqTkEn/0UhdYaysRNMLnf6j0+RNA5KOU1RoBoD38/5l97cJhgyc4WKyT7B7Y93ZwVV9X
         PYhpWgFXXk4JY9l6ijwyXa6z2VaDeuvCmIRqUvXCoiKgrV3WISSm+sSbcXcz3nuoX8fy
         +53A==
X-Gm-Message-State: AOAM532RxekN912avuuFEU918Pb7NqMWMKPg6GJjAgdSMRWs+BLJ7OBK
        n9u0qMgy9AS9uK5CDxxfpLg=
X-Google-Smtp-Source: ABdhPJxUEUmG7JhrrHTaTPsA7bglIxKepeD8Syw2pUKT/mf8O1Eob4CIrVJD5cakc4HURRW9j+p0sQ==
X-Received: by 2002:adf:f152:: with SMTP id y18mr4480748wro.77.1620299737290;
        Thu, 06 May 2021 04:15:37 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id u5sm3642433wrt.38.2021.05.06.04.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:15:36 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: [PATCH 3/5] phy: ralink: phy-mt7621-pci: use kernel clock APIS
Date:   Thu,  6 May 2021 13:15:29 +0200
Message-Id: <20210506111531.21978-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
References: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 SoC clock driver has already mainlined in
'commit 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")'
This allow us to properly use kernel clock apis to get
the clock frequency needed for the phy configuration
instead of use custom architecture code to do the same.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/phy-mt7621-pci.c | 33 +++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
index 753cb5bab930..5222edc7be10 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/phy/phy.h>
+#include <linux/clk.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
@@ -14,8 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sys_soc.h>
-#include <mt7621.h>
-#include <ralink_regs.h>
 
 #define RG_PE1_PIPE_REG				0x02c
 #define RG_PE1_PIPE_RST				BIT(12)
@@ -62,8 +61,6 @@
 
 #define RG_PE1_FRC_MSTCKDIV			BIT(5)
 
-#define XTAL_MASK				GENMASK(8, 6)
-
 #define MAX_PHYS	2
 
 /**
@@ -71,6 +68,7 @@
  * @dev: pointer to device
  * @regmap: kernel regmap pointer
  * @phy: pointer to the kernel PHY device
+ * @sys_clk: pointer to the system XTAL clock
  * @port_base: base register
  * @has_dual_port: if the phy has dual ports.
  * @bypass_pipe_rst: mark if 'mt7621_bypass_pipe_rst'
@@ -80,6 +78,7 @@ struct mt7621_pci_phy {
 	struct device *dev;
 	struct regmap *regmap;
 	struct phy *phy;
+	struct clk *sys_clk;
 	void __iomem *port_base;
 	bool has_dual_port;
 	bool bypass_pipe_rst;
@@ -116,12 +115,14 @@ static void mt7621_bypass_pipe_rst(struct mt7621_pci_phy *phy)
 	}
 }
 
-static void mt7621_set_phy_for_ssc(struct mt7621_pci_phy *phy)
+static int mt7621_set_phy_for_ssc(struct mt7621_pci_phy *phy)
 {
 	struct device *dev = phy->dev;
-	u32 xtal_mode;
+	unsigned long clk_rate;
 
-	xtal_mode = FIELD_GET(XTAL_MASK, rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0));
+	clk_rate = clk_get_rate(phy->sys_clk);
+	if (!clk_rate)
+		return -EINVAL;
 
 	/* Set PCIe Port PHY to disable SSC */
 	/* Debug Xtal Type */
@@ -139,13 +140,13 @@ static void mt7621_set_phy_for_ssc(struct mt7621_pci_phy *phy)
 			       RG_PE1_PHY_EN, RG_PE1_FRC_PHY_EN);
 	}
 
-	if (xtal_mode <= 5 && xtal_mode >= 3) { /* 40MHz Xtal */
+	if (clk_rate == 40000000) { /* 40MHz Xtal */
 		/* Set Pre-divider ratio (for host mode) */
 		mt7621_phy_rmw(phy, RG_PE1_H_PLL_REG, RG_PE1_H_PLL_PREDIV,
 			       FIELD_PREP(RG_PE1_H_PLL_PREDIV, 0x01));
 
 		dev_dbg(dev, "Xtal is 40MHz\n");
-	} else if (xtal_mode >= 6) { /* 25MHz Xal */
+	} else if (clk_rate == 25000000) { /* 25MHz Xal */
 		mt7621_phy_rmw(phy, RG_PE1_H_PLL_REG, RG_PE1_H_PLL_PREDIV,
 			       FIELD_PREP(RG_PE1_H_PLL_PREDIV, 0x00));
 
@@ -196,13 +197,15 @@ static void mt7621_set_phy_for_ssc(struct mt7621_pci_phy *phy)
 	mt7621_phy_rmw(phy, RG_PE1_H_PLL_BR_REG, RG_PE1_H_PLL_BR,
 		       FIELD_PREP(RG_PE1_H_PLL_BR, 0x00));
 
-	if (xtal_mode <= 5 && xtal_mode >= 3) { /* 40MHz Xtal */
+	if (clk_rate == 40000000) { /* 40MHz Xtal */
 		/* set force mode enable of da_pe1_mstckdiv */
 		mt7621_phy_rmw(phy, RG_PE1_MSTCKDIV_REG,
 			       RG_PE1_MSTCKDIV | RG_PE1_FRC_MSTCKDIV,
 			       FIELD_PREP(RG_PE1_MSTCKDIV, 0x01) |
 			       RG_PE1_FRC_MSTCKDIV);
 	}
+
+	return 0;
 }
 
 static int mt7621_pci_phy_init(struct phy *phy)
@@ -212,9 +215,7 @@ static int mt7621_pci_phy_init(struct phy *phy)
 	if (mphy->bypass_pipe_rst)
 		mt7621_bypass_pipe_rst(mphy);
 
-	mt7621_set_phy_for_ssc(mphy);
-
-	return 0;
+	return mt7621_set_phy_for_ssc(mphy);
 }
 
 static int mt7621_pci_phy_power_on(struct phy *phy)
@@ -324,6 +325,12 @@ static int mt7621_pci_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy->phy);
 	}
 
+	phy->sys_clk = devm_clk_get(dev, "sys_clk");
+	if (IS_ERR(phy->sys_clk)) {
+		dev_err(dev, "failed to get phy clock\n");
+		return PTR_ERR(phy->sys_clk);
+	}
+
 	phy_set_drvdata(phy->phy, phy);
 
 	provider = devm_of_phy_provider_register(dev, mt7621_pcie_phy_of_xlate);
-- 
2.25.1

