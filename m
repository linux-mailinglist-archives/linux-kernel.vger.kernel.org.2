Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1D362B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhDPWlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbhDPWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35490C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p67so14325494pfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5nOteFgoZnowwkTipxkWtE08iX9sY3pl7ULi9yEyaI=;
        b=W8hyzMu/n2h6P+btoPgO6hDZzVjhqexQbyYVYNXmEhPGuPi5s0RUkdrBz6VIbEPPV7
         zG1o4lr9afuQGk8W+WKyYmlPegOotR2ux4/bMDggeTsMoSjsK8W8H6GyH9bnVFCVdo16
         FXQUn08UWJTOaR8fX8Q5JzKcqPflvpRF2Y5+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5nOteFgoZnowwkTipxkWtE08iX9sY3pl7ULi9yEyaI=;
        b=WOSKObl5Dkxcxev7dMeqv0AAJIWQftdVPKq2RbfF8QQXH40IuaRODbVpuF0TUZO86z
         XR0TcaxuwzRZFYIj/U34NQVov5epIxbt3pnHII4ZlppBz1f3NcWpPjzsHJ2Mi+KEwiKc
         CrN678vOfYXRW/rbaJ+FUu6bgY7fSL/Y5wdE955zyIXKvwPMQ8sQ4k3PaTrSldY/T5Vl
         dZLk6nychQiEZcvvYL59AuVeG+gBfutdhQfJ/GHEhxzxGZ09SFel4+Iy1MvjUohp9sI0
         F1Xk7emYucS/QnTS7OdOy/DULEv6yuIi4aaNSpDOyqqyQ2Xt31bAQVEIbM7Ly4Vua+rq
         EN+g==
X-Gm-Message-State: AOAM532w1gkulE6CtnRD0m6X+dS1I0jHlpRyp2zGSZdJHM7SfkPBMwaf
        2qQNLDVbTASZDLGvJl9UHNbJbw==
X-Google-Smtp-Source: ABdhPJyj5GBW4RdGlaUXoToWPg882VwpJn8Yf5HvBP+mLu4qvhhDBwIkpFlvogSUcDSesiRyd++BrA==
X-Received: by 2002:a63:c847:: with SMTP id l7mr1102468pgi.445.1618612859778;
        Fri, 16 Apr 2021 15:40:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:40:59 -0700 (PDT)
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
Subject: [PATCH v4 06/27] drm/bridge: ti-sn65dsi86: Get rid of the useless detect() function
Date:   Fri, 16 Apr 2021 15:39:29 -0700
Message-Id: <20210416153909.v4.6.I826adf4faeb7f39f560b387f6b380e639c6986c8@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we just leave the detect() function as NULL then the upper layers
assume we're always connected. There's no reason for a stub.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
2.31.1.368.gbe11c130af-goog

