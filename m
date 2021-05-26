Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD733912E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhEZIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhEZItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181BC06138E
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z130so247722wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdhmaHY4/dmW91tEBMJX0Bu7PliwQQfsKUoeLcKD0IA=;
        b=OibzwUzjSDVCtV8ltB9PfH3nOFJ0quNuzsPiYyQdK4H9UVDDcpJZVJC08Jz7bgj/es
         xjxQgzQO7P7v6DS+p+5LFlLJoDjgFc/+eyif00nSU48DeP0v/b6mGDTXV3LD10O1ekPm
         is1c6rW4NUNkOK5jIybllp1DeajeLodSQhk4o19+F4bbzMFT2pzK9i8eNRxZ3dsVOFTI
         YSdUNpBG5X6dNrLI2fDSqwA0eZHzNntDIKe734r8dF8O/5AUmXYqDw5qvLPYmzw8EnbS
         ddEirlfh7i28ktzE+kYO3dkKLFf5EU19PwyOR5jC4iEUtQbqEb3H/JWVADHCdbXkf9cl
         BoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdhmaHY4/dmW91tEBMJX0Bu7PliwQQfsKUoeLcKD0IA=;
        b=ZbKr4GGm762J01s0yppvEKW49mf2fEV1+AfjG3yaYiK4TrbpCXa8yt2XXakC2XFPlX
         yzEEr6CJgVF5PrVFGqg/vEW/cT2Zvjr82/aT1adH1ECceBH58sOz9v/RcQqJR+RRaGd7
         qJIz1ibdvN0TNy0edDPfUAAtH99lXQrgFPlpJoIdfi29Cofzti9G5JART+tSt8nBn9T7
         Q6D65RxWO+C5gv0nwjnZaHp3Ou0l+Is+NmrvGK/XSBrXfk0eeEVQKqowEU9m4RhycvO0
         YGvezbRqAABs3nIFy5OsO0zToX4LyLRovUblJlGfU++Kdp4Yh4i3hFiTfOHgoRUCkyro
         268A==
X-Gm-Message-State: AOAM533SEE+IqTFYxNKsPTO2BvqOshIYvuyZbawmADO97QC1GBIwYDvk
        dtVzdu0F44gDnTRKJrlYj4W1CQ==
X-Google-Smtp-Source: ABdhPJwL1nDK4Uo0V6VHswsbzS764ElullDfNHxS322OpEzQ2x9bea+yfqjVJl6SY63hb6AWHflEjw==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr2360600wmq.48.1622018869377;
        Wed, 26 May 2021 01:47:49 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 18/34] drm/amd/display/dc/dce/dce_mem_input: Remove duplicate initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT,MASK
Date:   Wed, 26 May 2021 09:47:10 +0100
Message-Id: <20210526084726.552052-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:29:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7270:45: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:657:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7270:45: note: (near initialization for ‘mi_shifts.GRPH_NUM_BANKS’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:657:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7269:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:662:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7269:43: note: (near initialization for ‘mi_masks.GRPH_NUM_BANKS’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:662:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index 9b1c4d56275a4..08a4c8d029d9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -206,7 +206,6 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_ENABLE, GRPH_ENABLE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_DEPTH, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_FORMAT, mask_sh),\
-	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_X_START, GRPH_X_START, mask_sh),\
 	SFB(blk, GRPH_Y_START, GRPH_Y_START, mask_sh),\
 	SFB(blk, GRPH_X_END, GRPH_X_END, mask_sh),\
-- 
2.31.1

