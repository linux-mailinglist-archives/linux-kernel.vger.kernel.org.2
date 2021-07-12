Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F83C627B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhGLSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:15:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55378 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:15:10 -0400
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:e464:19d5:3655:dde7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 784C11F422BE;
        Mon, 12 Jul 2021 19:12:17 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, enric.balletbo@collabora.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH] drm/mediatek: Test component initialization earlier in the function mtk_drm_crtc_create
Date:   Mon, 12 Jul 2021 20:12:09 +0200
Message-Id: <20210712181209.27023-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization is currently tested in a later stage in
the function for no reason.
In addition, the test '!comp' will never fail since comp is
set with the '&' operator. Instead, test if a comp was not
initialized by testing "!comp->dev".

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 474efb844249..06f40e589922 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -755,14 +755,22 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	for (i = 0; i < path_len; i++) {
 		enum mtk_ddp_comp_id comp_id = path[i];
 		struct device_node *node;
+		struct mtk_ddp_comp *comp;
 
 		node = priv->comp_node[comp_id];
+		comp = &priv->ddp_comp[comp_id];
+
 		if (!node) {
 			dev_info(dev,
 				 "Not creating crtc %d because component %d is disabled or missing\n",
 				 pipe, comp_id);
 			return 0;
 		}
+
+		if (!comp->dev) {
+			dev_err(dev, "Component %pOF not initialized\n", node);
+			return -ENODEV;
+		}
 	}
 
 	mtk_crtc = devm_kzalloc(dev, sizeof(*mtk_crtc), GFP_KERNEL);
@@ -787,16 +795,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		enum mtk_ddp_comp_id comp_id = path[i];
 		struct mtk_ddp_comp *comp;
-		struct device_node *node;
 
-		node = priv->comp_node[comp_id];
 		comp = &priv->ddp_comp[comp_id];
-		if (!comp) {
-			dev_err(dev, "Component %pOF not initialized\n", node);
-			ret = -ENODEV;
-			return ret;
-		}
-
 		mtk_crtc->ddp_comp[i] = comp;
 
 		if (comp->funcs) {
-- 
2.17.1

