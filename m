Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A53442A80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhKBJjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:39:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:39:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 273471F4458B
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/3] drm/bridge: parade-ps8640: Move real poweroff action to new function
Date:   Tue,  2 Nov 2021 10:36:17 +0100
Message-Id: <20211102093618.114928-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
References: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for varying the poweron error handling in function
ps8640_bridge_poweron(), move function ps8640_bridge_poweroff() up
and also move the actual logic to power off the chip to a new
__ps8640_bridge_poweroff() function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8c5402947b3c..41f5d511d516 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -293,6 +293,26 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 	return 0;
 }
 
+static void __ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
+{
+	gpiod_set_value(ps_bridge->gpio_reset, 1);
+	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
+	if (regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
+				   ps_bridge->supplies)) {
+		DRM_ERROR("cannot disable regulators\n");
+	}
+}
+
+static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
+{
+	if (!ps_bridge->powered)
+		return;
+
+	__ps8640_bridge_poweroff(ps_bridge);
+
+	ps_bridge->powered = false;
+}
+
 static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
@@ -361,23 +381,6 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 	return ret;
 }
 
-static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
-{
-	int ret;
-
-	if (!ps_bridge->powered)
-		return;
-
-	gpiod_set_value(ps_bridge->gpio_reset, 1);
-	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
-	ret = regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
-				     ps_bridge->supplies);
-	if (ret < 0)
-		DRM_ERROR("cannot disable regulators %d\n", ret);
-
-	ps_bridge->powered = false;
-}
-
 static void ps8640_pre_enable(struct drm_bridge *bridge)
 {
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
-- 
2.33.1

