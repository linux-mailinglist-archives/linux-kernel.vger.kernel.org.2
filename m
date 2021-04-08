Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C12358270
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhDHLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:49:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16095 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:49:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGKHP5yJSz19L6C;
        Thu,  8 Apr 2021 19:46:57 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:49:00 +0800
From:   He Ying <heying24@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <chunfeng.yun@mediatek.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <heying24@huawei.com>
Subject: [PATCH v2 -next] phy: phy-mtk-mipi-dsi: Remove redundant dev_err call in mtk_mipi_tx_probe()
Date:   Thu, 8 Apr 2021 07:48:50 -0400
Message-ID: <20210408114850.14422-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
v2:
- Use 'return PTR_ERR();' instead of 'ret = PTR_ERR();return ret;'.

 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index c51114d8e437..01cf31633019 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -151,9 +151,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mipi_tx->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(mipi_tx->regs)) {
-		ret = PTR_ERR(mipi_tx->regs);
-		dev_err(dev, "Failed to get memory resource: %d\n", ret);
-		return ret;
+		return PTR_ERR(mipi_tx->regs);
 	}
 
 	ref_clk = devm_clk_get(dev, NULL);
-- 
2.17.1

