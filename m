Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311AE34DEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhC3Cy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhC3CyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7EC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso8696140pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTm+OMgZlY4S4hMjr1yPchfjYIhYww8IVvy3C+UG5OA=;
        b=T1ak2WvHBXzGIQK+L+Lq+8Ydsiyy7SAzW87e3YZAJR0P9M2cVBxpRS3kXSX/3+bAS0
         TyMOb6na5z7J4n+mnK9vwZIY4JmI8LfiedI1xE35JhEQDHzTm2Lv0g/CEOrM11JzFBPi
         J7Pzn6F79MaPYrGkaO7mXaxVycYLvdbRyGHns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTm+OMgZlY4S4hMjr1yPchfjYIhYww8IVvy3C+UG5OA=;
        b=iHN4zWAgo2Cyod0c0dX7lsdgAzMHtXuzd2fB46QUVp2p7P/EuL8ZfblivHI5+WTH9j
         GMRgUR/ThZt+Fg4Go4YNpbMQSz78J+ibV4d335+kpjf9W7d8+aT2tgEWwA1HQuGHrrmD
         rj9XGNb7iTy0jPIUGJLpLaq2t7lFIKkORVG53h254aZMleX5KkkQR7UfLFKjqkUkDY0m
         iUAsJWXcCthmudAf8XPVpf7nvXPUiOzHI2MWy3bsoJswtlT3/GI78B6BzKlpza9ZUAPc
         EuK3Qz4oiOvNVa0WBhBokJffrVgQs8KXCd1GQsFHSw3Y3NNDoY0MUCCcJtk34fQHuXWF
         WDzA==
X-Gm-Message-State: AOAM531bqAmReQeA+aMsjXrLtPpkqJ07Dmuc04VC1yQ0X1kefPf9MhZU
        QMYotmJ+46nkj2+j5Z7rNqkacA==
X-Google-Smtp-Source: ABdhPJxPN8enXp1e4HwIU+ZMKYwa4F8Gz+UNfz2Bce7f22QcfvvT37KnbBqNKoBBqjiwxVL9mJjXCA==
X-Received: by 2002:a17:902:f54e:b029:e6:3d74:eb3 with SMTP id h14-20020a170902f54eb02900e63d740eb3mr31652296plf.14.1617072852935;
        Mon, 29 Mar 2021 19:54:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:12 -0700 (PDT)
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
Subject: [PATCH v2 07/14] drm/bridge: ti-sn65dsi86: Get rid of the useless detect() function
Date:   Mon, 29 Mar 2021 19:53:38 -0700
Message-Id: <20210329195255.v2.7.I826adf4faeb7f39f560b387f6b380e639c6986c8@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we just leave the detect() function as NULL then the upper layers
assume we're always connected. There's no reason for a stub.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 50a52af8e39f..a0a00dd1187c 100644
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
2.31.0.291.g576ba9dcdaf-goog

