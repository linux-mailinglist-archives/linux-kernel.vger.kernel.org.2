Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AE341769
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhCSIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhCSIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b7so8290525ejv.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzEMJM+UnGpLFsbT1tH5hiSu2fCp7n+uz2nhd5JCrjs=;
        b=wuUIEt9Eb7tXET8ysN8MWKyhOlYTDtF2sT/pFKk4bEjMdmgQe3QrM5PtVeePf9VKxv
         bYk8Z1hyKHpr/dIq6aNjj/2qL6KumKX3UNjpAfttT4dbl1hEQNWL3r35FbFteiKOoahb
         Fj/K9NgcY2jXP309QwCGjWABQI0d7DtEwHzkvnSQzcqncHqH70hPsF8Xj+qC+D6fJgM8
         1nr/4c8N4MfdzX7cz0AKtKuNA0EKgd+nDspaYbHK+Yd6VlpfW78vUh9LIRU5E6D7cl/3
         Ide+6975i2RIBuwjm+gNn4UMbvtwE+17pzzrCQ+xXgomc8HdVMmzWHJ5bG7oo+55YOWq
         1McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzEMJM+UnGpLFsbT1tH5hiSu2fCp7n+uz2nhd5JCrjs=;
        b=P5FcLOFCsSDmNZk7VS0UQWbPtwD+lD36kEynqjZlRhqS2tBRwHkOs0zA+MVvU8mjMo
         V34qE363pz6kAgDZZpg6EuEDKK+TWu+7wrTYrjdtFdSaRvYzQ3Z93xYLVdtCGHg9Fm3q
         dpWyeWxtd/ChtUylhDk4cjffNzDDQLvKFDOqyhYHu0K1Pmv5b5HrMUcwjjgoZ50PDD5B
         Gl71i+Yg6H/TaoO+8xOGs7xwrQPZAfi+4arVstV4roz2rWE6iAz1SPxVk6dFwTNoSC8A
         1N5+7WfyDLXf5KD60G5s0fvCMIJ7raDR0ooyQ6uJcj5qvec/AghcwtizGzpTEmbiy/ph
         pfYQ==
X-Gm-Message-State: AOAM531vyumF+eFtU3xV3isWz4LmsmFiWUCtVuTT2wN3NTqhU2WFynRK
        +tDxk5zl58e+uMsr13gT/+k10g==
X-Google-Smtp-Source: ABdhPJxddfQO8CVFdXm0TZLoP3CbqNK6wuevakzop58iNsun4eTPRCFzfjR55l4dbd1pNyPemNR93Q==
X-Received: by 2002:a17:907:76c7:: with SMTP id kf7mr2948887ejc.470.1616142275944;
        Fri, 19 Mar 2021 01:24:35 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/19] include: drm: drm_atomic: Make use of 'new_plane_state'
Date:   Fri, 19 Mar 2021 08:24:13 +0000
Message-Id: <20210319082428.3294591-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the macro for_each_oldnew_plane_in_state() 'new_plane_state' is provided
as a container for state->planes[i].new_state, but is not utilised in
some use-cases, so we fake-use it instead.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function ‘amdgpu_dm_commit_cursors’:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7649:44: warning: variable ‘new_plane_state’ set but not used [-Wunused-but-set-variable]

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/drm/drm_atomic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index ac5a28eff2c86..259e6970dc836 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -871,7 +871,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 			     ((plane) = (__state)->planes[__i].ptr,	\
 			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
 			      (old_plane_state) = (__state)->planes[__i].old_state,\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state_reverse - iterate over all planes in an atomic
-- 
2.27.0

