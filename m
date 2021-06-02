Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22663398D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFBOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:37:05 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53185 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhFBOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:18 -0400
Received: by mail-wm1-f48.google.com with SMTP id f17so1451755wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxy5VbUuJktWYoN5f56DsShh05RPtQyulwCzQanfG8c=;
        b=x+eowQOPBexKc0gjdhN++Ps5HQm+5bGTLWuF+UQ6C3gZgripNSo2eBrgQ4v/c7P3B/
         +E+x9qPTRf1nF0Ab63hAIQpqRfG45A67ClrHAnxEyX++oCDb5wVHYSAMDWqmCuaLdRWO
         DCEMoQS1tVfwxxlCAGr6k3nOzuwIwMxs4A/rucgb9RFiQkVR9VibqzKVMKuXuIuj5HgF
         rij0SkVqrI3igYoqn331Lrve+WQ/wsDp1xY5XiCL2+NuGoTui+tN/YSZu3gsU5AlAJcI
         GTWDQ+WlcukducWQBP3VHgu0bmDqVX/nmeDicehdPudN1uXapqOWz+qTWnXKjnRz2Es8
         mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxy5VbUuJktWYoN5f56DsShh05RPtQyulwCzQanfG8c=;
        b=DF2VA0Y3y3RaHYDd5EdhuS/xucFmSmgYkp/8UhFiYvTHtvo4zvfX23t4Bo1xyMwZzr
         ZkJ4B/6KfaIJzVChUs1wERzPwbNJx24wvfVnqTgRZCS6ySGZrhq/dznm7AkKZrmx2epx
         eQAM0WEzxJL8SnkF5fH5Yntjhk5TqYLoy01/EOD30YVyObdxOj1p1UA+cGpw+JScfeD+
         O2e8IVV0keg2FkgAvPihzMimTgxz9fVEUfghD9oB8k4gU2wUKuXTuDQQwYdY8HqtQ3+L
         cRt5eMhJ2y4hCEfLZRGdMpJx+7KK0cZ4wUGhd3Myb2H2Zn/hv/r3THv7NSAvcKGXMS+B
         ahNg==
X-Gm-Message-State: AOAM532cWWqRZvRuMzFyK+mrjUPjGzZCTHv8E5PfFFe1fCm0pLUetZUq
        MZMsAZbHQVxUP4WFNevuh/+nbQ==
X-Google-Smtp-Source: ABdhPJx+xBu1BihQ5vQP4ImfnxY1U8nE9Hks2Zw/N4egBmVyT9aUFGosvKogM2eahWcVW20UK7GNQw==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr5534912wmh.69.1622644414673;
        Wed, 02 Jun 2021 07:33:34 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:34 -0700 (PDT)
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
Subject: [RESEND 24/26] drm/exynos/exynos_drm_ipp: Fix documentation for 'exynos_drm_ipp_get_{caps,res}_ioctl()'
Date:   Wed,  2 Jun 2021 15:32:58 +0100
Message-Id: <20210602143300.2330146-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

