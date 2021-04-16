Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5798F3622DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbhDPOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhDPOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60623C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d21so12452287edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTcc77PaUiGKf9phoAd/vzPQm0tz3YbgYP/6lveIZh4=;
        b=pJ3u5NeO+xtFEt59222VQTddT/mVwYGlZ19Sl0O7F7DINA7n1E962WyomgkEmnrQ7/
         hIU7DbIsLL4BN80rKA9uaowzRvR6SlQWVOeLKReBBI1565aqLRmKeNlVP5fjx++m/hGc
         PF7VZPyPXpfuSxbctS+snGwSo3I/Hn64La6iq7sZrUG/ECQVI2Muerd5DEPoJJdu5+8p
         I8KCYaVf2itm0KiGo9Yc76L1jroFIhOs4DWjpz3AzRUl3nNog4E7azTwpv6WNaI3lJ61
         gRZG8stGP4QeA2/H7ZDZoYKEaubn4R3GVxmw4SX0U614PYQHe27IrKjcIaMkM+UZgYeh
         umOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTcc77PaUiGKf9phoAd/vzPQm0tz3YbgYP/6lveIZh4=;
        b=rDYwQ/fXbpWyC73P1IFGc/2fgw5NDGnoATyeh4XuIZkfn21G+ZZ1BuoCIVCRUZKiKi
         w4eVnLNHR3r7nSHUiYx5UvoWjilrfszz1jbO/P7NUlSX5YHX3Fk0JwyzsgZ76lVoh4lZ
         go44eTIVewHWz9TQhJ3WpGpxl/ejkp5jAtQXIprB83uwnJJvzxP1t7tcVF5OzyKxygz3
         BreVngMH645XQ8gZSFhRahphFgWDc/31L3YTSbD4CR2aqTIAg/qfbdR3uu4HerVqBhEC
         rYB9XQ1Tp76oYyGBlktTS9Nsd5GyLkgOGQQv+fLqY9B07ORFAdDLVCXzjV72l8xgEi8y
         C5Eg==
X-Gm-Message-State: AOAM533/F7tOedyEXBlFd1Wm9286qnjSMTBcYxnzkxve/izq7WWAnHHn
        xzj4gmKexyIiPgjb+xpstHxBrA==
X-Google-Smtp-Source: ABdhPJx07Zgv0qDznKDBpZsVR/FFZFAFeuV94FUsRu2Cf+yVIRkOF78fjqEYjThf8qLZYTJf52edwQ==
X-Received: by 2002:aa7:ca04:: with SMTP id y4mr10173077eds.72.1618583866128;
        Fri, 16 Apr 2021 07:37:46 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 15/40] drm/nouveau/nouveau_svm: Remove unused variable 'ret' from void function
Date:   Fri, 16 Apr 2021 15:37:00 +0100
Message-Id: <20210416143725.2769053-16-lee.jones@linaro.org>
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

 drivers/gpu/drm/nouveau/nouveau_svm.c: In function ‘nouveau_pfns_map’:
 drivers/gpu/drm/nouveau/nouveau_svm.c:810:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 1c3f890377d2c..26af6ee915368 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -811,7 +811,6 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 		 unsigned long addr, u64 *pfns, unsigned long npages)
 {
 	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
-	int ret;
 
 	args->p.addr = addr;
 	args->p.size = npages << PAGE_SHIFT;
@@ -819,8 +818,8 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 	mutex_lock(&svmm->mutex);
 
 	svmm->vmm->vmm.object.client->super = true;
-	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
-				npages * sizeof(args->p.phys[0]), NULL);
+	nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
+			  npages * sizeof(args->p.phys[0]), NULL);
 	svmm->vmm->vmm.object.client->super = false;
 
 	mutex_unlock(&svmm->mutex);
-- 
2.27.0

