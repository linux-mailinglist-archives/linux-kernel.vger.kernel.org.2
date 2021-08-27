Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9C3F9CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhH0Qk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:40:56 -0400
Received: from aposti.net ([89.234.176.197]:60078 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhH0Qkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:40:55 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, list@opendingux.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] drm/bridge: it66121: Initialize {device,vendor}_ids
Date:   Fri, 27 Aug 2021 17:39:55 +0100
Message-Id: <20210827163956.27517-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two arrays are populated with data read from the I2C device
through regmap_read(), and the data is then compared with hardcoded
vendor/product ID values of supported chips.

However, the return value of regmap_read() was never checked. This is
fine, as long as the two arrays are zero-initialized, so that we don't
compare the vendor/product IDs against whatever garbage is left on the
stack.

Address this issue by zero-initializing these two arrays.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 2f2a09adb4bc..b130d01147c6 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -889,7 +889,7 @@ static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
 static int it66121_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	u32 vendor_ids[2], device_ids[2], revision_id;
+	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
 	struct device_node *ep;
 	int ret;
 	struct it66121_ctx *ctx;
-- 
2.33.0

