Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED61420033
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhJCFZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:25:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4AC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rbmI2IZ22qehGTAtbIrL2E4xUQqN45kVWZNNZVp/+vI=; b=xBXYRqK0nKAr3XkgHc8/L4H1/S
        lN0lSaKSITWaX1owM3ghTyqUeO6EwzDoIog8fO7FEbxGeuIFW4f9pCH5FELIFTVZraJo5RYr5yz4x
        IlhoNZ/cznJ2OSYHbf38+xpa4xMREDX6MtHMS1k8gHJR8e3Lp+Rm5BYa7gF5Pwqva2JOt4eZw6e62
        oK4OLxjuYGgG1O1BuMFHFtpEAnd9j1CRFF23VY5UbX+0F0pBXgUD3qKaMFpFXRr93Tzg/jTvh7Rxo
        HX4e6E8rGoxtQqRoM9MfliBvGasSKz00+dTFLyIg0jacy/0U3skX9z1ExYCTpWOLfKLkOGybN9qYm
        WpkwCFyg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWtyJ-003DAA-N8; Sun, 03 Oct 2021 05:23:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Colin Xu <colin.xu@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/i915/gvt: clean up kernel-doc in gtt.c
Date:   Sat,  2 Oct 2021 22:23:34 -0700
Message-Id: <20211003052334.15764-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in gtt.c:

gtt.c:1152: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Check if can do 2M page
gtt.c:1152: warning: missing initial short description on line:
 * Check if can do 2M page
gtt.c:2209: warning: expecting prototype for intel_vgpu_emulate_gtt_mmio_read(). Prototype was for intel_vgpu_emulate_ggtt_mmio_read() instead

Fixes: a752b070a678 ("drm/i915/gvt: Fix function comment doc errors")
Fixes: 2707e4446688 ("drm/i915/gvt: vGPU graphics memory virtualization")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Colin Xu <colin.xu@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-gvt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/i915/gvt/gtt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211001.orig/drivers/gpu/drm/i915/gvt/gtt.c
+++ linux-next-20211001/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1148,7 +1148,7 @@ static inline void ppgtt_generate_shadow
 	ops->set_pfn(se, s->shadow_page.mfn);
 }
 
-/**
+/*
  * Check if can do 2M page
  * @vgpu: target vgpu
  * @entry: target pfn's gtt entry
@@ -2193,7 +2193,7 @@ static int emulate_ggtt_mmio_read(struct
 }
 
 /**
- * intel_vgpu_emulate_gtt_mmio_read - emulate GTT MMIO register read
+ * intel_vgpu_emulate_ggtt_mmio_read - emulate GTT MMIO register read
  * @vgpu: a vGPU
  * @off: register offset
  * @p_data: data will be returned to guest
