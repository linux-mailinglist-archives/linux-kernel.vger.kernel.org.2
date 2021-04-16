Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E33622F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbhDPOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244314AbhDPOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896DC061358
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so42522412ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41LgwOuoq22rGgsCktNaBese4amMVfNYLTWP6zyN98Q=;
        b=SdxKlv+fNXg5L8kGoNDlYldYsqKcpPLAo7SNh4UKeExvT+lzMSwwhYTQgAkyNW9XV1
         63a1JDzirzFBEbKuUKIuNOxi9MSJjlGxn4M3fV3HctPcinrNVovY6FlDNzSTVZ92KF+o
         XIk3NOOnT5B91RxZoU8MtBX+p3GuXccPlgOW5xfBBnG3UrYm0xApChnqyq6w3iu3Oe9j
         lE1286wLw82FuzX9IBZjoe3AXA+PeNjmQTiulNd5wH2OOPghylJzXQcb1Xu6CSnNgEHC
         dsZisdfzr5StyHwyG5CNaHmFfL+M9iwvAx32Z/rwAWgZDEmk+ytaEasqOsL58RLMkWX3
         zsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41LgwOuoq22rGgsCktNaBese4amMVfNYLTWP6zyN98Q=;
        b=Pk9BgW5UHfkLnZRbGXjcDR+0lNhQrNKBuvCvKvqiWV5+eNunEop/G3Pwqh7wG0jxDF
         doUPPOoyIQdh2ENtQZDSyw8AunkGyCYr+GJN15xQbwDurcHn4qwSi3mXCfbaJDv8lWA/
         3FN5O/AxQWGCj5+SV5SyaynVlr1TxgGTSUXPiPEnF8VxfQOaHxwMVhG6dUwu+9Wgg55d
         9ttTaCJNDBnFS5czaRFOq7BwXx+OiJCexAMzOadkzYHN7WfOUWA5GE6Usp9pA0tuDf5M
         YrWvdepxJ5l+7f9pJRnBf0imrSoSKk8IFH4uuRlcK0hIF7r0NLGmttxYj2l2DtX4q9VP
         +ipw==
X-Gm-Message-State: AOAM530WhyoLjTjS6+uQkgeid/syisIr/lc2BlzJOE6VDGmcKkf2JdAh
        SbOPfuXm1OhB9grDgxnegC6oRw==
X-Google-Smtp-Source: ABdhPJxvfI/125JkkMmqblbXT2TRLpBJYLh7O+FA3oUYUCfjmPOCcTm/RwOmqUq72nMdaj0sKo9gcg==
X-Received: by 2002:a17:906:b52:: with SMTP id v18mr8565368ejg.485.1618583890433;
        Fri, 16 Apr 2021 07:38:10 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 38/40] drm/exynos/exynos_drm_ipp: Fix some function name disparity issues
Date:   Fri, 16 Apr 2021 15:37:23 +0100
Message-Id: <20210416143725.2769053-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos_drm_ipp.c:105: warning: expecting prototype for exynos_drm_ipp_ioctl_get_res_ioctl(). Prototype was for exynos_drm_ipp_get_res_ioctl() instead
 drivers/gpu/drm/exynos/exynos_drm_ipp.c:153: warning: expecting prototype for exynos_drm_ipp_ioctl_get_caps(). Prototype was for exynos_drm_ipp_get_caps_ioctl() instead

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 4f2b7551b2515..9ae8689353579 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -88,7 +88,7 @@ void exynos_drm_ipp_unregister(struct device *dev,
 }
 
 /**
- * exynos_drm_ipp_ioctl_get_res_ioctl - enumerate all ipp modules
+ * exynos_drm_ipp_get_res_ioctl - enumerate all ipp modules
  * @dev: DRM device
  * @data: ioctl data
  * @file_priv: DRM file info
@@ -136,7 +136,7 @@ static inline struct exynos_drm_ipp *__ipp_get(uint32_t id)
 }
 
 /**
- * exynos_drm_ipp_ioctl_get_caps - get ipp module capabilities and formats
+ * exynos_drm_ipp_get_caps_ioctl - get ipp module capabilities and formats
  * @dev: DRM device
  * @data: ioctl data
  * @file_priv: DRM file info
-- 
2.27.0

