Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3D3F0A05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhHRROH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHRROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:14:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6ACC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:13:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so4611988wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFid9F2eF9PqNhKCggNJ7cYgvwbKXWCYKt0nUIUymOs=;
        b=GsvHQgpjaESYG5gtGcBAchUblwDnGBfCRa1Cbq88bnebOKDVZfNI47a7t8YHzfwXR0
         Wg6/E8zJEbHXHlBrKwmkoHSuKaof9B2CRhFCK0Y6FxL52+93tX0E0kCuVKSzTQXsOx3L
         VADza4/83gBW+6u12EezFkqO52Ms5vQWwwdrsPKMbb/Tdaj06pMLwUOcdpk/CSEHMVR0
         96PJ7L8+C3Knj82Xe7M4sVheHmHPjLn9tKND+G+STUu5ldE+650SpMm1t8HVAq/2MsKj
         Cxg1CUB4JG4OQwd6DzbvOosCxQAHzhuGKveOvF1noiFegFOaRoci9wlJDEgkZ000qc8A
         91KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFid9F2eF9PqNhKCggNJ7cYgvwbKXWCYKt0nUIUymOs=;
        b=jodpbz/3UQ3TGnrq2V5sOWuYEh9cyiUa+8E6XSYVJjTXMIjuJfc6ewaxhUV0OG+qD4
         7rpAkENnpKuReLuAQ/ZZ7ASm3y86Ue5Qyw3zds+iF/VvLRu/ISEZ7tj7UCHEOFPTDUHh
         uiA6YnjyrbD3d1jFFXzyuGSxnqX0lhEPnKMrRm6bTFBj8ugF9HoqkKNnPaMPMRZ2LJi8
         vYB/6Rq6yKb1C0cY9s+aNzUUYgNF/tqmsQz7d0Jh7qBoX8dvnVgmIcHNxgoCqPfzL0pG
         K4UZ8ZtJYK4sGjkL61Lr/KHyTa1cHnJW6+4umPxvw1s0yInkYuPcFqE/BkGfKXZjo6cM
         gI/w==
X-Gm-Message-State: AOAM530CyjENIoGIWohheSa8CRnXdhZ37wygk51vyUwcbGMlL5SZVtPG
        z+6MOdi+5PDejAqlbkvcq8pevA==
X-Google-Smtp-Source: ABdhPJxsRm2aT7e0rJVvWLb69hw4XoiBF8vUB/N+VxbBSZLj5e9PY8ThTjzFgyOW1rlRG9p9PCalKA==
X-Received: by 2002:a5d:67c6:: with SMTP id n6mr12007908wrw.150.1629306805112;
        Wed, 18 Aug 2021 10:13:25 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:a470:eb9f:53a5:20f8])
        by smtp.gmail.com with ESMTPSA id p3sm414825wrr.21.2021.08.18.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:13:24 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, xji@analogixsemi.com, pihsun@chromium.org,
        tzungbi@google.com, sam@ravnborg.org, hsinyi@chromium.org,
        drinkcat@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()
Date:   Wed, 18 Aug 2021 19:13:17 +0200
Message-Id: <20210818171318.1848272-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of sp_tx_rst_aux() is not propagated, which means
both compiler warnings and potential errors not being handled.

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

Changes since v1:
 - Instead of discarding the error, propagate it until it
   is handled properly

 drivers/gpu/drm/bridge/analogix/anx7625.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 14d73fb1dd15b..ea414cd349b5c 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -720,7 +720,7 @@ static int edid_read(struct anx7625_data *ctx,
 		ret = sp_tx_aux_rd(ctx, 0xf1);
 
 		if (ret) {
-			sp_tx_rst_aux(ctx);
+			ret = sp_tx_rst_aux(ctx);
 			DRM_DEV_DEBUG_DRIVER(dev, "edid read fail, reset!\n");
 		} else {
 			ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
@@ -735,7 +735,7 @@ static int edid_read(struct anx7625_data *ctx,
 	if (cnt > EDID_TRY_CNT)
 		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int segments_edid_read(struct anx7625_data *ctx,
@@ -785,7 +785,7 @@ static int segments_edid_read(struct anx7625_data *ctx,
 	if (cnt > EDID_TRY_CNT)
 		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int sp_tx_edid_read(struct anx7625_data *ctx,
@@ -887,7 +887,11 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 	}
 
 	/* Reset aux channel */
-	sp_tx_rst_aux(ctx);
+	ret = sp_tx_rst_aux(ctx);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "Failed to reset aux channel!\n");
+		return ret;
+	}
 
 	return (blocks_num + 1);
 }
-- 
2.30.2

