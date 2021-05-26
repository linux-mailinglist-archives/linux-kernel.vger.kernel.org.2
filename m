Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8C13912F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhEZIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhEZItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A85C061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so2933956wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4QyaYMBoYLFq2bECv9NcJDq+15DdDgMC7JcY/MSiHQ=;
        b=fXxjutAewkRO+ZLRFdPFIkDYQiq3FT1tAjQZAeRDdOi4gzVrCmRz0EfHowF5wmGIU9
         76vEzlODufv7/xzX4bFcjjaMBHWtnsp2o7aAGyOFJ7MydqdwBDVUs/dLiJTM3EtuT8Em
         nCwY5anBY4yFKKFiGHIQ9c3tybiUDbB/7KSUXRf2hhUT6fuzjMgqPvpLKUdwhnU3RJT2
         UIYYzMdHkXpCOU3/HF600gA0TktxLAoTIs5uifm8CpVMWcIDlV1SHWjVczPC3CLkGneU
         bWE8SoL5WsEyX7ERCKdOySnTVc4ZibSovBC0Ww3mEgyzqxw5IE//bQNsh+Am+8zkHAp6
         Wygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4QyaYMBoYLFq2bECv9NcJDq+15DdDgMC7JcY/MSiHQ=;
        b=UyjZ8BBjp/b7tbVgVg5zyEDYjCHVI8E93weW+yiTLmbQrmOQnbGj5vWV1TH5d0C4Xl
         dTes171O5eajAzq8+3dn6aEi35egDAp37yrKcnlBO+fBNn9phccLZTMK4cqh2+utczIO
         QpdJEiVHtYGdZ3f5nAZFoLxjv9MbKqwZJUDPHpEZEszV5YPGxnwtIhX3ym9fkJkK2zde
         lNGLv5eEjJZWnHJPQk4r2GN0fMTowT/FSnbByyqzzr2Ij8PUDyWX3iapBdH+l9aN6HCT
         b1gNc1rwiQLjkGTgRxLhJ6H2AhfzpB/DD8ib7Zs3MHpL5bl+4tUDAPwg2ZrnQ2x9aPqR
         t0tg==
X-Gm-Message-State: AOAM533+hwNEwpwRz9V5NJ/pb0WfbcP0mszsQcItPEjWx7sYn6iICzR+
        QYQePSVgiL19fkHZonJNOid+79QR69Hzsw==
X-Google-Smtp-Source: ABdhPJz0R2q9qd/5Z7jEN9eSA7NhHE1G25V1HtYeDCHeYnc83zadalbGt3yZ6CpynG6ngnVoAJwk4w==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr2225001wmi.75.1622018878547;
        Wed, 26 May 2021 01:47:58 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/34] drm/ttm/ttm_tt: Demote non-conformant kernel-doc header
Date:   Wed, 26 May 2021 09:47:19 +0100
Message-Id: <20210526084726.552052-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_tt.c:398: warning: Function parameter or member 'num_pages' not described in 'ttm_tt_mgr_init'
 drivers/gpu/drm/ttm/ttm_tt.c:398: warning: Function parameter or member 'num_dma32_pages' not described in 'ttm_tt_mgr_init'

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 539e0232cb3b4..682c840c9a517 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -415,7 +415,7 @@ DEFINE_SHOW_ATTRIBUTE(ttm_tt_debugfs_shrink);
 #endif
 
 
-/**
+/*
  * ttm_tt_mgr_init - register with the MM shrinker
  *
  * Register with the MM shrinker for swapping out BOs.
-- 
2.31.1

