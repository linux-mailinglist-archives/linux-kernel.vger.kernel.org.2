Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060543B8550
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhF3Oud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhF3Otr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:49:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6A3C061767
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:47:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D19F91F4360B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     jitao.shi@mediatek.com, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, drinkcat@chromium.org, eizan@chromium.org,
        kernel@collabora.com, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] soc: mediatek: mmsys: Add reset controller support
Date:   Wed, 30 Jun 2021 16:46:45 +0200
Message-Id: <20210630164623.5.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210630144646.868702-1-enric.balletbo@collabora.com>
References: <20210630144646.868702-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among other features the mmsys driver should implement a reset
controller to be able to reset different bits from their space.

Cc: Jitao Shi <jitao.shi@mediatek.com>
Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.h |  2 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 080660ef11bf..c4ed99d92d1a 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -4,10 +4,12 @@
  * Author: James Liao <jamesjj.liao@mediatek.com>
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset-controller.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 
 #include "mtk-mmsys.h"
@@ -55,6 +57,8 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 struct mtk_mmsys {
 	void __iomem *regs;
 	const struct mtk_mmsys_driver_data *data;
+	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
+	struct reset_controller_dev rcdev;
 };
 
 void mtk_mmsys_ddp_connect(struct device *dev,
@@ -91,6 +95,59 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
+				  bool assert)
+{
+	struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
+	unsigned long flags;
+	u32 reg;
+	int i;
+
+	spin_lock_irqsave(&mmsys->lock, flags);
+
+	reg = readl_relaxed(mmsys->regs + MMSYS_SW0_RST_B);
+
+	if (assert)
+		reg &= ~BIT(id);
+	else
+		reg |= BIT(id);
+
+	writel_relaxed(reg, mmsys->regs + MMSYS_SW0_RST_B);
+
+	spin_unlock_irqrestore(&mmsys->lock, flags);
+
+	return 0;
+}
+
+static int mtk_mmsys_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return mtk_mmsys_reset_update(rcdev, id, true);
+}
+
+static int mtk_mmsys_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return mtk_mmsys_reset_update(rcdev, id, false);
+}
+
+static int mtk_mmsys_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = mtk_mmsys_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 1100);
+
+	return mtk_mmsys_reset_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops mtk_mmsys_reset_ops = {
+	.assert = mtk_mmsys_reset_assert,
+	.deassert = mtk_mmsys_reset_deassert,
+	.reset = mtk_mmsys_reset,
+};
+
 static int mtk_mmsys_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -110,6 +167,18 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	spin_lock_init(&mmsys->lock);
+
+	mmsys->rcdev.owner = THIS_MODULE;
+	mmsys->rcdev.nr_resets = 32;
+	mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
+	mmsys->rcdev.of_node = pdev->dev.of_node;
+	ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
+		return ret;
+	}
+
 	mmsys->data = of_device_get_match_data(&pdev->dev);
 	platform_set_drvdata(pdev, mmsys);
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 11388961dded..f9f9e12ceab8 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -66,6 +66,8 @@
 #define DPI_SEL_IN_BLS				0x0
 #define DSI_SEL_IN_RDMA				0x1
 
+#define MMSYS_SW0_RST_B				0x140
+
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
-- 
2.30.2

