Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6167D341770
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhCSIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhCSIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b7so8290966ejv.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGGhPwZOypkRysPaew36bi2SL/oARoSOfv3/qOj60LY=;
        b=WkLf4se2ygcdBQIKbKwxqNveqB4koJlwdEfRBk1zP567hFamNxEMmDrYvU2lwE1cGJ
         u/AMNzO8QJnK7GmHddKQOpo6CfX1WGlP63nCTGh6wvTpl2Mo0PagzBkfowMdUOroYUga
         SaSe3CUWN0oq0wfCbBXT58D57a/vt286ZOMWRekrefpL46cI9PkOM9Sr3QR8NlxtLtJ7
         VW9x7B7zjtJPr8y4Hsr491F/ugrzs3zKGPkVBKc8RaMul6eV3CeguJuqGPIuWdfcUU72
         Z+yo/fyhUyqdEeXXzp14uKEhsbgptSrlNN2RwpVQy4ts/emeD7BM3gMv/SAarogZXO05
         oiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGGhPwZOypkRysPaew36bi2SL/oARoSOfv3/qOj60LY=;
        b=q8aGqkyEkF8jIlLDR5k69iLyebfdANsyrR15xQKWo3fbhOFwnyzqLKXgT5ijBB5Nii
         xsYhBUo7VE+WTumFO1wfrD1IjnSqWP00N0NBODUgHEropYcoCeMpEimo7V9mNRxyQ4Js
         oQQLWvqhRMPoCMku6AtLjp3gAPRLtDFfPQO7MXV/R/zrpYLoTnbdBgC3ychEa6Lar4tT
         qvU+CNaTSQPUhUvyKM0Q3zX89LdYS/yE5Eoeco6/IUcGcv+bUyYUlQFx7C+1rSbxoRbD
         3vJ/vO87tSlFX4UGu3ix6DcTICPWs/fYpv49rMh7JfiX7hOpuIqP7vStKdd5fLE0JcsE
         CW+g==
X-Gm-Message-State: AOAM532TJfDFJJyeIhx9uOiiyITXCVw8Xe0YA2dODmqBjZl5ZX2qozxm
        0FEDW485Xd2EstseiAqzR8zm9Q==
X-Google-Smtp-Source: ABdhPJy+b/uG5tTgU/yThQRTfU//08a1wHRYy9jj2+EPGa3YZj1QuCGlUX6+CDNbqK5fXTdf6lOGkw==
X-Received: by 2002:a17:906:3388:: with SMTP id v8mr3043046eja.278.1616142282308;
        Fri, 19 Mar 2021 01:24:42 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jeremy Kolb <jkolb@brandeis.edu>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 10/19] drm/nouveau/nouveau_bo: Remove unused variables 'dev'
Date:   Fri, 19 Mar 2021 08:24:19 +0000
Message-Id: <20210319082428.3294591-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_bo.c: In function ‘nouveau_ttm_tt_populate’:
 drivers/gpu/drm/nouveau/nouveau_bo.c:1228:17: warning: variable ‘dev’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/nouveau/nouveau_bo.c: In function ‘nouveau_ttm_tt_unpopulate’:
 drivers/gpu/drm/nouveau/nouveau_bo.c:1252:17: warning: variable ‘dev’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Jeremy Kolb <jkolb@brandeis.edu>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 281e9ed139895..913035ab85ec2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1250,7 +1250,6 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
 {
 	struct ttm_tt *ttm_dma = (void *)ttm;
 	struct nouveau_drm *drm;
-	struct device *dev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	if (ttm_tt_is_populated(ttm))
@@ -1263,7 +1262,6 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
 	}
 
 	drm = nouveau_bdev(bdev);
-	dev = drm->dev->dev;
 
 	return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
 }
@@ -1273,14 +1271,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_device *bdev,
 			  struct ttm_tt *ttm)
 {
 	struct nouveau_drm *drm;
-	struct device *dev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	if (slave)
 		return;
 
 	drm = nouveau_bdev(bdev);
-	dev = drm->dev->dev;
 
 	return ttm_pool_free(&drm->ttm.bdev.pool, ttm);
 }
-- 
2.27.0

