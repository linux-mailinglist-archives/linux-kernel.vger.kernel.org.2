Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09733697DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbhDWRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbhDWRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:00:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30BCC061358
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:00:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so35590927pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vN5od8em+5FKe5XxLDBfqxHA4H7++ijxC9/2y7ssun0=;
        b=PbMi+Tmz6a3EpvJ9X3Y9FXr95RRXZ4WgYEkkFrYH8DG3I9WXhyCde+nuxI9ZYVJL5m
         dpxwDpU6JhRXyHgwP6P4TkEmQCsf7BHAh+TtGCZr51NdhdfE7GjjXZtF76870E8VeXbG
         RSiv0/YdYeqcTbVH9s2F5nMI8pbO99Lz5yBp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vN5od8em+5FKe5XxLDBfqxHA4H7++ijxC9/2y7ssun0=;
        b=QBh6Iyx+eTRfOEJA5VQ54+KR1giogKdZNbSNhJz2sxr+dS/pURtT9sR78qlVB4yTz0
         U6gZ9PzBo/BY5iDQFz0vFIjPmNv9da3b1SvEzy9WjXz3i5frLw0/hf955kUjLuQAt8Ke
         I4NGBAEOQ43mF5RnmJ0LDaD/YqtsYfyrEdIkXXi0vyYIGBrm5+BotmA6bxXu/YuubBMU
         3rSK2gT+uOncgXBY/UVpxkD0UMU+cuxlLjyM7ijmuIFGCmxSC7KYzE3ADBXwjZrGH61E
         MorCseM9t0N6bUx7b6ApFHRlHoRG7tI8D8bmiqgMMNtiiAaxTlJh+4KFLYPtqYaATjy+
         w3zA==
X-Gm-Message-State: AOAM533tufinTwWQJl5D7gdbcCfGTrszjVqhQvN3pPvu7ctaPoX5GKQY
        R9rUtMjuIbd6KxzsKWCnxGD7Zg==
X-Google-Smtp-Source: ABdhPJwINQl5crpxyRVfX+jrNNrO5VsTiefR+FBPJxIt4U/f6GB7qHJwNiBie9Tl+LA3r9E8NJRtlg==
X-Received: by 2002:a63:f303:: with SMTP id l3mr4753122pgh.263.1619197200372;
        Fri, 23 Apr 2021 10:00:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6d86:663d:71f8:6a11])
        by smtp.gmail.com with ESMTPSA id v8sm5123607pfm.128.2021.04.23.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:00:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 18/20] drm/panel: panel-simple: Cache the EDID as long as we retain power
Date:   Fri, 23 Apr 2021 09:59:04 -0700
Message-Id: <20210423095743.v5.18.If050957eaa85cf45b10bcf61e6f7fa61c9750ebf@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423165906.2504169-1-dianders@chromium.org>
References: <20210423165906.2504169-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to go out to the bus and read the EDID over and
over again. Let's cache it and throw away the cache when we turn power
off from the panel. Autosuspend means that even if there are several
calls to read the EDID before we officially turn the power on then we
should get good use out of this cache.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a12dfe8b8d90..9be050ab372f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -189,6 +189,8 @@ struct panel_simple {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *hpd_gpio;
 
+	struct edid *edid;
+
 	struct drm_display_mode override_mode;
 
 	enum drm_panel_orientation orientation;
@@ -345,6 +347,9 @@ static int panel_simple_suspend(struct device *dev)
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
 
+	kfree(p->edid);
+	p->edid = NULL;
+
 	return 0;
 }
 
@@ -510,15 +515,13 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 
 	/* probe EDID if a DDC bus is available */
 	if (p->ddc) {
-		struct edid *edid;
-
 		pm_runtime_get_sync(panel->dev);
 
-		edid = drm_get_edid(connector, p->ddc);
-		if (edid) {
-			num += drm_add_edid_modes(connector, edid);
-			kfree(edid);
-		}
+		if (!p->edid)
+			p->edid = drm_get_edid(connector, p->ddc);
+
+		if (p->edid)
+			num += drm_add_edid_modes(connector, p->edid);
 
 		pm_runtime_mark_last_busy(panel->dev);
 		pm_runtime_put_autosuspend(panel->dev);
-- 
2.31.1.498.g6c1eba8ee3d-goog

