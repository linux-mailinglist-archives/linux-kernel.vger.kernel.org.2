Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25106353128
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhDBW3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhDBW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B9DC061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c17so4362202pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6G7mQknm6wjoWphPZSZUuxY9hNho1AQ+iay1c8iYnQ4=;
        b=Y/riba2ZyERhmbUbp0nZgFQrpTe0WmQx/lQQLmVwpGVfRsd43VoIWOsO4jZfN5IS2V
         J78oY0zNvSXmoIpHmCZfKN8ypiUOWVjANqbOkrxwOs7ZO3WCI5ocdcARKy0Fhbx60QpO
         hgJxkCCRgFoVxizvJyry96LBAyaFNIDg6TkSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6G7mQknm6wjoWphPZSZUuxY9hNho1AQ+iay1c8iYnQ4=;
        b=ZeOxVUIa/X0J4283ofZX2muwBPV9k2tBnDRdcID8efggNUsLs8ZNeUABzWXbO3fw6Q
         Ys7krEo6uinhC+0lEHIVrABx2/1Wjzge8jsMzU7jdM/2hb1xW1aqRatGgpSssNVIVH1x
         zPM5Y8qS9fMleRwRcSYDGl2r9RWNCq4OacuAu6AmY9ZJIQhjjWo/0Ifb/tt4EUjV6MAt
         dhJBRxnDnpFeP5tyyO8jrvLwTI7Sjffp1H3/h15nxgEo3HczYKC5wZz+j82qy+b5RwsB
         TDt0eItamd9YcXkld8Ouz59yeuOxaEjCNnxQEMef2v6RZwL3LOFmFhrN9r+ZSc9/ZA04
         4CeA==
X-Gm-Message-State: AOAM531yPQHHrUo9fw8iva/Ppm4FS1AKg9ncyz3aljBwnKD6o8iWQl19
        RopZy7HqP2iMTbHagUbUiuZTdg==
X-Google-Smtp-Source: ABdhPJz4NdL95sgVBazICIqKq0ekk4Cx/rwWSUaLe9Uv1pcNYM9TEmiPwe664DKuaS1enCO1P/h+RQ==
X-Received: by 2002:a63:1d18:: with SMTP id d24mr13864452pgd.402.1617402573324;
        Fri, 02 Apr 2021 15:29:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:33 -0700 (PDT)
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
Subject: [PATCH v3 06/12] drm/bridge: ti-sn65dsi86: Get rid of the useless detect() function
Date:   Fri,  2 Apr 2021 15:28:40 -0700
Message-Id: <20210402152701.v3.6.I826adf4faeb7f39f560b387f6b380e639c6986c8@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we just leave the detect() function as NULL then the upper layers
assume we're always connected. There's no reason for a stub.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index e30460002c48..51db30d573c1 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -306,20 +306,8 @@ static struct drm_connector_helper_funcs ti_sn_bridge_connector_helper_funcs = {
 	.mode_valid = ti_sn_bridge_connector_mode_valid,
 };
 
-static enum drm_connector_status
-ti_sn_bridge_connector_detect(struct drm_connector *connector, bool force)
-{
-	/**
-	 * TODO: Currently if drm_panel is present, then always
-	 * return the status as connected. Need to add support to detect
-	 * device state for hot pluggable scenarios.
-	 */
-	return connector_status_connected;
-}
-
 static const struct drm_connector_funcs ti_sn_bridge_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.detect = ti_sn_bridge_connector_detect,
 	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-- 
2.31.0.208.g409f899ff0-goog

