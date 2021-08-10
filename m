Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8986D3D9374
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhG1Qqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhG1Qq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:46:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m1so6066211pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+64vU1qKaQt4H6y0jZvJKOI9CTWrL576JKYHnv+P58=;
        b=Cj6Z5k6TbxD2x9dIUzq5VLOSItV5NUhbE32Hew4oiMroHjqzqpsn9Q3OrMqx00NRpL
         FHOzjt8EPIj5vKnMCwPP7QmZ1hZu42xkmm9bjUlaAgxtGtGaZ/UObb1c6Z5Ki5FVheBf
         uGKzLxl5ZVcfQKnfp4lcSKrqaXbb7VzOx+Ec4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+64vU1qKaQt4H6y0jZvJKOI9CTWrL576JKYHnv+P58=;
        b=KQROCxjld/tsGPpHl3aBr4/VZtVMh68EY6Ky4DZ5Pi9QAZII/uh5/gnk3pM5zaaLFc
         xeIgtSJZbZec1VSAqWkH4hCCB8pWyAaBTQ++skYjcyMNKxrIPeEI2Hb0NOUBkyxJlEIB
         QngFdGTvXVf+MeHg2TBet33YW0N4gFIlpY/WynA73Pzpns4cz9VpjOIrm/eIT+5zgid7
         PEB0glRUJdanCZO659Epgx/HswncrM/Jf4yV4F8yddn73PcLRh/vVsaw5KC0NocDbUFY
         BBQ9MahJlNPbiH9aR5OqEM1KEvWV/iexAUX2deLlWj+nEL/ovtFZnxg/GaVojGoF3GVc
         /qKA==
X-Gm-Message-State: AOAM531+vT4nx+rc4FUZpHjawOv8zzXlCz90lKQCw4tLQakw3VLUlBAT
        Ye1vW3m45ORlm755v7q/vxnuVg==
X-Google-Smtp-Source: ABdhPJxWFqYtDvnJJgoUgNEvupJRcl6FnSGf7LmlHKsxRxSnzigsEFmlt+KzkZI7qZszb9FiqXJYjg==
X-Received: by 2002:a17:902:8ec6:b029:12b:ab33:15d4 with SMTP id x6-20020a1709028ec6b029012bab3315d4mr515472plo.80.1627490786102;
        Wed, 28 Jul 2021 09:46:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:9f1e:e713:1a5e:89dc])
        by smtp.gmail.com with ESMTPSA id l12sm474075pff.182.2021.07.28.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:46:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, linux-arm-msm@vger.kernel.org,
        a.hajda@samsung.com, sam@ravnborg.org, airlied@linux.ie,
        bjorn.andersson@linaro.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, rodrigo.vivi@intel.com,
        jonas@kwiboo.se, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, robert.foss@linaro.org,
        jernej.skrabec@gmail.com, mripard@kernel.org,
        linus.walleij@linaro.org, maarten.lankhorst@linux.intel.com,
        rajeevny@codeaurora.org, lyude@redhat.com,
        thierry.reding@gmail.com, steev@kali.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drm/dp: Don't zero PWMGEN_BIT_COUNT when driver_pwm_freq_hz not specified
Date:   Wed, 28 Jul 2021 09:45:52 -0700
Message-Id: <20210728094511.1.If017efce7116ae8ba015ed7def840c390a0e0c77@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210728164557.1882787-1-dianders@chromium.org>
References: <20210728164557.1882787-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function drm_edp_backlight_init() is defined such that the
"driver_pwm_freq_hz" parameter is optional--it's 0 if you don't want
to futz with it. If you follow this variable through, you'll find out
that if it's 0 we won't ever set the "bl->pwmgen_bit_count", leaving
it as 0.

That means that before using it in drm_edp_backlight_enable() we need
to check to see if it's non-zero.

Programming this field to zero was confusing the panel I tested with
(Samsung ATNA33XC20). The backlight still worked somewhat but the
brightness values didn't correspond to what they should have been.

Fixes: 867cf9cd73c3 ("drm/dp: Extract i915's eDP backlight code into DRM helpers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_dp_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index b5f75ca05774..b8a5c5e49d74 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -3229,10 +3229,12 @@ int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct drm_edp_backli
 		new_dpcd_buf &= ~DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
 		new_dpcd_buf |= DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD;
 
-		ret = drm_dp_dpcd_writeb(aux, DP_EDP_PWMGEN_BIT_COUNT, bl->pwmgen_bit_count);
-		if (ret != 1)
-			drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux pwmgen bit count: %d\n",
-				    aux->name, ret);
+		if (bl->pwmgen_bit_count) {
+			ret = drm_dp_dpcd_writeb(aux, DP_EDP_PWMGEN_BIT_COUNT, bl->pwmgen_bit_count);
+			if (ret != 1)
+				drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux pwmgen bit count: %d\n",
+					aux->name, ret);
+		}
 	}
 
 	if (bl->pwm_freq_pre_divider) {
-- 
2.32.0.432.gabb21c7263-goog

