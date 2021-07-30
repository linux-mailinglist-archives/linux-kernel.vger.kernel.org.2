Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79263DC045
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 23:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhG3V1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhG3V05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:26:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3BC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:26:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so22593266pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37Nacw64+KOiMZmL+vH2rc7D0NFwBJZ1GX41lOzA7sI=;
        b=k3dRWkT1xUJQUM1V3eFMcOCXVOa7G3HDa077JfJ6+aehexe59cOrNfpB0XemFMroc7
         9fP1fXGIEoJ8JUIUXS0nvYt0g7InyqCzjz5uw5aaB6YNXKRPz3KVs6jgRqfLRflWaoNM
         EtrOjelZ44Et6gdFGNEK/YWJ3uD9WIzm5XkIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37Nacw64+KOiMZmL+vH2rc7D0NFwBJZ1GX41lOzA7sI=;
        b=N/jIWOB0FmS62ocKm0WZWb2gIZXnPahHrWKfhc1xj2k3KQ1/tM8zoBLImNbB5/JDMO
         OqgS2Q7WdKsF6pdoklJ1irP5U29h4VcZ5IdWTiYOBsR2oCNwYThXTXz6784y6zLVx5tr
         Ozr0RrTrj0oSQ4z1Uxa4PODYkwE/pzRJemuihmMPQo43j4kfGInSAjyZbHOPMKGGtzZr
         ehlrdpovPMR7R6HWgoxxt+ssSiEaxv2n/HG/BaoXJQHo/KY1tHi3LEwruc7j77ZnoQot
         9Kkl+96GMVb7jXC8n4wmcsXjEZXSwF/ca3QrvWaH3zRwqVuc9efiFWL9UWH2NgjQOdGc
         Rvnw==
X-Gm-Message-State: AOAM530y1WTuMVa6libdiOWNOEOhOUBcl5ebKaay/+MVpa3OZyUhP+bw
        FVWbxiC04OirnRu+mYLgqIcmnA==
X-Google-Smtp-Source: ABdhPJyd5vlwWOM/HeeHAZX/FPiTwLb2eJnUBso0gVxPSxpB1owLbAxI8YeEzKhk0K0yQ86ZtY/f3Q==
X-Received: by 2002:a63:2308:: with SMTP id j8mr4059101pgj.166.1627680411233;
        Fri, 30 Jul 2021 14:26:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3424:e0ac:5a92:d061])
        by smtp.gmail.com with ESMTPSA id u21sm3484625pfh.163.2021.07.30.14.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 14:26:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] drm/panel-simple: Don't re-read the EDID every time we power off the panel
Date:   Fri, 30 Jul 2021 14:26:23 -0700
Message-Id: <20210730142537.v2.4.Ib810fb3bebd0bd6763e4609e1a6764d06064081e@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210730212625.3071831-1-dianders@chromium.org>
References: <20210730212625.3071831-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple-panel driver is for panels that are not hot-pluggable at
runtime. Let's keep our cached EDID around until driver unload.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ff8b59471c71..b06bf30c65d0 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -350,9 +350,6 @@ static int panel_simple_suspend(struct device *dev)
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
 
-	kfree(p->edid);
-	p->edid = NULL;
-
 	return 0;
 }
 
@@ -834,6 +831,9 @@ static int panel_simple_remove(struct device *dev)
 	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
 		put_device(&panel->ddc->dev);
 
+	kfree(panel->edid);
+	panel->edid = NULL;
+
 	return 0;
 }
 
-- 
2.32.0.554.ge1b32706d8-goog

