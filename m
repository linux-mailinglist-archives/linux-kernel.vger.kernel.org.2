Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154D5347BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhCXPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbhCXPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:07:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1155C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1JCSW6fhPhnUwYncwpS20rorlG/js5sifoyi387v58U=; b=a12sGQgsKwfYuwbQ1gBupszG1C
        yAeb6nnGZRI3R+69ggOJafJWtp13VdbaAliVZsTER/1hsNxFFU1t2KDbEx5paEL3HHhRlj5KFLf/M
        eC7LAdaYRv8+w94Ny4nBOE2uvC4n+90QiwFjLDlm7E6a2dl68Qxdb7p0OiwJIvYFEQyx1oMeIrEa3
        9wSsZtkcI5F1rPfd+RktLQwnt02h7SKU40Sxu7kaM7EK0o1X8R9r2+Gyeb22Yrx+fAJN/wHb3jmIc
        X+hlVmuCSKoX+WR/UqcSD+LBC0JiSuYIacUF4+U1TJny4vwITd02UstB1FQGY0UEwowuDPnbyR17G
        ucX0BvkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP55t-00BU5L-Jx; Wed, 24 Mar 2021 15:06:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/4] mm/util: Add kvmalloc_node_caller
Date:   Wed, 24 Mar 2021 15:05:16 +0000
Message-Id: <20210324150518.2734402-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210324150518.2734402-1-willy@infradead.org>
References: <20210324150518.2734402-1-willy@infradead.org>
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
 mm/util.c            | 51 +++++++++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 23 deletions(-)

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
index 5c2304bb02ae..96dd498206ad 100644
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
@@ -593,7 +575,32 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
-	return __vmalloc_node(size, 1, flags, node, _RET_IP_);
+	return __vmalloc_node(size, 1, flags, node, caller);
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

