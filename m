Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311A23622E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbhDPOjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbhDPOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1EC061761
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so32526047edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6lJM5vDlPCigZaMaZ137qXfyZxXCNgpbaNiX62r2Ss=;
        b=flSVCO6bULmEgKESUIhxGFuVTNcmVsqnwVrbn6m72srwUAYXKxBZS5Q/oDRhGv11DB
         v2a+c3zWguVvSFBphtnT73j9vAYOvHTNhi79odq04gfZLHYc8P+C4KTSZfBLdj8PyqNi
         BysQPAg5pgN8mANchtugw5z6tOHIVzKAx7bDEr8rmeH8ZQ8wjCv2lHbOIbX9jNKGxnLM
         ha5i5bwbGCMi3MrzIg5/rf/uHde9U+WFKoCGDBgH6kOx9yXAPH+LqQIFyTVIgV/dHEsc
         SyIsLANSeD5YaFr6F/3jY5GkhhiKLkX0scp2o5vzC6FMlIjMpnzTMnNQ3SCT8WDCRs+9
         AjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6lJM5vDlPCigZaMaZ137qXfyZxXCNgpbaNiX62r2Ss=;
        b=d3ENPc8Ke58vlzRiOPv12pjvcDYnAp3jEMsdi+TT/3XdKsysOcXrwoKnbRwHfw2bVY
         eVqX8kLK3ZlBEifSFU8J4K07GWU9aObbbqAcPgFN1sn0xsOD51LKjAq5R1OWjspSX42a
         gNJHCb4046EqJwoXegBP8nfJ7j0Tt3Gz3ODZavlTLlmbDcLQ1hBb91hjoeRW4KOwyt2L
         EfkyNk/cW1mD7V9xbjlWL7zH0vFd77B7S32i9Hj5lP7DPcA5WL0hUZfeVtHHXTWO7Vo7
         ryDEFilSR+MU4wl2qBNeParjvSyp+SfMUPPiUva46n36S4u9DfxhK/7OBrr1dCMd0B8P
         qtPA==
X-Gm-Message-State: AOAM5327TWiFzQpYNGluyVsovGfJ9g06z1OPyTNaGNuYhusQgrPLmSxy
        kDZFOWAyA7CAnYiohQgGYZetnA==
X-Google-Smtp-Source: ABdhPJyb4be2bRHCUASGhOYcF9QNbDlJuZvsy9N/XCm+mUih0S3RcBA88c3OyeoKleXaK17tAQDyYw==
X-Received: by 2002:a50:9b12:: with SMTP id o18mr10607699edi.376.1618583874356;
        Fri, 16 Apr 2021 07:37:54 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 23/40] drm/ttm/ttm_bo: Fix incorrectly documented function 'ttm_bo_cleanup_refs'
Date:   Fri, 16 Apr 2021 15:37:08 +0100
Message-Id: <20210416143725.2769053-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_bo.c:293: warning: expecting prototype for function ttm_bo_cleanup_refs(). Prototype was for ttm_bo_cleanup_refs() instead

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index cfd0b92923973..defec9487e1de 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -274,7 +274,7 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
 }
 
 /**
- * function ttm_bo_cleanup_refs
+ * ttm_bo_cleanup_refs
  * If bo idle, remove from lru lists, and unref.
  * If not idle, block if possible.
  *
-- 
2.27.0

