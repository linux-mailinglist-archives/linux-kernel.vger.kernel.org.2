Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404A35BA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhDLGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:36:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40299 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229461AbhDLGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:36:30 -0400
X-UUID: f8aabd12473d4570825721b582a00111-20210412
X-UUID: f8aabd12473d4570825721b582a00111-20210412
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2108598801; Mon, 12 Apr 2021 14:36:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 14:36:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 14:36:00 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1, 3/3] drm/mediatek: gamma set with cmdq
Date:   Mon, 12 Apr 2021 14:35:47 +0800
Message-ID: <1618209347-10816-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618209347-10816-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1618209347-10816-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BACF569B9F0F25D4D72D96AEB1C6CA56791BB7C7EA94D6DD78DF15CEA1877CBA2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gamma lut set in vsync active will caused display flash issue
set gamma lut with cmdq 

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c     |  4 ++--
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  7 ++++---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 11 ++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 18 +++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  8 +++++---
 5 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index 64b4528..c8e178e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -59,12 +59,12 @@ void mtk_aal_config(struct device *dev, unsigned int w,
 	mtk_ddp_write(cmdq_pkt, w << 16 | h, &aal->cmdq_reg, aal->regs, DISP_AAL_SIZE);
 }
 
-void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state)
+void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state, struct cmdq_pkt *cmdq_pkt)
 {
 	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
 
 	if (aal->data && aal->data->has_gamma)
-		mtk_gamma_set_common(aal->regs, state);
+		mtk_gamma_set_common(aal->regs, &aal->cmdq_reg, state, cmdq_pkt);
 }
 
 void mtk_aal_start(struct device *dev)
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 86c3068..c2e7dcb 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -14,7 +14,7 @@
 void mtk_aal_config(struct device *dev, unsigned int w,
 		    unsigned int h, unsigned int vrefresh,
 		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
-void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state);
+void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state, struct cmdq_pkt *cmdq_pkt);
 void mtk_aal_start(struct device *dev);
 void mtk_aal_stop(struct device *dev);
 
@@ -50,8 +50,9 @@ void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
 void mtk_gamma_config(struct device *dev, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
-void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state);
-void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *state);
+void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state, struct cmdq_pkt *cmdq_pkt);
+void mtk_gamma_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
+			  struct drm_crtc_state *state, struct cmdq_pkt *cmdq_pkt);
 void mtk_gamma_start(struct device *dev);
 void mtk_gamma_stop(struct device *dev);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 3ebf91e..99a4ff3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -55,7 +55,8 @@ void mtk_gamma_clk_disable(struct device *dev)
 	clk_disable_unprepare(gamma->clk);
 }
 
-void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *state)
+void mtk_gamma_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
+			  struct drm_crtc_state *state, struct cmdq_pkt *cmdq_pkt)
 {
 	unsigned int i, reg;
 	struct drm_color_lut *lut;
@@ -65,23 +66,23 @@ void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *state)
 	if (state->gamma_lut) {
 		reg = readl(regs + DISP_GAMMA_CFG);
 		reg = reg | GAMMA_LUT_EN;
-		writel(reg, regs + DISP_GAMMA_CFG);
+		mtk_ddp_write(cmdq_pkt, reg, cmdq_reg, regs, DISP_GAMMA_CFG);
 		lut_base = regs + DISP_GAMMA_LUT;
 		lut = (struct drm_color_lut *)state->gamma_lut->data;
 		for (i = 0; i < MTK_LUT_SIZE; i++) {
 			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
 				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
 				((lut[i].blue >> 6) & LUT_10BIT_MASK);
-			writel(word, (lut_base + i * 4));
+			mtk_ddp_write(cmdq_pkt, word, cmdq_reg, regs, (lut_base + i * 4));
 		}
 	}
 }
 
-void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
+void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state, struct cmdq_pkt *cmdq_pkt)
 {
 	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
 
-	mtk_gamma_set_common(gamma->regs, state);
+	mtk_gamma_set_common(gamma->regs, &gamma->cmdq_reg, state, cmdq_pkt);
 }
 
 void mtk_gamma_config(struct device *dev, unsigned int w,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 8b0de90..73428f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -423,6 +423,15 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 		}
 		mtk_crtc->pending_async_planes = false;
 	}
+
+	if (crtc->state->color_mgmt_changed) {
+		int i;
+
+		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state, cmdq_handle);
+			mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
+		}
+	}
 }
 
 static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
@@ -464,7 +473,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (mtk_crtc->cmdq_client) {
 		mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
-		cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, PAGE_SIZE);
+		cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, 2 * PAGE_SIZE);
 		cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
@@ -616,15 +625,10 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 				      struct drm_atomic_state *state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	int i;
 
 	if (mtk_crtc->event)
 		mtk_crtc->pending_needs_vblank = true;
-	if (crtc->state->color_mgmt_changed)
-		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
-			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
-			mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
-		}
+
 	mtk_drm_crtc_hw_config(mtk_crtc);
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index bb914d9..bffa58d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -60,7 +60,8 @@ struct mtk_ddp_comp_funcs {
 			     struct mtk_plane_state *state,
 			     struct cmdq_pkt *cmdq_pkt);
 	void (*gamma_set)(struct device *dev,
-			  struct drm_crtc_state *state);
+			  struct drm_crtc_state *state,
+			  struct cmdq_pkt *cmdq_pkt);
 	void (*bgclr_in_on)(struct device *dev);
 	void (*bgclr_in_off)(struct device *dev);
 	void (*ctm_set)(struct device *dev,
@@ -160,10 +161,11 @@ static inline void mtk_ddp_comp_layer_config(struct mtk_ddp_comp *comp,
 }
 
 static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
-				     struct drm_crtc_state *state)
+				     struct drm_crtc_state *state,
+				     struct cmdq_pkt *cmdq_pkt)
 {
 	if (comp->funcs && comp->funcs->gamma_set)
-		comp->funcs->gamma_set(comp->dev, state);
+		comp->funcs->gamma_set(comp->dev, state, cmdq_pkt);
 }
 
 static inline void mtk_ddp_comp_bgclr_in_on(struct mtk_ddp_comp *comp)
-- 
1.8.1.1.dirty

