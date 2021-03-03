Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34B32BE57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385600AbhCCRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349261AbhCCNoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2A1C0617AA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id w7so5210439wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSYYF9avR+ibuwGTDH+u4wL/4B2uArbe+K5Pi6OSJeE=;
        b=ycKjNwxVRbCbFBAENcOkX967iuzNILRBy64Agv/v6AoZsMb6fh2R8wRdvYyJH6Cj2D
         TgcS8VnsiDfrUZ4+cXJGZ7euWyTdOdLNdKMr+YOK635Vr7OgrzD4hBE02dgD7nopt4ZM
         w0Lut7zaa1OSOrPr2NtQ7k3kyGq7LnzgpWxg/3jlkxOLCPITPG/yUPcRKl6OLgvuy9yI
         AMlLutx1kgcc7QtPN/Xk2FNrgBpBoYKNVwWWNI0+HI/7NtZ9Vvkzae0XtKZKuVpk3BQ5
         fDtXc95a7S4ZQr7B2TODC9Z/hm0uLpjbMGGrYxonprBaU5PcGThm2OYN0sDp65mrMGI5
         7v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSYYF9avR+ibuwGTDH+u4wL/4B2uArbe+K5Pi6OSJeE=;
        b=rPEL21wcIcAhBGfzUx9uberPyRAN9YfEzHg5qwHrN/AhhYfPOa0tEgwoLruqGP3tjn
         dkK3XXx2k/kBAh2VnWW2t+Zi1qezXhVt0P1JaQ7ZwPsSPEGHd7nwOj16Ow0o6ivQy579
         wAYi1VFwD6L1eH7Z1K2OOMjwr+mlL2MpNXtUdfCKyDXjeXI59yhvdVUYnGrsYfnpwNRA
         aijaIBltBhWGBCtMju4FKfmhDky7AjAHBjUk6AhX/m5Q1Sd3NXG+v1JuU563BDGE9BPj
         FreST67I4CP8cOyaLo3pJdTiYhaKyv6UuJ0LWHSGRfpbWjMWFqfnN6BuEd/qo45ozwnU
         GpiA==
X-Gm-Message-State: AOAM531FdBiwb19NDP/YkThkr6LlzoIwbIcN1RXaxy8/yT8jrPC3rtun
        K7tiD/zLlaGLcLhUDnub7Bxiiw==
X-Google-Smtp-Source: ABdhPJwiGxjArDO8rR5idnJXWqI7FvnqHY0aib4SalTLxl3V/8oEa/eGolnFiAQ3rvhsAU4vK+Y5xw==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr8916602wmc.119.1614779014483;
        Wed, 03 Mar 2021 05:43:34 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:34 -0800 (PST)
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
Subject: [PATCH 05/53] include: drm: drm_atomic: Make use of 'new_plane_state'
Date:   Wed,  3 Mar 2021 13:42:31 +0000
Message-Id: <20210303134319.3160762-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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
index ce7023e9115d7..a71c19e1d785c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -867,7 +867,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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

