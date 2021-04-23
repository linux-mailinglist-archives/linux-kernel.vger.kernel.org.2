Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5033697DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbhDWRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbhDWRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:00:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B8C06134C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:59:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w10so35615857pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYPxCdxtMKks8nftHI6+ZQaaJJnE9/+IALv4FLgIF54=;
        b=FvspuRuAWQhP6jQ5s/WPvA91XTFtWFz+QdqQAvdR0ZycpQE1pGtYWhuwDPlrqPY4Ef
         y68z04/DlCKz2zLgffkrU/DZWpJ2HOc/x1wsBCXKmxXRzdlb1KSt+mdDMDksFGjx0xpi
         7NlQq1WUOY+oTayFgiLb9M1V2hgjIAZupsRuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYPxCdxtMKks8nftHI6+ZQaaJJnE9/+IALv4FLgIF54=;
        b=lug9iGRlAhiH/a5YdQh7//Q6rQu/aEuhVYopfpb+XCdstrlEP/IfgbBWQ4YaRtfDU2
         tV2NrE9Gbf16uGYGItbwXMx8oHl7Z8TDw59zpewPJFX4b9vsrKMz4bIk72PP0i9HzR3y
         mCmQjZ4naFuLt7m0wLdJ49LHH1Kb3L+Ox7jStWnCdF43LddBZneZIp1h0Vaupzq/5a3i
         Urt+Lc8HjK/koa4FQ0OcjwwUUNjkFpnDfXF+QyZpHGnW7CzCTWyM1W+eZb1tZdwWO/gS
         f4bGD68RML473gZj3mUD0WxmuRMZeMtSlemwj0J668Fx65PRG245LxXm/iOsg0bew2eO
         fB/Q==
X-Gm-Message-State: AOAM530RXPIcP2lyUWbso+wsCBPjTmCipQe2CNZEnagK9ddwRbLVKuP3
        OdvrOJo66VsHnAZ1yNNEJ/9T1w==
X-Google-Smtp-Source: ABdhPJyVdUM/1lp2NxOCx1Zx4EFgPXlKhQBOV5qtNjvmUvZ8eSWax5LiJ/ZRUO5ihILkjxoJYoXPQA==
X-Received: by 2002:a63:4512:: with SMTP id s18mr4722524pga.275.1619197198125;
        Fri, 23 Apr 2021 09:59:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6d86:663d:71f8:6a11])
        by smtp.gmail.com with ESMTPSA id v8sm5123607pfm.128.2021.04.23.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:59:57 -0700 (PDT)
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
Subject: [PATCH v5 16/20] drm/panel: panel-simple: Remove extra call: drm_connector_update_edid_property()
Date:   Fri, 23 Apr 2021 09:59:02 -0700
Message-Id: <20210423095743.v5.16.Icb581b0273d95cc33ca38676c61ae6d7d2e75357@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423165906.2504169-1-dianders@chromium.org>
References: <20210423165906.2504169-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 5186421cbfe2 ("drm: Introduce epoch counter to
drm_connector") the drm_get_edid() function calls
drm_connector_update_edid_property() for us. There's no reason for us
to call it again.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
As Laurent pointed out [1] this is actually a pretty common
problem. His suggestion to do this more broadly is a good idea but
this series is probably a bit ambitious already so I would suggest
that be taken up separately.

[1] https://lore.kernel.org/r/YGphgcESWsozCi1y@pendragon.ideasonboard.com

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index bd208abcbf07..4de33c929a59 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -512,7 +512,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	if (p->ddc) {
 		struct edid *edid = drm_get_edid(connector, p->ddc);
 
-		drm_connector_update_edid_property(connector, edid);
 		if (edid) {
 			num += drm_add_edid_modes(connector, edid);
 			kfree(edid);
-- 
2.31.1.498.g6c1eba8ee3d-goog

