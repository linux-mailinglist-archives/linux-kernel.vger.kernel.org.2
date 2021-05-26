Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0423912E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhEZItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhEZItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE58C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b191so250591wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkeiHBD/X56XoAULZC4Zm0KTS26etafLmMiiBA6RZwA=;
        b=E5sBb6eSXnSEoXMYdy1ht4w3v1vwsj+A6bNuBnhDM9u6F2HlqgNLzq2dNKCejMjijh
         LoGSybTP9qaeLJVLUFU8f19dMAa62x7cRdIlkcvWmTjRkW50v8sBlqUbczah4tZn4Wy2
         wW5UyWPN0MtIZPmUCCwhYYIPUMfvzsWNnV1zpYqjG7NA6SoBJc8/Zl75bVYEVDVPkFXp
         0gfV6UsRV3lvhomh9Fuc4xvbZDxgSiFFE2et/mhDJH1jTdp0F52Yd0J8fr0RWxYxxTLZ
         qOlYq09WJa9Mns74A3DYacw6KA2lZsT+deEZkdryeyolLkn+ZrR/asYaBAahuJF3hDgz
         E28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkeiHBD/X56XoAULZC4Zm0KTS26etafLmMiiBA6RZwA=;
        b=elV1d6Jt6DuTY92u0BsuhwiHKB5FJl3KWrydA7vszlVEEco+Fw3OVyOeT7AoYv1zYR
         ku9Ugd/TQSP/mwExIV4e4utqgbk3xTSmjddYcaKPhG/afhmkNSmJjGySck6347I3KFD6
         H8FhLiEM53xK3S+SUrSSvPBMlZJvCvoSOKfiSxdN7qLBLK69mz5Fw8FJ5DWBHe4tZrOV
         Fn4lNrwIW1n4BjrM+gQ7mxdb7T6HrVl+NyInFapjjtlYVVckG5Vpf3K7r9mehhEdfohU
         t42zPBRKyzszs36NegQgc4kr2Be5ngKR9rjMPWyTTWJNCgmgbL3VCqDRSttOxArCYUnX
         ThNg==
X-Gm-Message-State: AOAM532ayN7awjmyvRLyyNS7TPAFcB9FH7/JVn1e7Tc3wAw8As3Woe3N
        Mw6sCHIqVBVS02gEQE4pZzi4DQ==
X-Google-Smtp-Source: ABdhPJwRVFjsZJ8Yn28HNsWaQ3Eep+6zlv63t509qvwQfx+QHNdSX3OCtpjtefRI3FqPdr8dyt03gw==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr27552263wmj.109.1622018868241;
        Wed, 26 May 2021 01:47:48 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:47 -0700 (PDT)
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
Subject: [PATCH 17/34] drm/amd/display/dc/dce/dce_mem_input: Remove duplicate initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT,MASK}
Date:   Wed, 26 May 2021 09:47:09 +0100
Message-Id: <20210526084726.552052-18-lee.jones@linaro.org>
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
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:657:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7270:45: note: (near initialization for ‘mi_shifts.GRPH_NUM_BANKS’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:657:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7269:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:662:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:7269:43: note: (near initialization for ‘mi_masks.GRPH_NUM_BANKS’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note: in expansion of macro ‘MI_GFX6_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:662:3: note: in expansion of macro ‘MI_DCE6_MASK_SH_LIST’

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index 23db5c72f07ed..9b1c4d56275a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -181,7 +181,6 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_ENABLE, GRPH_ENABLE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_DEPTH, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_FORMAT, mask_sh),\
-	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_X_START, GRPH_X_START, mask_sh),\
 	SFB(blk, GRPH_Y_START, GRPH_Y_START, mask_sh),\
 	SFB(blk, GRPH_X_END, GRPH_X_END, mask_sh),\
-- 
2.31.1

