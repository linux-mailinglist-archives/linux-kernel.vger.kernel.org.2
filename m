Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9913362B7C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhDPWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhDPWle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC94C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so7039565pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0QEnKfzihSwkUCUDGgWB7m6oBMdGB/Jg6G+CQJIJ/k=;
        b=BJEXFVrJglXTtCKWO5BcKDAJ8HiyFKWqH+mvRCmMjCmnkd3DLzlWhTn1fdIg5HQv3S
         3Gql/hN0ZaLFfrfDU/TNvKV68ACKKuWZz2aooKWej1qeZNp5/NZar2/du0JSb+CBRiAk
         G6z9GF+1B8SzhuORPXDFry43kuky8nLzbIT2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0QEnKfzihSwkUCUDGgWB7m6oBMdGB/Jg6G+CQJIJ/k=;
        b=n6r73f3RaAuF/jORghzL849Kj5KkRniCm2yWKboSrUn5lNt2iEXr1hSH5XGoL8lxvr
         0hXl4Fr9T4VcG1WC/km/kHPm4/pvZlITp129V/T52CNivCEnCWAe2srb6jdrQ/kCrTH+
         XLYLi5nQ0nuvu7PiO3VYe5Xhp+9qNoCFbz4PV7Dm5GY1YTmfAGY4rCWiCVIsyD06qa72
         /sapBhJx8GFHKO637yUYAFVNF4Uyru7mbNVAHBpGJv4cYuUJv2g77wdGQwgpxR9iGRSm
         R+R4zp6sqoL60BL1bY/4Pgor8DoiZnWXFr4RaTwjkHTG77XLlKR/ONAZ5gMPwTI0pMZ3
         OoFQ==
X-Gm-Message-State: AOAM532PaeWdHVnvImPVqLzfsN7ApgKFB2tEvRrbtx1k/OJ3AEvgkMkq
        uKz5ArMSt+oxt8+pVkm2zriqqg==
X-Google-Smtp-Source: ABdhPJxVcP4GeB0Q80asqybNMgUJp0GMle4/sAyPnAkbN5/yDiouXth2EZvymAtPSU+eTKLwJl/oew==
X-Received: by 2002:a17:90a:4381:: with SMTP id r1mr12486696pjg.214.1618612868578;
        Fri, 16 Apr 2021 15:41:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:08 -0700 (PDT)
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
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/27] drm/bridge: ti-sn65dsi86: Move all the chip-related init to the start
Date:   Fri, 16 Apr 2021 15:39:37 -0700
Message-Id: <20210416153909.v4.14.Ide8ba40feb2e43bc98a11edbb08d696d62dcd83e@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just code motion of the probe routine to move all the things
that are for the "whole chip" (instead of the GPIO parts or the
MIPI-to-eDP parts) together at the start of probe. This is in
preparation for breaking the driver into sub-drivers.

Since we're using devm for all of the "whole chip" stuff this is
actually quite easy now.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 53f1f7b3022f..57bc489a0412 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1253,12 +1253,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 		return PTR_ERR(pdata->regmap);
 	}
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &pdata->panel, NULL);
-	if (ret) {
-		DRM_ERROR("could not find any panel node\n");
-		return ret;
-	}
-
 	pdata->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(pdata->enable_gpio)) {
 		DRM_ERROR("failed to get enable gpio from DT\n");
@@ -1266,8 +1260,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ti_sn_bridge_parse_lanes(pdata, dev->of_node);
-
 	ret = ti_sn65dsi86_parse_regulators(pdata);
 	if (ret) {
 		DRM_ERROR("failed to parse regulators\n");
@@ -1278,12 +1270,22 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 	if (IS_ERR(pdata->refclk))
 		return PTR_ERR(pdata->refclk);
 
-	ret = ti_sn_bridge_parse_dsi_host(pdata);
+	pm_runtime_enable(dev);
+	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_runtime_disable, dev);
 	if (ret)
 		return ret;
 
-	pm_runtime_enable(dev);
-	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_runtime_disable, dev);
+	ti_sn65dsi86_debugfs_init(pdata);
+
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &pdata->panel, NULL);
+	if (ret) {
+		DRM_ERROR("could not find any panel node\n");
+		return ret;
+	}
+
+	ti_sn_bridge_parse_lanes(pdata, dev->of_node);
+
+	ret = ti_sn_bridge_parse_dsi_host(pdata);
 	if (ret)
 		return ret;
 
@@ -1301,8 +1303,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 
 	drm_bridge_add(&pdata->bridge);
 
-	ti_sn65dsi86_debugfs_init(pdata);
-
 	return 0;
 }
 
-- 
2.31.1.368.gbe11c130af-goog

