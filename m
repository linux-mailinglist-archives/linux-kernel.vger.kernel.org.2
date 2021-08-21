Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701453F3982
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhHUIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:22:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622AC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:21:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lo4so24960772ejb.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLNxIQ4b36nOK8YiQqh9tj6nRfmDkfjYUObbVW/rzuE=;
        b=Fr6EEYIqKzlYJL29Bk6kAN0wVc2ohjHDeSEBJJ3s89jdf/bzRME8wKYuaxRVpDvTSr
         Pa/dLXpP5vKCZaSha5zbjNYyynxqvwGWy2/6TlZmVK6YSIiD3oYytqubmQZfh7RpGovV
         6LYX4aOeXx5pavlsuD+yrLBrQQ4AyPo8SmrZMPzO9ViEAqDtNmRrzd90PMStPy608oEi
         1suZXYDqceKxL83xTQcSWZ+8QBWDy5Z/tilnWr4cUWTl8fbXU1cKmtrn/jY9Qd7WXrM9
         ZT6LwHr39F8K7aJSOtu91mjN+c28v96xOW93LJjj5mS6SpVDhXsbVP1rtCb99SNx39oy
         RVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLNxIQ4b36nOK8YiQqh9tj6nRfmDkfjYUObbVW/rzuE=;
        b=JKMgBYb/1AxuTW47eO+dKkfI/TpQxAlNmIqxRHAOQB523qa151sUrHQF09zq9HbIOz
         1qi2tktGzswywkLvwFYQLFq/w784M8x2dTGMkt0a76q7P9Vd5Y64BprKC9SSi1ym5Gw+
         JOgI+FiF27l1ZrxFxzAjQjgwnWTru8+14OCyzE+L5TN5wS9OfMCk/ne90Eku8jI2slG2
         ErOYxGVC/xNKnsiSEdZL5uIcDoSCpJWOexKO5cSQ/GnxqQ3AE7D3ajffOTCmvQFGq480
         IjsdAzxQuCL10p0D73GBZ+TfQiz0p7pS05liUA/ZZgrPyCVci+vsDP8i3ZuSK2So7N/E
         ZV2w==
X-Gm-Message-State: AOAM531lLbRVvUoUJf/VIMRnnpUq1wx0uKH8CZsLFhpbsEguZd0P8T2l
        m2syh+Hj22ITLZEBDmqjKHI=
X-Google-Smtp-Source: ABdhPJxkIkynxwDeHi53+v+uOYVEfg0/kL1L316cPovUVthOvnCB/ud9O4FzhIVP8auxpcmvbFQzUA==
X-Received: by 2002:a17:907:2b09:: with SMTP id gc9mr26430452ejc.49.1629534112230;
        Sat, 21 Aug 2021 01:21:52 -0700 (PDT)
Received: from robot.. ([2a02:2f0d:b800:ab00:6398:283c:6862:f51e])
        by smtp.gmail.com with ESMTPSA id r27sm4888327edb.66.2021.08.21.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:21:51 -0700 (PDT)
From:   Liviu Cheru <liviucheru@gmail.com>
X-Google-Original-From: Liviu Cheru <liviu.cheru@gmail.com>
To:     airlied@linux.ie
Cc:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        liviu.cheru@gmail.com
Subject: [PATCH] gpu: drm: amd: amdgpu: Fixed a few warnings
Date:   Sat, 21 Aug 2021 11:21:41 +0300
Message-Id: <20210821082141.8608-1-liviu.cheru@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed warnings regarding SPDX license, using "unsigned" instead
of "unsigned int", wrong function parameter name for the
documentation and a space between the function name and "(".

Signed-off-by: Liviu Cheru <liviu.cheru@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 795fa7445abe..af1abb281c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2009 Jerome Glisse.
  * All Rights Reserved.
@@ -129,7 +130,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 	u32 c = 0;
 
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
-		unsigned visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
+		unsigned int visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
 
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -731,7 +732,7 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
 /**
  * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
  *
- * @bo: BO that will be inserted into the shadow list
+ * @vmbo: BO that will be inserted into the shadow list
  *
  * Insert a BO to the shadow list.
  */
@@ -957,7 +958,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, domain);
 	for (i = 0; i < bo->placement.num_placement; i++) {
-		unsigned fpfn, lpfn;
+		unsigned int fpfn, lpfn;
 
 		fpfn = min_offset >> PAGE_SHIFT;
 		lpfn = max_offset >> PAGE_SHIFT;
@@ -1175,7 +1176,7 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
  * Returns:
  * 0 for success or a negative error code on failure.
  */
-int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
+int amdgpu_bo_set_metadata(struct amdgpu_bo *bo, void *metadata,
 			    uint32_t metadata_size, uint64_t flags)
 {
 	struct amdgpu_bo_user *ubo;
-- 
2.30.2

