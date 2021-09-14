Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F240BC26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhINXaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhINXaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:30:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FA8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:28:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k24so806999pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TG0v/NMBTHKCottWQ8zE4nJL5wLp1OcBA8MYjwcUsTI=;
        b=KNKA161asUi9rxrD3VuFSO9UYwtO3CgqRVbbKrQR8HcOm7Tf+NbLo71JIMFvri83x6
         oqjt/TA1UOe9Z5SX/LB26gPBrSx1Bwd8i8gGl3uutXcFHacpAtSP0k7nmglwcGNSqsKy
         TvyJ+3NhYEK77GJntVcEt2+rapN3N8bC+sZNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TG0v/NMBTHKCottWQ8zE4nJL5wLp1OcBA8MYjwcUsTI=;
        b=PC1rXbj2y6RRbH3AQIfPt77Z7f5TfcVNTKs2i2ibSv0drtg7hExkuHjd9X5y4Eq7NX
         AIiIeeNem7vGJJNtgmeyahI6/9h6UcYp1UFU9l3sDIvJgvyA3XPGpIowXBK6U8FXtyHm
         MrCVnboIXd1i9cPrmLMG3ln+SzOqgBYCmV+V+5mIOiYMqmmtlcwXiBJq11WebhrIYgQD
         I20byI3Qzh+B4SM0r7UrDS/JVGdHHuN494NNLstePC+xpTcJ62VfvATr6eBWDMXoGcTi
         oh8gZ+GRQ0SFXEpKfEg2W7MPY3WBLFwg4u/+LmhjncnoSHa1uX1D9f+jQPhInjI29amr
         wYEA==
X-Gm-Message-State: AOAM530m1kdn2uDSIQTVsi8IagoKaZ5+94wRv1AkYwOSstNtQKNLo7O3
        ZF9Wpp6io3Vor8GbqQ9wK84zln8QaAZ9og==
X-Google-Smtp-Source: ABdhPJyXHKTHdRaVtt0luMlddR2sqiPa9p5cTluIuo5Rfd9LbTcw1xqRSsvXPGmg2Rm6TeSREMIrrA==
X-Received: by 2002:a63:3503:: with SMTP id c3mr17293809pga.393.1631662135011;
        Tue, 14 Sep 2021 16:28:55 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:6213:6a82:3731:1220])
        by smtp.gmail.com with ESMTPSA id x64sm11395360pfd.194.2021.09.14.16.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:28:54 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/3] drm/bridge: parade-ps8640: Improve logging at probing
Date:   Tue, 14 Sep 2021 16:28:43 -0700
Message-Id: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() to add logs for error cases at probing time.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/parade-ps8640.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 685e9c38b2db..e340af381e05 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -332,8 +332,10 @@ static int ps8640_probe(struct i2c_client *client)
 		return -ENODEV;
 
 	ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-	if (IS_ERR(ps_bridge->panel_bridge))
-		return PTR_ERR(ps_bridge->panel_bridge);
+	if (IS_ERR(ps_bridge->panel_bridge)) {
+		return dev_err_probe(dev, PTR_ERR(ps_bridge->panel_bridge),
+				     "Error creating bridge device\n");
+	}
 
 	ps_bridge->supplies[0].supply = "vdd33";
 	ps_bridge->supplies[1].supply = "vdd12";
@@ -344,16 +346,20 @@ static int ps8640_probe(struct i2c_client *client)
 
 	ps_bridge->gpio_powerdown = devm_gpiod_get(&client->dev, "powerdown",
 						   GPIOD_OUT_HIGH);
-	if (IS_ERR(ps_bridge->gpio_powerdown))
-		return PTR_ERR(ps_bridge->gpio_powerdown);
+	if (IS_ERR(ps_bridge->gpio_powerdown)) {
+		return dev_err_probe(dev, PTR_ERR(ps_bridge->gpio_powerdown),
+				     "Error getting gpio_powerdown\n");
+	}
 
 	/*
 	 * Assert the reset to avoid the bridge being initialized prematurely
 	 */
 	ps_bridge->gpio_reset = devm_gpiod_get(&client->dev, "reset",
 					       GPIOD_OUT_HIGH);
-	if (IS_ERR(ps_bridge->gpio_reset))
-		return PTR_ERR(ps_bridge->gpio_reset);
+	if (IS_ERR(ps_bridge->gpio_reset)) {
+		return dev_err_probe(dev, PTR_ERR(ps_bridge->gpio_reset),
+				     "Error getting gpio_reset\n");
+	}
 
 	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
 	ps_bridge->bridge.of_node = dev->of_node;
@@ -367,9 +373,9 @@ static int ps8640_probe(struct i2c_client *client)
 							     client->adapter,
 							     client->addr + i);
 		if (IS_ERR(ps_bridge->page[i])) {
-			dev_err(dev, "failed i2c dummy device, address %02x\n",
+			return dev_err_probe(dev, PTR_ERR(ps_bridge->page[i]),
+				"Error initting i2c dummy dev, address %02x\n",
 				client->addr + i);
-			return PTR_ERR(ps_bridge->page[i]);
 		}
 	}
 
-- 
2.33.0.309.g3052b89438-goog

