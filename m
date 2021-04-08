Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A035828A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhDHL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:56:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16096 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHL43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:56:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGKRc3Ky4z19KPl;
        Thu,  8 Apr 2021 19:54:04 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:56:10 +0800
From:   He Ying <heying24@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <chunfeng.yun@mediatek.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <heying24@huawei.com>
Subject: [PATCH v2 -next] phy: phy-mtk-hdmi: Remove redundant dev_err call in mtk_hdmi_phy_probe()
Date:   Thu, 8 Apr 2021 07:55:30 -0400
Message-ID: <20210408115530.15673-1-heying24@huawei.com>
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

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
v2:
- Use 'return PTR_ERR()' instead of 'ret = PTR_ERR();return ret;'.

 drivers/phy/mediatek/phy-mtk-hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 8313bd517e4c..8ad8f717ef43 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -119,9 +119,7 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hdmi_phy->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(hdmi_phy->regs)) {
-		ret = PTR_ERR(hdmi_phy->regs);
-		dev_err(dev, "Failed to get memory resource: %d\n", ret);
-		return ret;
+		return PTR_ERR(hdmi_phy->regs);
 	}
 
 	ref_clk = devm_clk_get(dev, "pll_ref");
-- 
2.17.1

