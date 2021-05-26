Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8834639130C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhEZIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:54:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40610 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232995AbhEZIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:53:58 -0400
X-UUID: e7ea0d5471834ebbbd8b9e366e7a6781-20210526
X-UUID: e7ea0d5471834ebbbd8b9e366e7a6781-20210526
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 173398681; Wed, 26 May 2021 16:52:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 May 2021 16:52:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 16:52:20 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v5,PATCH 2/3] drm/mediatek: config driver data to support dual edge sample
Date:   Wed, 26 May 2021 16:52:18 +0800
Message-ID: <20210526085219.7582-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210526085219.7582-1-rex-bc.chen@mediatek.com>
References: <20210526085219.7582-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add output_fmts and num_output_fmts value for all configuration.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index f034ebd12fa6..a71f112e9a7a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -123,6 +123,8 @@ struct mtk_dpi_conf {
 	u32 reg_h_fre_con;
 	u32 max_clock_khz;
 	bool edge_sel_en;
+	const u32 *output_fmts;
+	u32 num_output_fmts;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -702,10 +704,21 @@ static unsigned int mt8183_calculate_factor(int clock)
 		return 2;
 }
 
+static const u32 mt8173_output_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_1X24,
+};
+
+static const u32 mt8183_output_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_2X12_LE,
+	MEDIA_BUS_FMT_RGB888_2X12_BE,
+};
+
 static const struct mtk_dpi_conf mt8173_conf = {
 	.cal_factor = mt8173_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 	.max_clock_khz = 300000,
+	.output_fmts = mt8173_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 };
 
 static const struct mtk_dpi_conf mt2701_conf = {
@@ -713,18 +726,24 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.reg_h_fre_con = 0xb0,
 	.edge_sel_en = true,
 	.max_clock_khz = 150000,
+	.output_fmts = mt8173_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 };
 
 static const struct mtk_dpi_conf mt8183_conf = {
 	.cal_factor = mt8183_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 	.max_clock_khz = 100000,
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 };
 
 static const struct mtk_dpi_conf mt8192_conf = {
 	.cal_factor = mt8183_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 	.max_clock_khz = 150000,
+	.output_fmts = mt8173_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
-- 
2.18.0

