Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB83AE999
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUNFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFUNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:05:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0470C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gb4Xc0jhckMTpUbU0AvOmkHXxGN8uRuBfWiJLIWbCwc=; b=BeuvRc3vfVhwl1xHnScd7u1dvi
        coGKRdXF5QCRLzhSE+M7E/A4MlECUcN4VoNY2hYEJf5s4AQm59Hh/J32Yl2krq2tM8EOtDicZ28ln
        MEcN+lUXSaDW37MLv183AOGNNYpHF4dtDkMGzNz4eqY7liEPEFpbD4dcuV2XV9nkp89wVWEPR4mOB
        NpI+r/Nrkcnyy5FahNrEOBLBMJgyhT4KOjZeaejDHvueWrkDr+7PrwLIoiL6hAeC+NBi5d0kEUicD
        1n+o4smxREtIgy/M1K7pXfVHHV/LvcVROfKbd7SJgXvl8MHIrbzfNlJqq+rgyDR2yfebcTEcnp67K
        LliW5EeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvJZ4-00D6gd-Gj; Mon, 21 Jun 2021 13:02:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm: Move kvmalloc-related functions to slab.h
Date:   Mon, 21 Jun 2021 14:02:08 +0100
Message-Id: <20210621130209.3123659-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all files in the kernel should include mm.h.  Migrating callers from
kmalloc to kvmalloc is easier if the kvmalloc functions are in slab.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h   | 32 --------------------------------
 include/linux/slab.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ae31622deef..750a6f227ec7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -798,38 +798,6 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 }
 #endif
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
-static inline void *kvmalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc_node(size, flags, NUMA_NO_NODE);
-}
-static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
-{
-	return kvmalloc_node(size, flags | __GFP_ZERO, node);
-}
-static inline void *kvzalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc(size, flags | __GFP_ZERO);
-}
-
-static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
-
-	return kvmalloc(bytes, flags);
-}
-
-static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
-{
-	return kvmalloc_array(n, size, flags | __GFP_ZERO);
-}
-
-extern void kvfree(const void *addr);
-extern void kvfree_sensitive(const void *addr, size_t len);
-
 static inline int head_compound_mapcount(struct page *head)
 {
 	return atomic_read(compound_mapcount_ptr(head)) + 1;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..ee676de68afe 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -697,6 +697,38 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
 	return kmalloc_node(size, flags | __GFP_ZERO, node);
 }
 
+extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
+static inline void *kvmalloc(size_t size, gfp_t flags)
+{
+	return kvmalloc_node(size, flags, NUMA_NO_NODE);
+}
+static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
+{
+	return kvmalloc_node(size, flags | __GFP_ZERO, node);
+}
+static inline void *kvzalloc(size_t size, gfp_t flags)
+{
+	return kvmalloc(size, flags | __GFP_ZERO);
+}
+
+static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+
+	return kvmalloc(bytes, flags);
+}
+
+static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return kvmalloc_array(n, size, flags | __GFP_ZERO);
+}
+
+extern void kvfree(const void *addr);
+extern void kvfree_sensitive(const void *addr, size_t len);
+
 unsigned int kmem_cache_size(struct kmem_cache *s);
 void __init kmem_cache_init_late(void);
 
-- 
2.30.2

