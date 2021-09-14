Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0A40A345
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhINCSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:18:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50888 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237186AbhINCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:23 -0400
X-UUID: 5d420342b9264579a1f5f4a16e56d67c-20210914
X-UUID: 5d420342b9264579a1f5f4a16e56d67c-20210914
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 14497189; Tue, 14 Sep 2021 10:17:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:01 +0800
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
Subject: [v3 06/24] clk: mediatek: Add MT8195 apmixedsys clock support
Date:   Tue, 14 Sep 2021 10:16:15 +0800
Message-ID: <20210914021633.26377-7-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 apmixedsys clock controller which provides Plls
generated from SoC 26m and ssusb clock gate control.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig                 |   8 +
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 145 +++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apmixedsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 439b7c8d0d07..4654ec336fc1 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -575,6 +575,14 @@ config COMMON_CLK_MT8192_VENCSYS
 	help
 	  This driver supports MediaTek MT8192 vencsys clocks.
 
+config COMMON_CLK_MT8195
+        bool "Clock driver for MediaTek MT8195"
+        depends on ARM64 || COMPILE_TEST
+        select COMMON_CLK_MEDIATEK
+        default ARCH_MEDIATEK
+        help
+          This driver supports MediaTek MT8195 clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 15bc045f0b71..d4157cfca865 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -80,5 +80,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
 obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
+obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
new file mode 100644
index 000000000000..6156ceeed71e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8195-clk.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs apmixed_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate apmixed_clks[] = {
+	GATE_APMIXED(CLK_APMIXED_PLL_SSUSB26M, "pll_ssusb26m", "clk26m", 1),
+};
+
+#define MT8195_PLL_FMAX		(3800UL * MHZ)
+#define MT8195_PLL_FMIN		(1500UL * MHZ)
+#define MT8195_INTEGER_BITS	8
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
+	    _rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,		\
+	    _tuner_reg, _tuner_en_reg, _tuner_en_bit,			\
+	    _pcw_reg, _pcw_shift, _pcw_chg_reg,				\
+	    _en_reg, _pll_en_bit) {					\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT8195_PLL_FMAX,				\
+		.fmin = MT8195_PLL_FMIN,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = MT8195_INTEGER_BITS,			\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcw_chg_reg = _pcw_chg_reg,				\
+		.en_reg = _en_reg,					\
+		.pll_en_bit = _pll_en_bit,				\
+	}
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_NNAPLL, "nnapll", 0x0390, 0x03a0, 0,
+	    0, 0, 22, 0x0398, 24, 0, 0, 0, 0x0398, 0, 0x0398, 0, 9),
+	PLL(CLK_APMIXED_RESPLL, "respll", 0x0190, 0x0320, 0,
+	    0, 0, 22, 0x0198, 24, 0, 0, 0, 0x0198, 0, 0x0198, 0, 9),
+	PLL(CLK_APMIXED_ETHPLL, "ethpll", 0x0360, 0x0370, 0,
+	    0, 0, 22, 0x0368, 24, 0, 0, 0, 0x0368, 0, 0x0368, 0, 9),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0710, 0x0720, 0,
+	    0, 0, 22, 0x0718, 24, 0, 0, 0, 0x0718, 0, 0x0718, 0, 9),
+	PLL(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x00a0, 0x00b0, 0,
+	    0, 0, 22, 0x00a8, 24, 0, 0, 0, 0x00a8, 0, 0x00a8, 0, 9),
+	PLL(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x00c0, 0x00d0, 0,
+	    0, 0, 22, 0x00c8, 24, 0, 0, 0, 0x00c8, 0, 0x00c8, 0, 9),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x00e0, 0x00f0, 0xff000000,
+	    HAVE_RST_BAR, BIT(23), 22, 0x00e8, 24, 0, 0, 0, 0x00e8, 0, 0x00e8, 0, 9),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x01d0, 0x01e0, 0xff000000,
+	    HAVE_RST_BAR, BIT(23), 22, 0x01d8, 24, 0, 0, 0, 0x01d8, 0, 0x01d8, 0, 9),
+	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x0890, 0x08a0, 0,
+	    0, 0, 22, 0x0898, 24, 0, 0, 0, 0x0898, 0, 0x0898, 0, 9),
+	PLL(CLK_APMIXED_IMGPLL, "imgpll", 0x0100, 0x0110, 0,
+	    0, 0, 22, 0x0108, 24, 0, 0, 0, 0x0108, 0, 0x0108, 0, 9),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x01f0, 0x0700, 0xff000000,
+	    HAVE_RST_BAR, BIT(23), 22, 0x01f8, 24, 0, 0, 0, 0x01f8, 0, 0x01f8, 0, 9),
+	PLL(CLK_APMIXED_HDMIPLL1, "hdmipll1", 0x08c0, 0x08d0, 0,
+	    0, 0, 22, 0x08c8, 24, 0, 0, 0, 0x08c8, 0, 0x08c8, 0, 9),
+	PLL(CLK_APMIXED_HDMIPLL2, "hdmipll2", 0x0870, 0x0880, 0,
+	    0, 0, 22, 0x0878, 24, 0, 0, 0, 0x0878, 0, 0x0878, 0, 9),
+	PLL(CLK_APMIXED_HDMIRX_APLL, "hdmirx_apll", 0x08e0, 0x0dd4, 0,
+	    0, 0, 32, 0x08e8, 24, 0, 0, 0, 0x08ec, 0, 0x08e8, 0, 9),
+	PLL(CLK_APMIXED_USB1PLL, "usb1pll", 0x01a0, 0x01b0, 0,
+	    0, 0, 22, 0x01a8, 24, 0, 0, 0, 0x01a8, 0, 0x01a8, 0, 9),
+	PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x07e0, 0x07f0, 0,
+	    0, 0, 22, 0x07e8, 24, 0, 0, 0, 0x07e8, 0, 0x07e8, 0, 9),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x07c0, 0x0dc0, 0,
+	    0, 0, 32, 0x07c8, 24, 0x0470, 0x0000, 12, 0x07cc, 0, 0x07c8, 0, 9),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0780, 0x0dc4, 0,
+	    0, 0, 32, 0x0788, 24, 0x0474, 0x0000, 13, 0x078c, 0, 0x0788, 0, 9),
+	PLL(CLK_APMIXED_APLL3, "apll3", 0x0760, 0x0dc8, 0,
+	    0, 0, 32, 0x0768, 24, 0x0478, 0x0000, 14, 0x076c, 0, 0x0768, 0, 9),
+	PLL(CLK_APMIXED_APLL4, "apll4", 0x0740, 0x0dcc, 0,
+	    0, 0, 32, 0x0748, 24, 0x047C, 0x0000, 15, 0x074c, 0, 0x0748, 0, 9),
+	PLL(CLK_APMIXED_APLL5, "apll5", 0x07a0, 0x0dd0, 0x100000,
+	    0, 0, 32, 0x07a8, 24, 0x0480, 0x0000, 16, 0x07ac, 0, 0x07a8, 0, 9),
+	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0340, 0x0350, 0,
+	    0, 0, 22, 0x0348, 24, 0, 0, 0, 0x0348, 0, 0x0348, 0, 9),
+	PLL(CLK_APMIXED_DGIPLL, "dgipll", 0x0150, 0x0160, 0,
+	    0, 0, 22, 0x0158, 24, 0, 0, 0, 0x0158, 0, 0x0158, 0, 9),
+};
+
+static const struct of_device_id of_match_clk_mt8195_apmixed[] = {
+	{ .compatible = "mediatek,mt8195-apmixedsys", },
+	{}
+};
+
+static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	return r;
+
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt8195_apmixed_drv = {
+	.probe = clk_mt8195_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8195-apmixed",
+		.of_match_table = of_match_clk_mt8195_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt8195_apmixed_drv);
-- 
2.18.0

