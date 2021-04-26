Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3536B9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbhDZTUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbhDZTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:20:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7456C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:19:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so86121442ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPSGYcihSYfm5NnA+nu9YTkGLMVNgdMxJvMX/B7FahE=;
        b=WMibWvRWHe9598QLkUkR1PFJFBTq3S8q3+KsuQPGrI1VvjLWu7dAuOSdipKauCEyOs
         EIR/XLrvRe3w1J3V4JvNdHsXbQQFkOyRlaFgbVfw7iLGnVVpLYJday9poK7L/6qDrzeb
         PtXav7gnPmbFWFh9txlaM3yj0I30KBzxf2pzLADRunxi7O2Kx8aAIphhKAF5don1vLRC
         pqGhM37wXjQh/MOx1YgrRYjB6QyASjt9o0OcYSDu4jcJY8RHDu+Sj9Qo7qDHV/1Tg4Hz
         aCr4MmJwR+WWOe9m8F1PLqXmGXDfZvl/tgia+E7ZRagvnAdVZ9XS9au1A/2X2mYNlOog
         KUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPSGYcihSYfm5NnA+nu9YTkGLMVNgdMxJvMX/B7FahE=;
        b=kP1cSfI/4ogSqL2bnGLUdHzxaI3+V/jJQWVDZNMsacG3bDNGHzPfJBc94boNgNN+pP
         A/vr7SLTySY1dowAZpwYvdAs6fMPQK+JlDc2getnbuyli5vak1psICEGAwiSkgHm/oDL
         5h7ALCivgo4cBNo3KVdrYLfJnWPnjMjek7suUcQ+n9FtNMXcQFq/NeGIGhHVvOJnFpVS
         rSdu7TrqevHjb7yJiDEJ6dB9Gf6PJwOhjTgvIFUHyRFOkW3NiJcHSd++J2M6kp0aDTl9
         aDakowPcZ7/lyy+JXZ+efo3ICrqL/D2zFyIJFCNGUbUNrH26nzryQgrxbQ+n97fd1hwF
         ATzw==
X-Gm-Message-State: AOAM531C76JaDCjwZRWsEcKWjhNkGW77wVi4gkFNmzZ9DwlklGPWVlfh
        c8+vnp7dVPJUwCkGp6foMeM=
X-Google-Smtp-Source: ABdhPJx1tkuutLobUAvlBcITj9ne3h659zUDMZ/8Xlk/cmtLkCkCGnorZDzZdPx0kFv7qJm1n82DnA==
X-Received: by 2002:a17:906:85da:: with SMTP id i26mr7946351ejy.287.1619464797585;
        Mon, 26 Apr 2021 12:19:57 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id k19sm11878059ejk.117.2021.04.26.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:19:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, dri-devel@lists.fredesktop.org,
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
Date:   Mon, 26 Apr 2021 21:19:52 +0200
Message-Id: <20210426191952.24385-1-fmdefrancesco@gmail.com>
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

