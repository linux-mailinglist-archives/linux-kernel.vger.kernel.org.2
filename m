Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4F63D894B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhG1H7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:59:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43092 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235070AbhG1H7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:59:17 -0400
X-UUID: 18a18a3682fc48beade026321c9e7dac-20210728
X-UUID: 18a18a3682fc48beade026321c9e7dac-20210728
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 870256727; Wed, 28 Jul 2021 15:59:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 15:59:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 15:59:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 7/9] phy: phy-mtk-hdmi: convert to devm_platform_ioremap_resource
Date:   Wed, 28 Jul 2021 15:58:29 +0800
Message-ID: <1627459111-2907-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource to simplify code

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 8ad8f717ef43..5fb4217fb8e0 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -100,7 +100,6 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_hdmi_phy *hdmi_phy;
-	struct resource *mem;
 	struct clk *ref_clk;
 	const char *ref_clk_name;
 	struct clk_init_data clk_init = {
@@ -116,11 +115,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	if (!hdmi_phy)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdmi_phy->regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(hdmi_phy->regs)) {
+	hdmi_phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hdmi_phy->regs))
 		return PTR_ERR(hdmi_phy->regs);
-	}
 
 	ref_clk = devm_clk_get(dev, "pll_ref");
 	if (IS_ERR(ref_clk)) {
-- 
2.18.0

