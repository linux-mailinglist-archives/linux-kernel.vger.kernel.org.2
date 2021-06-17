Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876483AB263
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhFQLXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhFQLXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:23:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE29C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:21:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f10so630215plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6R0FEjF7oq2KNX8VeWTVUIbsW8u4UsYJd42ph9pC1A=;
        b=PcR1UbEaott76KwONcj2/b42uiSTpdpLzTRqYZ7Zis8SWGf7xyLwEn0GtL2ne1L+18
         wCfph9vmWzbdYnI6FcinYpwauKitP4wABDd1thfzdQ8MFeDrug5xwuCK70rswtCJV4kl
         DyuefhJG2uPvwl1t4tvgJJGOKBtsJ+NrjRPZ4oJn9/cEn8FHu2qmwqFwz9zjvKa8lX/i
         fcWd+mi4caT1DaltYD+vwJ7KtPfhHlDN3yGdgeXN9SwaHQAfYoJIdBj48lxEyzsWaN4Q
         W2A4uQo129ywnOx83HHPm7MFgLVrEPH3aSxiqUTThVhU3bwUVa7jhWMKMDxKgPdko1Iq
         NREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6R0FEjF7oq2KNX8VeWTVUIbsW8u4UsYJd42ph9pC1A=;
        b=StixFN5v8UEpr7RSpy7/25LEeSfdNwGmOkkZBGVMHKkbUBxNshvJjvvcNwAWMBSRBp
         T6/UX3cR41EH0KnfubUwT6lpZedx3xQ77rEdaNiP9xntkpTbfODrgyGGrY0g46RRE57s
         w6KDq9Bar/dFRyTvdZtnFuD/t1bQAR+FkjpjZFzjHsYFdGLyOkKyQSW3EujhGuveN8A/
         yEfTv1sW621j0DrllzAOAvucAKAGxYk/YHCQm/JqVmzua298k5Ag4HdLOXRnaRNjarDd
         rqRvp0+uuCvlWkakP1XV9UGx9KaYSx3vEcZ0PZNOGrZQvXGSHVR2fpO3ii9TaPAbmzAH
         X5IQ==
X-Gm-Message-State: AOAM531Cz6NuhUox6ArhH78SLU/ZRj34liUoPQZ8Y77CBwp7MSgkKEvn
        GokjVOyGHONMmB/x/H2dYjE=
X-Google-Smtp-Source: ABdhPJysJyKGyvAca3XdWxeEe9FRr9MA/N49yAGeiH7inBCWjDFaoXYUfLRacqfnq1+IFe3kS5rdsg==
X-Received: by 2002:a17:902:c407:b029:106:302e:534 with SMTP id k7-20020a170902c407b0290106302e0534mr4068908plk.17.1623928884766;
        Thu, 17 Jun 2021 04:21:24 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id v67sm5035585pfb.193.2021.06.17.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:21:24 -0700 (PDT)
From:   Jonathan Liu <net147@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Liu <net147@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH] drm/bridge: ti-sn65dsi83: Fix null pointer dereference in remove callback
Date:   Thu, 17 Jun 2021 21:19:25 +1000
Message-Id: <20210617111925.162120-1-net147@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If attach has not been called, unloading the driver can result in a null
pointer dereference in mipi_dsi_detach as ctx->dsi has not been assigned
yet.

Fixes: ceb515ba29ba6b ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 750f2172ef08..8e9f45c5c7c1 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -671,8 +671,11 @@ static int sn65dsi83_remove(struct i2c_client *client)
 {
 	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
 
-	mipi_dsi_detach(ctx->dsi);
-	mipi_dsi_device_unregister(ctx->dsi);
+	if (ctx->dsi) {
+		mipi_dsi_detach(ctx->dsi);
+		mipi_dsi_device_unregister(ctx->dsi);
+	}
+
 	drm_bridge_remove(&ctx->bridge);
 	of_node_put(ctx->host_node);
 
-- 
2.32.0

