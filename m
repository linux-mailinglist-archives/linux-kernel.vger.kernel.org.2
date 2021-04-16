Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55B9362B89
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhDPWmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhDPWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1783C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r13so10984510pjf.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uYaRXTJ9SzjKPinVOIa28yrACdd5IDUsRVEw7A47h4=;
        b=Nbw4sDF5xEN+X83f92ecl+/EPhWBNbObado3b9Jjiv2edeJw1nN2spoXZY4Y96pgIX
         qhaSuqrOV0w90yWzwCoAEHXY7pZWnYCRu6FjP/qDh4ciu5IHRJ4B3JSUKcsX4u5nDG2q
         uX42NRCRihbgjYl+eeM8yacOQVWwPUtyB5cKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uYaRXTJ9SzjKPinVOIa28yrACdd5IDUsRVEw7A47h4=;
        b=GBPNFMab7kMohiysTVpRqBp4mPvrronugmGU150YrjvOA78cljKA3tUcwqjb2FFsZv
         M/S8urUjGnn7oZAtn1W0GJe9dMO8afjUrbwIdC+Numv4LcFdwszVuElwjkjTgMYlPUD5
         AhibAmE7uIcyMOe91/fF/DCYSpGudR2wFzB5J2M6fHO71rxhlQadLJzgA/Lzbe1ZxZdx
         HcKdtW7yUrWsfRiiAVLVw9WZG1pTqPEDKu+LU+qgaXcU8oIvx3vxLwgBUsdyP5xoSV19
         ZDiOUhiVNo5+m206aXtHoid/sLMExuau1bem+ZHCACH3c8+btTsvEXq0fQO8ANTmbF9F
         fuXg==
X-Gm-Message-State: AOAM530W7ZV0Gy1ZlgvTE6ZIOveeR67GmM0pQf1jqkb69c60RSvQLEvz
        14/SC29Hsls8INVnPnuzUvOt+A==
X-Google-Smtp-Source: ABdhPJweffa8csxEuLym54xIiGWDrpRtoZP1G8Yw7KMaqPmglHVlQGjo6oV1pRzh8WSUnopwMlc62Q==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr11627576pjn.221.1618612879486;
        Fri, 16 Apr 2021 15:41:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:19 -0700 (PDT)
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/27] drm/panel: panel-simple: Cache the EDID as long as we retain power
Date:   Fri, 16 Apr 2021 15:39:47 -0700
Message-Id: <20210416153909.v4.24.If050957eaa85cf45b10bcf61e6f7fa61c9750ebf@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
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
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 40382c1be692..5a2953c4ca44 100644
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
2.31.1.368.gbe11c130af-goog

