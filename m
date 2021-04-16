Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D53622EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhDPOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhDPOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE3C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x4so32590822edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtJJGzKSHczA5bNxqqkJUwGtlpEbmjnBJdKzpKDEnCY=;
        b=yqJ3UFcVv2gARKiV72xCrq0tI5R1O8jjDny5TfNTybJygWqlFnLk1n559dd4JdWHIa
         Mv9cWET1zGWtkY1m95oCj6PTPqfWOOBgw3ijHcxb6gtY5xJo1GbfGUqjuvHAQAeYALFu
         egFNwiC82OUdr53tLKhaq2fA+vvVXQ/bIMiWBTpdtCoQkk3AFJngC0N4XCi5Mo8A0jXa
         GZI6fcZf2/PuH7pjYG75Usus7CYTj/a/HEo82nMnwljU+tnDRScD9O7Eqzbj5ZAx8mEm
         eNa21fKg1D9KvQ/XF2i2e3sP4rEdUVZnA2OiQANGSy438qulqZKIH0RgprxXSxOtNaYu
         MEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtJJGzKSHczA5bNxqqkJUwGtlpEbmjnBJdKzpKDEnCY=;
        b=FOtEBH/B3D292QhPOvbbyutMSC0HzjzBXd7cgy4jUJhjcVLbQcId5xc9qBXBFaCqqF
         kVBuFi7QJC7x8Ogm1HYM0+W3jWdNwXQpPbP01fC7/TK0MKoLoDLCRfNvoHMAMKJAxbNN
         m82EldokrV7IrUCZT7F5hQOLol580uHlhjpkI3r7mR4cHmpLBp5jq9gLtT4Fx3rCawlz
         3ndpfNs97pp0PYcl1Q0oqCCyIMZr4nZhUDOGSUwvF/twrHdkly1dHzPoup/1btcaiDrs
         fLTiZ6g4pwgvHqrMBTiyxJZtfY4YN83Y9NuEuwQ9X3ALk3V887I824onTJfONeUzERSv
         W8SQ==
X-Gm-Message-State: AOAM530LPj4rWXjsfS2MYGF5JVdxY4o72ExW/ukSsFG1ZzGCksftZEag
        pOpB0ijXixRnoZE3i/X38ODnZw==
X-Google-Smtp-Source: ABdhPJxLFtxGxCrP9noPgUReurWM0Eh0qHFdofj6JgkNOBdbRgqYvm35tfMFnhk/mpV0idHiLOKZcw==
X-Received: by 2002:aa7:dd98:: with SMTP id g24mr10283531edv.75.1618583878480;
        Fri, 16 Apr 2021 07:37:58 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/40] drm/ttm/ttm_device: Demote kernel-doc abuses
Date:   Fri, 16 Apr 2021 15:37:12 +0100
Message-Id: <20210416143725.2769053-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_device.c:42: warning: Function parameter or member 'ttm_global_mutex' not described in 'DEFINE_MUTEX'
 drivers/gpu/drm/ttm/ttm_device.c:42: warning: expecting prototype for ttm_global_mutex(). Prototype was for DEFINE_MUTEX() instead
 drivers/gpu/drm/ttm/ttm_device.c:112: warning: Function parameter or member 'ctx' not described in 'ttm_global_swapout'
 drivers/gpu/drm/ttm/ttm_device.c:112: warning: Function parameter or member 'gfp_flags' not described in 'ttm_global_swapout'
 drivers/gpu/drm/ttm/ttm_device.c:112: warning: expecting prototype for A buffer object shrink method that tries to swap out the first(). Prototype was for ttm_global_swapout() instead

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 9b787b3caeb50..a8bec8358350d 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -36,7 +36,7 @@
 
 #include "ttm_module.h"
 
-/**
+/*
  * ttm_global_mutex - protecting the global state
  */
 DEFINE_MUTEX(ttm_global_mutex);
@@ -104,7 +104,7 @@ static int ttm_global_init(void)
 	return ret;
 }
 
-/**
+/*
  * A buffer object shrink method that tries to swap out the first
  * buffer object on the global::swap_lru list.
  */
-- 
2.27.0

