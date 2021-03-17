Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9833F805
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhCQSRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:17:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhCQSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:17:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4DC5F1F45485
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Collabora Kernel ML <kernel@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
Date:   Wed, 17 Mar 2021 19:17:09 +0100
Message-Id: <20210317181711.795245-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317181711.795245-1-enric.balletbo@collabora.com>
References: <20210317181711.795245-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

Apart from the driver data, in order to extend the driver to support more
and more SoCs, we will need to store other configuration data. So, create
a mtk_mmsys struct to encapsulate all that information.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---

Changes in v2: None

 drivers/soc/mediatek/mtk-mmsys.c | 47 ++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 18f93979e14a..da2de8f6969e 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -101,6 +101,11 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
 };
 
+struct mtk_mmsys {
+	void __iomem *regs;
+	const struct mtk_mmsys_driver_data *data;
+};
+
 static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
 					  enum mtk_ddp_comp_id next,
 					  unsigned int *addr)
@@ -259,21 +264,21 @@ void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next)
 {
-	void __iomem *config_regs = dev_get_drvdata(dev);
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
 	unsigned int addr, value, reg;
 
 	value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) | value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 
-	mtk_mmsys_ddp_sout_sel(config_regs, cur, next);
+	mtk_mmsys_ddp_sout_sel(mmsys->regs, cur, next);
 
 	value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) | value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
@@ -282,44 +287,46 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
 {
-	void __iomem *config_regs = dev_get_drvdata(dev);
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
 	unsigned int addr, value, reg;
 
 	value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) & ~value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 
 	value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) & ~value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
 static int mtk_mmsys_probe(struct platform_device *pdev)
 {
-	const struct mtk_mmsys_driver_data *data;
 	struct device *dev = &pdev->dev;
 	struct platform_device *clks;
 	struct platform_device *drm;
-	void __iomem *config_regs;
+	struct mtk_mmsys *mmsys;
 	int ret;
 
-	config_regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(config_regs)) {
-		ret = PTR_ERR(config_regs);
+	mmsys = devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
+	if (!mmsys)
+		return -ENOMEM;
+
+	mmsys->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmsys->regs)) {
+		ret = PTR_ERR(mmsys->regs);
 		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, config_regs);
-
-	data = of_device_get_match_data(&pdev->dev);
+	mmsys->data = of_device_get_match_data(&pdev->dev);
+	platform_set_drvdata(pdev, mmsys);
 
-	clks = platform_device_register_data(&pdev->dev, data->clk_driver,
+	clks = platform_device_register_data(&pdev->dev, mmsys->data->clk_driver,
 					     PLATFORM_DEVID_AUTO, NULL, 0);
 	if (IS_ERR(clks))
 		return PTR_ERR(clks);
-- 
2.30.2

