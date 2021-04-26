Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB636B9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhDZT3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbhDZT3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:29:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:28:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ja3so10243212ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPSGYcihSYfm5NnA+nu9YTkGLMVNgdMxJvMX/B7FahE=;
        b=ctXrYWq3oz6pjzAXmFpyJd/LoD0/v+4tl7HlYy8uF5CLLgpv6M8UmNUPLsPomE0iA1
         IbJjJZ6tjjLS4sM55IgbpW9yDGZzZn9pJHHIFxfMVa2gbPU25sdhChZCVgJUZyDvH62f
         IvusHlYK/dmNk4ddrQjOcQclx+tRkOIOBAOx5eh9z4GyeD7KsOwiwr6GEsOB2U1r1ZLy
         fu9vfUQP3WT+EHM1aJ8f2ZuYcJbO63u9p+9s7HLJ/tKORD6z95KhytxfMmgWW55FD4dh
         hCnTI5CqbHAR0XGbUSFIdUl+yXW3JUsNHGjIphoFg2dAlbppxLp6deUJSN56Ovvet3sx
         xZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPSGYcihSYfm5NnA+nu9YTkGLMVNgdMxJvMX/B7FahE=;
        b=OWVYUuBpllja7c/73ZPtW8wihU8ZIrZO55qgWbRxPCZv/keL4i9G1Lygyea6Q0J1vQ
         9IKzJkzUF5QK3ORLg+1nr6ZEYQgIs+xCf9Y+xquTU6eU/5dsoS1g0/ds6tnk5cItpddj
         AymEVuLi6SpoM4kwIVICmD9yTzYaQ036ONjQ/Jw4bM1dm7hoRosEsLrMSa7ai4leavVL
         rNZRP5/qdyHeU17oTYDHEUnRuiyv1Vy4XZaH/V4nhTb7maE2HCAzKd5CBOSxqegnAqMT
         hrshY92nQ45GgO4nLr4fzNhdkOz8b3bDMM8xUCsjDU4C3Z7TCmbf+Qj1Wb4c1OFBREiO
         ZMvQ==
X-Gm-Message-State: AOAM530BEA4wKoftl/8jXYhm7NMU6iY9t47DH2+IkZ0vaPgV39dIobJI
        iL7uBkEDpzCXlY0p0XB1hVQ=
X-Google-Smtp-Source: ABdhPJxt5ijbkx1gr5nMUoX4S1ZPQTXA4JCK9wk3uzykoQlBO5tcNsIlVyD2cNLLFRGveTBeQRClDg==
X-Received: by 2002:a17:906:cb88:: with SMTP id mf8mr20576558ejb.541.1619465336843;
        Mon, 26 Apr 2021 12:28:56 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id p4sm807568ejr.81.2021.04.26.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:28:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] drm/amd/amdgpu: Replace drm_modeset_lock_all with drm_modeset_lock
Date:   Mon, 26 Apr 2021 21:28:51 +0200
Message-Id: <20210426192851.30155-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_modeset_lock_all() is not needed here, so it is replaced with
drm_modeset_lock(). The crtc list around which we are looping never
changes, therefore the only lock we need is to protect access to
crtc->state.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

Changes from v2: Drop file name from the Subject. Cc'ed all maintainers.
Changes from v1: Removed unnecessary braces around single statement
block.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 671ec1002230..adfeec2b17c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1439,17 +1439,15 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	if (amdgpu_device_has_dc_support(adev)) {
 		struct drm_crtc *crtc;
 
-		drm_modeset_lock_all(drm_dev);
-
 		drm_for_each_crtc(crtc, drm_dev) {
-			if (crtc->state->active) {
+			drm_modeset_lock(&crtc->mutex, NULL);
+			if (crtc->state->active)
 				ret = -EBUSY;
+			drm_modeset_unlock(&crtc->mutex);
+			if (ret < 0)
 				break;
-			}
 		}
 
-		drm_modeset_unlock_all(drm_dev);
-
 	} else {
 		struct drm_connector *list_connector;
 		struct drm_connector_list_iter iter;
-- 
2.31.1

