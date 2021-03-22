Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA0345013
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCVTk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhCVTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:39:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=umAyPvMB0ox2owuNnUxAWBk74eoFU1cPIidPuUVXyPc=; b=OkbGN2/+7oiOzKyUuQ1trRXPSH
        xe/OOw3UKZ4E1Kf7kiAkKE2YzDYBmkfce9VDl50jFpGlCGNZPHTB9zzn4wt+hv380CVWT18ZvbAqq
        RUsATnyf0ElBF0mRuLmOqkRNCEb5KsSbsqB2dk8RANS9k/JefDEo2RvLa0Z/c+5Y6fs1mzLX8Y3Be
        GwB9va8d6u/5RSTV1N10/MXhSrziW1HTECs4tNkitUi2mqZlhx3nshdtYwomAo8oeLCHi7gdp9ZaZ
        /YyJBZ1us4bvLJaN5LAV3czhoJBsArMev3XFInjesxp8LMZ0jTwAs2yJhdol3YOE8TeKYY1FZldU5
        07elDNxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQNa-008yos-2G; Mon, 22 Mar 2021 19:38:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/2] mm/util: Add kvmalloc_node_caller
Date:   Mon, 22 Mar 2021 19:38:19 +0000
Message-Id: <20210322193820.2140045-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the caller of kvmalloc to specify who counts as the allocator
of the memory instead of assuming it's the immediate caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h   |  4 +++-
 include/linux/slab.h |  2 ++
 mm/util.c            | 52 ++++++++++++++++++++++++--------------------
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb1e191da319..b65a7105d9a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -786,7 +786,9 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 }
 #endif
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
+void *kvmalloc_node_caller(size_t size, gfp_t flags, int node,
+		unsigned long caller);
+void *kvmalloc_node(size_t size, gfp_t flags, int node);
 static inline void *kvmalloc(size_t size, gfp_t flags)
 {
 	return kvmalloc_node(size, flags, NUMA_NO_NODE);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..6611b8ee55ee 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -663,6 +663,8 @@ extern void *__kmalloc_node_track_caller(size_t, gfp_t, int, unsigned long);
 
 #else /* CONFIG_NUMA */
 
+#define __kmalloc_node_track_caller(size, flags, node, caller) \
+	__kmalloc_track_caller(size, flags, caller)
 #define kmalloc_node_track_caller(size, flags, node) \
 	kmalloc_track_caller(size, flags)
 
diff --git a/mm/util.c b/mm/util.c
index 0b6dd9d81da7..7120bb8ff9ca 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -539,26 +539,8 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_mmap);
 
-/**
- * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
- * failure, fall back to non-contiguous (vmalloc) allocation.
- * @size: size of the request.
- * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
- * @node: numa node to allocate from
- *
- * Uses kmalloc to get the memory but if the allocation fails then falls back
- * to the vmalloc allocator. Use kvfree for freeing the memory.
- *
- * Reclaim modifiers - __GFP_NORETRY and __GFP_NOFAIL are not supported.
- * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
- * preferable to the vmalloc fallback, due to visible performance drawbacks.
- *
- * Please note that any use of gfp flags outside of GFP_KERNEL is careful to not
- * fall back to vmalloc.
- *
- * Return: pointer to the allocated memory of %NULL in case of failure
- */
-void *kvmalloc_node(size_t size, gfp_t flags, int node)
+void *kvmalloc_node_caller(size_t size, gfp_t flags, int node,
+		unsigned long caller)
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -584,7 +566,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 			kmalloc_flags |= __GFP_NORETRY;
 	}
 
-	ret = kmalloc_node(size, kmalloc_flags, node);
+	ret = __kmalloc_node_track_caller(size, kmalloc_flags, node, caller);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -593,8 +575,32 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
-	return __vmalloc_node(size, 1, flags, node,
-			__builtin_return_address(0));
+	return __vmalloc_node(size, 1, flags, node, (void *)caller);
+}
+
+/**
+ * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * failure, fall back to non-contiguous (vmalloc) allocation.
+ * @size: size of the request.
+ * @flags: GFP flags for the allocation - must be compatible (superset) with GFP_KERNEL.
+ * @node: numa node to allocate from
+ *
+ * Uses kmalloc to get the memory but if the allocation fails then falls back
+ * to the vmalloc allocator. Use kvfree for freeing the memory.
+ *
+ * Reclaim modifiers - __GFP_NORETRY and __GFP_NOFAIL are not supported.
+ * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
+ * preferable to the vmalloc fallback, due to visible performance drawbacks.
+ *
+ * Please note that any use of gfp flags outside of GFP_KERNEL is careful to not
+ * fall back to vmalloc.
+ *
+ * Return: pointer to the allocated memory or %NULL in case of failure.
+ * %ZERO_SIZE_PTR if @size is zero.
+ */
+void *kvmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return kvmalloc_node_caller(size, flags, node, _RET_IP_);
 }
 EXPORT_SYMBOL(kvmalloc_node);
 
-- 
2.30.2

