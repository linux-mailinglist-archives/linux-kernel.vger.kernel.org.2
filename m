Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949132D643
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhCDPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhCDPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AFC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:14:08 -0800 (PST)
Message-Id: <20210303132711.487711828@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rJE6TfIVVBhUiw4RP/fALBnIsuzL/pXFN6DWG6//yDc=;
        b=DdgdpNUstaCQQp7YZTE5STTaQn8aWHYCROUbnlQvqMDHJoXuu/PCF3+vSeMK3n+K9n6BZP
        rhXkBucdIm3hKv2Ry+vckd2S/3a3xrfq7i1LTyXRoZe5ol/4t7AIsAdmwhk69LLel3VtCF
        DHytdPNb/tmLe2tB27KyWVP8DuvKQnCJjp9acbNHr5R2Juc8bS8pSI1XJ8F7B6bk4bPXl2
        GdNVO5PP8a1xH5m7Pe6wTgQxmT2zAGS6LbCI/eD3OY/H6rhk0SWbBxJ3W10Zz223cRsw1e
        22Pg+JNZxEOC2T6V0dFlRwYzQ6ZQwBz77QpFsEPr19+HD6TMfOP+4qzr8zZ3Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rJE6TfIVVBhUiw4RP/fALBnIsuzL/pXFN6DWG6//yDc=;
        b=eVdvhEFWtouHdvBn5qUl5XDmNbqC9EasL94g7pQARkVIiPzX9TlLt0cRQEF+e/ZDBDl3ho
        dKJMbuZp9HjKD8Bw==
Date:   Wed, 03 Mar 2021 14:20:25 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Subject: [patch 2/7] drm/vmgfx: Replace kmap_atomic()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to disable pagefaults and preemption as a side effect of
kmap_atomic_prot().

Use kmap_local_page_prot() instead and document the reasoning for the
mapping usage with the given pgprot.

Remove the NULL pointer check for the map. These functions return a valid
address for valid pages and the return was bogus anyway as it would have
left preemption and pagefaults disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -375,12 +375,12 @@ static int vmw_bo_cpu_blit_line(struct v
 		copy_size = min_t(u32, copy_size, PAGE_SIZE - src_page_offset);
 
 		if (unmap_src) {
-			kunmap_atomic(d->src_addr);
+			kunmap_local(d->src_addr);
 			d->src_addr = NULL;
 		}
 
 		if (unmap_dst) {
-			kunmap_atomic(d->dst_addr);
+			kunmap_local(d->dst_addr);
 			d->dst_addr = NULL;
 		}
 
@@ -388,12 +388,8 @@ static int vmw_bo_cpu_blit_line(struct v
 			if (WARN_ON_ONCE(dst_page >= d->dst_num_pages))
 				return -EINVAL;
 
-			d->dst_addr =
-				kmap_atomic_prot(d->dst_pages[dst_page],
-						 d->dst_prot);
-			if (!d->dst_addr)
-				return -ENOMEM;
-
+			d->dst_addr = kmap_local_page_prot(d->dst_pages[dst_page],
+							   d->dst_prot);
 			d->mapped_dst = dst_page;
 		}
 
@@ -401,12 +397,8 @@ static int vmw_bo_cpu_blit_line(struct v
 			if (WARN_ON_ONCE(src_page >= d->src_num_pages))
 				return -EINVAL;
 
-			d->src_addr =
-				kmap_atomic_prot(d->src_pages[src_page],
-						 d->src_prot);
-			if (!d->src_addr)
-				return -ENOMEM;
-
+			d->src_addr = kmap_local_page_prot(d->src_pages[src_page],
+							   d->src_prot);
 			d->mapped_src = src_page;
 		}
 		diff->do_cpy(diff, d->dst_addr + dst_page_offset,
@@ -436,8 +428,10 @@ static int vmw_bo_cpu_blit_line(struct v
  *
  * Performs a CPU blit from one buffer object to another avoiding a full
  * bo vmap which may exhaust- or fragment vmalloc space.
- * On supported architectures (x86), we're using kmap_atomic which avoids
- * cross-processor TLB- and cache flushes and may, on non-HIGHMEM systems
+ *
+ * On supported architectures (x86), we're using kmap_local_prot() which
+ * avoids cross-processor TLB- and cache flushes. kmap_local_prot() will
+ * either map a highmem page with the proper pgprot on HIGHMEM=y systems or
  * reference already set-up mappings.
  *
  * Neither of the buffer objects may be placed in PCI memory
@@ -500,9 +494,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_ob
 	}
 out:
 	if (d.src_addr)
-		kunmap_atomic(d.src_addr);
+		kunmap_local(d.src_addr);
 	if (d.dst_addr)
-		kunmap_atomic(d.dst_addr);
+		kunmap_local(d.dst_addr);
 
 	return ret;
 }


