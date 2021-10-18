Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55375430E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhJRDle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJRDlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:41:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A965C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 20:39:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so13489634pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPx9sGsVBsJjnzOib64gL98eVdY2tjTSHncFbZdEilc=;
        b=XDOz024RIoQztaAP+dfxPGVu0wNPBUg6df3uVJN3zn2wr2PGn6D90XG/SoIGto/k1k
         ce7lhy9eP2z2UC2MneTAmIyoWz5e93Ivucj/aR66JbfNgYArH7RBwhL7oAEm36+CNH29
         0JfLj6TJde8+m+/T9jv1idpo7fbrbQeOyD0Mxp22qZ3mks0vTKZZH5yDQIXVnF1I6/T5
         iJuyDJYUkfvQnPguaQsYk4I29Uq4wBy963nDBB/ky4mFf3ZQC2k6y0/Oz6SC9Jx1gWnP
         TGnxFoRVKub9SnNKL67zBxm5j8AatXZluQsL9WhNEhZthbQmSKWAXsN0b0rdozx8fTlI
         8ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPx9sGsVBsJjnzOib64gL98eVdY2tjTSHncFbZdEilc=;
        b=u2oO+/KsaQXGRHQnJmctemVS/EQ1PG7E8sRmjyMcG6huoJEaxgsU/wIuvtF2s3oLIC
         LI+X/n3Igv0rh+AqfqvCsELUHtYr9IydwUlnsJNx5e/H2EABizGB/9oTnzf35yVOwwRX
         vQ0BXbsmvPGpSXhzW0xWEr2eeUBrd+Vaha4RrALiCYsOkchIvUqlzMVaEnb2eQXYzkuS
         T0Y4yby1gNWKXoAfecdI2jhcfOUiGitUlwk/L5MgttXtEosdc4QZq4QN0pivLrwRrYOq
         /u1PG+Gie0NvGAMs+g2z+BqNSn/WmQAmqtcqsnc9LMi7abM84uYJ0Hi5m+aZuRvGvF3m
         0vxQ==
X-Gm-Message-State: AOAM53065S7PU3y+mOmSE4JEPDQDdNeJoBH/zYwAwW4VY+uvPKJRvFqx
        NgsDVbIADXxYxC+6KQRNODg=
X-Google-Smtp-Source: ABdhPJwgp1h7FNpdoKu159fUn85sIz0jUALuZYzwtfvTMX+g5TsVRdSHf8xJHTLmWQ3ZakKxPFcwDg==
X-Received: by 2002:a17:90b:388f:: with SMTP id mu15mr30418065pjb.28.1634528361572;
        Sun, 17 Oct 2021 20:39:21 -0700 (PDT)
Received: from nuc10.. (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id mi8sm12010895pjb.20.2021.10.17.20.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 20:39:20 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com, Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] slob: add size header to all allocations
Date:   Sun, 17 Oct 2021 20:38:41 -0700
Message-Id: <20211018033841.3027515-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015005729.GD24333@magnolia>
References: <20211015005729.GD24333@magnolia>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's prepend all  allocations of (PAGE_SIZE - align_offset) and less
with the size header. This way kmem_cache_alloc() memory can be freed
with kfree() and the other way around, as long as they are less than
(PAGE_SIZE - align_offset).

The main reason for this change is to simplify SLOB a little bit, make
it a bit easier to debug whenever something goes wrong.

meminfo right after the system boot, without the patch:
Slab:              35500 kB

the same, with the patch:
Slab:              36396 kB

stats for compiling glibc without the patch:
      1,493,972.89 msec task-clock                #    3.557 CPUs utilized
           317,158      context-switches          #  212.292 /sec
             8,567      cpu-migrations            #    5.734 /sec
        33,788,323      page-faults               #   22.616 K/sec
 5,267,687,400,091      cycles                    #    3.526 GHz
 4,388,201,248,601      instructions              #    0.83  insn per cycle
   885,424,236,657      branches                  #  592.664 M/sec
    14,117,492,893      branch-misses             #    1.59% of all branches

     420.051843478 seconds time elapsed

     472.784856000 seconds user
    1024.645256000 seconds sys

the same with the patch:
      1,803,990.92 msec task-clock                #    3.597 CPUs utilized
           330,110      context-switches          #  182.989 /sec
             9,170      cpu-migrations            #    5.083 /sec
        33,789,627      page-faults               #   18.730 K/sec
 6,499,753,661,134      cycles                    #    3.603 GHz
 4,564,216,028,344      instructions              #    0.70  insn per cycle
   917,120,742,440      branches                  #  508.384 M/sec
    15,068,415,552      branch-misses             #    1.64% of all branches

     501.519434175 seconds time elapsed

     495.587614000 seconds user
    1312.652833000 seconds sys

Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 mm/slob.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 74d3f6e60666..3d8fbb33f5a3 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -373,25 +373,28 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
 	}
 	if (unlikely(gfp & __GFP_ZERO))
 		memset(b, 0, size);
+	/* Write size in the header */
+	*(unsigned int *)b = size - align_offset;
+	b = (void *)b + align_offset;
 	return b;
 }
 
 /*
  * slob_free: entry point into the slob allocator.
  */
-static void slob_free(void *block, int size)
+static void slob_free(void *block)
 {
 	struct page *sp;
-	slob_t *prev, *next, *b = (slob_t *)block;
+	int align_offset = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+	void *hdr = (void *)block - align_offset;
+	unsigned int size = *(unsigned int *)hdr + align_offset;
+	slob_t *prev, *next, *b = (slob_t *)hdr;
 	slobidx_t units;
 	unsigned long flags;
 	struct list_head *slob_list;
 
-	if (unlikely(ZERO_OR_NULL_PTR(block)))
-		return;
-	BUG_ON(!size);
-
-	sp = virt_to_page(block);
+	BUG_ON(!size || size >= PAGE_SIZE);
+	sp = virt_to_page(hdr);
 	units = SLOB_UNITS(size);
 
 	spin_lock_irqsave(&slob_lock, flags);
@@ -476,7 +479,6 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
-	unsigned int *m;
 	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *ret;
 
@@ -497,12 +499,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		if (!size)
 			return ZERO_SIZE_PTR;
 
-		m = slob_alloc(size + minalign, gfp, align, node, minalign);
-
-		if (!m)
-			return NULL;
-		*m = size;
-		ret = (void *)m + minalign;
+		ret = slob_alloc(size + minalign, gfp, align, node, minalign);
 
 		trace_kmalloc_node(caller, ret,
 				   size, size + minalign, gfp, node);
@@ -554,9 +551,7 @@ void kfree(const void *block)
 
 	sp = virt_to_page(block);
 	if (PageSlab(sp)) {
-		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
-		unsigned int *m = (unsigned int *)(block - align);
-		slob_free(m, *m + align);
+		slob_free((void *)block);
 	} else {
 		unsigned int order = compound_order(sp);
 		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
@@ -567,7 +562,6 @@ void kfree(const void *block)
 }
 EXPORT_SYMBOL(kfree);
 
-/* can't use ksize for kmem_cache_alloc memory, only kmalloc */
 size_t __ksize(const void *block)
 {
 	struct page *sp;
@@ -600,16 +594,17 @@ int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 
 static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 {
+	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *b;
 
 	flags &= gfp_allowed_mask;
 
 	might_alloc(flags);
 
-	if (c->size < PAGE_SIZE) {
-		b = slob_alloc(c->size, flags, c->align, node, 0);
+	if (c->size < PAGE_SIZE - minalign) {
+		b = slob_alloc(c->size + minalign, flags, c->align, node, minalign);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
+					    SLOB_UNITS(c->size + minalign) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
@@ -649,8 +644,14 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 static void __kmem_cache_free(void *b, int size)
 {
-	if (size < PAGE_SIZE)
-		slob_free(b, size);
+	struct page *sp;
+
+	if (unlikely(ZERO_OR_NULL_PTR(b)))
+		return;
+
+	sp = virt_to_page(b);
+	if (PageSlab(sp))
+		slob_free(b);
 	else
 		slob_free_pages(b, get_order(size));
 }
-- 
2.30.2

