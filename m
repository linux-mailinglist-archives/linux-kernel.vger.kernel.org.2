Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D262341777
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhCSIZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhCSIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u9so8277010ejj.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTcc77PaUiGKf9phoAd/vzPQm0tz3YbgYP/6lveIZh4=;
        b=o76YDBB9GOGYLe4KosrUgxOBNbMHyVlSzUKKNYctBr1a+nJl39FsRZBjx1MUrCV60z
         G02VKl9741zmmRXVAMB9v+F/VyHIHhwpPx1ssPPESKP0k2Qh2yuji6ZU8S0vaapOLjeO
         tvdsbLtjE0hYM4zorjaqD1iE1Lf8d+9uMi+DM4AeDSFKF6b3BYqNNUG5znwLuJ7lICpM
         fprqwrsIvtynzXDtKCXAZkIggamTvNoH2UPXAjK6JOzLwpydN/t7VEghUfqBQr+v6LeX
         jIup1bHTfmcMgRVhge9WozkrF9w0IvoRiy/3Yke03HQoKu28B+bVdjggc263BREr6fN4
         2pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTcc77PaUiGKf9phoAd/vzPQm0tz3YbgYP/6lveIZh4=;
        b=GRsDAV8VVPWtUyqZLUQUbPKSSVFIO0qPH5xfEAnkrpONlAI5etNdB6+UTwNJoqYueS
         xr3cgE4KRUUAQR7BcIvq304QN9MLRY3q4D3LR3PIg/Xu04s8pECtTTAA1r8nBc8h1RsO
         RmplbuhQlt+Bhk03QXj7YkUDBGkobru67To3J3R7oZjbUjRgd3RzFkeA5KpNMbSa3Mm2
         SRWJY74kjVsZYKLSXmX90lD9ez8J4WeduE9qctDYCDZIoYlC2W+vdDvP3bwZQGPI1dR/
         S4OTB5m+4kI/GDE3aGy+vOBthN649l/T37/SuLXYu2zXHCwKyOxp39nnkxikXmeZ4KLq
         7VhA==
X-Gm-Message-State: AOAM533KSzH04rNbeBilrnInjiP7VBr66P29I99Cx6kOuo+ArPNXkeyZ
        d+LJLbD6CGV+zbqUJo2URt8uAQ==
X-Google-Smtp-Source: ABdhPJyt9WxjA2yF5MI7zF3j6iSLZCsXBYIAvwMV8pLBKOdVRXhhE0rbhZoXP7z5g87BfNLkKLNk6A==
X-Received: by 2002:a17:907:76c7:: with SMTP id kf7mr2949578ejc.470.1616142289588;
        Fri, 19 Mar 2021 01:24:49 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 18/19] drm/nouveau/nouveau_svm: Remove unused variable 'ret' from void function
Date:   Fri, 19 Mar 2021 08:24:27 +0000
Message-Id: <20210319082428.3294591-19-lee.jones@linaro.org>
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

