Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CCC3AA6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhFPWwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:52:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33467 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234316AbhFPWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:52:02 -0400
X-UUID: b57bca0b1a8742d9bc5e36adc4e0e28d-20210617
X-UUID: b57bca0b1a8742d9bc5e36adc4e0e28d-20210617
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1247905543; Thu, 17 Jun 2021 06:49:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:49 +0800
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
Subject: [PATCH 09/22] clk: mediatek: Add MT8195 imgsys clock support
Date:   Thu, 17 Jun 2021 06:47:30 +0800
Message-ID: <20210616224743.5109-10-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 imgsys clock providers

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  6 ++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8195-img.c | 98 +++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-img.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 6a6e496d08a4..f92d0b6b7eec 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -612,6 +612,12 @@ config COMMON_CLK_MT8195_CCUSYS
 	help
 	  This driver supports MediaTek MT8195 ccusys clocks.
 
+config COMMON_CLK_MT8195_IMGSYS
+	bool "Clock driver for MediaTek MT8195 imgsys"
+	depends on COMMON_CLK_MT8195
+	help
+	  This driver supports MediaTek MT8195 imgsys clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index bb8aac6f9185..1768eda917c2 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -85,5 +85,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS) += clk-mt8195-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8195_AUDSYS_SRC) += clk-mt8195-aud_src.o
 obj-$(CONFIG_COMMON_CLK_MT8195_CAMSYS) += clk-mt8195-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8195_CCUSYS) += clk-mt8195-ccu.o
+obj-$(CONFIG_COMMON_CLK_MT8195_IMGSYS) += clk-mt8195-img.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
new file mode 100644
index 000000000000..923fa82aedae
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt8195-clk.h>
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
+	GATE_IMG(CLK_IMG_LARB9, "img_larb9", "img_sel", 0),
+	GATE_IMG(CLK_IMG_TRAW0, "img_traw0", "img_sel", 1),
+	GATE_IMG(CLK_IMG_TRAW1, "img_traw1", "img_sel", 2),
+	GATE_IMG(CLK_IMG_TRAW2, "img_traw2", "img_sel", 3),
+	GATE_IMG(CLK_IMG_TRAW3, "img_traw3", "img_sel", 4),
+	GATE_IMG(CLK_IMG_DIP0, "img_dip0", "img_sel", 8),
+	GATE_IMG(CLK_IMG_WPE0, "img_wpe0", "img_sel", 9),
+	GATE_IMG(CLK_IMG_IPE, "img_ipe", "img_sel", 10),
+	GATE_IMG(CLK_IMG_DIP1, "img_dip1", "img_sel", 11),
+	GATE_IMG(CLK_IMG_WPE1, "img_wpe1", "img_sel", 12),
+	GATE_IMG(CLK_IMG_GALS, "img_gals", "img_sel", 31),
+};
+
+static const struct mtk_gate img1_dip_top_clks[] = {
+	GATE_IMG(CLK_IMG1_DIP_TOP_LARB10, "img1_dip_top_larb10", "img_sel", 0),
+	GATE_IMG(CLK_IMG1_DIP_TOP_DIP_TOP, "img1_dip_top_dip_top", "img_sel", 1),
+};
+
+static const struct mtk_gate img1_dip_nr_clks[] = {
+	GATE_IMG(CLK_IMG1_DIP_NR_RESERVE, "img1_dip_nr_reserve", "img_sel", 0),
+	GATE_IMG(CLK_IMG1_DIP_NR_DIP_NR, "img1_dip_nr_dip_nr", "img_sel", 1),
+};
+
+static const struct mtk_gate img1_wpe_clks[] = {
+	GATE_IMG(CLK_IMG1_WPE_LARB11, "img1_wpe_larb11", "img_sel", 0),
+	GATE_IMG(CLK_IMG1_WPE_WPE, "img1_wpe_wpe", "img_sel", 1),
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
+
+builtin_platform_driver(clk_mt8195_img_drv);
-- 
2.18.0

