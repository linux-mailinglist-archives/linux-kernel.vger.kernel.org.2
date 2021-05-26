Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6846E3912FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhEZIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhEZItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAECC061348
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so2934120wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxy5VbUuJktWYoN5f56DsShh05RPtQyulwCzQanfG8c=;
        b=xiOe4mFhni6btU7/RAd8kfv+LqfSWalgP3f2ZIm7Rb3ksXK76sewdnNshZe2TuZOhI
         h3ytakn2HgyVRlYV+T6oSaydAt2VFLbS/m49aMBA6B0oIMfbijvQ6yy+x4zezyZrBUa9
         9aUt5xFjzyxuKLDmk6Xk/y0H8zreqHKRNE3A70BZEWwd7IOl00RUJeONgRUPgHmSGh4l
         6FZxtMzbNVYuD2HXHpnjVE33NcykFKLcH1GpeMaF8Y8csrykvsi0JYhlIJjGRVoZqSUX
         ZExAQbIG7mdvtFNOqF15xbWWKTSGIEs04nP4x33eRc8L7L2mrh97/SOCcNcFUgV8Wx8M
         N1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxy5VbUuJktWYoN5f56DsShh05RPtQyulwCzQanfG8c=;
        b=guolP//oI5OAxz5ixgSL77h7X/A7h26EIXRIDpB96aU8tW3O+qklO+DFN6lWG+B0Zf
         N+sW0YDBT/aNCcxMi9KirDVrBcupg75SmVbzSJKxg0sBmmFeAcuVlgvK8ST7OXWRqJiH
         K1HhMAYmMNh1UTm2bffj3EMraLKvlRgdKgWdoljCAUXMrB9m3qnj8FNXox8EmS7Y7/xd
         kshVxhOykrAcSg12s6cNMryj/YZXhj3Bs+jiY1lkCUEBlwqE3yjNfFTq/hnZeGbrFfWy
         vAxhExhe/pLErJkHgdZoU/KomdYzD639uHzrEkBzpqvlMtbZtZns4tel4cFy/wQEE17F
         XTtw==
X-Gm-Message-State: AOAM530idUlthkhUmZCbAbJj/WUb/8yNFXtpRUqvy4aVZedN7imWicp2
        rSGTCiBcxAev5OqVddKF9hvp7A==
X-Google-Smtp-Source: ABdhPJwGH9LW1zlxMLp6/VgecZDFwPNMjdT5Q6ofmkGzeRbpsGwG9WIb3mzgYLBGcw+4227c0C/4pw==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr2334263wmq.9.1622018885095;
        Wed, 26 May 2021 01:48:05 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:48:04 -0700 (PDT)
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
Subject: [PATCH 32/34] drm/exynos/exynos_drm_ipp: Fix documentation for 'exynos_drm_ipp_get_{caps,res}_ioctl()'
Date:   Wed, 26 May 2021 09:47:24 +0100
Message-Id: <20210526084726.552052-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
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
2.31.1

