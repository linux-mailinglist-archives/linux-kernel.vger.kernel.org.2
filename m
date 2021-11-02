Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E491442A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:39:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58422 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:39:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 836B11F4458A
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
Subject: [PATCH v2 1/3] drm/bridge: parade-ps8640: Don't try to enable VDO if poweron fails
Date:   Tue,  2 Nov 2021 10:36:16 +0100
Message-Id: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bridge cannot get powered on, there's no reason to try to
communicate with it: change the ps8640_bridge_poweron function to
return an error value to the caller, so that we can avoid calling
ps8640_bridge_vdo_control() in ps8640_pre_enable() if the poweron
sequence fails.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 4b36e4dc78f1..8c5402947b3c 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -293,19 +293,19 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 	return 0;
 }
 
-static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
+static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
 	int ret, status;
 
 	if (ps_bridge->powered)
-		return;
+		return 0;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
 				    ps_bridge->supplies);
 	if (ret < 0) {
 		DRM_ERROR("cannot enable regulators %d\n", ret);
-		return;
+		return ret;
 	}
 
 	gpiod_set_value(ps_bridge->gpio_powerdown, 0);
@@ -352,11 +352,13 @@ static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 
 	ps_bridge->powered = true;
 
-	return;
+	return 0;
 
 err_regulators_disable:
 	regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
 			       ps_bridge->supplies);
+
+	return ret;
 }
 
 static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
@@ -381,7 +383,9 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
 	int ret;
 
-	ps8640_bridge_poweron(ps_bridge);
+	ret = ps8640_bridge_poweron(ps_bridge);
+	if (ret)
+		return;
 
 	ret = ps8640_bridge_vdo_control(ps_bridge, ENABLE);
 	if (ret < 0)
-- 
2.33.1

