Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F56412B20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhIUCIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhIUBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B04C0363D0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:53:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k24so18864373pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7Kd/fx639sfsLQE+1CpU+ldwaQco2odWCA1BPkcvGw=;
        b=Ud2vEMCB11Hm5xIjp7frwtre74H8/FnkW4cydkGPAikdhbQBRzGPpzxK6mFY7Iv9dx
         89vz5xyLVwFeVrk+rHH21dtigCeYMgzt2HeZlSzv1LL0yGddlrwU9DuWEHap0AwFOp4Y
         v/YlnLqE0cual8hL2n67Y/vA7KrQLsy4s1CkZ8+6V0q/Nqs3hkPfrE6+zj5xKA3doke+
         FltHEs033zpgbCtAbr3KrSTo6sVLxeR63az3iqyta1xeVzYDV3LdoWu7aE5BWLD5qDDK
         e5LQrrDQUNGH4AMekiLqyULcCMkckO9V7m4fsiSKdDQple8vf/KAUId4rcKy3q0q9Vpj
         /4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7Kd/fx639sfsLQE+1CpU+ldwaQco2odWCA1BPkcvGw=;
        b=SFGw5rkzEhIDl87J7QpL/EttKkzBaccTQMm8KJfOvPbKm6mKg9LXbo2BDj4NntQbWM
         B45/sxHhTdz3PgHThEtoDxJ4yGMe3fow4EUr9AOoo6ct+/Pkfj8eN49VW/SpZd9Ng95D
         rW97sKNawKa2FHsQdzIVkCAYYetLsDBjbZBTCpp8TDfO7ugIEOFUP0S3epeXLnhVhb8o
         crnRR003y2gGqxpZ/63ru/RNZKLGn5aCTAPt2ykaNuMiDgUXuEKnCY7Jrlv982PbBmLm
         DjqTIfxNc3R2RSH6BX4w46CLIGT1KbapOAdFakOOe18kmiAK8OYXU2IIbVKWGgy+nSn8
         TPyg==
X-Gm-Message-State: AOAM530oNPMOhGTTtFJUj+tTxjzPMNTZrbujuYdDqTIP7XEvDhVy86lL
        wuJDK5tyTx0s/BeiruQQFTk=
X-Google-Smtp-Source: ABdhPJzkv3lS9kuzqOopAwA30eh7zEZHIyNIFHDRkrHhorbXzYaU6+d9O1ZGtc/7sg3l3ekovZTW3Q==
X-Received: by 2002:a63:7a17:: with SMTP id v23mr15479039pgc.22.1632178411738;
        Mon, 20 Sep 2021 15:53:31 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id y8sm16086983pfe.162.2021.09.20.15.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:53:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/bridge: ti-sn65dsi86: Implement bridge->mode_valid()
Date:   Mon, 20 Sep 2021 15:57:59 -0700
Message-Id: <20210920225801.227211-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920225801.227211-1-robdclark@gmail.com>
References: <20210920225801.227211-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For the brave new world of bridges not creating their own connectors, we
need to implement the max clock limitation via bridge->mode_valid()
instead of connector->mode_valid().

v2: Drop unneeded connector->mode_valid()

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 41d48a393e7f..6154bed0af5b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -615,20 +615,8 @@ static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 	return drm_bridge_get_modes(pdata->next_bridge, connector);
 }
 
-static enum drm_mode_status
-ti_sn_bridge_connector_mode_valid(struct drm_connector *connector,
-				  struct drm_display_mode *mode)
-{
-	/* maximum supported resolution is 4K at 60 fps */
-	if (mode->clock > 594000)
-		return MODE_CLOCK_HIGH;
-
-	return MODE_OK;
-}
-
 static struct drm_connector_helper_funcs ti_sn_bridge_connector_helper_funcs = {
 	.get_modes = ti_sn_bridge_connector_get_modes,
-	.mode_valid = ti_sn_bridge_connector_mode_valid,
 };
 
 static const struct drm_connector_funcs ti_sn_bridge_connector_funcs = {
@@ -766,6 +754,18 @@ static void ti_sn_bridge_detach(struct drm_bridge *bridge)
 	drm_dp_aux_unregister(&bridge_to_ti_sn65dsi86(bridge)->aux);
 }
 
+static enum drm_mode_status
+ti_sn_bridge_mode_valid(struct drm_bridge *bridge,
+			const struct drm_display_info *info,
+			const struct drm_display_mode *mode)
+{
+	/* maximum supported resolution is 4K at 60 fps */
+	if (mode->clock > 594000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static void ti_sn_bridge_disable(struct drm_bridge *bridge)
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
@@ -1127,6 +1127,7 @@ static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
 static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.attach = ti_sn_bridge_attach,
 	.detach = ti_sn_bridge_detach,
+	.mode_valid = ti_sn_bridge_mode_valid,
 	.pre_enable = ti_sn_bridge_pre_enable,
 	.enable = ti_sn_bridge_enable,
 	.disable = ti_sn_bridge_disable,
-- 
2.31.1

