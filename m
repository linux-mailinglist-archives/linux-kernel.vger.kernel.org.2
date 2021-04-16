Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED83622E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbhDPOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbhDPOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A84C061344
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx20so31418700edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nA+2lokIo5+ShZDBy9HyhfN8ugkVVJ0D8A+fjT6S/o=;
        b=JT+qwWdcusOALmrf7ZLdMUE2NBydZv8PujbzUpgvw3/DUohzJA+x2wlYAeJAoFG5rM
         rMkYK7DHWY1dlwMI6ot5f+Auf1YMrEF6RlZPeTFoWdNaIfQhXlq5UkxQq/Fv/Ljf2ybi
         s/XEi1+IVlW3YJwBO6sgSD6pCGOqE9H35Xk4fXmQyLF4bsVolmGBL4CKd3oW2G+BJJaS
         mK0C+22qN43AXEx4JBIcs8Mnk/pvpU9PA4//UQvXIECQv4BPNHcLv8B8GAHuy6+hIMlH
         l2/NrhYhJqiDC7a/N2dSCognVIg0Cf1IxtaTkXtEQl+OlYLudwNpMxofszyIjhqfbq6D
         UwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nA+2lokIo5+ShZDBy9HyhfN8ugkVVJ0D8A+fjT6S/o=;
        b=lMTcumpxWyfuDhWB8VwdjnKc/yTcmY7tqke0bYgcGoglj06LmsvUVbxsNJ0gqBc9bp
         xP2pus5BawEBqh6IX7NBM21TTJ/EVcv7gVALbSYAEv+5Fd6D8lMhvLPTEp94SshwiLOC
         NO0+vfFmi38X4xXBYw1Gcy1+2SAJm/gSDMNja/USHwcwUwA4NlZ1otDcERv6b+KNFDrX
         +wXVCjSvyTTQaMqzB0dgq3JXyrwBfsTLupJtOrmlFS/FRpVrzwKWsBTmADmATnYDikMA
         y0MChpc3B2MaEdp4JyMxRW5IEe6pRjFlki6xbKZidD57cKpWos7HbnMCj7FMhbRvkcgq
         +YCA==
X-Gm-Message-State: AOAM531pFlad7Y6eknf/2q/Fq56Gs2+tcR/y0epxBAVgOMXqC+0GN0KS
        IRLf0yaoxMYNkwUL4NYRLwG7hQ==
X-Google-Smtp-Source: ABdhPJyC14vYUXyqy/t+TqjEGM4ZhoCO42QZ4CqVlCScrkxs6PVqHnQ1Pzc5N+W97cANt3cO8Uu1Gw==
X-Received: by 2002:aa7:d046:: with SMTP id n6mr9118370edo.357.1618583873184;
        Fri, 16 Apr 2021 07:37:53 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/40] drm/ttm/ttm_tt: Demote non-conformant kernel-doc header
Date:   Fri, 16 Apr 2021 15:37:07 +0100
Message-Id: <20210416143725.2769053-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
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
index 7dcd3fb694956..d939c3bde2fcf 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -389,7 +389,7 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
 	ttm->page_flags &= ~TTM_PAGE_FLAG_PRIV_POPULATED;
 }
 
-/**
+/*
  * ttm_tt_mgr_init - register with the MM shrinker
  *
  * Register with the MM shrinker for swapping out BOs.
-- 
2.27.0

