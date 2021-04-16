Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40C3622EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbhDPOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244613AbhDPOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A6BC06138A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f8so32557144edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZSAadoVwWWKS/0qwmdM9B0hG2udBsRl+ZNcX49QlvU=;
        b=nw2nOI9l6bUUJmtRby49O2JfdE9k1M4kUJc1s4RPv33ufbBEVEtxgscvAnToufcmDo
         RbVeTBFbe3K1OylmmnszhZ1sts9nOAjyQ6gQAQZWgdBZLy5/fAADEWhPmjg8Kb9pBDrt
         v4ajsDabD+SR+GdhKqXy8O+PVM9vzbs6COwHPxfWao+2YZNVqSBNb8KAKtMl8i3Yp9Fj
         utQpfV5J7eXNzA9EyqhqZ49g+0VzXGyRprORETslu3gZEaJCebXLpeii7FClbzLtrHfa
         bWETg/DXaJIFFqy6ADORLEp/MJfg71OENRKxzlW5QUtqlEKemuH3f0mjzQUqbicdf1vy
         wDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZSAadoVwWWKS/0qwmdM9B0hG2udBsRl+ZNcX49QlvU=;
        b=JKIovRYBuOBpR0MuY4gtsY1qD90H5aYWj3EFTxz5c+rYMEkPmuyN5VHGhAN5XFR1UF
         xn7bi/j/uyp3/HB53Uf8VcXDIqwHIRPs2/008xYTLex7usdk3AeMQOgu7avLZHjWFXHL
         DdRDUIAsel1lLVNQUk1Lg/EzHgS6GEKtXtgagE6gBZl5sOxKIIyu/CP++ivSj1Erd408
         Slx+V+KqalRXg/HrEDl33WrYXLlLExME2n3dZQGEUPjh2ixS+cZZmFhxIyuINptPCbG2
         Y/kIKyMRu7j01wVrTZscXhTkte9n7c0V+FOXTjSqg0a5NB0R8kk9gv0dUn+XACROcsSl
         XC2Q==
X-Gm-Message-State: AOAM530D24bN+B/LNKhhw22gDx2CI0aXCcAPZLJ5ea7DQXM+TIUtMVHg
        N64++hrZfnuksgwHxSs8c+pGBg==
X-Google-Smtp-Source: ABdhPJyaWCWNnk1gyPCzfGXwhwfCB5WDHs+D8lShvvSaWygeMRqZlvqxZLDhhzs5ZiOecIFpI4V1ww==
X-Received: by 2002:a50:85cd:: with SMTP id q13mr10416204edh.114.1618583882788;
        Fri, 16 Apr 2021 07:38:02 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 31/40] drm/amd/amdgpu/amdgpu_gart: Correct a couple of function names in the docs
Date:   Fri, 16 Apr 2021 15:37:16 +0100
Message-Id: <20210416143725.2769053-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:73: warning: expecting prototype for amdgpu_dummy_page_init(). Prototype was for amdgpu_gart_dummy_page_init() instead
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:96: warning: expecting prototype for amdgpu_dummy_page_fini(). Prototype was for amdgpu_gart_dummy_page_fini() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Nirmoy Das <nirmoy.das@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c5a9a4fb10d2b..5562b5c90c032 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -60,7 +60,7 @@
  */
 
 /**
- * amdgpu_dummy_page_init - init dummy page used by the driver
+ * amdgpu_gart_dummy_page_init - init dummy page used by the driver
  *
  * @adev: amdgpu_device pointer
  *
@@ -86,7 +86,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_dummy_page_fini - free dummy page used by the driver
+ * amdgpu_gart_dummy_page_fini - free dummy page used by the driver
  *
  * @adev: amdgpu_device pointer
  *
-- 
2.27.0

