Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE92353123
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhDBW3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbhDBW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F687C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ay2so3067590plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wJ6M1bGIwRFPnVY3IaI+9jJdO1aYMpIT1iEsleX6Es=;
        b=ePUgktHW5kXZRuCKf0O/J58zQqgVweIOh+yyjfO9NbSrepDLjup46dgomfaobMeofj
         zFcaxBHZQokhH7cWG0hD+zIm2epwgUJawcrSxBtwmoKoFI/t49+gZKnr4jTfOAz8NCsH
         RDzKBedY9tSMoPzPTOad+bNjiXb7I/S3x7g2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wJ6M1bGIwRFPnVY3IaI+9jJdO1aYMpIT1iEsleX6Es=;
        b=nzE5PGh6gYuvIsR9CVPvQMx0gfDnMhoTxFSkIR7/nAFmzowHQTtOUXYMDSKFL5SsW4
         U4gcefsQfOjUnQT8cETgRKeKJWqS3qg5VLqyWFTSEVvn9xrXarae4MDVsO4khl6Otlpy
         zrsRb0czs1C5fgL9JR2NwagMwsHi4JZbVWhbXdJgt0+NerCrOXMhjuiMOQi4/W6aocKG
         3jebgeLvAMliHkiNRTQJvTSTHIFm7LhuhGwRUdVLddEjHqFjUkufD0LJ2ztwg3Zd4MkR
         NhF952GLUlDnwm1YIeE7k9ucxyiWvrVFXrpP76akvN7g6Dc0cmwmZ7nzK7qy84/ncE06
         osdQ==
X-Gm-Message-State: AOAM531oTx5DkwPFgxGqiayWnO08DcqiaVH86O87oFzmb1GUk+8zGx8c
        O3xq+Ax8GtVZuHYxGRJ5ekrIlQ==
X-Google-Smtp-Source: ABdhPJxsjTz8h7xHUz2mmZKKY+Ac8x0Kwl9t3r7hiHvG5cMx0anZAHyd8M6rX41TxpSme+MUXcqqaA==
X-Received: by 2002:a17:902:8e83:b029:e8:c8bd:f65b with SMTP id bg3-20020a1709028e83b02900e8c8bdf65bmr3192394plb.4.1617402572240;
        Fri, 02 Apr 2021 15:29:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robdclark@chromium.org, Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/12] drm/bridge: ti-sn65dsi86: Move drm_panel_unprepare() to post_disable()
Date:   Fri,  2 Apr 2021 15:28:39 -0700
Message-Id: <20210402152701.v3.5.Ia75c9ffe2a2582393a8532d244da86f18b4c9b21@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prepared the panel in pre_enable() so we should unprepare it in
post_disable() to match.

This becomes important once we start using pre_enable() and
post_disable() to make sure things are powered on (and then off again)
when reading the EDID.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

(no changes since v1)

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
2.31.0.208.g409f899ff0-goog

