Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FB040A349
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhINCSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:18:43 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33808 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237717AbhINCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:27 -0400
X-UUID: 7c8553ffeaef40de83c531b43945ed99-20210914
X-UUID: 7c8553ffeaef40de83c531b43945ed99-20210914
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 546386904; Tue, 14 Sep 2021 10:17:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:17:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:17:06 +0800
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
Subject: [v3 08/24] clk: mediatek: Add MT8195 peripheral clock support
Date:   Tue, 14 Sep 2021 10:16:17 +0800
Message-ID: <20210914021633.26377-9-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 peripheral clock controller which provides clock
gate control for ethernet/flashif/pcie/ssusb.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile             |  3 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c | 62 +++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-peri_ao.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index a142342a0cea..0dbf4ddf4a09 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
 obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
-obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
+				   clk-mt8195-peri_ao.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
new file mode 100644
index 000000000000..907a92b22de8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+static const struct mtk_gate_regs peri_ao_cg_regs = {
+	.set_ofs = 0x10,
+	.clr_ofs = 0x14,
+	.sta_ofs = 0x18,
+};
+
+#define GATE_PERI_AO(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &peri_ao_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate peri_ao_clks[] = {
+	GATE_PERI_AO(CLK_PERI_AO_ETHERNET, "peri_ao_ethernet", "top_axi", 0),
+	GATE_PERI_AO(CLK_PERI_AO_ETHERNET_BUS, "peri_ao_ethernet_bus", "top_axi", 1),
+	GATE_PERI_AO(CLK_PERI_AO_FLASHIF_BUS, "peri_ao_flashif_bus", "top_axi", 3),
+	GATE_PERI_AO(CLK_PERI_AO_FLASHIF_FLASH, "peri_ao_flashif_flash", "top_spinor", 5),
+	GATE_PERI_AO(CLK_PERI_AO_SSUSB_1P_BUS, "peri_ao_ssusb_1p_bus", "top_usb_top_1p", 7),
+	GATE_PERI_AO(CLK_PERI_AO_SSUSB_1P_XHCI, "peri_ao_ssusb_1p_xhci", "top_ssusb_xhci_1p", 8),
+	GATE_PERI_AO(CLK_PERI_AO_SSUSB_2P_BUS, "peri_ao_ssusb_2p_bus", "top_usb_top_2p", 9),
+	GATE_PERI_AO(CLK_PERI_AO_SSUSB_2P_XHCI, "peri_ao_ssusb_2p_xhci", "top_ssusb_xhci_2p", 10),
+	GATE_PERI_AO(CLK_PERI_AO_SSUSB_3P_BUS, "peri_ao_ssusb_3p_bus", "top_usb_top_3p", 11),
+	GATE_PERI_AO(CLK_PERI_AO_SSUSB_3P_XHCI, "peri_ao_ssusb_3p_xhci", "top_ssusb_xhci_3p", 12),
+	GATE_PERI_AO(CLK_PERI_AO_SPINFI, "peri_ao_spinfi", "top_spinfi_bclk", 15),
+	GATE_PERI_AO(CLK_PERI_AO_ETHERNET_MAC, "peri_ao_ethernet_mac", "top_snps_eth_250m", 16),
+	GATE_PERI_AO(CLK_PERI_AO_NFI_H, "peri_ao_nfi_h", "top_axi", 19),
+	GATE_PERI_AO(CLK_PERI_AO_FNFI1X, "peri_ao_fnfi1x", "top_nfi1x", 20),
+	GATE_PERI_AO(CLK_PERI_AO_PCIE_P0_MEM, "peri_ao_pcie_p0_mem", "mem_466m", 24),
+	GATE_PERI_AO(CLK_PERI_AO_PCIE_P1_MEM, "peri_ao_pcie_p1_mem", "mem_466m", 25),
+};
+
+static const struct mtk_clk_desc peri_ao_desc = {
+	.clks = peri_ao_clks,
+	.num_clks = ARRAY_SIZE(peri_ao_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_peri_ao[] = {
+	{
+		.compatible = "mediatek,mt8195-pericfg_ao",
+		.data = &peri_ao_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_peri_ao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-peri_ao",
+		.of_match_table = of_match_clk_mt8195_peri_ao,
+	},
+};
+builtin_platform_driver(clk_mt8195_peri_ao_drv);
-- 
2.18.0

