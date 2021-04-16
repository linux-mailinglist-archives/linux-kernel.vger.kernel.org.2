Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F11362B8C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhDPWnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhDPWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09404C06134B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e2so10425674plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YO52CfN8ObAfgZLp7u0yIiEJEMcw9jv84B9RSSd91cE=;
        b=hA6/ZsuHqB3kmRjFkH5Jkmzrdy85gSWuR/4vaAHDMIE48BeNPayj8tRWKkTNZOoCUA
         gRRUhNxWn4Q+CAFmmSoYepPODVh1Dg8VZqqI+TAzcrKuUTSCCor5HJ/2yiH3K07JuKWA
         7Gbo7zdtWsX4PGODSqc8sfSuTvIpo5Wbl6XZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YO52CfN8ObAfgZLp7u0yIiEJEMcw9jv84B9RSSd91cE=;
        b=oIYgyoZYIu+6WUpnQQ+VfacYL3F/SCPmCA/2srGbxD7P1FlpIMIfhCo5zDzDYGYQGZ
         Ttx/fW/aBs6wSoezygp7ZPc4+R6/F4N7TGYqQ4vTG9WYEpbvhQbAs23nD3GeneBd3pjr
         lnN8CtmyoDWn/q1l6lTRkdShlB2Ihy3yzuarypfdIMdaHfisuaM/IkP1S705JdTjzY/a
         Cxi8cEz9fL9hPiGYLYfr2+m1jJlbDJu/B1etAZTM5qoKenN/H+3r9oEI0bqP6LgimW+R
         beke32HUh3CSorNESpcARSO6hl/fxR80QwnZjM1oA7VeYQlwxMg8f4sLa8Rr9fMAJsy1
         AJnw==
X-Gm-Message-State: AOAM5335eoqxg7Vtilp7VQOA/E8bkHjItd3DTEnUWKEgfNvagC2YEb4M
        gSfauIuelUWKpWbVAQFMpxyBpA==
X-Google-Smtp-Source: ABdhPJzVfbNwbQjph550fbIuOfgbviSQ03VrlkRSJ2bniftc4dglobcQ38N6Az75kI85FCVdC+w4lQ==
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id p6-20020a170902a406b02900e678c471c8mr11524014plq.17.1618612882638;
        Fri, 16 Apr 2021 15:41:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:22 -0700 (PDT)
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
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 27/27] drm/panel: panel-simple: Prepare/unprepare are refcounted, not forced
Date:   Fri, 16 Apr 2021 15:39:50 -0700
Message-Id: <20210416153909.v4.27.I502f2a92ddd36c3d28d014dd75e170c2d405a0a5@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically simple-panel had code to make sure that if prepare() was
called on an already-prepared panel that it was a no-op. Similarly if
unprepare() was called on an already-unprepared panel it was also a
no-op. Essentially it means that these functions always "forced" the
value to be whatever the caller wanted it to be. You can see that the
forcing behavior dates back at least as far as 2014 by looking at
commit 613a633e7a56 ("drm/panel: simple: Add proper definition for
prepare and unprepare").

Apparently the code supporting the historical behavior may not be
needed [1] and prepare() / unprepare() are supposed to be
balanced. Let's try removing it and see if anyone breaks! If they do
then we can have a debate about whether we should change that code or
revert this patch. :-) If nobody breaks then we've nicely saved a few
lines of code and some complexity.

[1] https://lore.kernel.org/r/YHePsQgqOau1V5lD@pendragon.ideasonboard.com

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5a2953c4ca44..a2c3008af7e5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -176,8 +176,6 @@ struct panel_simple {
 	bool enabled;
 	bool no_hpd;
 
-	bool prepared;
-
 	ktime_t prepared_time;
 	ktime_t unprepared_time;
 
@@ -355,18 +353,12 @@ static int panel_simple_suspend(struct device *dev)
 
 static int panel_simple_unprepare(struct drm_panel *panel)
 {
-	struct panel_simple *p = to_panel_simple(panel);
 	int ret;
 
-	/* Unpreparing when already unprepared is a no-op */
-	if (!p->prepared)
-		return 0;
-
 	pm_runtime_mark_last_busy(panel->dev);
 	ret = pm_runtime_put_autosuspend(panel->dev);
 	if (ret < 0)
 		return ret;
-	p->prepared = false;
 
 	return 0;
 }
@@ -475,18 +467,12 @@ static int panel_simple_prepare(struct drm_panel *panel)
 	struct panel_simple *p = to_panel_simple(panel);
 	int ret;
 
-	/* Preparing when already prepared is a no-op */
-	if (p->prepared)
-		return 0;
-
 	ret = pm_runtime_get_sync(panel->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(panel->dev);
 		return ret;
 	}
 
-	p->prepared = true;
-
 	return 0;
 }
 
-- 
2.31.1.368.gbe11c130af-goog

