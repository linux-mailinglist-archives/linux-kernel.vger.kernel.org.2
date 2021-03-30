Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C8E34DEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhC3Cy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhC3CyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A863C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v23so5391107ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPcvkA/+dPL4qhz8ZVLSjs9HCv03yetPJyqdMPURwCo=;
        b=B6I0RdTPrj/Kd0yWPFWFp7fM6GGADE1pQB4GI4+cT4PpmL1jrqfnU23r9DZsNA9cCC
         8B1Ncdn4LITdp9OXNRxjzZloCU/Tn+MJYiz+ZIXz2YvablWJWfTCgytCaBnoaU4z2oMG
         kydPHSSVE+8fV1KAWnE3ApTeoCFWh5pu82DL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPcvkA/+dPL4qhz8ZVLSjs9HCv03yetPJyqdMPURwCo=;
        b=uPEoZxF2U80/SJcLTibH159W1n5/5dyhM+a8asGYpuGiXVAGZWQBAE9tR2DW08I4Bt
         jojv8UfTVG693xBsyt7G8/XO08GOKnRao2yob9d5Ft/fslMx+MCUkB9jt3c8t8gJ42jf
         MqlT4gsMaCC6mAUX1PrF4X6qtxmohIUdUyNxeTxZsKXVOh8mSMhFrgin18nTXscClHY/
         E6e8KE8lq5k80FjMHM0RHRMkMlOgP2h6yHvXwfxYWBU7P3b+9rIbq/dRcABZFt6gr0Lf
         WKzm3ohL8wjkWBpGNB40hntxiTVq4kDTNOoYoewjEVcu34WU7+CS9aHeV8VHBRO80WUG
         1Msg==
X-Gm-Message-State: AOAM5312HjGq7o1jEE+gDeK+UyL1AvUXrC2Qop2G5Fpl+Mdz1sYdY54+
        P5n4RK2mw+I3H5kVETe2JkQcHA==
X-Google-Smtp-Source: ABdhPJxuu4EYsqmrXz954R1Z5YP+cOJ4Ifd+QvOTnbBflnQYIsWzLuv5y6G5f6GnwB1lH22aCko55w==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr2098018pjo.121.1617072851012;
        Mon, 29 Mar 2021 19:54:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] drm/bridge: ti-sn65dsi86: Move drm_panel_unprepare() to post_disable()
Date:   Mon, 29 Mar 2021 19:53:37 -0700
Message-Id: <20210329195255.v2.6.Ia75c9ffe2a2582393a8532d244da86f18b4c9b21@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
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
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index e8e523b3a16b..50a52af8e39f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -460,8 +460,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
 	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
 	/* disable DP PLL */
 	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
-
-	drm_panel_unprepare(pdata->panel);
 }
 
 static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn_bridge *pdata)
@@ -877,6 +875,8 @@ static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
 {
 	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
 
+	drm_panel_unprepare(pdata->panel);
+
 	clk_disable_unprepare(pdata->refclk);
 
 	pm_runtime_put_sync(pdata->dev);
-- 
2.31.0.291.g576ba9dcdaf-goog

