Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059B43FD52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJ2N3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:29:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54428 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ2N3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:29:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A44491F45A6F
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
Subject: [PATCH 2/3] drm/bridge: parade-ps8640: Move real poweroff action to new function
Date:   Fri, 29 Oct 2021 15:26:49 +0200
Message-Id: <20211029132650.918761-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029132650.918761-1-angelogioacchino.delregno@collabora.com>
References: <20211029132650.918761-1-angelogioacchino.delregno@collabora.com>
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
 drivers/gpu/drm/bridge/parade-ps8640.c | 39 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8c5402947b3c..9334217d02c9 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -293,6 +293,28 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 	return 0;
 }
 
+static void __ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
+{
+	int ret;
+
+	gpiod_set_value(ps_bridge->gpio_reset, 1);
+	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
+	if (regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
+				   ps_bridge->supplies)) {
+		DRM_ERROR("cannot disable regulators %d\n", ret);
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
@@ -361,23 +383,6 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
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
2.33.0

