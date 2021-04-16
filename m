Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68F3622C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbhDPOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242934AbhDPOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF720C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so32524618edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzEMJM+UnGpLFsbT1tH5hiSu2fCp7n+uz2nhd5JCrjs=;
        b=Oh8pAFgTSoI3mZ3oqNkCqeRUimxHAuKsuYJLMVyb3itxERn7cUAjgXwN3aQXU3NW9D
         SJypAlB2KHK9CjP1CUJ8U3jtKHbngA4R+T+3CcDXj99EVKHdstCDlL53QQ4V1QaZOG/p
         EPi9QzropfpMVm6xCAxpBm8SsH9x4EtDZ2eT3IUZPmgFjt0Ff9vO3L3dIVDXAV5M0SVy
         X6hhCJ6VmWiqQYBSWFX+AFNGdnhEpk4O7fJDepod9pJ/VNiFmbv1hH5fgM1efHxKgU8P
         KPtnVqEUe3gVluffqqAZVlpYVAzLD51k70RwnPEp7yY2vUJU9ONcXQ3LsYra3Djr5FCp
         6bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzEMJM+UnGpLFsbT1tH5hiSu2fCp7n+uz2nhd5JCrjs=;
        b=mQIo3EZHzP2xhui//ERQhU3yxbk/ekLhaUtBAT/vCjLuo8v0rPYj4kTFkrjQM1vSkE
         GLl3K2lGjfKg0krbugZneSsf8d4aUj9cXq0sxlaqkN5bHboDu1Tl/ZuA6l3VHZlDqg6R
         wK0YEn9gAGlhclAwVe/kvLtqpfdXWVkGv8qG9MkrCB13yG/Hqie/3ifZDK1CkjO9xBYV
         GNt8YIYlviwF7hvHNnZxO5hHfLw6EuF1oGj3Hn8/w2l2r4RGh1D9xs6azCjQc9Jc5n2r
         23VlJ3ChdAyTQeS9gqZW8dOe4PiUGADrUg1GKXt+zHhn7vTvtukVRfsYrl+KAx07pNWh
         Sg4w==
X-Gm-Message-State: AOAM5314CMiJOb0BjcJIWKMOhCmv+2GaxRZOL4fHgjCxB+6RjefeidVU
        hEVo1VwbpGE4YebaXnOOky1UaA==
X-Google-Smtp-Source: ABdhPJzGqNL4Z4E6R5Nr3ACtN7RcM/bSmBJekxIViM6hZWhm8FIOWYGhgGqFhWQEqCFtqBmtLK56BQ==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr10526627edu.57.1618583854534;
        Fri, 16 Apr 2021 07:37:34 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:34 -0700 (PDT)
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
Subject: [PATCH 04/40] include: drm: drm_atomic: Make use of 'new_plane_state'
Date:   Fri, 16 Apr 2021 15:36:49 +0100
Message-Id: <20210416143725.2769053-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
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

