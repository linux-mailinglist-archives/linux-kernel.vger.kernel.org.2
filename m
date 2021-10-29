Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2843FD57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhJ2N3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhJ2N3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:29:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9905C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 06:27:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4CD2C1F45A72
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
Subject: [PATCH 3/3] drm/bridge: parade-ps8640: Perform full poweroff if poweron fails
Date:   Fri, 29 Oct 2021 15:26:50 +0200
Message-Id: <20211029132650.918761-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029132650.918761-1-angelogioacchino.delregno@collabora.com>
References: <20211029132650.918761-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ps8640_bridge_poweron(), in case of a failure not relative
to the regulators enablement, the code was disabling the regulators but
the gpio changes that happened during the poweron sequence were not
being reverted back to a clean poweroff state.

Since it is expected that, when we enter ps8640_bridge_poweron(), the
powerdown and reset GPIOs are both in active state exactly as they were
left in the poweroff function before, we can simply call function
__ps8640_bridge_poweroff() in the failure case, reverting every change
that was done during the power on sequence.

Of course it was chosen to call the poweroff function instead of adding
code to revert the GPIO changes to the poweron one to avoid duplicating
code, as we would be doing exactly what the poweroff function does.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 9334217d02c9..8b54b515828a 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -346,7 +346,7 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 
 	if (ret < 0) {
 		DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", ret);
-		goto err_regulators_disable;
+		goto err_poweroff;
 	}
 
 	msleep(50);
@@ -362,23 +362,22 @@ static int ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 	ret = regmap_update_bits(map, PAGE2_MCS_EN, MCS_EN, 0);
 	if (ret < 0) {
 		DRM_ERROR("failed write PAGE2_MCS_EN: %d\n", ret);
-		goto err_regulators_disable;
+		goto err_poweroff;
 	}
 
 	/* Switch access edp panel's edid through i2c */
 	ret = regmap_write(map, PAGE2_I2C_BYPASS, I2C_BYPASS_EN);
 	if (ret < 0) {
 		DRM_ERROR("failed write PAGE2_I2C_BYPASS: %d\n", ret);
-		goto err_regulators_disable;
+		goto err_poweroff;
 	}
 
 	ps_bridge->powered = true;
 
 	return 0;
 
-err_regulators_disable:
-	regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
-			       ps_bridge->supplies);
+err_poweroff:
+	__ps8640_bridge_poweroff(ps_bridge);
 
 	return ret;
 }
-- 
2.33.0

