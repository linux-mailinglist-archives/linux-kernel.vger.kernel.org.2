Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D15310243
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhBEB35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:29:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37302 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232788AbhBEB3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:29:42 -0500
X-UUID: 3511a71b2cd84f23974afce041f4246d-20210205
X-UUID: 3511a71b2cd84f23974afce041f4246d-20210205
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 376675214; Fri, 05 Feb 2021 09:28:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Feb 2021 09:28:14 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Feb 2021 09:28:14 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>, Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 4/5] soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs
Date:   Fri, 5 Feb 2021 09:28:10 +0800
Message-ID: <1612488491-6149-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1612488491-6149-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1612488491-6149-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E4C02D556F2C3D71E90CCF0AED60B328757AD8C6ACE866E5AB1ADC23312F53782000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6873/8192 are highly integrated SoCs and use PMIC_MT6359 for
power management. This patch adds pwrap master driver to
access PMIC_MT6359.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
changes since v4: no changes
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index a75019fa02dc..e4de75f35c33 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -632,6 +632,17 @@ static int mt6797_regs[] = {
 	[PWRAP_DCM_DBC_PRD] =		0x1D4,
 };
 
+static int mt6873_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3E0,
+	[PWRAP_INT_EN] =		0x448,
+	[PWRAP_WACS2_CMD] =		0xC80,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0xC84,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0xC94,
+	[PWRAP_WACS2_VLDCLR] =		0xCA4,
+	[PWRAP_WACS2_RDATA] =		0xCA8,
+};
+
 static int mt7622_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1050,6 +1061,7 @@ enum pwrap_type {
 	PWRAP_MT6765,
 	PWRAP_MT6779,
 	PWRAP_MT6797,
+	PWRAP_MT6873,
 	PWRAP_MT7622,
 	PWRAP_MT8135,
 	PWRAP_MT8173,
@@ -1511,6 +1523,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT7622:
 		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
 		break;
+	case PWRAP_MT6873:
 	case PWRAP_MT8183:
 		break;
 	}
@@ -1947,6 +1960,19 @@ static const struct pmic_wrapper_type pwrap_mt6797 = {
 	.init_soc_specific = NULL,
 };
 
+static const struct pmic_wrapper_type pwrap_mt6873 = {
+	.regs = mt6873_regs,
+	.type = PWRAP_MT6873,
+	.arb_en_all = 0x777f,
+	.int_en_all = BIT(4) | BIT(5),
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt7622 = {
 	.regs = mt7622_regs,
 	.type = PWRAP_MT7622,
@@ -2024,6 +2050,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6797-pwrap",
 		.data = &pwrap_mt6797,
+	}, {
+		.compatible = "mediatek,mt6873-pwrap",
+		.data = &pwrap_mt6873,
 	}, {
 		.compatible = "mediatek,mt7622-pwrap",
 		.data = &pwrap_mt7622,
-- 
2.18.0

