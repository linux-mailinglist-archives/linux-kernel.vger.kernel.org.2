Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0D44BA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 03:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhKJC0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 21:26:01 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229813AbhKJC0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 21:26:01 -0500
X-UUID: f930fba295a4459290908b2c2467d657-20211110
X-UUID: f930fba295a4459290908b2c2467d657-20211110
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1609416930; Wed, 10 Nov 2021 10:23:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 10 Nov 2021 10:23:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 10 Nov 2021 10:23:07 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v1] clk: mediatek: use en_mask as a pure div_en_mask
Date:   Wed, 10 Nov 2021 10:22:58 +0800
Message-ID: <20211110022258.2358-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer allow en_mask to be a combination of
pll_en_bit and div_en_mask, so remove pll_en_bit(bit0)
from en_mask to make en_mask a pure en_mask that only
used for pll dividers.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
This patch is based on v5.15-rc7 and [1].

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=546235
---
 drivers/clk/mediatek/clk-mt2701.c |  8 ++++----
 drivers/clk/mediatek/clk-mt2712.c | 30 +++++++++++++++---------------
 drivers/clk/mediatek/clk-mt6765.c | 20 ++++++++++----------
 drivers/clk/mediatek/clk-mt6779.c | 24 ++++++++++++------------
 drivers/clk/mediatek/clk-mt6797.c | 20 ++++++++++----------
 drivers/clk/mediatek/clk-mt7622.c | 18 +++++++++---------
 drivers/clk/mediatek/clk-mt7629.c | 12 ++++++------
 drivers/clk/mediatek/clk-mt8135.c | 20 ++++++++++----------
 drivers/clk/mediatek/clk-mt8167.c | 16 ++++++++--------
 drivers/clk/mediatek/clk-mt8173.c | 28 ++++++++++++++--------------
 drivers/clk/mediatek/clk-mt8183.c | 22 +++++++++++-----------
 drivers/clk/mediatek/clk-mt8516.c | 12 ++++++------
 drivers/clk/mediatek/clk-pll.c    | 12 ++++--------
 13 files changed, 119 insertions(+), 123 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 695be0f77427..d4061dca5328 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -934,13 +934,13 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	}
 
 static const struct mtk_pll_data apmixed_plls[] = {
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x200, 0x20c, 0x80000001,
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x200, 0x20c, 0x80000000,
 			PLL_AO, 21, 0x204, 24, 0x0, 0x204, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x210, 0x21c, 0xf0000001,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x210, 0x21c, 0xf0000000,
 		  HAVE_RST_BAR, 21, 0x210, 4, 0x0, 0x214, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x220, 0x22c, 0xf3000001,
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x220, 0x22c, 0xf3000000,
 		  HAVE_RST_BAR, 7, 0x220, 4, 0x0, 0x224, 14),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x230, 0x23c, 0x00000001, 0,
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x230, 0x23c, 0, 0,
 				21, 0x230, 4, 0x0, 0x234, 0),
 	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x240, 0x24c, 0x00000001, 0,
 				21, 0x240, 4, 0x0, 0x244, 0),
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a3bd9a107209..fd81162a2dd4 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1222,38 +1222,38 @@ static const struct mtk_pll_div_table mmpll_div_table[] = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000101,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000100,
 		HAVE_RST_BAR, 31, 0x0230, 4, 0, 0, 0, 0x0234, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000101,
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000100,
 		HAVE_RST_BAR, 31, 0x0240, 4, 0, 0, 0, 0x0244, 0),
-	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000101,
+	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000100,
 		0, 31, 0x0320, 4, 0, 0, 0, 0x0324, 0),
-	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000101,
+	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000100,
 		0, 31, 0x0280, 4, 0, 0, 0, 0x0284, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000101,
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000100,
 		0, 31, 0x0330, 4, 0x0338, 0x0014, 0, 0x0334, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000101,
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000100,
 		0, 31, 0x0350, 4, 0x0358, 0x0014, 1, 0x0354, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000101,
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000100,
 		0, 31, 0x0370, 4, 0, 0, 0, 0x0374, 0),
-	PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000101,
+	PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000100,
 		0, 31, 0x0390, 4, 0, 0, 0, 0x0394, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000101,
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000100,
 		0, 31, 0x0270, 4, 0, 0, 0, 0x0274, 0),
-	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000101,
+	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000100,
 		0, 31, 0x0410, 4, 0, 0, 0, 0x0414, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000101,
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000100,
 		0, 31, 0x0290, 4, 0, 0, 0, 0x0294, 0),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000101,
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000100,
 		0, 31, 0x0250, 4, 0, 0, 0, 0x0254, 0,
 		mmpll_div_table),
-	PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000101,
+	PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000100,
 		HAVE_RST_BAR, 31, 0x0100, 4, 0, 0, 0, 0x0104, 0,
 		armca35pll_div_table),
-	PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000101,
+	PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000100,
 		0, 31, 0x0210, 4, 0, 0, 0, 0x0214, 0,
 		armca72pll_div_table),
-	PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000101,
+	PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000100,
 		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index d77ea5aff292..ab2ff8fb1775 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -747,26 +747,26 @@ static const struct mtk_gate apmixed_clks[] = {
 			_pcw_reg, _pcw_shift, NULL)	\
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x021C, 0x0228, BIT(0),
+	PLL(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x021C, 0x0228, 0,
 	    PLL_AO, 22, 8, 0x0220, 24, 0, 0, 0, 0x0220, 0),
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x020C, 0x0218, BIT(0),
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x020C, 0x0218, 0,
 	    PLL_AO, 22, 8, 0x0210, 24, 0, 0, 0, 0x0210, 0),
-	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x022C, 0x0238, BIT(0),
+	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x022C, 0x0238, 0,
 	    PLL_AO, 22, 8, 0x0230, 24, 0, 0, 0, 0x0230, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x023C, 0x0248, BIT(0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x023C, 0x0248, 0,
 	    (HAVE_RST_BAR | PLL_AO), 22, 8, 0x0240, 24, 0, 0, 0, 0x0240,
 	    0),
-	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x024C, 0x0258, BIT(0),
+	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x024C, 0x0258, 0,
 	    0, 22, 8, 0x0250, 24, 0, 0, 0, 0x0250, 0),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x025C, 0x0268, BIT(0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x025C, 0x0268, 0,
 	    0, 22, 8, 0x0260, 24, 0, 0, 0, 0x0260, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x026C, 0x0278, BIT(0),
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x026C, 0x0278, 0,
 	    HAVE_RST_BAR, 22, 8, 0x0270, 24, 0, 0, 0, 0x0270, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x027C, 0x0288, BIT(0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x027C, 0x0288, 0,
 	    0, 22, 8, 0x0280, 24, 0, 0, 0, 0x0280, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x028C, 0x029C, BIT(0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x028C, 0x029C, 0,
 	    0, 32, 8, 0x0290, 24, 0x0040, 0x000C, 0, 0x0294, 0),
-	PLL(CLK_APMIXED_MPLL, "mpll", 0x02A0, 0x02AC, BIT(0),
+	PLL(CLK_APMIXED_MPLL, "mpll", 0x02A0, 0x02AC, 0,
 	    PLL_AO, 22, 8, 0x02A4, 24, 0, 0, 0, 0x02A4, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 6e0d3a166729..89e1bd4f0019 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1180,33 +1180,33 @@ static const struct mtk_gate apmixed_clks[] = {
 			_pcw_chg_reg, NULL)
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, BIT(0),
+	PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0,
 	    PLL_AO, 0, 22, 8, 0x0204, 24, 0, 0, 0, 0x0204, 0, 0),
-	PLL(CLK_APMIXED_ARMPLL_BL, "armpll_bl", 0x0210, 0x021C, BIT(0),
+	PLL(CLK_APMIXED_ARMPLL_BL, "armpll_bl", 0x0210, 0x021C, 0,
 	    PLL_AO, 0, 22, 8, 0x0214, 24, 0, 0, 0, 0x0214, 0, 0),
-	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x02A0, 0x02AC, BIT(0),
+	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x02A0, 0x02AC, 0,
 	    PLL_AO, 0, 22, 8, 0x02A4, 24, 0, 0, 0, 0x02A4, 0, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, BIT(0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0,
 	    (HAVE_RST_BAR), BIT(24), 22, 8, 0x0234, 24, 0, 0, 0,
 	    0x0234, 0, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0240, 0x024C, BIT(0),
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0240, 0x024C, 0,
 	    (HAVE_RST_BAR), BIT(24), 22, 8, 0x0244, 24,
 	    0, 0, 0, 0x0244, 0, 0),
-	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0250, 0x025C, BIT(0),
+	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0250, 0x025C, 0,
 	    0, 0, 22, 8, 0x0254, 24, 0, 0, 0, 0x0254, 0, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0260, 0x026C, BIT(0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0260, 0x026C, 0,
 	    0, 0, 22, 8, 0x0264, 24, 0, 0, 0, 0x0264, 0, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, BIT(0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, 0,
 	    0, 0, 22, 8, 0x0274, 24, 0, 0, 0, 0x0274, 0, 0),
-	PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x02b0, 0x02bC, BIT(0),
+	PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x02b0, 0x02bC, 0,
 	    (HAVE_RST_BAR), BIT(23), 22, 8, 0x02b4, 24,
 	    0, 0, 0, 0x02b4, 0, 0),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0280, 0x028C, BIT(0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0280, 0x028C, 0,
 	    (HAVE_RST_BAR), BIT(23), 22, 8, 0x0284, 24,
 	    0, 0, 0, 0x0284, 0, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x02C0, 0x02D0, BIT(0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x02C0, 0x02D0, 0,
 	    0, 0, 32, 8, 0x02C0, 1, 0, 0x14, 0, 0x02C4, 0, 0x2C0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x02D4, 0x02E4, BIT(0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x02D4, 0x02E4, 0,
 	    0, 0, 32, 8, 0x02D4, 1, 0, 0x14, 1, 0x02D8, 0, 0x02D4),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 428eb24ffec5..32f46e7c1b00 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -634,25 +634,25 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 			NULL)
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0xF0000101, PLL_AO,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0xF0000100, PLL_AO,
 	    21, 0x220, 4, 0x0, 0x224, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0230, 0x023C, 0xFE000011, 0, 7,
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0230, 0x023C, 0xFE000010, 0, 7,
 	    0x230, 4, 0x0, 0x234, 14),
-	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000101, 0, 21,
+	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000100, 0, 21,
 	    0x244, 24, 0x0, 0x244, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000121, 0, 21,
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000120, 0, 21,
 	    0x250, 4, 0x0, 0x254, 0),
-	PLL(CLK_APMIXED_IMGPLL, "imgpll", 0x0260, 0x026C, 0x00000121, 0, 21,
+	PLL(CLK_APMIXED_IMGPLL, "imgpll", 0x0260, 0x026C, 0x00000120, 0, 21,
 	    0x260, 4, 0x0, 0x264, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, 0xC0000121, 0, 21,
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, 0xC0000120, 0, 21,
 	    0x270, 4, 0x0, 0x274, 0),
-	PLL(CLK_APMIXED_CODECPLL, "codecpll", 0x0290, 0x029C, 0x00000121, 0, 21,
+	PLL(CLK_APMIXED_CODECPLL, "codecpll", 0x0290, 0x029C, 0x00000120, 0, 21,
 	    0x290, 4, 0x0, 0x294, 0),
-	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x02E4, 0x02F0, 0x00000121, 0, 21,
+	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x02E4, 0x02F0, 0x00000120, 0, 21,
 	    0x2E4, 4, 0x0, 0x2E8, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000131, 0, 31,
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000130, 0, 31,
 	    0x2A0, 4, 0x2A8, 0x2A4, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x02B4, 0x02C4, 0x00000131, 0, 31,
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x02B4, 0x02C4, 0x00000130, 0, 31,
 	    0x2B4, 4, 0x2BC, 0x2B8, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index ef5947e15c75..2fdb27ab51d5 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -328,23 +328,23 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001,
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0,
 	    PLL_AO, 21, 0x0204, 24, 0, 0x0204, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0x00000001,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0,
 	    HAVE_RST_BAR, 21, 0x0214, 24, 0, 0x0214, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0x00000001,
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0,
 	    HAVE_RST_BAR, 7, 0x0224, 24, 0, 0x0224, 14),
-	PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0x00000001,
+	PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0,
 	    0, 21, 0x0300, 1, 0, 0x0304, 0),
-	PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0x00000001,
+	PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0,
 	    0, 21, 0x0314, 1, 0, 0x0318, 0),
-	PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x0324, 0x0330, 0x00000001,
+	PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x0324, 0x0330, 0,
 	    0, 31, 0x0324, 1, 0, 0x0328, 0),
-	PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x0334, 0x0340, 0x00000001,
+	PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x0334, 0x0340, 0,
 	    0, 31, 0x0334, 1, 0, 0x0338, 0),
-	PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x0344, 0x0354, 0x00000001,
+	PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x0344, 0x0354, 0,
 	    0, 21, 0x0344, 1, 0, 0x0348, 0),
-	PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0x00000001,
+	PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0,
 	    0, 21, 0x0358, 1, 0, 0x035C, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index a0ee079670c7..b97e0eb49b8d 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -335,17 +335,17 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001,
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0,
 	    0, 21, 0x0204, 24, 0, 0x0204, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0x00000001,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0,
 	    HAVE_RST_BAR, 21, 0x0214, 24, 0, 0x0214, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0x00000001,
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0,
 	    HAVE_RST_BAR, 7, 0x0224, 24, 0, 0x0224, 14),
-	PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0x00000001,
+	PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0,
 	    0, 21, 0x0300, 1, 0, 0x0304, 0),
-	PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0x00000001,
+	PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0,
 	    0, 21, 0x0314, 1, 0, 0x0318, 0),
-	PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0x00000001,
+	PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0,
 	    0, 21, 0x0358, 1, 0, 0x035C, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 9b4b645aea99..a1d462f7c7ba 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -611,16 +611,16 @@ CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 	}
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
-	PLL(CLK_APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000001, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000001, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000001, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000001, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000001, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000001, 0, 31, 0x294, 6, 0x0, 0x298, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2b0, 0x2c8,	0x80000001, 0, 21, 0x2b0, 6, 0x0, 0x2b4, 0),
-	PLL(CLK_APMIXED_AUDPLL, "audpll", 0x2e8, 0x300, 0x80000001, 0, 31, 0x2e8, 6, 0x2f8, 0x2ec, 0),
-	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c,	0x80000001, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
+	PLL(CLK_APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000000, 0, 21, 0x204, 24, 0x0, 0x204, 0),
+	PLL(CLK_APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000000, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000000, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000000, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000000, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000000, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000000, 0, 31, 0x294, 6, 0x0, 0x298, 0),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2b0, 0x2c8, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x2b4, 0),
+	PLL(CLK_APMIXED_AUDPLL, "audpll", 0x2e8, 0x300, 0x80000000, 0, 31, 0x2e8, 6, 0x2f8, 0x2ec, 0),
+	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
 };
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index e5ea10e31799..180e24a4ca1e 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -1016,21 +1016,21 @@ static const struct mtk_pll_div_table mmpll_div_table[] = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0100, 0x0110, 0x00000001, 0,
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0100, 0x0110, 0, 0,
 		21, 0x0104, 24, 0, 0x0104, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0120, 0x0130, 0x00000001,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0120, 0x0130, 0,
 		HAVE_RST_BAR, 21, 0x0124, 24, 0, 0x0124, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0140, 0x0150, 0x30000001,
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0140, 0x0150, 0x30000000,
 		HAVE_RST_BAR, 7, 0x0144, 24, 0, 0x0144, 0),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0160, 0x0170, 0x00000001, 0,
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0160, 0x0170, 0, 0,
 		21, 0x0164, 24, 0, 0x0164, 0, mmpll_div_table),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x0180, 0x0190, 0x00000001, 0,
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x0180, 0x0190, 0, 0,
 		31, 0x0180, 1, 0x0194, 0x0184, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x01A0, 0x01B0, 0x00000001, 0,
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x01A0, 0x01B0, 0, 0,
 		31, 0x01A0, 1, 0x01B4, 0x01A4, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x01C0, 0x01D0, 0x00000001, 0,
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x01C0, 0x01D0, 0, 0,
 		21, 0x01C4, 24, 0, 0x01C4, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x01E0, 0x01F0, 0x00000001, 0,
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x01E0, 0x01F0, 0, 0,
 		21, 0x01E4, 24, 0, 0x01E4, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 8f898ac476c0..f309e7810951 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -972,20 +972,20 @@ static const struct mtk_pll_div_table mmpll_div_table[] = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0x00000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
-	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0x00000001, 0, 21, 0x214, 24, 0x0, 0x214, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000101, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000001, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0x00000001, 0, 21, 0x250, 4, 0x0, 0x254, 0),
-	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0x00000001, 0, 21, 0x260, 4, 0x0, 0x264, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0x00000001, 0, 21, 0x270, 4, 0x0, 0x274, 0),
-	PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0x00000001, 0, 21, 0x280, 4, 0x0, 0x284, 0),
-	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0x00000001, 0, 21, 0x290, 4, 0x0, 0x294, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0x00000001, 0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0x00000001, 0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0x00000001, 0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
-	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0x00000001, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
+	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0, 0, 21, 0x204, 24, 0x0, 0x204, 0),
+	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0, 0, 21, 0x214, 24, 0x0, 0x214, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000100, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000000, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0, 0, 21, 0x250, 4, 0x0, 0x254, 0),
+	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0, 0, 21, 0x260, 4, 0x0, 0x264, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0, 0, 21, 0x270, 4, 0x0, 0x274, 0),
+	PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0, 0, 21, 0x280, 4, 0x0, 0x284, 0),
+	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0, 0, 21, 0x290, 4, 0x0, 0x294, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0, 0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0, 0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0, 0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
+	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
 };
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5046852eb0fd..608108cfa14a 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1121,34 +1121,34 @@ static const struct mtk_pll_div_table mfgpll_div_table[] = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0x00000001,
+	PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0,
 		HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0204, 24, 0x0, 0x0, 0,
 		0x0204, 0, 0, armpll_div_table),
-	PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0x00000001,
+	PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0,
 		HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0214, 24, 0x0, 0x0, 0,
 		0x0214, 0, 0, armpll_div_table),
-	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0x00000001,
+	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0,
 		HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0294, 24, 0x0, 0x0, 0,
 		0x0294, 0, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0x00000001,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0,
 		HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24, 0x0, 0x0, 0,
 		0x0224, 0, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0x00000001,
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0,
 		HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24, 0x0, 0x0, 0,
 		0x0234, 0, 0),
-	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000001,
+	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0,
 		0, 0, 22, 8, 0x0244, 24, 0x0, 0x0, 0, 0x0244, 0, 0,
 		mfgpll_div_table),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000001,
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0,
 		0, 0, 22, 8, 0x0254, 24, 0x0, 0x0, 0, 0x0254, 0, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0x00000001,
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0,
 		0, 0, 22, 8, 0x0264, 24, 0x0, 0x0, 0, 0x0264, 0, 0),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0x00000001,
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0,
 		HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24, 0x0, 0x0, 0,
 		0x0274, 0, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000001,
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0,
 		0, 0, 32, 8, 0x02A0, 1, 0x02A8, 0x0014, 0, 0x02A4, 0, 0x02A0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0x00000001,
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0,
 		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 9d4261ecc760..ec215e5d7acb 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -770,17 +770,17 @@ static const struct mtk_pll_div_table mmpll_div_table[] = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0100, 0x0110, 0x00000001, 0,
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0100, 0x0110, 0, 0,
 		21, 0x0104, 24, 0, 0x0104, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0120, 0x0130, 0x00000001,
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0120, 0x0130, 0,
 		HAVE_RST_BAR, 21, 0x0124, 24, 0, 0x0124, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0140, 0x0150, 0x30000001,
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0140, 0x0150, 0x30000000,
 		HAVE_RST_BAR, 7, 0x0144, 24, 0, 0x0144, 0),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0160, 0x0170, 0x00000001, 0,
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0160, 0x0170, 0, 0,
 		21, 0x0164, 24, 0, 0x0164, 0, mmpll_div_table),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x0180, 0x0190, 0x00000001, 0,
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x0180, 0x0190, 0, 0,
 		31, 0x0180, 1, 0x0194, 0x0184, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x01A0, 0x01B0, 0x00000001, 0,
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x01A0, 0x01B0, 0, 0,
 		31, 0x01A0, 1, 0x01B4, 0x01A4, 0),
 };
 
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 99ada6e06697..df0eee0bab77 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -239,7 +239,6 @@ static int mtk_pll_prepare(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 r;
-	u32 div_en_mask;
 
 	r = readl(pll->pwr_addr) | CON0_PWR_ON;
 	writel(r, pll->pwr_addr);
@@ -252,9 +251,8 @@ static int mtk_pll_prepare(struct clk_hw *hw)
 	r = readl(pll->en_addr) | BIT(pll->data->pll_en_bit);
 	writel(r, pll->en_addr);
 
-	div_en_mask = pll->data->en_mask & ~CON0_BASE_EN;
-	if (div_en_mask) {
-		r = readl(pll->base_addr + REG_CON0) | div_en_mask;
+	if (pll->data->en_mask) {
+		r = readl(pll->base_addr + REG_CON0) | pll->data->en_mask;
 		writel(r, pll->base_addr + REG_CON0);
 	}
 
@@ -275,7 +273,6 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 r;
-	u32 div_en_mask;
 
 	if (pll->data->flags & HAVE_RST_BAR) {
 		r = readl(pll->base_addr + REG_CON0);
@@ -285,9 +282,8 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
 
 	__mtk_pll_tuner_disable(pll);
 
-	div_en_mask = pll->data->en_mask & ~CON0_BASE_EN;
-	if (div_en_mask) {
-		r = readl(pll->base_addr + REG_CON0) & ~div_en_mask;
+	if (pll->data->en_mask) {
+		r = readl(pll->base_addr + REG_CON0) & ~pll->data->en_mask;
 		writel(r, pll->base_addr + REG_CON0);
 	}
 
-- 
2.18.0

