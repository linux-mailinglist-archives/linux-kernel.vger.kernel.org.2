Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E223EE99E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhHQJVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:21:01 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34882 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239485AbhHQJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:20:52 -0400
X-UUID: 1526a1858f954a279f3a88e9d905fca2-20210817
X-UUID: 1526a1858f954a279f3a88e9d905fca2-20210817
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 539471833; Tue, 17 Aug 2021 17:20:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 17:20:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 17:20:12 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 7/9] phy: phy-mtk-hdmi: convert to devm_platform_ioremap_resource
Date:   Tue, 17 Aug 2021 17:19:45 +0800
Message-ID: <1629191987-20774-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1629191987-20774-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1629191987-20774-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource to simplify code

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: no changes
v2: add acked-by CK
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

