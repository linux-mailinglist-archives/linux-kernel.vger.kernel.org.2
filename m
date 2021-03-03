Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C332D647
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhCDPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:15:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhCDPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:54 -0500
Message-Id: <20210303132712.077853188@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vxawU6WKg1yAdTzwxrwR7A69cfqTRPEP3GzbWm7j6PI=;
        b=LX6ER4CAc5RBvSn/4Sh0tSlX2kpHC1KfR7bKF6Bx4m+WqypmrPPtsQWDI+0qkI2qj0dKH9
        q3CuC5FUl22+d71u7vWfpqnp5HnifLp/M5QmGMGSNF2Dn117m3Qb+1OY5NglP/RAdvlhhx
        RxkcOSuWrB75nBY/AueAI+oYiBkfF3J7FUuOfam73IA+j7E8ZL25d4XGyFbU8dA38d+QZI
        KOGj7IA5rV3z8EDovPDLYkbVg+EUoZjnEgr4aKnM3y1DEGpqQNdXGpGdLJbITkqL/Wuh7+
        qnE9PqdYbE1oskv+BGJf6UsfsWzdCXZ1eBIYxJoxK6puCd6780muD3se3rKctg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vxawU6WKg1yAdTzwxrwR7A69cfqTRPEP3GzbWm7j6PI=;
        b=mNo5mK70whIQOzTO5Gqg7GGZ1K+G8Bi2DJq4ELQUjaQI7UigGmWbIz4DJ0+ZdeawSGyZzS
        xE5CavRZ1AJUw4Cg==
Date:   Wed, 03 Mar 2021 14:20:30 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Subject: [patch 7/7] io-mapping: Remove io_mapping_map_atomic_wc()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No more users. Get rid of it and remove the traces in documentation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 Documentation/driver-api/io-mapping.rst |   22 +++++-----------
 include/linux/io-mapping.h              |   42 +-------------------------------
 2 files changed, 9 insertions(+), 55 deletions(-)

--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -21,19 +21,15 @@ mappable, while 'size' indicates how lar
 enable. Both are in bytes.
 
 This _wc variant provides a mapping which may only be used with
-io_mapping_map_atomic_wc(), io_mapping_map_local_wc() or
-io_mapping_map_wc().
+io_mapping_map_local_wc() or io_mapping_map_wc().
 
 With this mapping object, individual pages can be mapped either temporarily
 or long term, depending on the requirements. Of course, temporary maps are
-more efficient. They come in two flavours::
+more efficient.
 
 	void *io_mapping_map_local_wc(struct io_mapping *mapping,
 				      unsigned long offset)
 
-	void *io_mapping_map_atomic_wc(struct io_mapping *mapping,
-				       unsigned long offset)
-
 'offset' is the offset within the defined mapping region.  Accessing
 addresses beyond the region specified in the creation function yields
 undefined results. Using an offset which is not page aligned yields an
@@ -50,9 +46,6 @@ io_mapping_map_local_wc() has a side eff
 migration to make the mapping code work. No caller can rely on this side
 effect.
 
-io_mapping_map_atomic_wc() has the side effect of disabling preemption and
-pagefaults. Don't use in new code. Use io_mapping_map_local_wc() instead.
-
 Nested mappings need to be undone in reverse order because the mapping
 code uses a stack for keeping track of them::
 
@@ -65,11 +58,10 @@ Nested mappings need to be undone in rev
 The mappings are released with::
 
 	void io_mapping_unmap_local(void *vaddr)
-	void io_mapping_unmap_atomic(void *vaddr)
 
-'vaddr' must be the value returned by the last io_mapping_map_local_wc() or
-io_mapping_map_atomic_wc() call. This unmaps the specified mapping and
-undoes the side effects of the mapping functions.
+'vaddr' must be the value returned by the last io_mapping_map_local_wc()
+call. This unmaps the specified mapping and undoes eventual side effects of
+the mapping function.
 
 If you need to sleep while holding a mapping, you can use the regular
 variant, although this may be significantly slower::
@@ -77,8 +69,8 @@ If you need to sleep while holding a map
 	void *io_mapping_map_wc(struct io_mapping *mapping,
 				unsigned long offset)
 
-This works like io_mapping_map_atomic/local_wc() except it has no side
-effects and the pointer is globaly visible.
+This works like io_mapping_map_local_wc() except it has no side effects and
+the pointer is globaly visible.
 
 The mappings are released with::
 
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -60,28 +60,7 @@ io_mapping_fini(struct io_mapping *mappi
 	iomap_free(mapping->base, mapping->size);
 }
 
-/* Atomic map/unmap */
-static inline void __iomem *
-io_mapping_map_atomic_wc(struct io_mapping *mapping,
-			 unsigned long offset)
-{
-	resource_size_t phys_addr;
-
-	BUG_ON(offset >= mapping->size);
-	phys_addr = mapping->base + offset;
-	preempt_disable();
-	pagefault_disable();
-	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
-}
-
-static inline void
-io_mapping_unmap_atomic(void __iomem *vaddr)
-{
-	kunmap_local_indexed((void __force *)vaddr);
-	pagefault_enable();
-	preempt_enable();
-}
-
+/* Temporary mappings which are only valid in the current context */
 static inline void __iomem *
 io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
 {
@@ -163,24 +142,7 @@ io_mapping_unmap(void __iomem *vaddr)
 {
 }
 
-/* Atomic map/unmap */
-static inline void __iomem *
-io_mapping_map_atomic_wc(struct io_mapping *mapping,
-			 unsigned long offset)
-{
-	preempt_disable();
-	pagefault_disable();
-	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
-}
-
-static inline void
-io_mapping_unmap_atomic(void __iomem *vaddr)
-{
-	io_mapping_unmap(vaddr);
-	pagefault_enable();
-	preempt_enable();
-}
-
+/* Temporary mappings which are only valid in the current context */
 static inline void __iomem *
 io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
 {

