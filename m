Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58EF34D41B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhC2Phb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:37:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51358 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhC2Pgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:36:55 -0400
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:85ba:22ea:8b43:4375])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D4AD81F45548;
        Mon, 29 Mar 2021 16:36:53 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, enric.balletbo@collabora.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 3/3] drm/mediatek: in struct mtk_hdmi, replace conn field with curr_conn ptr
Date:   Mon, 29 Mar 2021 17:36:32 +0200
Message-Id: <20210329153632.17559-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329153632.17559-1-dafna.hirschfeld@collabora.com>
References: <20210329153632.17559-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_hdmi does not support creating a bridge with a connector.
Therefore the field 'conn' should be removed from the mtk_hdmi struct.
It is replaced with a pointer curr_conn that points to the current
connector which can be access through the global state.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 1eeb211b1536..0d95d2cfe3de 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -153,7 +153,7 @@ struct mtk_hdmi_conf {
 struct mtk_hdmi {
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
-	struct drm_connector conn;
+	struct drm_connector *curr_conn;/* current connector (only valid when 'enabled') */
 	struct device *dev;
 	const struct mtk_hdmi_conf *conf;
 	struct phy *phy;
@@ -969,7 +969,7 @@ static int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi,
 	ssize_t err;
 
 	err = drm_hdmi_avi_infoframe_from_display_mode(&frame,
-						       &hdmi->conn, mode);
+						       hdmi->curr_conn, mode);
 	if (err < 0) {
 		dev_err(hdmi->dev,
 			"Failed to get AVI infoframe from mode: %zd\n", err);
@@ -1049,7 +1049,7 @@ static int mtk_hdmi_setup_vendor_specific_infoframe(struct mtk_hdmi *hdmi,
 	ssize_t err;
 
 	err = drm_hdmi_vendor_infoframe_from_display_mode(&frame,
-							  &hdmi->conn, mode);
+							  hdmi->curr_conn, mode);
 	if (err) {
 		dev_err(hdmi->dev,
 			"Failed to get vendor infoframe from mode: %zd\n", err);
@@ -1322,6 +1322,8 @@ static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 	clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_HDMI_PIXEL]);
 	clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_HDMI_PLL]);
 
+	hdmi->curr_conn = NULL;
+
 	hdmi->enabled = false;
 }
 
@@ -1385,8 +1387,13 @@ static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi,
 static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 					  struct drm_bridge_state *old_state)
 {
+	struct drm_atomic_state *state = old_state->base.state;
 	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
 
+	/* Retrieve the connector through the atomic state. */
+	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state,
+								   bridge->encoder);
+
 	mtk_hdmi_output_set_display_mode(hdmi, &hdmi->mode);
 	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PLL]);
 	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PIXEL]);
@@ -1625,8 +1632,10 @@ static int mtk_hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
-	memcpy(buf, hdmi->conn.eld, min(sizeof(hdmi->conn.eld), len));
-
+	if (hdmi->enabled)
+		memcpy(buf, hdmi->curr_conn->eld, min(sizeof(hdmi->curr_conn->eld), len));
+	else
+		memset(buf, 0, len);
 	return 0;
 }
 
-- 
2.17.1

