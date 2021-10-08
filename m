Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C154642623E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhJHCB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:01:28 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41636 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233656AbhJHCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:01:26 -0400
X-UUID: 84e716349a8c448d941e684b220ee898-20211008
X-UUID: 84e716349a8c448d941e684b220ee898-20211008
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2003491048; Fri, 08 Oct 2021 09:59:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 09:59:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Oct
 2021 09:59:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Oct 2021 09:59:24 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v10, 2/2] soc: mediatek: mmsys: Add mt8192 mmsys routing table
Date:   Fri, 8 Oct 2021 09:59:23 +0800
Message-ID: <20211008015923.24675-3-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008015923.24675-1-yongqiang.niu@mediatek.com>
References: <20211008015923.24675-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8192 has different routing registers than mt8183

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/soc/mediatek/mt8192-mmsys.h | 77 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    | 11 +++++
 2 files changed, 88 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h

diff --git a/drivers/soc/mediatek/mt8192-mmsys.h b/drivers/soc/mediatek/mt8192-mmsys.h
new file mode 100644
index 000000000000..7ea1531ee8af
--- /dev/null
+++ b/drivers/soc/mediatek/mt8192-mmsys.h
@@ -0,0 +1,77 @@
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
+		MT8192_OVL0_MOUT_EN_DISP_RDMA0
+	}, {
+		DDP_COMPONENT_OVL_2L2, DDP_COMPONENT_RDMA4,
+		MT8192_DISP_OVL2_2L_MOUT_EN, MT8192_OVL2_2L_MOUT_EN_RDMA4,
+		MT8192_OVL2_2L_MOUT_EN_RDMA4
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8192_DISP_DITHER0_MOUT_EN, MT8192_DITHER0_MOUT_IN_DSI0,
+		MT8192_DITHER0_MOUT_IN_DSI0
+	}, {
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8192_DISP_RDMA0_SEL_IN, MT8192_RDMA0_SEL_IN_OVL0_2L,
+		MT8192_RDMA0_SEL_IN_OVL0_2L
+	}, {
+		DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
+		MT8192_DISP_AAL0_SEL_IN, MT8192_AAL0_SEL_IN_CCORR0,
+		MT8192_AAL0_SEL_IN_CCORR0
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0,
+		MT8192_DSI0_SEL_IN_DITHER0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
+		MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0,
+		MT8192_RDMA0_SOUT_COLOR0
+	}, {
+		DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
+		MT8192_DISP_CCORR0_SOUT_SEL, MT8192_CCORR0_SOUT_AAL0,
+		MT8192_CCORR0_SOUT_AAL0
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
+		MT8192_MMSYS_OVL_MOUT_EN, MT8192_DISP_OVL0_GO_BG,
+		MT8192_DISP_OVL0_GO_BG,
+	}, {
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8192_MMSYS_OVL_MOUT_EN, MT8192_DISP_OVL0_2L_GO_BLEND,
+		MT8192_DISP_OVL0_2L_GO_BLEND,
+	}
+};
+
+#endif /* __SOC_MEDIATEK_MT8192_MMSYS_H */
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index a78e88f27b62..63fccdf3d491 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -14,6 +14,7 @@
 #include "mt8167-mmsys.h"
 #include "mt8183-mmsys.h"
 #include "mt8365-mmsys.h"
+#include "mt8192-mmsys.h"
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.clk_driver = "clk-mt2701-mm",
@@ -53,6 +54,12 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
+static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
+	.clk_driver = "clk-mt8192-mm",
+	.routes = mmsys_mt8192_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
+};
+
 static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
 	.clk_driver = "clk-mt8365-mm",
 	.routes = mt8365_mmsys_routing_table,
@@ -167,6 +174,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8183-mmsys",
 		.data = &mt8183_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8192-mmsys",
+		.data = &mt8192_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8365-mmsys",
 		.data = &mt8365_mmsys_driver_data,
-- 
2.25.1

