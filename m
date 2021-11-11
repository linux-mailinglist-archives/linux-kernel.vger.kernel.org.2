Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA744D10A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhKKE4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:56:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48784 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232426AbhKKE4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:56:40 -0500
X-UUID: 24b653ddd35d43548cf3baca7a80515e-20211111
X-UUID: 24b653ddd35d43548cf3baca7a80515e-20211111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1306471337; Thu, 11 Nov 2021 12:53:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 11 Nov 2021 12:53:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Nov 2021 12:53:47 +0800
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
Subject: [PATCH v14 3/3] spmi: mediatek: Add support for MT8195
Date:   Thu, 11 Nov 2021 12:53:44 +0800
Message-ID: <20211111045344.11664-4-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211111045344.11664-1-james.lo@mediatek.com>
References: <20211111045344.11664-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spmi support for MT8195.
Refine indent in spmi-mtk-pmif.c.

Signed-off-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-mtk-pmif.c | 202 +++++++++++++++++++++++++----------
 1 file changed, 145 insertions(+), 57 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 3283d0a5903c..ad511f2c3324 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -105,51 +105,99 @@ enum pmif_regs {
 };
 
 static const u32 mt6873_regs[] = {
-	[PMIF_INIT_DONE] =	0x0000,
-	[PMIF_INF_EN] =		0x0024,
-	[PMIF_ARB_EN] =		0x0150,
-	[PMIF_CMDISSUE_EN] =	0x03B4,
-	[PMIF_TIMER_CTRL] =	0x03E0,
-	[PMIF_SPI_MODE_CTRL] =	0x0400,
-	[PMIF_IRQ_EVENT_EN_0] =	0x0418,
-	[PMIF_IRQ_FLAG_0] =	0x0420,
-	[PMIF_IRQ_CLR_0] =	0x0424,
-	[PMIF_IRQ_EVENT_EN_1] =	0x0428,
-	[PMIF_IRQ_FLAG_1] =	0x0430,
-	[PMIF_IRQ_CLR_1] =	0x0434,
-	[PMIF_IRQ_EVENT_EN_2] =	0x0438,
-	[PMIF_IRQ_FLAG_2] =	0x0440,
-	[PMIF_IRQ_CLR_2] =	0x0444,
-	[PMIF_IRQ_EVENT_EN_3] =	0x0448,
-	[PMIF_IRQ_FLAG_3] =	0x0450,
-	[PMIF_IRQ_CLR_3] =	0x0454,
-	[PMIF_IRQ_EVENT_EN_4] =	0x0458,
-	[PMIF_IRQ_FLAG_4] =	0x0460,
-	[PMIF_IRQ_CLR_4] =	0x0464,
-	[PMIF_WDT_EVENT_EN_0] =	0x046C,
-	[PMIF_WDT_FLAG_0] =	0x0470,
-	[PMIF_WDT_EVENT_EN_1] =	0x0474,
-	[PMIF_WDT_FLAG_1] =	0x0478,
-	[PMIF_SWINF_0_ACC] =	0x0C00,
-	[PMIF_SWINF_0_WDATA_31_0] =	0x0C04,
-	[PMIF_SWINF_0_RDATA_31_0] =	0x0C14,
-	[PMIF_SWINF_0_VLD_CLR] =	0x0C24,
-	[PMIF_SWINF_0_STA] =	0x0C28,
-	[PMIF_SWINF_1_ACC] =	0x0C40,
-	[PMIF_SWINF_1_WDATA_31_0] =	0x0C44,
-	[PMIF_SWINF_1_RDATA_31_0] =	0x0C54,
-	[PMIF_SWINF_1_VLD_CLR] =	0x0C64,
-	[PMIF_SWINF_1_STA] =	0x0C68,
-	[PMIF_SWINF_2_ACC] =	0x0C80,
-	[PMIF_SWINF_2_WDATA_31_0] =	0x0C84,
-	[PMIF_SWINF_2_RDATA_31_0] =	0x0C94,
-	[PMIF_SWINF_2_VLD_CLR] =	0x0CA4,
-	[PMIF_SWINF_2_STA] =	0x0CA8,
-	[PMIF_SWINF_3_ACC] =	0x0CC0,
-	[PMIF_SWINF_3_WDATA_31_0] =	0x0CC4,
-	[PMIF_SWINF_3_RDATA_31_0] =	0x0CD4,
-	[PMIF_SWINF_3_VLD_CLR] =	0x0CE4,
-	[PMIF_SWINF_3_STA] =	0x0CE8,
+	[PMIF_INIT_DONE] = 0x0000,
+	[PMIF_INF_EN] = 0x0024,
+	[PMIF_ARB_EN] = 0x0150,
+	[PMIF_CMDISSUE_EN] = 0x03B4,
+	[PMIF_TIMER_CTRL] = 0x03E0,
+	[PMIF_SPI_MODE_CTRL] = 0x0400,
+	[PMIF_IRQ_EVENT_EN_0] = 0x0418,
+	[PMIF_IRQ_FLAG_0] = 0x0420,
+	[PMIF_IRQ_CLR_0] = 0x0424,
+	[PMIF_IRQ_EVENT_EN_1] = 0x0428,
+	[PMIF_IRQ_FLAG_1] = 0x0430,
+	[PMIF_IRQ_CLR_1] = 0x0434,
+	[PMIF_IRQ_EVENT_EN_2] = 0x0438,
+	[PMIF_IRQ_FLAG_2] = 0x0440,
+	[PMIF_IRQ_CLR_2] = 0x0444,
+	[PMIF_IRQ_EVENT_EN_3] = 0x0448,
+	[PMIF_IRQ_FLAG_3] = 0x0450,
+	[PMIF_IRQ_CLR_3] = 0x0454,
+	[PMIF_IRQ_EVENT_EN_4] = 0x0458,
+	[PMIF_IRQ_FLAG_4] = 0x0460,
+	[PMIF_IRQ_CLR_4] = 0x0464,
+	[PMIF_WDT_EVENT_EN_0] = 0x046C,
+	[PMIF_WDT_FLAG_0] = 0x0470,
+	[PMIF_WDT_EVENT_EN_1] = 0x0474,
+	[PMIF_WDT_FLAG_1] = 0x0478,
+	[PMIF_SWINF_0_ACC] = 0x0C00,
+	[PMIF_SWINF_0_WDATA_31_0] = 0x0C04,
+	[PMIF_SWINF_0_RDATA_31_0] = 0x0C14,
+	[PMIF_SWINF_0_VLD_CLR] = 0x0C24,
+	[PMIF_SWINF_0_STA] = 0x0C28,
+	[PMIF_SWINF_1_ACC] = 0x0C40,
+	[PMIF_SWINF_1_WDATA_31_0] = 0x0C44,
+	[PMIF_SWINF_1_RDATA_31_0] = 0x0C54,
+	[PMIF_SWINF_1_VLD_CLR] = 0x0C64,
+	[PMIF_SWINF_1_STA] = 0x0C68,
+	[PMIF_SWINF_2_ACC] = 0x0C80,
+	[PMIF_SWINF_2_WDATA_31_0] = 0x0C84,
+	[PMIF_SWINF_2_RDATA_31_0] = 0x0C94,
+	[PMIF_SWINF_2_VLD_CLR] = 0x0CA4,
+	[PMIF_SWINF_2_STA] = 0x0CA8,
+	[PMIF_SWINF_3_ACC] = 0x0CC0,
+	[PMIF_SWINF_3_WDATA_31_0] = 0x0CC4,
+	[PMIF_SWINF_3_RDATA_31_0] = 0x0CD4,
+	[PMIF_SWINF_3_VLD_CLR] = 0x0CE4,
+	[PMIF_SWINF_3_STA] = 0x0CE8,
+};
+
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
 };
 
 enum spmi_regs {
@@ -165,21 +213,52 @@ enum spmi_regs {
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
-	[SPMI_OP_ST_CTRL] =	0x0000,
-	[SPMI_GRP_ID_EN] =	0x0004,
-	[SPMI_OP_ST_STA] =	0x0008,
-	[SPMI_MST_SAMPL] =	0x000c,
-	[SPMI_MST_REQ_EN] =	0x0010,
-	[SPMI_REC_CTRL] =	0x0040,
-	[SPMI_REC0] =		0x0044,
-	[SPMI_REC1] =		0x0048,
-	[SPMI_REC2] =		0x004c,
-	[SPMI_REC3] =		0x0050,
-	[SPMI_REC4] =		0x0054,
-	[SPMI_MST_DBG] =	0x00fc,
+	[SPMI_OP_ST_CTRL] = 0x0000,
+	[SPMI_GRP_ID_EN] = 0x0004,
+	[SPMI_OP_ST_STA] = 0x0008,
+	[SPMI_MST_SAMPL] = 0x000c,
+	[SPMI_MST_REQ_EN] = 0x0010,
+	[SPMI_REC_CTRL] = 0x0040,
+	[SPMI_REC0] = 0x0044,
+	[SPMI_REC1] = 0x0048,
+	[SPMI_REC2] = 0x004c,
+	[SPMI_REC3] = 0x0050,
+	[SPMI_REC4] = 0x0054,
+	[SPMI_MST_DBG] = 0x00fc,
+};
+
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
 };
 
 static u32 pmif_readl(struct pmif *arb, enum pmif_regs reg)
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

