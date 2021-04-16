Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D93622E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbhDPOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbhDPOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E694C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r9so42483609ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77KORMvjycuosDmjlDlE5rkJsrZos9ee6jXmEuSJFYU=;
        b=HPaBNGTBopwSRGzFIlqBdzxoh9v8tKGDodE6bsGoO8t2VUZO/SxuVnkNG9JnqDCbGE
         VojMx5Hv47p3/y6Fyv1MNHvDV1eia1HKQeYArX0WlBkzBrPbItLWOuFSWHI1owP5l9CM
         MvLa8jw5+ntXAixaJz9MmS0dkOZwTx0+4fVEZm6lf6/KvCWrYnuLJbxRg24OtYcK7tZS
         8SNXAB5bWdX7zoJW/Xi9x78O8THiDfx0uRWPY78zqAFoYUxtFgJS693oKm5Gb5xlJK8T
         tKU0/X1g2YCb6T9AqWYqwzFuHDR6wNLFSipYp2GwbyW/LTk6ppVhcUDNE5pkfSVYW6B2
         ZrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77KORMvjycuosDmjlDlE5rkJsrZos9ee6jXmEuSJFYU=;
        b=ktyb3NFHKZt5XTI8og+/BWjFymSciCbYGx2ekxmeQQS9Xc39bAH7+Zn+2bxUNuVjmj
         Yw8T6KpsNH8XT8NmeGJ3JT8pNE8GdH0hUnQbtfwvC5Ud6mIKnntjrD3S0ocfixMWR/Z7
         h62U9MPm/G+oIlsDveqRsM0k5ekTeXKdlAuRsKkzb0YIaCFpdB87DY5bvJOGmnB79Kpy
         V5s3d8RZUFo/7wQTmUXTnS6jIeiuHqiiWxwcyqCUuXh6AL2Qu8NjojCEqdNuR4qFRv9n
         nOGwADrzjQJdKdn0qtSx9iIGP01OAekgwfYA6j0APT75XgDbV2TGux6M/1zjUxjGARk4
         UQ+Q==
X-Gm-Message-State: AOAM5320daE/bi92t1bue22r3kMAeZpFCsUPTvPWVQhi6Nqi9+T3XXkz
        IYIf1AXok/p+MmTTLZLc4fdt6nXKoIDE5Q==
X-Google-Smtp-Source: ABdhPJzqQgFU7n08Qr/b5rOK9sbCAd1su0qR5zRs5qHTAnyG7RJlaa/5uaHYH3FzGTjDbsEGgdGDcw==
X-Received: by 2002:a17:906:94d2:: with SMTP id d18mr8641752ejy.531.1618583869107;
        Fri, 16 Apr 2021 07:37:49 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tomi Valkeinen <tomba@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <rob.clark@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/40] drm/omapdrm/omap_irq: Fix a couple of incorrectly documented functions
Date:   Fri, 16 Apr 2021 15:37:03 +0100
Message-Id: <20210416143725.2769053-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/omapdrm/omap_irq.c:114: warning: expecting prototype for enable_vblank(). Prototype was for omap_irq_enable_vblank() instead
 drivers/gpu/drm/omapdrm/omap_irq.c:140: warning: expecting prototype for disable_vblank(). Prototype was for omap_irq_disable_vblank() instead

Cc: Tomi Valkeinen <tomba@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/omapdrm/omap_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 15148d4b35b57..dff095c864909 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -99,7 +99,7 @@ int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
 }
 
 /**
- * enable_vblank - enable vblank interrupt events
+ * omap_irq_enable_vblank - enable vblank interrupt events
  * @crtc: DRM CRTC
  *
  * Enable vblank interrupts for @crtc.  If the device doesn't have
@@ -129,7 +129,7 @@ int omap_irq_enable_vblank(struct drm_crtc *crtc)
 }
 
 /**
- * disable_vblank - disable vblank interrupt events
+ * omap_irq_disable_vblank - disable vblank interrupt events
  * @crtc: DRM CRTC
  *
  * Disable vblank interrupts for @crtc.  If the device doesn't have
-- 
2.27.0

