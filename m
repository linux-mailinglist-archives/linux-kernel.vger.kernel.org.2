Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE8358487
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhDHNWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:22:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15627 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:22:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGMKg1dGvzpW0F;
        Thu,  8 Apr 2021 21:19:03 +0800 (CST)
Received: from huawei.com (10.67.174.37) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:21:46 +0800
From:   Chen Hui <clare.chenhui@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/mediatek: Remove redundant dev_err calls
Date:   Thu, 8 Apr 2021 21:21:50 +0800
Message-ID: <20210408132150.200583-1-clare.chenhui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err calls to avoid redundant
error messages.

Signed-off-by: Chen Hui <clare.chenhui@huawei.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 4 +---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 63f411ab393b..d9b6f3b100dc 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -112,10 +112,8 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->regs)) {
-		dev_err(dev, "failed to ioremap color\n");
+	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
-	}
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
 	if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 3ebf91e0ab41..ad5df3f9d477 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -146,10 +146,8 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->regs)) {
-		dev_err(dev, "failed to ioremap gamma\n");
+	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
-	}
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
-- 
2.17.1

