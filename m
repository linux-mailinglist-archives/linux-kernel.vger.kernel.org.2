Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B68034DED7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhC3CyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhC3CyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC930C061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g15so11181639pfq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0a82Fvj95xpPBe4qqrq7QwDbwlHgP+SSdPbPFDe0q8=;
        b=CVcj4Vw20yH89xN07Z6BhprfbML7ZL5HUvCtvJwTUB3wWjw/+M0p1pBa875Ap1fZJx
         4kAqftRj9MPjSe8yPMhTJmaW5VZDybBxwSyhywGaMBO9hvyfusHZglZF9EPF+I8Vy6uH
         mX5aECtiRVrVMN7I6lTJ1fj9R9af5yBJaMo60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0a82Fvj95xpPBe4qqrq7QwDbwlHgP+SSdPbPFDe0q8=;
        b=tjZjWB89KBpk+iG0TYxWAZ2TOfD2Z5v6LtlfDz5NNYnbxCsEIEjLWdljj+2pgqmjAT
         KOrMRlVkmhNOWcs8Wi4ZyLnlMn3DCUReYDRmZBOe6e96mOsZTvyGHbZ4lku5bI/VPix0
         KInnhYVfeuE70MlGrqvfoGWSeIerokYs3/HgLD7kZH/Mdau2D6noOYxy23jPisfs/DfS
         rmgo3ALsjbFrbwCJoiCALGUrqTHaBOSaBXegxq5Pejcm5R1MqGZwEK7CSwrcvc6mgBDI
         rDOUHdQ8J2EPw2TBZ3z186aTSm21/nvp3LCzpqkS1Rs3pxn9sOUvKzRVha0tFGanL0FW
         KMjg==
X-Gm-Message-State: AOAM532xm+qBKoayRUeI7d+J2SkPEEo8UULUcaKJC0h5tiXsc6JLav19
        7CjcKClPM80+8jmz8nSd0GZpUQ==
X-Google-Smtp-Source: ABdhPJzYHHI11ASL6+sqBEqRntEX4mX3gGBjkpvTlBS2HCIxzcLVie16h9UEbsEDFRdBJqvUhgWQ7w==
X-Received: by 2002:a65:4986:: with SMTP id r6mr1027046pgs.392.1617072844237;
        Mon, 29 Mar 2021 19:54:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:03 -0700 (PDT)
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
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] drm/bridge: ti-sn65dsi86: Simplify refclk handling
Date:   Mon, 29 Mar 2021 19:53:33 -0700
Message-Id: <20210329195255.v2.2.Ic9c04f960190faad5290738b2a35d73661862735@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
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
---

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
2.31.0.291.g576ba9dcdaf-goog

