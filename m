Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851743DE6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhHCGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:34:51 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36282 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234021AbhHCGem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:34:42 -0400
X-UUID: 8a167679915c47bf8bc750a2148de924-20210803
X-UUID: 8a167679915c47bf8bc750a2148de924-20210803
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2138508699; Tue, 03 Aug 2021 14:34:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 14:34:26 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 14:34:26 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH v10 4/5] spmi: mediatek: Add support for MT8195
Date:   Tue, 3 Aug 2021 14:34:20 +0800
Message-ID: <1627972461-2627-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1627972461-2627-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1627972461-2627-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

Add spmi support for MT8195.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
changes since v9:
- No change.
---
 drivers/spmi/spmi-mtk-pmif.c | 90 ++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 94c45d46ab0c..0c320801c9d5 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -150,6 +150,54 @@ static const u32 mt6873_regs[] = {
 	[PMIF_SWINF_3_STA] =	0x0CE8,
 };
 
+static const u32 mt8195_regs[] = {
+	[PMIF_INIT_DONE] =			0x0000,
+	[PMIF_INF_EN] =				0x0024,
+	[PMIF_ARB_EN] =				0x0150,
+	[PMIF_CMDISSUE_EN] =			0x03B8,
+	[PMIF_TIMER_CTRL] =			0x03E4,
+	[PMIF_SPI_MODE_CTRL] =			0x0408,
+	[PMIF_IRQ_EVENT_EN_0] =			0x0420,
+	[PMIF_IRQ_FLAG_0] =			0x0428,
+	[PMIF_IRQ_CLR_0] =			0x042C,
+	[PMIF_IRQ_EVENT_EN_1] =			0x0430,
+	[PMIF_IRQ_FLAG_1] =			0x0438,
+	[PMIF_IRQ_CLR_1] =			0x043C,
+	[PMIF_IRQ_EVENT_EN_2] =			0x0440,
+	[PMIF_IRQ_FLAG_2] =			0x0448,
+	[PMIF_IRQ_CLR_2] =			0x044C,
+	[PMIF_IRQ_EVENT_EN_3] =			0x0450,
+	[PMIF_IRQ_FLAG_3] =			0x0458,
+	[PMIF_IRQ_CLR_3] =			0x045C,
+	[PMIF_IRQ_EVENT_EN_4] =			0x0460,
+	[PMIF_IRQ_FLAG_4] =			0x0468,
+	[PMIF_IRQ_CLR_4] =			0x046C,
+	[PMIF_WDT_EVENT_EN_0] =			0x0474,
+	[PMIF_WDT_FLAG_0] =			0x0478,
+	[PMIF_WDT_EVENT_EN_1] =			0x047C,
+	[PMIF_WDT_FLAG_1] =			0x0480,
+	[PMIF_SWINF_0_ACC] =			0x0800,
+	[PMIF_SWINF_0_WDATA_31_0] =		0x0804,
+	[PMIF_SWINF_0_RDATA_31_0] =		0x0814,
+	[PMIF_SWINF_0_VLD_CLR] =		0x0824,
+	[PMIF_SWINF_0_STA] =			0x0828,
+	[PMIF_SWINF_1_ACC] =			0x0840,
+	[PMIF_SWINF_1_WDATA_31_0] =		0x0844,
+	[PMIF_SWINF_1_RDATA_31_0] =		0x0854,
+	[PMIF_SWINF_1_VLD_CLR] =		0x0864,
+	[PMIF_SWINF_1_STA] =			0x0868,
+	[PMIF_SWINF_2_ACC] =			0x0880,
+	[PMIF_SWINF_2_WDATA_31_0] =		0x0884,
+	[PMIF_SWINF_2_RDATA_31_0] =		0x0894,
+	[PMIF_SWINF_2_VLD_CLR] =		0x08A4,
+	[PMIF_SWINF_2_STA] =			0x08A8,
+	[PMIF_SWINF_3_ACC] =			0x08C0,
+	[PMIF_SWINF_3_WDATA_31_0] =		0x08C4,
+	[PMIF_SWINF_3_RDATA_31_0] =		0x08D4,
+	[PMIF_SWINF_3_VLD_CLR] =		0x08E4,
+	[PMIF_SWINF_3_STA] =			0x08E8,
+};
+
 enum spmi_regs {
 	SPMI_OP_ST_CTRL,
 	SPMI_GRP_ID_EN,
@@ -163,6 +211,15 @@ enum spmi_regs {
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
@@ -180,6 +237,28 @@ static const u32 mt6873_spmi_regs[] = {
 	[SPMI_MST_DBG] =	0x00fc,
 };
 
+static const u32 mt8195_spmi_regs[] = {
+	[SPMI_OP_ST_CTRL] =	0x0000,
+	[SPMI_GRP_ID_EN] =	0x0004,
+	[SPMI_OP_ST_STA] =	0x0008,
+	[SPMI_MST_SAMPL] =	0x000C,
+	[SPMI_MST_REQ_EN] =	0x0010,
+	[SPMI_MST_RCS_CTRL] =	0x0014,
+	[SPMI_SLV_3_0_EINT] =	0x0020,
+	[SPMI_SLV_7_4_EINT] =	0x0024,
+	[SPMI_SLV_B_8_EINT] =	0x0028,
+	[SPMI_SLV_F_C_EINT] =	0x002C,
+	[SPMI_REC_CTRL] =	0x0040,
+	[SPMI_REC0] =		0x0044,
+	[SPMI_REC1] =		0x0048,
+	[SPMI_REC2] =		0x004C,
+	[SPMI_REC3] =		0x0050,
+	[SPMI_REC4] =		0x0054,
+	[SPMI_REC_CMD_DEC] =	0x005C,
+	[SPMI_DEC_DBG] =	0x00F8,
+	[SPMI_MST_DBG] =	0x00FC,
+};
+
 static u32 pmif_readl(struct pmif *arb, enum pmif_regs reg)
 {
 	return readl(arb->base + arb->data->regs[reg]);
@@ -348,6 +427,14 @@ static const struct pmif_data mt6873_pmif_arb = {
 	.soc_chan = 2,
 };
 
+static const struct pmif_data mt8195_pmif_arb[] = {
+	{
+		.regs = mt8195_regs,
+		.spmimst_regs = mt8195_spmi_regs,
+		.soc_chan = 2,
+	},
+};
+
 static int mtk_spmi_probe(struct platform_device *pdev)
 {
 	struct pmif *arb;
@@ -444,6 +531,9 @@ static const struct of_device_id mtk_spmi_match_table[] = {
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

