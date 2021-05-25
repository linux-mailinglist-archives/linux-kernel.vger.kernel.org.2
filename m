Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99C3900A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhEYMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:16:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37899 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232344AbhEYMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:16:34 -0400
X-UUID: 5d7315ec5ab24e7ea665154e5dd84d40-20210525
X-UUID: 5d7315ec5ab24e7ea665154e5dd84d40-20210525
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 695154224; Tue, 25 May 2021 20:14:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 20:14:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 20:14:57 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4,PATCH 3/3] drm/mediatek: dpi: add bus format negotiation
Date:   Tue, 25 May 2021 20:14:48 +0800
Message-ID: <20210525121448.30075-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210525121448.30075-1-rex-bc.chen@mediatek.com>
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negotiate
the possible output and input formats for the current mode and monitor,
and use the negotiated formats in a basic atomic_check callback.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 78 ++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index d6a422986efc..667a97470389 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -540,6 +540,73 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	return 0;
 }
 
+static u32 *mtk_dpi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					unsigned int *num_output_fmts)
+{
+	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
+
+	*num_output_fmts = 0;
+
+	if (!dpi->conf->output_fmts)
+		return NULL;
+
+	*num_output_fmts = dpi->conf->num_output_fmts;
+
+	return (u32 *)dpi->conf->output_fmts;
+}
+
+#define MAX_INPUT_SEL_FORMATS	1
+
+static u32 *mtk_dpi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					u32 output_fmt,
+					unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	*num_input_fmts = 1;
+	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+
+	return input_fmts;
+}
+
+static int mtk_dpi_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct mtk_dpi *dpi = bridge->driver_private;
+	unsigned int out_bus_format;
+
+	out_bus_format = bridge_state->output_bus_cfg.format;
+
+	dev_dbg(dpi->dev, "input format 0x%04x, output format 0x%04x\n",
+		bridge_state->input_bus_cfg.format,
+		bridge_state->output_bus_cfg.format);
+
+	dpi->ddr_edge_sel = (out_bus_format == MEDIA_BUS_FMT_RGB888_2X12_LE) ?
+			   true : false;
+
+	dpi->bit_num = MTK_DPI_OUT_BIT_NUM_8BITS;
+	dpi->channel_swap = MTK_DPI_OUT_CHANNEL_SWAP_RGB;
+	dpi->yc_map = MTK_DPI_OUT_YC_MAP_RGB;
+	dpi->color_format = MTK_DPI_COLOR_FORMAT_RGB;
+
+	return 0;
+}
+
 static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
 				 enum drm_bridge_attach_flags flags)
 {
@@ -592,6 +659,12 @@ static const struct drm_bridge_funcs mtk_dpi_bridge_funcs = {
 	.mode_valid = mtk_dpi_bridge_mode_valid,
 	.disable = mtk_dpi_bridge_disable,
 	.enable = mtk_dpi_bridge_enable,
+	.atomic_check = mtk_dpi_bridge_atomic_check,
+	.atomic_get_output_bus_fmts = mtk_dpi_bridge_atomic_get_output_bus_fmts,
+	.atomic_get_input_bus_fmts = mtk_dpi_bridge_atomic_get_input_bus_fmts,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
 };
 
 void mtk_dpi_start(struct device *dev)
@@ -638,11 +711,6 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 	}
 	drm_connector_attach_encoder(dpi->connector, &dpi->encoder);
 
-	dpi->bit_num = MTK_DPI_OUT_BIT_NUM_8BITS;
-	dpi->channel_swap = MTK_DPI_OUT_CHANNEL_SWAP_RGB;
-	dpi->yc_map = MTK_DPI_OUT_YC_MAP_RGB;
-	dpi->color_format = MTK_DPI_COLOR_FORMAT_RGB;
-
 	return 0;
 
 err_cleanup:
-- 
2.18.0

