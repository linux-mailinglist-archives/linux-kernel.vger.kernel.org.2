Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E062032BE75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCCRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444508AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2040CC061A28
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u125so6379542wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTcc77PaUiGKf9phoAd/vzPQm0tz3YbgYP/6lveIZh4=;
        b=Hv3a0tcAo2K75m0PVXruwEWL4rfLpWzsc4Q8ptX+wlRQui8I+T9dLgLHzoAzZ504j/
         XcEzu5iref2iOCnTh/o7cuHw+viXjLLMy8clfd4ZxtHnXl0RQYy2eGfS2ggWC1qnxc5p
         xC4l5DEddko48sXzz7/SS7YKf1p0wal7oJ5cXs9QtL18zSF/4lmjSmI2HgSN3tyE6B1S
         /FTU0+aJKxH890PwQM1AEg3ZlrQQ+JU2ilGVGkvuv97eQX2CwvOuTVNBVkTMCDWRoCS6
         t3to01UjR2QuViV0QUnqOsUPl5w4dzGd0Yi/iMWuHy/RtGZ8ifOVWd3phAkfkQ8RvNOA
         kRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTcc77PaUiGKf9phoAd/vzPQm0tz3YbgYP/6lveIZh4=;
        b=XztSlbnAaRAmMJCwqNVM2+VGiWzrdlMs9BOlsM58WUOBJH0nS160zfZ8KXmJg8H5xK
         eVMXxRR1KnaFkXbTNV0WVTjE2zJxOaEyhrSo+VgtZE6FIlLec2CgD5OxFSZ1B43Bjl/o
         zMyEI+llmrHW3azxe9Dsq+bQJ8k4rKTWXgj7FSnRn3ajMcNV/u4KV1yvWwWcsDQG5Nk8
         FsF30LaJeOipVQMVY5iQ3/QAkQkkx65F16lhQAgYKpOgLYqjVTjgTlJ1ZgIa7UGj2Anl
         puyx58FRjy8sv2q8MYRKEMYIshrowsrm4vsQ4E/gt+R19Cf/mtrHgLebISiUYiXpMjh2
         Np6A==
X-Gm-Message-State: AOAM533VAPXqTn40sEWUb5ZHWJex/5r1rEgKzU+mJ3D1m6JRCCpvCIvV
        ZvcNXokXgmH0Ot3tUJLVsBywTfPx/h7Smg==
X-Google-Smtp-Source: ABdhPJzCUtL2oe5CKkrYfLuRcO0VMQwAKyVrObWALyWobvl6AF/6diNzxih8O3BeA+r07qK/DufcjQ==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr9157109wmq.140.1614779032867;
        Wed, 03 Mar 2021 05:43:52 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 21/53] drm/nouveau/nouveau_svm: Remove unused variable 'ret' from void function
Date:   Wed,  3 Mar 2021 13:42:47 +0000
Message-Id: <20210303134319.3160762-22-lee.jones@linaro.org>
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

