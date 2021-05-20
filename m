Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0E38AEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbhETMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbhETMnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AE9C0611A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2531380wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5sw4AF7XegGlkCLbUkHlKVD/9b0ngx4FCn81/fMRTw=;
        b=ksOBWl5tUNwe2AcCRFDXtFTwh3WcnrwIVTy4i2oBgCXno9jjdWp/XD6S8ubPm3p6G8
         egyngHGEAXetidUWukGeEGKRoxrHehVNUujwL5UZaJXJM/ujGV8GWbx+fsWk5zk1yvB7
         FZ7J8mU2JWiDEe6oEXLSL21YmyI9LN+k7Kjkb/11Qy49SEbRUVsKBJ37qENvdOJRZKL2
         BNLlgLJJTf/3kYZkL8yy9GP6Lj8K4Nq3roKE/fjJ7b5LSSkQFEotJBMIx5MBWf15wEnH
         I+MnL828LxfDCMygyT7WpszFes9K6itFg+Gm8fCJsCOpyneL2IezTNfHMizJD+jIPe5j
         UM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5sw4AF7XegGlkCLbUkHlKVD/9b0ngx4FCn81/fMRTw=;
        b=LHqXuuYQDw2o6MtjyNremCyb/gQ4xmFio/INeHvetmBSdkh3qCP5UkY7K0/E5d84Hi
         I0a46rj06g6jj93TcU9TErM7Wuh6aJzSmsZdy+O23Y6KPjk7FEHZ+JCR/LiLQ/Rq/oeE
         AJwPuodLqitxR0NWbmM2gjkSETCeU6naBNDGH7e0WBDN6A2sPf1QVhr+OqS2NxmArSEP
         RbctDvHJVqmFb9jRwwcDZ3ZfaVALLkyIbfTeO03p4/yZeEHZryAfyxrjeIxl2FNSy1vQ
         xIxNbbiXzs7EBgBatdg2bBEKFS24i0cEmanYC3n5A+aMDVgHPN+R/75E70Mw9+qFKZOV
         M09Q==
X-Gm-Message-State: AOAM5322kRu3vVp5i0lySC9BCQuNYpoolhNjmRdFZsRD41hqnfKSHHDS
        Oelx6km/EENi6nE8eTg1B6Yp9Q==
X-Google-Smtp-Source: ABdhPJytwId7vCW32UE4+OALKLTHqn8gKfwODyoIgV/xjaR47aJ4cs0jn84xEkBWDkNWVdXHbHxY0A==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr3314880wmq.138.1621512184229;
        Thu, 20 May 2021 05:03:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/38] drm/amd/amdgpu/amdgpu_gmc: Fix a little naming related doc-rot
Date:   Thu, 20 May 2021 13:02:22 +0100
Message-Id: <20210520120248.3464013-13-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:487: warning: expecting prototype for amdgpu_tmz_set(). Prototype was for amdgpu_gmc_tmz_set() instead
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:533: warning: expecting prototype for amdgpu_noretry_set(). Prototype was for amdgpu_gmc_noretry_set() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a129ecc738693..58feb0a422c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -528,7 +528,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_tmz_set -- check and set if a device supports TMZ
+ * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
  * @adev: amdgpu_device pointer
  *
  * Check and set if an the device @adev supports Trusted Memory
@@ -574,7 +574,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_noretry_set -- set per asic noretry defaults
+ * amdgpu_gmc_noretry_set -- set per asic noretry defaults
  * @adev: amdgpu_device pointer
  *
  * Set a per asic default for the no-retry parameter.
-- 
2.31.1

