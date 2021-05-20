Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068DF38AED1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbhETMpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbhETMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B16C05649E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so17351393wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aa3gg5EuMa9A5nk5o0d0T8SZ6WR+4Hli7trc1GNqVzE=;
        b=P/8FbvIM/h7Ij52WQCkLtGbmLfZt2AIUofpELl7aKx9cVVKxRhCPQWSTqLoL+D5ek0
         3e7FpGFtcDBnwmpnAo9QDgzBiqYfUul8fsWJeAdJ7gqxXWD3KfNPqhNmL0hOBgD8iCLs
         RHzl84pChy/3XbBLbG+ny0C3LSao4HP+jP1MS08fMA09Bv1MtJYVhGkCT6RL8+WsnmG6
         2IpoNRsoY7lJhmH+oP52+LkzipwOSevCUEQlu28ZqIaOJy+zUHSR8XzhYCrK4pomOiQM
         H9hu5ChdIaJPBw6CSJrYMjgHUW9+6vQGnmLJfH42Xr7yZ3VgkiBDkOTrowlpSuVIksnb
         9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aa3gg5EuMa9A5nk5o0d0T8SZ6WR+4Hli7trc1GNqVzE=;
        b=ookYmso+uBwI9xMSEP2Rf3+S3gXBNSIXK22Knwo4nLncukypP0tSw4LRwyJowl4Khl
         OgugwPfcfl6TOmS6PXGrCiFSzK1qdK7SDnk0WjKNSlzmMjRhk/YmXwg5pPNo+J/IIDkr
         Yax9wExyAqGRzcOO6TERDii15JqzATEMxsqeTo2LpamDZxS28E7o4nTXjtcrkpWa4Sdv
         7E6bW/cJnaBP3IIWVOsnL1+gHiqz18KMdzOeIvw2OkjALgmxq5Oj6DhUtDJhCGFvKtTU
         HUr6PXupvmFz9Yb4fCIP3XvTSnt7I32Qa6jX42VOTPySJqwSaNnyGcLZAlSpWttq0eKg
         zcpg==
X-Gm-Message-State: AOAM531bFtLX59pHMaK+efyCVUF+AtPvIpLaz9enZlWr6e93ipzcALjW
        lBFcwmrD2kZuVnhmcNvE73YcNg==
X-Google-Smtp-Source: ABdhPJxcm94XcnPIlXpI+aoOcisifK8IL9R99fLfefdLdPJx9Qsa0SXHZUEbROwc7y4h4Dww96AGxA==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr4038472wrt.189.1621512195526;
        Thu, 20 May 2021 05:03:15 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/38] drm/amd/amdgpu/gmc_v7_0: Fix potential copy/paste issue
Date:   Thu, 20 May 2021 13:02:33 +0100
Message-Id: <20210520120248.3464013-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:526: warning: expecting prototype for gmc_v8_0_set_fault_enable_default(). Prototype was for gmc_v7_0_set_fault_enable_default() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 210ada2289ec9..8e282169f99eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -516,7 +516,7 @@ static void gmc_v7_0_get_vm_pte(struct amdgpu_device *adev,
 }
 
 /**
- * gmc_v8_0_set_fault_enable_default - update VM fault handling
+ * gmc_v7_0_set_fault_enable_default - update VM fault handling
  *
  * @adev: amdgpu_device pointer
  * @value: true redirects VM faults to the default page
-- 
2.31.1

