Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1C3A57F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhFMLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhFMLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:23:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B075EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 04:20:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j12so6382039pgh.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=km7fFSoakwLzBL2K4C+XOrORhJcE9EZrDxM5qTTgCOg=;
        b=EVJ4IsPbyK9Sj8w5NYgL4BjGXMDVJ/sTd/Sf8kbEd+6MvzMRLCpjdOYBSH6+WVO3AK
         oVScYkOnPrjZYQGfznN9DxDHEgzZZalD2qAa+g9IJBC2ucq6GxuUFPG1jvEyl9UFzpcs
         P2qssZdMyqAhxklk3sP0DFHwCtV52Oxjl/XCIGn3ftmvJ7ZMwk/phuCLwwRUK8QmJVLg
         6o9ZztKWVtu7VvJW1uq/sLWMoC+vz3TnKoaD1RAO1V2eRAQDRA7APrMfOfrN5I4Kmoax
         qXdLYV3FEzS55cVcEeGFW9kIKvU9XX3lAwqJPQXoy2xSFPULA/9ga2BFKhyAyftunyAy
         KqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=km7fFSoakwLzBL2K4C+XOrORhJcE9EZrDxM5qTTgCOg=;
        b=L7QPAKrNOvvaI6lOASWWENw3yga436cWAubvmK3wPpmJoeZYTTzLCqAVh93crFQ7e5
         C1G91Okh1TL98ueSszEoeBW/yQMixyb34q7wLjiOJyCWIjXGKVfNFcpYS3VLblxdt7q0
         bbEtIYZPx6tB8cpOBnUq0GC/uj53ZvJNuaPBGnJf9mS1tx5rJP0WDdYfSbKi/wQ2VS43
         dNTRc7BCEK6EJbEHORsVTbL/136tVsqdte/nhhM9CrRPZPvV/zdC+5KC9O1SXCbR1YAp
         hcBADOhRWyLNuocuVldzhBmzVMV8c4+4agFpfZvLYZ+nx4peLAVk8fSUTgx0YfsNTKVa
         pg2Q==
X-Gm-Message-State: AOAM530gldepOI4VKg3idmzK5SCLmwF/3H8lTjVuUtL0S6UQwdTy5mv9
        hKS37iM9zWo5GZrf/ink8/A=
X-Google-Smtp-Source: ABdhPJzUiGJ1yIHs4EorvIoB5w2vzkEzl8kzr/5ccH+zbckWpdu6tvfVwa1iOirPhvkpacyDXQwCtg==
X-Received: by 2002:a63:b10:: with SMTP id 16mr12369772pgl.90.1623583248107;
        Sun, 13 Jun 2021 04:20:48 -0700 (PDT)
Received: from localhost.localdomain ([209.58.129.97])
        by smtp.gmail.com with ESMTPSA id l5sm9392162pff.20.2021.06.13.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 04:20:47 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     lukas.bulwahn@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH --next] drm/amd/amdgpu: Fix kernel doc warnings
Date:   Sun, 13 Jun 2021 16:50:34 +0530
Message-Id: <20210613112034.19235-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cb1c81467af3 ("drm/ttm: flip the switch for driver
allocated resources v2") changed few ttm_resource pointer names.
The corresponding kernel doc comments were not updated, which
produces few kernel doc build warnings of the type:

./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:193: warning: Excess
function parameter 'mem' description in 'amdgpu_gtt_mgr_del'

Rename the kernel doc function arguments to match the prototype.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index ec96e0b26b11..fa88273364b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -118,7 +118,7 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
  * @man: TTM memory type manager
  * @tbo: TTM BO we need this range for
  * @place: placement flags and restrictions
- * @mem: the resulting mem object
+ * @res: the resulting TTM memory object
  *
  * Dummy, allocate the node but no space for it yet.
  */
@@ -184,7 +184,7 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
  * amdgpu_gtt_mgr_del - free ranges
  *
  * @man: TTM memory type manager
- * @mem: TTM memory object
+ * @res: TTM memory object
  *
  * Free the allocated GTT again.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 436ec246a7da..f06813f04e8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -361,7 +361,7 @@ static void amdgpu_vram_mgr_virt_start(struct ttm_resource *mem,
  * @man: TTM memory type manager
  * @tbo: TTM BO we need this range for
  * @place: placement flags and restrictions
- * @mem: the resulting mem object
+ * @res: the resulting TTM memory object
  *
  * Allocate VRAM for the given BO.
  */
@@ -482,7 +482,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
  * amdgpu_vram_mgr_del - free ranges
  *
  * @man: TTM memory type manager
- * @mem: TTM memory object
+ * @res: TTM memory object
  *
  * Free the allocated VRAM again.
  */
@@ -517,7 +517,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
  * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
  *
  * @adev: amdgpu device pointer
- * @mem: TTM memory object
+ * @res: TTM memory object
  * @offset: byte offset from the base of VRAM BO
  * @length: number of bytes to export in sg_table
  * @dev: the other device
-- 
2.28.0

