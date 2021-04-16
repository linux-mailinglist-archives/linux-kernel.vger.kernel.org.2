Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929083622CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbhDPOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbhDPOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA71C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so42519951ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7/qJg/GxIoIQOOm1SNOLLnFRtxZCMtYZ46XvrqG7mv4=;
        b=itln6XERME/4Yh80Mask5Ou5IFhw9E4rP1eKimMutmDEThu7t2bC6wxjUfv9+3am+0
         Ivc5a9UFk2rAyPPvLw/G7NrQrAZyq3TKud34Vt5mGrX7IL5JSu1VmtugH/FcOCGKRI4G
         iCIXzZERumpfQBAlqmR1xjkxjwAPJZmF1Hj8S5yoTM51VsLTNEUuKolsvlWpOtJbSslP
         6D9/3lqjJ8B8JU1NrLhmJAEImB/HJXPjthAGwlNpzU5kOvTKjK4ziF25bgwEF/cv/vW7
         Irer8JRZejsZ1eZ5PXkstUyuQ6PaPg5YsLo+ioQ3cNpsH5qGoyk5YfmpxpOqiqzd5ZoL
         RdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7/qJg/GxIoIQOOm1SNOLLnFRtxZCMtYZ46XvrqG7mv4=;
        b=nyiZhVwHwNzOgME1pHs8VQLJu7mEU63PGczgWq84GF1OR7bsUQHATWygMeKdPpj05v
         nYe17tOL105GCqq/K8eCQyTivqLXPwlHm7+zHMYOqRBm4aW4aoEx7gLcExEVLYhWiA/1
         IWoMjyWsbbqlwZJHWCUxDiFaCZBeLNLugqumaEEe7yh6ow/NEV1DwLFPsmc9Exzpa/Zx
         oBt/oUZ7t0vTAgDL/tIEsK/VRp9qFiThJGtvKboaIFkILFsxsk2zeNcP/BcfKobICb8h
         TQFp17A7hPOHqe2TjseIRJ0gyevKrWOg6CWAHScnEOcew0KKv3wAzHJfXBX/6SL3wiBZ
         Tdkg==
X-Gm-Message-State: AOAM5304ryXg4808GSSDry6hkebZOgo7+gKsKg7jJuruw6hdu2VjfGC8
        BeW27ZmuKlHQNmERpVSQjM1JEA==
X-Google-Smtp-Source: ABdhPJwyyQ78HhFxwVGsHOCCHcrMEtltPH9DKl5AUPQtj9p3tU6DB6ttsT61SqDtIpq8Q2r9Ym/3hA==
X-Received: by 2002:a17:906:c218:: with SMTP id d24mr8346753ejz.363.1618583858315;
        Fri, 16 Apr 2021 07:37:38 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:37 -0700 (PDT)
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
Subject: [PATCH 07/40] drm/nouveau/nouveau_bo: Remove unused variables 'dev'
Date:   Fri, 16 Apr 2021 15:36:52 +0100
Message-Id: <20210416143725.2769053-8-lee.jones@linaro.org>
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
index 3e09df0472ce4..37b3d2c10f5c5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1255,7 +1255,6 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
 {
 	struct ttm_tt *ttm_dma = (void *)ttm;
 	struct nouveau_drm *drm;
-	struct device *dev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	if (ttm_tt_is_populated(ttm))
@@ -1268,7 +1267,6 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
 	}
 
 	drm = nouveau_bdev(bdev);
-	dev = drm->dev->dev;
 
 	return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
 }
@@ -1278,14 +1276,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_device *bdev,
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

