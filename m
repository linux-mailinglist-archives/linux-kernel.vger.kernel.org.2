Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF90832D648
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhCDPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhCDPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C15C061760
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:14:13 -0800 (PST)
Message-Id: <20210303132711.982307498@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yu34YjnIEyOyfqoftcpNPw8TU3KSWyY89xmWxIGGep0=;
        b=chmwnZQKb5D/CyT40zo//PeCWkbQq4sZX3P81oGa1TA5y/Y1/eQW/WdMO/VE7YAmZLxR+E
        4ISiuYVdI/Bm+151Nj7bgVB4khgxKotITwm3qoqDjJto2+LBO/ZX4fVKpk9LUaYSPNQzvp
        ZDNEtN+VDeojHH2oQYxnuVFIOJlkL59fPMSp0lJIDsKueuR9JsYavEmG1sA8Qh+3s2Wkiv
        A0UtARr7st+Fw8HI3Jl5TgyD9SmkAp0Oo6q9s2H54g+t89F7+2t/C7ixKOFKik8ceLy/od
        GXkWACpSk9qaFk6SWfHqmw7B66SlrwA3PMz02/HZ3Q3xFSGsSM/XR81tkkWUwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yu34YjnIEyOyfqoftcpNPw8TU3KSWyY89xmWxIGGep0=;
        b=oQztf/0RVI2avMzXgiQF+z+XX3Cp+a3u3ZVfKmq2tsgbIrWCc7WtT2UobyCvmD2tVI+fiZ
        6ArXbSvj9hPd2DBw==
Date:   Wed, 03 Mar 2021 14:20:29 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org
Subject: [patch 6/7] drm/i915: Replace io_mapping_map_atomic_wc()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

None of these mapping requires the side effect of disabling pagefaults and
preemption.

Use io_mapping_map_local_wc() instead, and clean up gtt_user_read() and
gtt_user_write() to use a plain copy_from_user() as the local maps are not
disabling pagefaults.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |    7 +---
 drivers/gpu/drm/i915/i915_gem.c                |   40 ++++++++-----------------
 drivers/gpu/drm/i915/selftests/i915_gem.c      |    4 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c  |    8 ++---
 4 files changed, 22 insertions(+), 37 deletions(-)

--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1080,7 +1080,7 @@ static void reloc_cache_reset(struct rel
 		struct i915_ggtt *ggtt = cache_to_ggtt(cache);
 
 		intel_gt_flush_ggtt_writes(ggtt->vm.gt);
-		io_mapping_unmap_atomic((void __iomem *)vaddr);
+		io_mapping_unmap_local((void __iomem *)vaddr);
 
 		if (drm_mm_node_allocated(&cache->node)) {
 			ggtt->vm.clear_range(&ggtt->vm,
@@ -1146,7 +1146,7 @@ static void *reloc_iomap(struct drm_i915
 
 	if (cache->vaddr) {
 		intel_gt_flush_ggtt_writes(ggtt->vm.gt);
-		io_mapping_unmap_atomic((void __force __iomem *) unmask_page(cache->vaddr));
+		io_mapping_unmap_local((void __force __iomem *) unmask_page(cache->vaddr));
 	} else {
 		struct i915_vma *vma;
 		int err;
@@ -1194,8 +1194,7 @@ static void *reloc_iomap(struct drm_i915
 		offset += page << PAGE_SHIFT;
 	}
 
-	vaddr = (void __force *)io_mapping_map_atomic_wc(&ggtt->iomap,
-							 offset);
+	vaddr = (void __force *)io_mapping_map_local_wc(&ggtt->iomap, offset);
 	cache->page = page;
 	cache->vaddr = (unsigned long)vaddr;
 
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -253,22 +253,15 @@ gtt_user_read(struct io_mapping *mapping
 	      char __user *user_data, int length)
 {
 	void __iomem *vaddr;
-	unsigned long unwritten;
+	bool fail = false;
 
 	/* We can use the cpu mem copy function because this is X86. */
-	vaddr = io_mapping_map_atomic_wc(mapping, base);
-	unwritten = __copy_to_user_inatomic(user_data,
-					    (void __force *)vaddr + offset,
-					    length);
-	io_mapping_unmap_atomic(vaddr);
-	if (unwritten) {
-		vaddr = io_mapping_map_wc(mapping, base, PAGE_SIZE);
-		unwritten = copy_to_user(user_data,
-					 (void __force *)vaddr + offset,
-					 length);
-		io_mapping_unmap(vaddr);
-	}
-	return unwritten;
+	vaddr = io_mapping_map_local_wc(mapping, base);
+	if (copy_to_user(user_data, (void __force *)vaddr + offset, length))
+		fail = true;
+	io_mapping_unmap_local(vaddr);
+
+	return fail;
 }
 
 static int
@@ -437,21 +430,14 @@ ggtt_write(struct io_mapping *mapping,
 	   char __user *user_data, int length)
 {
 	void __iomem *vaddr;
-	unsigned long unwritten;
+	bool fail = false;
 
 	/* We can use the cpu mem copy function because this is X86. */
-	vaddr = io_mapping_map_atomic_wc(mapping, base);
-	unwritten = __copy_from_user_inatomic_nocache((void __force *)vaddr + offset,
-						      user_data, length);
-	io_mapping_unmap_atomic(vaddr);
-	if (unwritten) {
-		vaddr = io_mapping_map_wc(mapping, base, PAGE_SIZE);
-		unwritten = copy_from_user((void __force *)vaddr + offset,
-					   user_data, length);
-		io_mapping_unmap(vaddr);
-	}
-
-	return unwritten;
+	vaddr = io_mapping_map_local_wc(mapping, base);
+	if (copy_from_user((void __force *)vaddr + offset, user_data, length))
+		fail = true;
+	io_mapping_unmap_local(vaddr);
+	return fail;
 }
 
 /**
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -58,12 +58,12 @@ static void trash_stolen(struct drm_i915
 
 		ggtt->vm.insert_page(&ggtt->vm, dma, slot, I915_CACHE_NONE, 0);
 
-		s = io_mapping_map_atomic_wc(&ggtt->iomap, slot);
+		s = io_mapping_map_local_wc(&ggtt->iomap, slot);
 		for (x = 0; x < PAGE_SIZE / sizeof(u32); x++) {
 			prng = next_pseudo_random32(prng);
 			iowrite32(prng, &s[x]);
 		}
-		io_mapping_unmap_atomic(s);
+		io_mapping_unmap_local(s);
 	}
 
 	ggtt->vm.clear_range(&ggtt->vm, slot, PAGE_SIZE);
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1201,9 +1201,9 @@ static int igt_ggtt_page(void *arg)
 		u64 offset = tmp.start + order[n] * PAGE_SIZE;
 		u32 __iomem *vaddr;
 
-		vaddr = io_mapping_map_atomic_wc(&ggtt->iomap, offset);
+		vaddr = io_mapping_map_local_wc(&ggtt->iomap, offset);
 		iowrite32(n, vaddr + n);
-		io_mapping_unmap_atomic(vaddr);
+		io_mapping_unmap_local(vaddr);
 	}
 	intel_gt_flush_ggtt_writes(ggtt->vm.gt);
 
@@ -1213,9 +1213,9 @@ static int igt_ggtt_page(void *arg)
 		u32 __iomem *vaddr;
 		u32 val;
 
-		vaddr = io_mapping_map_atomic_wc(&ggtt->iomap, offset);
+		vaddr = io_mapping_map_local_wc(&ggtt->iomap, offset);
 		val = ioread32(vaddr + n);
-		io_mapping_unmap_atomic(vaddr);
+		io_mapping_unmap_local(vaddr);
 
 		if (val != n) {
 			pr_err("insert page failed: found %d, expected %d\n",

