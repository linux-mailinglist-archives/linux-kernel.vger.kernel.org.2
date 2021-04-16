Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CEC362B5D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhDPWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbhDPWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9029C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b17so20148930pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2616N/QYdtGiJ2WPqXN32z+9F37dE5BQ+AbPSzAlWM=;
        b=Kvygd9Jv3cSdtacrk08etIwGlvbXGIrpJZ3Kbi2fof0pagVnuMUHM5nHqm4TWmIu0l
         NbsEdW2P2kh3xjBHWDqpfg/e1gPhpozUNag0jYXbTdhTM22I3Dcjy9L9b7GQIOjRcYgp
         J65JqAvMF89YzAQdk9fBdrswX5VeBIl87nLqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2616N/QYdtGiJ2WPqXN32z+9F37dE5BQ+AbPSzAlWM=;
        b=tKkC8/pnCNWQ5RTrDjaPxr7TtRPXyiOJYv930WHvLjzdNGD+Mq1vMBWI/hsLqDv8wm
         6BUUR+k9q63qdJSqfY3qZhvVXIAL0CsVObMzQxzbubPxE+UxbBqV+JHQKqdS05OOaMLK
         tpy+1YRiGrrHhqmO4C9ivFdBuwzpqX7rhuz0J6S1bVshpv7+ymJ+ld8MpXADELG1YwXE
         DMRIHFww4SztU651lKqgXjgvyB91/1XV1/kXScfMYX6tWt3371EPKOXBAeaupfSvkl7i
         u2//KUuAvgfnPTpTS1qMpurG8Bed1bD477C7g+/qcbrHoMcgVrOZDcwMHtYXCBZhuCAQ
         bjaA==
X-Gm-Message-State: AOAM533p+prG4O/YEr0F8FRPBLvcCWphqeZlz80qsZ9k5/U7XLWUPsaN
        x16L1+juruPyq/tt0W7GxQRtcA==
X-Google-Smtp-Source: ABdhPJx+++sgm6QScJKVRhLGDYDXTsoYpzMGpZIuovPKocdK2x9/8MdnhVgChFQiH8GmypmxYux8VA==
X-Received: by 2002:a63:514d:: with SMTP id r13mr1079777pgl.322.1618612855514;
        Fri, 16 Apr 2021 15:40:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:40:55 -0700 (PDT)
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
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/27] drm/bridge: ti-sn65dsi86: Simplify refclk handling
Date:   Fri, 16 Apr 2021 15:39:25 -0700
Message-Id: <20210416153909.v4.2.Ic9c04f960190faad5290738b2a35d73661862735@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock framework makes it simple to deal with an optional clock.
You can call clk_get_optional() and if the clock isn't specified it'll
just return NULL without complaint. It's valid to pass NULL to
enable/disable/prepare/unprepare. Let's make use of this to simplify
things a tiny bit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

(no changes since v2)

Changes in v2:
- Removed 2nd paragraph in commit message.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 88df4dd0f39d..96fe8f2c0ea9 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1275,14 +1275,9 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	pdata->refclk = devm_clk_get(pdata->dev, "refclk");
-	if (IS_ERR(pdata->refclk)) {
-		ret = PTR_ERR(pdata->refclk);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-		DRM_DEBUG_KMS("refclk not found\n");
-		pdata->refclk = NULL;
-	}
+	pdata->refclk = devm_clk_get_optional(pdata->dev, "refclk");
+	if (IS_ERR(pdata->refclk))
+		return PTR_ERR(pdata->refclk);
 
 	ret = ti_sn_bridge_parse_dsi_host(pdata);
 	if (ret)
-- 
2.31.1.368.gbe11c130af-goog

