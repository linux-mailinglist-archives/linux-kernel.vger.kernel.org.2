Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2F3622F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbhDPOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244497AbhDPOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9280EC06134E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd23so33835238ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrproNEUMCgSjmh/8B0I/rNyBQoaOU4LantvG8VttuY=;
        b=AbhwF2o8lWGjI+FDsAThxXdYjTFw6ntHJ+FjLaceNvJgOS2Y7pl+JkE3/1i576V58B
         YvDUmpqhZuyg4ON7XYVatcqM580H8JN3lJS9HLyvlLYjuXBs5xAjEta/3co9QOEIr43v
         XLrqP7juFl6LHY7r+NdZVb0uIbH4dibSpJu6wGgmMky1EuVOjhAXtvsFFHpR0y46mchQ
         rNSYZwaCr8ePffvLwn7sdYpMKrD+vBBEloIRYGDJwzMvm6Upd6Mr0PlQYUiNkmTcHqFp
         eVdmSNrJHUvjzz7h9vB9PlsqKdu6rTezQq6HeQ7z78UZtM0LGOPupSB1p9WxIUVHznWW
         Y/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrproNEUMCgSjmh/8B0I/rNyBQoaOU4LantvG8VttuY=;
        b=q/0lVzvOoRoKdSe1kPR83SBxKBo3d2ElUTQw0+Z52vlGjV5iU1jrGbn2wRLw7GB15D
         cP91mU2G+G8RjZFdMiu7S0ve+60koo+TrvheKlgpcOa6WjPmgOof/Y8n6B8IpCuxqjyb
         tDnpB60d3gXK9dgLd/ndEixNgFJl0rJHy5aNJ0sOjSKp5p4IhwOzVn1OcQmj4MFupVPU
         WWvRWr1gVw7ffeQvJIVhMZlDMbX+l6mQ8Wj/rh2sbylIoeKoqDueWvjTaBkuCN2Nv85o
         hT6PSmceUlgzNznP0w2MIpwak3LALXRAi0YzirRUT/baOls4BiYp2p9lUhdtVHZfYdig
         cD1A==
X-Gm-Message-State: AOAM5307FL79CvgOQReXcpzePIrjJxxHkxxTm7HbOgWSrdz/Xi3lQvxO
        v6Uc+72IxM1wN5FHKvZo868oHA==
X-Google-Smtp-Source: ABdhPJxRohIyR/YCoUD5YI/XkzLdyuPidmXlmk0d8AmwuQ7/5UcOVVluw10vUFCBA6T3eZAmMx7dlA==
X-Received: by 2002:a17:906:dbcd:: with SMTP id yc13mr8165471ejb.99.1618583888233;
        Fri, 16 Apr 2021 07:38:08 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Akshu Agarwal <akshua@gmail.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 36/40] drm/exynos/exynos7_drm_decon: Realign function name with its header
Date:   Fri, 16 Apr 2021 15:37:21 +0100
Message-Id: <20210416143725.2769053-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos7_drm_decon.c:355: warning: expecting prototype for shadow_protect_win(). Prototype was for decon_shadow_protect_win() instead

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Akshu Agarwal <akshua@gmail.com>
Cc: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 431c5d32f9a47..9b5e6f94e5585 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -344,7 +344,7 @@ static void decon_win_set_colkey(struct decon_context *ctx, unsigned int win)
 }
 
 /**
- * shadow_protect_win() - disable updating values from shadow registers at vsync
+ * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
  *
  * @ctx: display and enhancement controller context
  * @win: window to protect registers for
-- 
2.27.0

