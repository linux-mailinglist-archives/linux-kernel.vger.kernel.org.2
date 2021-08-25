Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED723F7329
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbhHYK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:27:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbhHYK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:27:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0EE521F4370B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        eizan@chromium.org, drinkcat@chromium.org, chunkuang.hu@kernel.org,
        kernel@collabora.com, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/7] soc: mediatek: mmsys: Add reset controller support
Date:   Wed, 25 Aug 2021 12:26:31 +0200
Message-Id: <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825102632.601614-1-enric.balletbo@collabora.com>
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
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
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---

(no changes since v1)

 drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.h |  2 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index a78e88f27b62..855a3a50840c 100644
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
@@ -62,6 +64,8 @@ static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
 struct mtk_mmsys {
 	void __iomem *regs;
 	const struct mtk_mmsys_driver_data *data;
+	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
+	struct reset_controller_dev rcdev;
 };
 
 void mtk_mmsys_ddp_connect(struct device *dev,
@@ -101,6 +105,59 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
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
@@ -120,6 +177,18 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
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
index 9e2b81bd38db..8b0ed05117ea 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -78,6 +78,8 @@
 #define DSI_SEL_IN_RDMA				0x1
 #define DSI_SEL_IN_MASK				0x1
 
+#define MMSYS_SW0_RST_B				0x140
+
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
-- 
2.30.2

