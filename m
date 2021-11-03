Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C3443C27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 05:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKCEYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 00:24:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34298 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230059AbhKCEYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 00:24:07 -0400
X-UUID: cb9d0a0e1d574e2198d3f0d473b6d596-20211103
X-UUID: cb9d0a0e1d574e2198d3f0d473b6d596-20211103
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 607324921; Wed, 03 Nov 2021 12:21:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 3 Nov 2021 12:21:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Nov 2021 12:21:27 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [v13 4/4] spmi: mediatek: Add support for MT8195
Date:   Wed, 3 Nov 2021 12:21:03 +0800
Message-ID: <20211103042103.4984-5-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211103042103.4984-1-james.lo@mediatek.com>
References: <20211103042103.4984-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spmi support for MT8195.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-mtk-pmif.c | 88 ++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 3283d0a5903c..c5946494087f 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -152,6 +152,54 @@ static const u32 mt6873_regs[] = {
 	[PMIF_SWINF_3_STA] =	0x0CE8,
 };
 
+static const u32 mt8195_regs[] = {
+	[PMIF_INIT_DONE] = 0x0000,
+	[PMIF_INF_EN] = 0x0024,
+	[PMIF_ARB_EN] = 0x0150,
+	[PMIF_CMDISSUE_EN] = 0x03B8,
+	[PMIF_TIMER_CTRL] = 0x03E4,
+	[PMIF_SPI_MODE_CTRL] = 0x0408,
+	[PMIF_IRQ_EVENT_EN_0] = 0x0420,
+	[PMIF_IRQ_FLAG_0] = 0x0428,
+	[PMIF_IRQ_CLR_0] = 0x042C,
+	[PMIF_IRQ_EVENT_EN_1] = 0x0430,
+	[PMIF_IRQ_FLAG_1] = 0x0438,
+	[PMIF_IRQ_CLR_1] = 0x043C,
+	[PMIF_IRQ_EVENT_EN_2] = 0x0440,
+	[PMIF_IRQ_FLAG_2] = 0x0448,
+	[PMIF_IRQ_CLR_2] = 0x044C,
+	[PMIF_IRQ_EVENT_EN_3] = 0x0450,
+	[PMIF_IRQ_FLAG_3] = 0x0458,
+	[PMIF_IRQ_CLR_3] = 0x045C,
+	[PMIF_IRQ_EVENT_EN_4] = 0x0460,
+	[PMIF_IRQ_FLAG_4] = 0x0468,
+	[PMIF_IRQ_CLR_4] = 0x046C,
+	[PMIF_WDT_EVENT_EN_0] = 0x0474,
+	[PMIF_WDT_FLAG_0] = 0x0478,
+	[PMIF_WDT_EVENT_EN_1] = 0x047C,
+	[PMIF_WDT_FLAG_1] = 0x0480,
+	[PMIF_SWINF_0_ACC] = 0x0800,
+	[PMIF_SWINF_0_WDATA_31_0] = 0x0804,
+	[PMIF_SWINF_0_RDATA_31_0] = 0x0814,
+	[PMIF_SWINF_0_VLD_CLR] = 0x0824,
+	[PMIF_SWINF_0_STA] = 0x0828,
+	[PMIF_SWINF_1_ACC] = 0x0840,
+	[PMIF_SWINF_1_WDATA_31_0] = 0x0844,
+	[PMIF_SWINF_1_RDATA_31_0] = 0x0854,
+	[PMIF_SWINF_1_VLD_CLR] = 0x0864,
+	[PMIF_SWINF_1_STA] = 0x0868,
+	[PMIF_SWINF_2_ACC] = 0x0880,
+	[PMIF_SWINF_2_WDATA_31_0] = 0x0884,
+	[PMIF_SWINF_2_RDATA_31_0] = 0x0894,
+	[PMIF_SWINF_2_VLD_CLR] = 0x08A4,
+	[PMIF_SWINF_2_STA] = 0x08A8,
+	[PMIF_SWINF_3_ACC] = 0x08C0,
+	[PMIF_SWINF_3_WDATA_31_0] = 0x08C4,
+	[PMIF_SWINF_3_RDATA_31_0] = 0x08D4,
+	[PMIF_SWINF_3_VLD_CLR] = 0x08E4,
+	[PMIF_SWINF_3_STA] = 0x08E8,
+};
+
 enum spmi_regs {
 	SPMI_OP_ST_CTRL,
 	SPMI_GRP_ID_EN,
@@ -165,6 +213,15 @@ enum spmi_regs {
 	SPMI_REC3,
 	SPMI_REC4,
 	SPMI_MST_DBG,
+
+	/* MT8195 spmi regs */
+	SPMI_MST_RCS_CTRL,
+	SPMI_SLV_3_0_EINT,
+	SPMI_SLV_7_4_EINT,
+	SPMI_SLV_B_8_EINT,
+	SPMI_SLV_F_C_EINT,
+	SPMI_REC_CMD_DEC,
+	SPMI_DEC_DBG,
 };
 
 static const u32 mt6873_spmi_regs[] = {
@@ -182,6 +239,28 @@ static const u32 mt6873_spmi_regs[] = {
 	[SPMI_MST_DBG] =	0x00fc,
 };
 
+static const u32 mt8195_spmi_regs[] = {
+	[SPMI_OP_ST_CTRL] = 0x0000,
+	[SPMI_GRP_ID_EN] = 0x0004,
+	[SPMI_OP_ST_STA] = 0x0008,
+	[SPMI_MST_SAMPL] = 0x000C,
+	[SPMI_MST_REQ_EN] = 0x0010,
+	[SPMI_MST_RCS_CTRL] = 0x0014,
+	[SPMI_SLV_3_0_EINT] = 0x0020,
+	[SPMI_SLV_7_4_EINT] = 0x0024,
+	[SPMI_SLV_B_8_EINT] = 0x0028,
+	[SPMI_SLV_F_C_EINT] = 0x002C,
+	[SPMI_REC_CTRL] = 0x0040,
+	[SPMI_REC0] = 0x0044,
+	[SPMI_REC1] = 0x0048,
+	[SPMI_REC2] = 0x004C,
+	[SPMI_REC3] = 0x0050,
+	[SPMI_REC4] = 0x0054,
+	[SPMI_REC_CMD_DEC] = 0x005C,
+	[SPMI_DEC_DBG] = 0x00F8,
+	[SPMI_MST_DBG] = 0x00FC,
+};
+
 static u32 pmif_readl(struct pmif *arb, enum pmif_regs reg)
 {
 	return readl(arb->base + arb->data->regs[reg]);
@@ -345,6 +424,12 @@ static const struct pmif_data mt6873_pmif_arb = {
 	.soc_chan = 2,
 };
 
+static const struct pmif_data mt8195_pmif_arb = {
+	.regs = mt8195_regs,
+	.spmimst_regs = mt8195_spmi_regs,
+	.soc_chan = 2,
+};
+
 static int mtk_spmi_probe(struct platform_device *pdev)
 {
 	struct pmif *arb;
@@ -433,6 +518,9 @@ static const struct of_device_id mtk_spmi_match_table[] = {
 	{
 		.compatible = "mediatek,mt6873-spmi",
 		.data = &mt6873_pmif_arb,
+	}, {
+		.compatible = "mediatek,mt8195-spmi",
+		.data = &mt8195_pmif_arb,
 	}, {
 		/* sentinel */
 	},
-- 
2.18.0

