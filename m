Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78363F2AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbhHTLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:18:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43600 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239997AbhHTLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:18:08 -0400
X-UUID: 6653ba7bfca44d48a965a11ccc6025a6-20210820
X-UUID: 6653ba7bfca44d48a965a11ccc6025a6-20210820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 865972504; Fri, 20 Aug 2021 19:17:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 19:17:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Aug 2021 19:17:26 +0800
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
Subject: [v2 13/24] clk: mediatek: Add MT8195 ipesys clock support
Date:   Fri, 20 Aug 2021 19:14:53 +0800
Message-ID: <20210820111504.350-14-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210820111504.350-1-chun-jie.chen@mediatek.com>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 ipesys clock controller which provides clock gate
control for ipe IP block.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile         |  2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c | 51 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ipe.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index f9736e6640ce..84d315a6b3e4 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -81,6 +81,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-mt8195-cam.o \
-					clk-mt8195-ccu.o clk-mt8195-img.o
+					clk-mt8195-ccu.o clk-mt8195-img.o clk-mt8195-ipe.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
new file mode 100644
index 000000000000..fc176e844973
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -0,0 +1,51 @@
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
+static const struct mtk_gate_regs ipe_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IPE(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &ipe_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate ipe_clks[] = {
+	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "top_ipe", 0),
+	GATE_IPE(CLK_IPE_FDVT, "ipe_fdvt", "top_ipe", 1),
+	GATE_IPE(CLK_IPE_ME, "ipe_me", "top_ipe", 2),
+	GATE_IPE(CLK_IPE_TOP, "ipe_top", "top_ipe", 3),
+	GATE_IPE(CLK_IPE_SMI_LARB12, "ipe_smi_larb12", "top_ipe", 4),
+};
+
+static const struct mtk_clk_desc ipe_desc = {
+	.clks = ipe_clks,
+	.num_clks = ARRAY_SIZE(ipe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8195_ipe[] = {
+	{
+		.compatible = "mediatek,mt8195-ipesys",
+		.data = &ipe_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8195_ipe_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8195-ipe",
+		.of_match_table = of_match_clk_mt8195_ipe,
+	},
+};
+builtin_platform_driver(clk_mt8195_ipe_drv);
-- 
2.18.0

