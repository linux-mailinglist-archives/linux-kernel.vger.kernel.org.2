Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8B32BE66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385688AbhCCRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383267AbhCCNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:45:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63DC061226
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so2882972wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LL2CIStDBvdCQ2ilvl+8GEJmSghnQSGgGmDvpCxTU0Q=;
        b=JAR371RMHMFvNknWC4hTcGuEAbhD8bdPwtV8wy/zEUaqExQqn49iQu+3FZE5JeJ482
         TTxTOhGQXqFarSADpG3hoP9sVweTfSwdInfl4ijt+5NNYhYgK44aT6oWR0AHJYEjy/NW
         63j4wlV4giSCXJZMusdcHGwj83XWUOM3WtrQJMgEDJfDXyDq4YtRQdhQZ/g926iBrhok
         aTczenLvwexE8X+xuU8Zvz4M9PaqcOEwh7ohl+xI+weOigImuBmjT1S44SOWRe/BziJm
         LxsHNW9IXmqiXjDhBPGZdGejytI0y1AcpsV0fAhpF/9Gj5rVWwsbJrNWCXuMbunOUnkz
         koog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LL2CIStDBvdCQ2ilvl+8GEJmSghnQSGgGmDvpCxTU0Q=;
        b=FUTwMWCOL9AukCkqr1EvhEJW/7ndk95+cllLQ+F3ym4KoNMSGiIo/A/QdnjL6s4zcB
         w7IEuO4Zyq/LatPsbTUnDsX06AKUXJinxJG+CsBAQ95UQDpSUZPBqAMVFVjvrZpalp77
         b3OLVZisqq/cK1Icq24Fzh7TOGWhHlfi1LKn1bc0frFMQGRvsVi16opWj9oQH4jp3r/8
         7BjjujS4vlz7lVdzmTTxO37iXYLGnE6aznvmnsiwqZhaeSdLnmOjlnzW1FFnPCpo9Gqx
         CdFpPVA3o44vsibuxfClis6zGseGmqL4uVsGsqD14GZE4iKBLAi9ZoTF+F1U3z/pOV/P
         TnhQ==
X-Gm-Message-State: AOAM531+zYNZ95zP3/dILA34VSu1pUEQoSi9zm0hJadaZyi+a1LGdsaB
        mFLwUoyhAayQCuppoiyaY/5zRA==
X-Google-Smtp-Source: ABdhPJy3BEgPq8kDRUEDefnM1AmgmfYSo8HfYm0VdWVUkTu6qNsrubOKe7pD80qd1DLzjYlkm27t5Q==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr9451964wmk.89.1614779024289;
        Wed, 03 Mar 2021 05:43:44 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:43 -0800 (PST)
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
Subject: [PATCH 13/53] drm/nouveau/nouveau_bo: Remove unused variables 'dev'
Date:   Wed,  3 Mar 2021 13:42:39 +0000
Message-Id: <20210303134319.3160762-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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
index 2375711877cf3..0b94f8ae77291 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1251,7 +1251,6 @@ nouveau_ttm_tt_populate(struct ttm_bo_device *bdev,
 {
 	struct ttm_tt *ttm_dma = (void *)ttm;
 	struct nouveau_drm *drm;
-	struct device *dev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	if (ttm_tt_is_populated(ttm))
@@ -1264,7 +1263,6 @@ nouveau_ttm_tt_populate(struct ttm_bo_device *bdev,
 	}
 
 	drm = nouveau_bdev(bdev);
-	dev = drm->dev->dev;
 
 	return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
 }
@@ -1274,14 +1272,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_bo_device *bdev,
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

