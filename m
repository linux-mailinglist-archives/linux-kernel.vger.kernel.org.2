Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4F3B0FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFVWBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFVWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:01:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=INWpsc1UVjms1eLYsvuvGZc0zD9LX7V0xGiQqg6km1o=; b=e7r9sbUnAb7gN7BztF5Nm75xsK
        cWpyUXRPWmVUSimdR6iL03cJaLBr1u9OQczRskBllHFSi+GLUa66pqpPPm057WMR+XePc3B91ZGCZ
        S1Y+1tc7b7CmqotwQnaTFC2Iabs5ZFExciQnZJkytuhtJYuBaK2hctXqyzzWiYudxG6qPJfEIJMjQ
        /kJd6RBzAwYy1wAHg401NGgJEel0m+Y71xpkbdug3dYUhzVYO+JWfKiLQ2U5gIbbPiJeWlfkqj0ac
        kEB676HDG2h3ENilpBMO5o5/A2vTzm8artM24Y+XWK1WQb+8U5bk9Fn5wEHiNZtAYVXmWnQbaXIBJ
        MuRaCCTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvoPA-00EnBm-NH; Tue, 22 Jun 2021 21:58:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2] mm: Move kvmalloc-related functions to slab.h
Date:   Tue, 22 Jun 2021 22:57:57 +0100
Message-Id: <20210622215757.3525604-1-willy@infradead.org>
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
v2: allmodconfig revealed someone calling kvmalloc without slab.h.  It
doesn't include mm.h either, but clearly it's being included through
some indirect path.
 drivers/of/kexec.c   |  1 +
 include/linux/mm.h   | 32 --------------------------------
 include/linux/slab.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f335d941a716..b90660c05f30 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/random.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
 /* relevant device tree properties */
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
 
+void *kvmalloc_node(size_t size, gfp_t flags, int node);
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
+void kvfree(const void *addr);
+void kvfree_sensitive(const void *addr, size_t len);
+
 unsigned int kmem_cache_size(struct kmem_cache *s);
 void __init kmem_cache_init_late(void);
 
-- 
2.30.2

