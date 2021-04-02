Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F32D35311B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhDBW3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhDBW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:29:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A68C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:29:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so3121602pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9ClulGPtKR9A7rITeJp1v1hARrcdfM+I5BoklnoMnw=;
        b=fnshem5entDFKpSgrA9NSoQeqydRYdFv5g8r6wSV16c8j7NoYQqKfF+/bg41xWpacT
         /r+qS3Ca5MB+cPQKPagDutZvYLdhIO8GcUDBhMq/Sn9ifdMvGFjXX9PrvY8Bb+2EGnRA
         FVV9NE7zWQtdqtHcHT0TOnetHxC+lb0hrFI5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9ClulGPtKR9A7rITeJp1v1hARrcdfM+I5BoklnoMnw=;
        b=RNDKuLZd070AJ/TVcSQ1SReCWgQVCKzPxansVIIX+58/sjAZ4JiGJXij7b2dw0pRHT
         ptU3zsFfzKaJ89HvZ4uVvgGMiEVVgxkN5oDFxfryjJn44qiGaBb3GUvFWrFA6ROd8jQo
         VbsThGv6LLAKTqcfJcWqM36JCcirDVZxNrm0qzgoVOeK0rpqUy/6trMRdVB/+cgVGhL0
         8XuEpsEyIsF+3JOFr/Zewz43DJG6NYBmbPdVnqAj/B9LgiEukIVhBeafPDP5dWhZGc9K
         OaNitQsMaI2hAphHsQIDkRLcJdTo/rHDHy4sroN5YDeGjLpeo+HN4Uw0Qnu0rgEj/0b5
         PMAA==
X-Gm-Message-State: AOAM533w1fkRz0FlNFIlc3LZoYbnrVRpiWqzCJCFnx42NlwYNRjSevYE
        S3IKciQHlEcLrl3juRActB0J5Q==
X-Google-Smtp-Source: ABdhPJzBdc/sHqoL7CJFXE8mAC4IndrGbD4Eg+ATHS/EnjLfbECtxnsCG0vmYHmtml3I1vQ9G5hqsQ==
X-Received: by 2002:a17:90a:ce0d:: with SMTP id f13mr15578491pju.85.1617402568895;
        Fri, 02 Apr 2021 15:29:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c58:fab2:c5e2:f2d7])
        by smtp.gmail.com with ESMTPSA id t16sm9233094pfc.204.2021.04.02.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:29:28 -0700 (PDT)
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
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] drm/bridge: ti-sn65dsi86: Simplify refclk handling
Date:   Fri,  2 Apr 2021 15:28:36 -0700
Message-Id: <20210402152701.v3.2.Ic9c04f960190faad5290738b2a35d73661862735@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210402222846.2461042-1-dianders@chromium.org>
References: <20210402222846.2461042-1-dianders@chromium.org>
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
2.31.0.208.g409f899ff0-goog

