Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFE33B023D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFVLFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:05:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36948 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229837AbhFVLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:05:05 -0400
X-UUID: f60c50f0241e4612bee59c968a83be0a-20210622
X-UUID: f60c50f0241e4612bee59c968a83be0a-20210622
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2063075771; Tue, 22 Jun 2021 19:02:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 19:02:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Jun 2021 19:02:39 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v7, 2/2] soc: mediatek: mmsys: Add mt8192 mmsys routing table
Date:   Tue, 22 Jun 2021 19:02:27 +0800
Message-ID: <1624359747-25567-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624359747-25567-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1624359747-25567-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8192 has different routing registers than mt8183

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/soc/mediatek/mt8192-mmsys.h | 68 +++++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    | 11 ++++++
 2 files changed, 79 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h

diff --git a/drivers/soc/mediatek/mt8192-mmsys.h b/drivers/soc/mediatek/mt8192-mmsys.h
new file mode 100644
index 0000000..3179029
--- /dev/null
+++ b/drivers/soc/mediatek/mt8192-mmsys.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8192_MMSYS_H
+#define __SOC_MEDIATEK_MT8192_MMSYS_H
+
+#define MT8192_MMSYS_OVL_MOUT_EN		0xf04
+#define MT8192_DISP_OVL1_2L_MOUT_EN		0xf08
+#define MT8192_DISP_OVL0_2L_MOUT_EN		0xf18
+#define MT8192_DISP_OVL0_MOUT_EN		0xf1c
+#define MT8192_DISP_RDMA0_SEL_IN		0xf2c
+#define MT8192_DISP_RDMA0_SOUT_SEL		0xf30
+#define MT8192_DISP_CCORR0_SOUT_SEL		0xf34
+#define MT8192_DISP_AAL0_SEL_IN			0xf38
+#define MT8192_DISP_DITHER0_MOUT_EN		0xf3c
+#define MT8192_DISP_DSI0_SEL_IN			0xf40
+#define MT8192_DISP_OVL2_2L_MOUT_EN		0xf4c
+
+#define MT8192_DISP_OVL0_GO_BLEND			BIT(0)
+#define MT8192_DITHER0_MOUT_IN_DSI0			BIT(0)
+#define MT8192_OVL0_MOUT_EN_DISP_RDMA0			BIT(0)
+#define MT8192_OVL2_2L_MOUT_EN_RDMA4			BIT(0)
+#define MT8192_DISP_OVL0_GO_BG				BIT(1)
+#define MT8192_DISP_OVL0_2L_GO_BLEND			BIT(2)
+#define MT8192_DISP_OVL0_2L_GO_BG			BIT(3)
+#define MT8192_OVL1_2L_MOUT_EN_RDMA1			BIT(4)
+#define MT8192_OVL0_MOUT_EN_OVL0_2L			BIT(4)
+#define MT8192_RDMA0_SEL_IN_OVL0_2L			0x3
+#define MT8192_RDMA0_SOUT_COLOR0			0x1
+#define MT8192_CCORR0_SOUT_AAL0				0x1
+#define MT8192_AAL0_SEL_IN_CCORR0			0x1
+#define MT8192_DSI0_SEL_IN_DITHER0			0x1
+
+static const struct mtk_mmsys_routes mmsys_mt8192_routing_table[] = {
+	{
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8192_DISP_OVL0_2L_MOUT_EN, MT8192_OVL0_MOUT_EN_DISP_RDMA0,
+	}, {
+		DDP_COMPONENT_OVL_2L2, DDP_COMPONENT_RDMA4,
+		MT8192_DISP_OVL2_2L_MOUT_EN, MT8192_OVL2_2L_MOUT_EN_RDMA4
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8192_DISP_DITHER0_MOUT_EN, MT8192_DITHER0_MOUT_IN_DSI0
+	}, {
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8192_DISP_RDMA0_SEL_IN, MT8192_RDMA0_SEL_IN_OVL0_2L
+	}, {
+		DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
+		MT8192_DISP_AAL0_SEL_IN, MT8192_AAL0_SEL_IN_CCORR0
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
+		MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0
+	}, {
+		DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
+		MT8192_DISP_CCORR0_SOUT_SEL, MT8192_CCORR0_SOUT_AAL0
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
+		MT8192_MMSYS_OVL_MOUT_EN, MT8192_DISP_OVL0_GO_BG,
+	}, {
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8192_MMSYS_OVL_MOUT_EN, MT8192_DISP_OVL0_2L_GO_BLEND,
+	}
+};
+
+#endif /* __SOC_MEDIATEK_MT8192_MMSYS_H */
+
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 080660e..de7b122 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -13,6 +13,7 @@
 #include "mtk-mmsys.h"
 #include "mt8167-mmsys.h"
 #include "mt8183-mmsys.h"
+#include "mt8192-mmsys.h"
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.clk_driver = "clk-mt2701-mm",
@@ -52,6 +53,12 @@
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
+static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
+	.clk_driver = "clk-mt8192-mm",
+	.routes = mmsys_mt8192_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
+};
+
 struct mtk_mmsys {
 	void __iomem *regs;
 	const struct mtk_mmsys_driver_data *data;
@@ -157,6 +164,10 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		.compatible = "mediatek,mt8183-mmsys",
 		.data = &mt8183_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8192-mmsys",
+		.data = &mt8192_mmsys_driver_data,
+	},
 	{ }
 };
 
-- 
1.8.1.1.dirty

