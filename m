Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A22353129
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhDBW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhDBW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DDC0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso3139051pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4Ez8ElepMTV+MvClEGu3tQsRyt96EN/+CswsXajnuI=;
        b=P8fcZHl4ImlsURal5ihPb9+EUw8hnU1p0T9V9nhAhLqrQ9Tv9ZmFPNcCw71g926VSw
         hDLJeiwcvUlcatrIpw8ioIZC6OPLSin3euGxphNrBRE/RLS3b4ARCv9hoQ2FRtMy+AzB
         2BTg8WGu6zx/2u3g8eMThiHr6b56/Ihtyim9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4Ez8ElepMTV+MvClEGu3tQsRyt96EN/+CswsXajnuI=;
        b=nWVmfUTX4DQ8K7hT72HnEWu/ZKytOGLIdVz93vNw85SBXxKZhW29PqKs6FXqcbMUSu
         yRPKxqScPvPU/haleg+dIqAFw07KwFFh/gT2qOpcbuRdzMeWx4BKsuiGOACDKZi90DMz
         bhS4xaxlI2kw7sODf3+1EcRCO56RO+8Q4Rqn5byWQMYxtAZKgcLOvn3jkn7io7iUrVJR
         V0EZHJzNbfl611cQi8J2UprvFDr+dAAQEGOIau0Lebxgl2IMuAocUhdvr+aJnwu8bG/D
         d4CbrN/UX/t3Kp7uSRBY0+Q2s9rOPHGoLQQYPuPmU7W6fPNeBUKWlb2+TasOzPYrsOwB
         NwAA==
X-Gm-Message-State: AOAM532/xZiP7TQASGxVvDQufXpMiLuocGY6hGXkFGNwFEqq02qcURg1
        rfxIqfHtftU+QfUnufbAXGLTSA==
X-Google-Smtp-Source: ABdhPJwqMvePBtECYQE0aZVwdf49bgZJbb46tTVxAwzEB7ocaDZqVJ0i94UhCf6xtSJelKW1maLpvg==
X-Received: by 2002:a17:902:ecce:b029:e8:b810:1c1a with SMTP id a14-20020a170902ecceb02900e8b8101c1amr5836469plh.51.1617402575494;
        Fri, 02 Apr 2021 15:29:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:35 -0700 (PDT)
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
Subject: [PATCH v3 08/12] drm/bridge: ti-sn65dsi86: Power things properly for reading the EDID
Date:   Fri,  2 Apr 2021 15:28:42 -0700
Message-Id: <20210402152701.v3.8.Ied721dc895156046ac523baa55a71da241cd09c7@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDP panels won't provide their EDID unless they're powered on. Let's
chain a power-on before we read the EDID. This roughly matches what
was done in 'parade-ps8640.c'.

NOTE: The old code attempted to call pm_runtime_get_sync() before
reading the EDID. While that was enough to power the bridge chip on,
it wasn't enough to talk to the panel for two reasons:
1. Since we never ran the bridge chip's pre-enable then we never set
   the bit to ignore HPD. This meant the bridge chip didn't even _try_
   to go out on the bus and communicate with the panel.
2. Even if we fixed things to ignore HPD, the EDID still wouldn't read
   if the panel wasn't on.

ALSO NOTE: Without the future patch ("drm/panel: panel-simple: Use
runtime pm to avoid excessive unprepare / prepare") there will be boot
speed implications here. Specifically we'll power the panel on to read
the EDID, then fully off. Then we'll likely have to wait the minimum
time between power off and power on.

Fixes: 58074b08c04a ("drm/bridge: ti-sn65dsi86: Read EDID blob over DDC")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Rebased now that we're not moving EDID caching to the core.
- Separating out patch to block AUX channel when not powered.
- Added note about boot speed implications.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6390bc58f29a..543590801a8e 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -129,6 +129,7 @@
  * @dp_lanes:     Count of dp_lanes we're using.
  * @ln_assign:    Value to program to the LN_ASSIGN register.
  * @ln_polrs:     Value for the 4-bit LN_POLRS field of SN_ENH_FRAME_REG.
+ * @pre_enabled:  If true then pre_enable() has run.
  *
  * @gchip:        If we expose our GPIOs, this is used.
  * @gchip_output: A cache of whether we've set GPIOs to output.  This
@@ -157,6 +158,7 @@ struct ti_sn_bridge {
 	int				dp_lanes;
 	u8				ln_assign;
 	u8				ln_polrs;
+	bool				pre_enabled;
 
 #if defined(CONFIG_OF_GPIO)
 	struct gpio_chip		gchip;
@@ -270,12 +272,17 @@ static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 {
 	struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
 	struct edid *edid = pdata->edid;
+	bool was_enabled;
 	int num;
 
 	if (!edid) {
-		pm_runtime_get_sync(pdata->dev);
+		was_enabled = pdata->pre_enabled;
+
+		if (!was_enabled)
+			drm_bridge_chain_pre_enable(&pdata->bridge);
 		edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
-		pm_runtime_put(pdata->dev);
+		if (!was_enabled)
+			drm_bridge_chain_post_disable(&pdata->bridge);
 	}
 
 	if (edid && drm_edid_is_valid(edid)) {
@@ -846,12 +853,16 @@ static void ti_sn_bridge_pre_enable(struct drm_bridge *bridge)
 			   HPD_DISABLE);
 
 	drm_panel_prepare(pdata->panel);
+
+	pdata->pre_enabled = true;
 }
 
 static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
 {
 	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
 
+	pdata->pre_enabled = false;
+
 	drm_panel_unprepare(pdata->panel);
 
 	clk_disable_unprepare(pdata->refclk);
-- 
2.31.0.208.g409f899ff0-goog

