Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD29D3F9689
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbhH0I45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:56:57 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:36709 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244604AbhH0I4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:56:53 -0400
X-QQ-mid: bizesmtp45t1630054554txi14380
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 27 Aug 2021 16:55:51 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: 2NShQxXslJ80ztGdYiIwKJI2vknkXTv63LXb/bw/s+X3HP0lDGrw8HmTEgotg
        K3SAgXsqbAzrvemBm5NRhmo6Xvl6QZb0LPyvnsXYdGtVNMBELz54P4NX0i5Ach3T3u2nOlw
        LVlSSIFlFHQ58vylw2cXpabc1utlTAJbZ7nPlSbDf5/ZtOmBJ47VBZLEdXagzHVvC2KiUub
        EK7r714h9wdmcQ4MlqL26JYpMFIREL8idXQpX78arNRiAXCDeDP/N5tZhVTGLj8Vxfc56nw
        WIKkGAFy0vCMkiFCqUfvDffEeJR+1D0HQGNSfPawlnjXMAu+Hy6Itp015Y2seydmVhT5h7Z
        TvS2g2HGAgQ/9cLtMY=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     davem@davemloft.net, kuba@kernel.org, mcoquelin.stm32@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] stmmac: dwmac-loongson: change the pr_info() to dev_err() in loongson_dwmac_probe()
Date:   Fri, 27 Aug 2021 16:55:50 +0800
Message-Id: <20210827085550.13519-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the pr_info/dev_info to dev_err.
- Add the dev_err to improve readability.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 4c9a37dd0d3f..495c94e7929f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -54,20 +54,21 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	bool mdio = false;
 
 	np = dev_of_node(&pdev->dev);
-
 	if (!np) {
-		pr_info("dwmac_loongson_pci: No OF node\n");
+		dev_err(&pdev->dev, "dwmac_loongson_pci: No OF node\n");
 		return -ENODEV;
 	}
 
 	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
-		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
+		dev_err(&pdev->dev, "dwmac_loongson_pci: Incompatible OF node\n");
 		return -ENODEV;
 	}
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
-	if (!plat)
+	if (!plat) {
+		dev_err(&pdev->dev, "memory allocation failed\n");
 		return -ENOMEM;
+	}
 
 	if (plat->mdio_node) {
 		dev_err(&pdev->dev, "Found MDIO subnode\n");
@@ -109,8 +110,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		plat->bus_id = pci_dev_id(pdev);
 
 	phy_mode = device_get_phy_mode(&pdev->dev);
-	if (phy_mode < 0)
+	if (phy_mode < 0) {
 		dev_err(&pdev->dev, "phy_mode not found\n");
+		return phy_mode;
+	}
 
 	plat->phy_interface = phy_mode;
 	plat->interface = PHY_INTERFACE_MODE_GMII;
@@ -130,7 +133,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
 	if (res.wol_irq < 0) {
-		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
+		dev_err(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
 		res.wol_irq = res.irq;
 	}
 
-- 
2.20.1



