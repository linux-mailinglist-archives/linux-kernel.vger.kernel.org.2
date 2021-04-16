Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D4362B66
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhDPWlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhDPWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F471C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w8so15798226pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcJHDcYMV/GNRvkYvCP6Y5GlcN4y2gUoiu2dtS69kIs=;
        b=ZsInv2JReTrfjCgB8cC2jbctayfltBqBr0jOg/kNzrP6rbjJRuDO2ZT50ZjSe7P511
         6Eiktjk1IJ+Z76JPjdunMQ7+1SGN9m+uWcMd0FXecfowEx7VHM5M9vo76px1rEqZTcAA
         UF90B3xobn+6xQeKqzuNgiZBP9MVJxrOytsJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcJHDcYMV/GNRvkYvCP6Y5GlcN4y2gUoiu2dtS69kIs=;
        b=CUmwGI1J5a8MHv+1PpGzWMpo0Az8H1xRVZzQXx6jrYnxWOWy27bLJqJkTpKA75R9xi
         U4g7EywpAzN64AMJm3AH6cVv5ZJetU/HE+zGcNmnjUSDxENsdWHbCV9TjI3QOdvF8XMZ
         P24twIYcsleXi1jv2fBJmGxLi5m7B2lCFX5j35pSkqU0HNz614gb2YA4meb8e5/NliW5
         K8+w41ldeUMQFR2lIK70zxKwmlwVgCObbGGztHirBbc4S3RKnWAVZ9DKsAAvxGe0YfO0
         qQSr7KLPaS7q/xFoy4KKhHbRYESF+QHdmd/55Bdej7PI2Bj7//CfSPqUAGmcOfQsLITR
         ShMw==
X-Gm-Message-State: AOAM532onYHAB1NyUBfh7iOGsX8wpVKlEjj3hNYpBz87SC17ss9rojfD
        4WrZnmTpn62OCrGVis7MbUquug==
X-Google-Smtp-Source: ABdhPJxsoX7eKSMm+cKUoiLIrtgFQTzsLXBKF76NDygdyZY1gzqdrBnHowzCGvB55KXccagYFL6tdQ==
X-Received: by 2002:aa7:8608:0:b029:258:838a:23bb with SMTP id p8-20020aa786080000b0290258838a23bbmr7797618pfn.37.1618612858730;
        Fri, 16 Apr 2021 15:40:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:40:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/27] drm/bridge: ti-sn65dsi86: Move drm_panel_unprepare() to post_disable()
Date:   Fri, 16 Apr 2021 15:39:28 -0700
Message-Id: <20210416153909.v4.5.Ia75c9ffe2a2582393a8532d244da86f18b4c9b21@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prepared the panel in pre_enable() so we should unprepare it in
post_disable() to match.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v4:
- Reword commit mesage slightly.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index c006678c9921..e30460002c48 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -452,8 +452,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
 	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
 	/* disable DP PLL */
 	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
-
-	drm_panel_unprepare(pdata->panel);
 }
 
 static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn_bridge *pdata)
@@ -869,6 +867,8 @@ static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
 {
 	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
 
+	drm_panel_unprepare(pdata->panel);
+
 	clk_disable_unprepare(pdata->refclk);
 
 	pm_runtime_put_sync(pdata->dev);
-- 
2.31.1.368.gbe11c130af-goog

