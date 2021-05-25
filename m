Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E753900A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhEYMQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:16:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47037 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232212AbhEYMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:16:29 -0400
X-UUID: 0ae31d8bb13a42dd8930c96ee8e26486-20210525
X-UUID: 0ae31d8bb13a42dd8930c96ee8e26486-20210525
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1640227964; Tue, 25 May 2021 20:14:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 20:14:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 20:14:55 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4,PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
Date:   Tue, 25 May 2021 20:14:46 +0800
Message-ID: <20210525121448.30075-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210525121448.30075-1-rex-bc.chen@mediatek.com>
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPI can sample on falling, rising or both edge.
When DPI sample the data both rising and falling edge.
It can reduce half data io pins.
Use num_output_fmts to determine whether it is dual edge mode.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bea91c81626e..d3b883c97aaf 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -83,6 +83,7 @@ struct mtk_dpi {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_gpio;
 	struct pinctrl_state *pins_dpi;
+	bool ddr_edge_sel;
 	int refcount;
 };
 
@@ -122,6 +123,8 @@ struct mtk_dpi_conf {
 	u32 reg_h_fre_con;
 	u32 max_clock_khz;
 	bool edge_sel_en;
+	const u32 *output_fmts;
+	u32 num_output_fmts;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -381,6 +384,16 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 	}
 }
 
+static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
+{
+	if (dpi->conf->num_output_fmts > 1) {
+		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
+			     DDR_EN | DDR_4PHASE);
+		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
+			     dpi->ddr_edge_sel ? EDGE_SEL : 0, EDGE_SEL);
+	}
+}
+
 static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 {
 	if (WARN_ON(dpi->refcount == 0))
@@ -455,7 +468,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	pll_rate = clk_get_rate(dpi->tvd_clk);
 
 	vm.pixelclock = pll_rate / factor;
-	clk_set_rate(dpi->pixel_clk, vm.pixelclock);
+	clk_set_rate(dpi->pixel_clk,
+		     vm.pixelclock * ((dpi->conf->num_output_fmts > 1) ? 2 : 1));
 	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
 
 	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
@@ -519,6 +533,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 	mtk_dpi_config_color_format(dpi, dpi->color_format);
 	mtk_dpi_config_2n_h_fre(dpi);
+	mtk_dpi_dual_edge(dpi);
 	mtk_dpi_config_disable_edge(dpi);
 	mtk_dpi_sw_reset(dpi, false);
 
-- 
2.18.0

