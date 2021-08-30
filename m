Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE43FAF89
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhH3BZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 21:25:41 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:38322 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231401AbhH3BZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 21:25:38 -0400
X-QQ-mid: bizesmtp46t1630286661to8pa6p1
Received: from localhost.localdomain (unknown [111.207.172.18])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 30 Aug 2021 09:24:19 +0800 (CST)
X-QQ-SSF: 0140000000200070D000B00A0000000
X-QQ-FEAT: KrMf3JMLLXNBGie6cqgwm5UBDY6dT7nckKLs6yVHyn3GdTx38fmsxejuRm+3k
        M9rvrjyNm5KqW/wPxPyXsLogH7t1UO3fkkB8ieChemlDysJ7aV9kY9w+G3ClZ1aR8H80oIx
        0PjrlkrKNuwQncKD+CHr4yaX76wodH3CV3JNoVGeeWSalyrWjCimlbhhix8VJ8kaceU4Dsr
        VwDnEo9x5aATgfBBsEOVhslZLPO34dwSrYaDNgxWErKreXLSn02NuOsFDZpJyAias7i9JXK
        3DTlVS2NkLX+8FqUZu3BzDx4DdZMBZHN++Tvl2FJQX7Ml7MP8JIGCF/jzlwXgNuK31tRrac
        JiAsWjJhrqnKMCA1pk=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     davem@davemloft.net, kuba@kernel.org, mcoquelin.stm32@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v2] stmmac: dwmac-loongson: change the pr_info() to dev_err() in loongson_dwmac_probe()
Date:   Mon, 30 Aug 2021 09:24:17 +0800
Message-Id: <20210830012417.14872-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the pr_info to dev_err.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
v2: Remove the adding a return. 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 4c9a37dd0d3f..abcb55f87579 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -54,14 +54,13 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
 
@@ -69,6 +68,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat)
 		return -ENOMEM;
 
+
 	if (plat->mdio_node) {
 		dev_err(&pdev->dev, "Found MDIO subnode\n");
 		mdio = true;
@@ -111,6 +111,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	phy_mode = device_get_phy_mode(&pdev->dev);
 	if (phy_mode < 0)
 		dev_err(&pdev->dev, "phy_mode not found\n");
+	
 
 	plat->phy_interface = phy_mode;
 	plat->interface = PHY_INTERFACE_MODE_GMII;
-- 
2.20.1



