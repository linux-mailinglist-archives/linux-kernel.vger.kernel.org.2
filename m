Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5505732E033
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 04:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCEDks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 22:40:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13128 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 22:40:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsD463P4Hz16GHY;
        Fri,  5 Mar 2021 11:39:02 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 11:40:36 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] phy: ralink: phy-mt7621-pci: fix return value check in mt7621_pci_phy_probe()
Date:   Fri, 5 Mar 2021 03:49:31 +0000
Message-ID: <20210305034931.3237558-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the return value check which testing the wrong variable
in mt7621_pci_phy_probe().

Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/ralink/phy-mt7621-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
index 84ee2b5c2228..753cb5bab930 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -319,9 +319,9 @@ static int mt7621_pci_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy->regmap);
 
 	phy->phy = devm_phy_create(dev, dev->of_node, &mt7621_pci_phy_ops);
-	if (IS_ERR(phy)) {
+	if (IS_ERR(phy->phy)) {
 		dev_err(dev, "failed to create phy\n");
-		return PTR_ERR(phy);
+		return PTR_ERR(phy->phy);
 	}
 
 	phy_set_drvdata(phy->phy, phy);

