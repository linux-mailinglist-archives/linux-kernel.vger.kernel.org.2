Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5BA3622EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbhDPOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbhDPOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E191C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n2so42447555ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGyBouBX1Ggemr68Q6SGgePttKsGtb3+vFBnPKj0XKk=;
        b=zjKlrXCCCLp6PJd5mtBzTp6pYWfRMDUvqt2BWn+2iebcYzB4ncO09SI9ON5trK0Mam
         CjIjMhDYpJVSXmm7/T0jadBr3NikpYMCeaOhRFojpAVKzAabEx/CVte0Gsuqae2S6xdV
         m3ofbSyWJjul6HlGEexA3HzhJU5ERte6rjduLZpYCQX0D4qDhYvh11cZADkRRa7D7mVt
         VaRx3PHxNHgjRg+6O+QBVcbacEUXpPkop3e7KMFlSAGu8MI7ygi2QSXMBTeRYbMul+4O
         INtlWgVewA6b6Z4apPq07djKAEmY/3meppvazfhHplENudSCo2rSXtEgAI631O5pEX09
         HbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGyBouBX1Ggemr68Q6SGgePttKsGtb3+vFBnPKj0XKk=;
        b=XN7s6mt6y38Hrw8MiEkcrf/W8sOslwpkjECXhfg+hLIBw/R2YqD2H68SBSNTePk424
         ABezIHLoGiRc23o2VcWurBQgOLeMuEyaMJ3fSPkKAnavQ1ktXBfy9XBhC4GsQojn3xAB
         H04qsMMmhEVLSVNP0uyhnROg6Sd9rGPPW3qTvGXWlw+270PyRN9zM1jmcyUnGdNo494m
         otEXl4JYTMJwcmacX4wG5XZGuFAU+Be+nuD2iSv5Ma+fj8yhABDvhk0wYxQCuqpyy/nl
         b5Kw2OCSPa0Fkjv8zjnbeGcREtbHddw7Pudf8tWdyYByyAGA1N0hy5bz2Of996WGAtc8
         /GJw==
X-Gm-Message-State: AOAM5314pkB3511+eZKV9m/nkMNJyOxG+J15sMGhpafLS0X7br9wVYqL
        FyW2S8EYPgzVxKDUYD2j/HPWBw==
X-Google-Smtp-Source: ABdhPJws+FLe7plPr6Ort0gG8DuAX1ky+aZQxssJs5xmE11JaLd6HoX6Enf722QkwyFmK8phDKpX0Q==
X-Received: by 2002:a17:906:a20c:: with SMTP id r12mr8482174ejy.554.1618583883851;
        Fri, 16 Apr 2021 07:38:03 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jerome Glisse <glisse@freedesktop.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 32/40] drm/amd/amdgpu/amdgpu_ttm: Fix incorrectly documented function 'amdgpu_ttm_copy_mem_to_mem()'
Date:   Fri, 16 Apr 2021 15:37:17 +0100
Message-Id: <20210416143725.2769053-33-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:311: warning: expecting prototype for amdgpu_copy_ttm_mem_to_mem(). Prototype was for amdgpu_ttm_copy_mem_to_mem() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jerome Glisse <glisse@freedesktop.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3bef0432cac2f..859314c0d6a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -288,7 +288,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 }
 
 /**
- * amdgpu_copy_ttm_mem_to_mem - Helper function for copy
+ * amdgpu_ttm_copy_mem_to_mem - Helper function for copy
  * @adev: amdgpu device
  * @src: buffer/address where to read from
  * @dst: buffer/address where to write to
-- 
2.27.0

