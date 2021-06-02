Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19C3987F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFBLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:22:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50940 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230284AbhFBLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:40 -0400
X-UUID: ca0cf66e97724f15b1e742ecd48246dd-20210602
X-UUID: ca0cf66e97724f15b1e742ecd48246dd-20210602
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 945426686; Wed, 02 Jun 2021 19:20:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 19:20:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 19:20:53 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH 2/2] soc: mediatek: pwrap: add pwrap driver for MT8195 SoC
Date:   Wed, 2 Jun 2021 19:20:50 +0800
Message-ID: <20210602112050.12338-3-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210602112050.12338-1-james.lo@mediatek.com>
References: <20210602112050.12338-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

MT8195 are highly integrated SoC and use PMIC_MT6359 for
power management. This patch adds pwrap master driver to
access PMIC_MT6359.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index e4de75f35c33..952bc554f443 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -961,6 +961,23 @@ static int mt8183_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =			0xC28,
 };
 
+static int mt8195_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_STAUPD_CTRL] =		0x4C,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x420,
+	[PWRAP_INT_FLG] =		0x428,
+	[PWRAP_INT_CLR] =		0x42C,
+	[PWRAP_INT1_EN] =		0x450,
+	[PWRAP_INT1_FLG] =		0x458,
+	[PWRAP_INT1_CLR] =		0x45C,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
+};
+
 static int mt8516_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1066,6 +1083,7 @@ enum pwrap_type {
 	PWRAP_MT8135,
 	PWRAP_MT8173,
 	PWRAP_MT8183,
+	PWRAP_MT8195,
 	PWRAP_MT8516,
 };
 
@@ -1525,6 +1543,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 		break;
 	case PWRAP_MT6873:
 	case PWRAP_MT8183:
+	case PWRAP_MT8195:
 		break;
 	}
 
@@ -2025,6 +2044,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
 	.init_soc_specific = pwrap_mt8183_init_soc_specific,
 };
 
+static struct pmic_wrapper_type pwrap_mt8195 = {
+	.regs = mt8195_regs,
+	.type = PWRAP_MT8195,
+	.arb_en_all = 0x777f, /* NEED CONFIRM */
+	.int_en_all = 0x180000, /* NEED CONFIRM */
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static struct pmic_wrapper_type pwrap_mt8516 = {
 	.regs = mt8516_regs,
 	.type = PWRAP_MT8516,
@@ -2065,6 +2097,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt8183-pwrap",
 		.data = &pwrap_mt8183,
+	}, {
+		.compatible = "mediatek,mt8195-pwrap",
+		.data = &pwrap_mt8195,
 	}, {
 		.compatible = "mediatek,mt8516-pwrap",
 		.data = &pwrap_mt8516,
-- 
2.18.0

