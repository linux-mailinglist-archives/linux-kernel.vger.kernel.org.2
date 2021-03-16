Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFE33CBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhCPDNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:13:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34622 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232157AbhCPDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:13:22 -0400
X-UUID: f7fccac22b39490bbe57a2c7b72a3244-20210316
X-UUID: f7fccac22b39490bbe57a2c7b72a3244-20210316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 225210083; Tue, 16 Mar 2021 11:13:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 11:13:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 11:13:16 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4,1/2] drm/mediatek: mtk_dpi: Add check for max clock rate in mode_valid
Date:   Tue, 16 Mar 2021 11:12:57 +0800
Message-ID: <1615864378-21754-2-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615864378-21754-1-git-send-email-rex-bc.chen@mediatek.com>
References: <1615864378-21754-1-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per-platform max clock rate check in mtk_dpi_bridge_mode_valid.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index b05f900d9322..e1945d4bd7c4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -120,6 +120,7 @@ struct mtk_dpi_yc_limit {
 struct mtk_dpi_conf {
 	unsigned int (*cal_factor)(int clock);
 	u32 reg_h_fre_con;
+	u32 max_clock_khz;
 	bool edge_sel_en;
 };
 
@@ -557,9 +558,22 @@ static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
 	mtk_dpi_set_display_mode(dpi, &dpi->mode);
 }
 
+static enum drm_mode_status
+mtk_dpi_bridge_mode_valid(struct drm_bridge *bridge,
+			  const struct drm_display_mode *mode)
+{
+	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
+
+	if (dpi->conf->max_clock_khz && mode->clock > dpi->conf->max_clock_khz)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static const struct drm_bridge_funcs mtk_dpi_bridge_funcs = {
 	.attach = mtk_dpi_bridge_attach,
 	.mode_set = mtk_dpi_bridge_mode_set,
+	.mode_valid = mtk_dpi_bridge_mode_valid,
 	.disable = mtk_dpi_bridge_disable,
 	.enable = mtk_dpi_bridge_enable,
 };
@@ -668,17 +682,20 @@ static unsigned int mt8183_calculate_factor(int clock)
 static const struct mtk_dpi_conf mt8173_conf = {
 	.cal_factor = mt8173_calculate_factor,
 	.reg_h_fre_con = 0xe0,
+	.max_clock_khz = 300000,
 };
 
 static const struct mtk_dpi_conf mt2701_conf = {
 	.cal_factor = mt2701_calculate_factor,
 	.reg_h_fre_con = 0xb0,
 	.edge_sel_en = true,
+	.max_clock_khz = 150000,
 };
 
 static const struct mtk_dpi_conf mt8183_conf = {
 	.cal_factor = mt8183_calculate_factor,
 	.reg_h_fre_con = 0xe0,
+	.max_clock_khz = 100000,
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
-- 
2.18.0

