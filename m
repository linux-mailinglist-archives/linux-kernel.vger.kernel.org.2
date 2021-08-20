Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90F3F2AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbhHTLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:18:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43514 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240078AbhHTLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:18:05 -0400
X-UUID: 814fd5254a394bc59a0fa4e389282ee0-20210820
X-UUID: 814fd5254a394bc59a0fa4e389282ee0-20210820
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 891891612; Fri, 20 Aug 2021 19:17:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 19:17:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Aug 2021 19:17:23 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v2 12/24] clk: mediatek: Add MT8195 imgsys clock support
Date:   Fri, 20 Aug 2021 19:14:52 +0800
Message-ID: <20210820111504.350-13-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210820111504.350-1-chun-jie.chen@mediatek.com>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 imgsys clock controllers which provide clock gate
control for img IP blocks.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile         |  2 +-
 drivers/clk/mediatek/clk-mt8195-img.c | 96 +++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-img.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 03fb020834f3..f9736e6640ce 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -81,6 +81,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-mt8195-cam.o \
-					clk-mt8195-ccu.o
+					clk-mt8195-ccu.o clk-mt8195-img.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
new file mode 100644
index 000000000000..ee864a8fe5f1
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8195-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs img_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate img_clks[] = {
+	GATE_IMG(CLK_IMG_LARB9, "img_larb9", "top_img", 0),
+	GATE_IMG(CLK_IMG_TRAW0, "img_traw0", "top_img", 1),
+	GATE_IMG(CLK_IMG_TRAW1, "img_traw1", "top_img", 2),
+	GATE_IMG(CLK_IMG_TRAW2, "img_traw2", "top_img", 3),
+	GATE_IMG(CLK_IMG_TRAW3, "img_traw3", "top_img", 4),
+	GATE_IMG(CLK_IMG_DIP0, "img_dip0", "top_img", 8),
+	GATE_IMG(CLK_IMG_WPE0, "img_wpe0", "top_img", 9),
+	GATE_IMG(CLK_IMG_IPE, "img_ipe", "top_img", 10),
+	GATE_IMG(CLK_IMG_DIP1, "img_dip1", "top_img", 11),
+	GATE_IMG(CLK_IMG_WPE1, "img_wpe1", "top_img", 12),
+	GATE_IMG(CLK_IMG_GALS, "img_gals", "top_img", 31),
+};
+
+static const struct mtk_gate img1_dip_top_clks[] = {
+	GATE_IMG(CLK_IMG1_DIP_TOP_LARB10, "img1_dip_top_larb10", "top_img", 0),
+	GATE_IMG(CLK_IMG1_DIP_TOP_DIP_TOP, "img1_dip_top_dip_top", "top_img", 1),
+};
+
+static const struct mtk_gate img1_dip_nr_clks[] = {
+	GATE_IMG(CLK_IMG1_DIP_NR_RESERVE, "img1_dip_nr_reserve", "top_img", 0),
+	GATE_IMG(CLK_IMG1_DIP_NR_DIP_NR, "img1_dip_nr_dip_nr", "top_img", 1),
+};
+
+static const struct mtk_gate img1_wpe_clks[] = {
+	GATE_IMG(CLK_IMG1_WPE_LARB11, "img1_wpe_larb11", "top_img", 0),
+	GATE_IMG(CLK_IMG1_WPE_WPE, "img1_wpe_wpe", "top_img", 1),
+};
+
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
+
+static const struct mtk_clk_desc img1_dip_top_desc = {
+	.clks = img1_dip_top_clks,
+	.num_clks = ARRAY_SIZE(img1_dip_top_clks),
+};
+
+static const struct mtk_clk_desc img1_dip_nr_desc = {
+	.clks = img1_dip_nr_clks,
+	.num_clks = ARRAY_SIZE(img1_dip_nr_clks),
+};
+
+static const struct mtk_clk_desc img1_wpe_desc = {
+	.clks = img1_wpe_clks,
+	.num_clks = ARRAY_SIZE(img1_wpe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_img[] = {
+	{
+		.compatible = "mediatek,mt8195-imgsys",
+		.data = &img_desc,
+	}, {
+		.compatible = "mediatek,mt8195-imgsys1_dip_top",
+		.data = &img1_dip_top_desc,
+	}, {
+		.compatible = "mediatek,mt8195-imgsys1_dip_nr",
+		.data = &img1_dip_nr_desc,
+	}, {
+		.compatible = "mediatek,mt8195-imgsys1_wpe",
+		.data = &img1_wpe_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_img_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-img",
+		.of_match_table = of_match_clk_mt8195_img,
+	},
+};
+builtin_platform_driver(clk_mt8195_img_drv);
-- 
2.18.0

