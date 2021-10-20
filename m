Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073AF434CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:58:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C09C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:55:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h193so7196805pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Alx2r+W6FqjxHhQhw1YLbJ40ZJy39J39orH8xtZUcM=;
        b=GI1hMsHej3uZtrSzwsb7LcJ7iF6DJ6L/RZNSu99+QRJqxVoEZr+nejld6tGkyHncWn
         QI0Z+SHuZ9Ud9sRqtU1hJeDzkivtF/HqDAjxlc+wB2h0yZsH5f2EcI9cir2Xs5CXrYmt
         nch90RbsIGT5LZUXfmT5Vf6ucsJAVA4oDrTPGuh5ptn+6Yi4BOBVptogYXE3c+n+lsZ+
         FqWpnQeAa/yJceCj6QVYiUBearDkLaOeXRYQY4iqmaPhoIBBLmNNXQ9jYm/1jrMLY8Uf
         bZ5D8X67ASwIryqM+9Ni8eB5pKsmT6bRFaVXFn/E4VvLsh0L6sJOibG2ShiLASaOwi94
         RTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Alx2r+W6FqjxHhQhw1YLbJ40ZJy39J39orH8xtZUcM=;
        b=d+HuilFrJBzPtaXq23HB5X9SqYbRYdm7vW3QEen6NZZQE2oe1tKCDIaIfX20mEDZDY
         A9jeZ8Y6IC7B0bmRyJqf26Whx+sHqae8Cubdnf/C8SjEabgiOFaBQB4CHrBU/wCv4CRs
         TmS219ZDTtvVsi5nAbKgc44YmUs91LBtptjtZivcik72OcFd5iTyambkOv2n5mDkdBcV
         ufkW2dDp6zR02wd2OTYo0uo5oOAgkilR+TgAu83ON7Ze+DcgmIVSE77gKMWacmhuwh2Z
         fLGjZZGmg3ujoUbBeutwpu37xunn8yJldoigv0fugsPZ29N8KqV4gNF9pb/vvh2iUoVt
         Drcw==
X-Gm-Message-State: AOAM531b1LqvmHrNlrQgdKbTlIq4NLYr/YK5XT/Fo83uF8gk6SaynVKk
        jea78lBpjv3cOfHGnIrIDv12af4wi8Y=
X-Google-Smtp-Source: ABdhPJzn8p0h5VpTaFl3wZ5mywUhXORBvaDgQ9wxNWds3vxAzhhJRJEznuqf3d5X9xV+eGmYb91qdQ==
X-Received: by 2002:a05:6a00:13a1:b0:44c:f60d:5fe6 with SMTP id t33-20020a056a0013a100b0044cf60d5fe6mr178113pfg.48.1634738144964;
        Wed, 20 Oct 2021 06:55:44 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (21.210.64.34.bc.googleusercontent.com. [34.64.210.21])
        by smtp.gmail.com with ESMTPSA id a11sm3055381pfv.11.2021.10.20.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:55:44 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     42.hyeyoo@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH] mm, slob: Rewrite SLOB using segregated free list
Date:   Wed, 20 Oct 2021 13:55:35 +0000
Message-Id: <20211020135535.517236-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-mm, I rewrote SLOB using segregated free list,
to understand SLOB and SLUB more. It uses more kilobytes
of memory (48kB on 32bit tinyconfig) and became 9~10x faster.

But after rewriting, I thought I need to discuss what SLOB is for.
According to Matthew, SLOB is for small machines whose
memory is 1~16 MB.

I wonder adding 48kB on SLOB memory for speed/lower latency
is worth or harmful.

So.. questions in my head now:
    - Who is users of SLOB?
    - Is it harmful to add some kilobytes of memory into SLOB?
    - Is it really possible to run linux under 10MB of RAM?
    	(I failed with tinyconfig.)
    - What is the boundary to make decision between SLOB and SLUB?

Anyway, below is my work.
Any comments/opinions will be appreciated!

SLOB uses sequential fit method. the advantages of this method
is the fact that it is simple and does not have complex metadata.

But big downside of sequential fit method is its high latency
in allocation/deallocation and fast fragmentation.

High latency comes from iterating pages and also iterating objects
in the page to find suitable free object. And fragmentation easily
happens because objects of difference size is allocated in same page.

This patch tries to minimize both its latency and fragmentation by
re-implmenting SLOB using segregated free list method and adding
support for slab merging. it looks like lightweight SLUB but more
compact than SLUB.

One notable difference is after this patch SLOB uses kmalloc_caches
like SL[AU]B.

Below is performance impacts of this patch.

Memory usage was measured on 32 bit + tinyconfig + slab merging.

Before:
    MemTotal:          29668 kB
    MemFree:           19364 kB
    MemAvailable:      18396 kB
    Slab:                668 kB

After:
    MemTotal:          29668 kB
    MemFree:           19420 kB
    MemAvailable:      18452 kB
    Slab:                716 kB

This patch adds about 48 kB after boot.

hackbench was measured on 64 bit typical buildroot configuration.
After this patch it's 9~10x faster than before.

Before:
    memory usage:
        after boot:
            Slab:               7908 kB
        after hackbench:
            Slab:               8544 kB

    Time: 189.947
    Performance counter stats for 'hackbench -g 4 -l 10000':
         379413.20 msec cpu-clock                 #    1.997 CPUs utilized
           8818226      context-switches          #   23.242 K/sec
            375186      cpu-migrations            #  988.859 /sec
              3954      page-faults               #   10.421 /sec
      269923095290      cycles                    #    0.711 GHz
      212341582012      instructions              #    0.79  insn per cycle
        2361087153      branch-misses
       58222839688      cache-references          #  153.455 M/sec
        6786521959      cache-misses              #   11.656 % of all cache refs

     190.002062273 seconds time elapsed

       3.486150000 seconds user
     375.599495000 seconds sys

After:
    memory usage:
       after boot:
           Slab:               7560 kB
        after hackbench:
           Slab:               7836 kB

hackbench:
    Time: 20.780
    Performance counter stats for 'hackbench -g 4 -l 10000':
          41509.79 msec cpu-clock                 #    1.996 CPUs utilized
            630032      context-switches          #   15.178 K/sec
              8287      cpu-migrations            #  199.640 /sec
              4036      page-faults               #   97.230 /sec
       57477161020      cycles                    #    1.385 GHz
       62775453932      instructions              #    1.09  insn per cycle
         164902523      branch-misses
       22559952993      cache-references          #  543.485 M/sec
         832404011      cache-misses              #    3.690 % of all cache refs

      20.791893590 seconds time elapsed

       1.423282000 seconds user
      40.072449000 seconds sys

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/mm_types.h |   4 +-
 include/linux/slab.h     |   8 +-
 mm/slab.h                |  24 +-
 mm/slab_common.c         |   2 -
 mm/slob.c                | 608 ++++++++++++++++-----------------------
 5 files changed, 263 insertions(+), 383 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..465bb00327a5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -131,7 +131,7 @@ struct page {
 #endif
 				};
 			};
-			struct kmem_cache *slab_cache; /* not slob */
+			struct kmem_cache *slab_cache;
 			/* Double-word boundary */
 			void *freelist;		/* first free object */
 			union {
@@ -209,7 +209,7 @@ struct page {
 		unsigned int page_type;
 
 		unsigned int active;		/* SLAB */
-		int units;			/* SLOB */
+		int units;			/* zsmalloc */
 	};
 
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 083f3ce550bc..cca90f289cc3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -327,7 +327,6 @@ enum kmalloc_cache_type {
 	NR_KMALLOC_TYPES
 };
 
-#ifndef CONFIG_SLOB
 extern struct kmem_cache *
 kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 
@@ -423,7 +422,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	return -1;
 }
 #define kmalloc_index(s) __kmalloc_index(s, true)
-#endif /* !CONFIG_SLOB */
 
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
 void *kmem_cache_alloc(struct kmem_cache *, gfp_t flags) __assume_slab_alignment __malloc;
@@ -577,12 +575,11 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
 static __always_inline void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
-#ifndef CONFIG_SLOB
 		unsigned int index;
-#endif
+
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
-#ifndef CONFIG_SLOB
+
 		index = kmalloc_index(size);
 
 		if (!index)
@@ -591,7 +588,6 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 		return kmem_cache_alloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
-#endif
 	}
 	return __kmalloc(size, flags);
 }
diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..19c02568b6fb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -6,6 +6,13 @@
  */
 
 #ifdef CONFIG_SLOB
+
+struct slob {
+	size_t size;
+	spinlock_t lock;
+	struct list_head head[MAX_NUMNODES];
+};
+
 /*
  * Common fields provided in kmem_cache by all slab allocators
  * This struct is either used directly by the allocator (SLOB)
@@ -28,6 +35,7 @@ struct kmem_cache {
 	int refcount;		/* Use counter */
 	void (*ctor)(void *);	/* Called on object slot creation */
 	struct list_head list;	/* List of all slab caches on the system */
+	struct slob slob;
 };
 
 #endif /* CONFIG_SLOB */
@@ -80,14 +88,12 @@ extern const struct kmalloc_info_struct {
 	unsigned int size;
 } kmalloc_info[];
 
-#ifndef CONFIG_SLOB
 /* Kmalloc array related functions */
 void setup_kmalloc_cache_index_table(void);
 void create_kmalloc_caches(slab_flags_t);
 
 /* Find the kmalloc slab corresponding for a certain size */
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
-#endif
 
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
@@ -104,26 +110,12 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 int slab_unmergeable(struct kmem_cache *s);
 struct kmem_cache *find_mergeable(unsigned size, unsigned align,
 		slab_flags_t flags, const char *name, void (*ctor)(void *));
-#ifndef CONFIG_SLOB
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		   slab_flags_t flags, void (*ctor)(void *));
 
 slab_flags_t kmem_cache_flags(unsigned int object_size,
 	slab_flags_t flags, const char *name);
-#else
-static inline struct kmem_cache *
-__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *))
-{ return NULL; }
-
-static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
-	slab_flags_t flags, const char *name)
-{
-	return flags;
-}
-#endif
-
 
 /* Legal flag mask for kmem_cache_create(), for various configurations */
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..09f9d18ce091 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -636,7 +636,6 @@ void kmem_dump_obj(void *object)
 EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
 
-#ifndef CONFIG_SLOB
 /* Create a cache during boot when no slab services are available yet */
 void __init create_boot_cache(struct kmem_cache *s, const char *name,
 		unsigned int size, slab_flags_t flags,
@@ -926,7 +925,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	}
 #endif
 }
-#endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
 {
diff --git a/mm/slob.c b/mm/slob.c
index 74d3f6e60666..6cfc9725a24b 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -6,40 +6,38 @@
  *
  * NUMA support by Paul Mundt, 2007.
  *
+ * Rewritten by Hyeonggon Yoo <42.hyeyoo@gmail.com>, 2021
+ *
  * How SLOB works:
  *
- * The core of SLOB is a traditional K&R style heap allocator, with
+ * The core of SLOB is a simple segregated free list, with
  * support for returning aligned objects. The granularity of this
- * allocator is as little as 2 bytes, however typically most architectures
- * will require 4 bytes on 32-bit and 8 bytes on 64-bit.
- *
- * The slob heap is a set of linked list of pages from alloc_pages(),
- * and within each page, there is a singly-linked list of free blocks
- * (slob_t). The heap is grown on demand. To reduce fragmentation,
- * heap pages are segregated into three lists, with objects less than
- * 256 bytes, objects less than 1024 bytes, and all other objects.
+ * allocator is as little as size of pointers. This will require
+ * 4 bytes on 32-bit and 8 bytes on 64-bit.
  *
- * Allocation from heap involves first searching for a page with
- * sufficient free blocks (using a next-fit-like approach) followed by
- * a first-fit scan of the page. Deallocation inserts objects back
- * into the free list in address order, so this is effectively an
- * address-ordered first fit.
+ * A cache manages a linked list of pages allocated from alloc_pages()
+ * per node. and within each page, there is a singly-linked list of
+ * free blocks. The heap is grown on demand.
  *
- * Above this is an implementation of kmalloc/kfree. Blocks returned
- * from kmalloc are prepended with a 4-byte header with the kmalloc size.
- * If kmalloc is asked for objects of PAGE_SIZE or larger, it calls
+ * If SLOB is asked for objects of PAGE_SIZE or larger, it calls
  * alloc_pages() directly, allocating compound pages so the page order
  * does not have to be separately tracked.
- * These objects are detected in kfree() because PageSlab()
+ * These objects are detected in kfree()/slob_free() because PageSlab()
  * is false for them.
  *
+ * Allocation from heap is done by taking object from freelist of the page.
+ * Deallocation inserts objects back into the head of a freelist.
+ *
+ * Allocation/Deallocation is done in constant time as SLOB does not
+ * iterate list of free objects. SLOB supports slab merging to minimize
+ * memory usage.
+ *
  * SLAB is emulated on top of SLOB by simply calling constructors and
  * destructors for every SLAB allocation. Objects are returned with the
- * 4-byte alignment unless the SLAB_HWCACHE_ALIGN flag is set, in which
- * case the low-level allocator will fragment blocks to create the proper
- * alignment. Again, objects of page-size or greater are allocated by
- * calling alloc_pages(). As SLAB objects know their size, no separate
- * size bookkeeping is necessary and there is essentially no allocation
+ * pointer size alignment unless the cache does not specify its alignment.
+ * Again, objects of page-size or greater are allocated by calling
+ * alloc_pages(). As SLAB objects know their size, no separate size
+ * bookkeeping is necessary and there is essentially no allocation
  * space overhead, and compound pages aren't needed for multi-page
  * allocations.
  *
@@ -50,11 +48,9 @@
  * instead. The common case (or when the node id isn't explicitly provided)
  * will default to the current node, as per numa_node_id().
  *
- * Node aware pages are still inserted in to the global freelist, and
- * these are scanned for by matching against the node id encoded in the
- * page flags. As a result, block allocations that can be satisfied from
- * the freelist will only be done so on pages residing on the same node,
- * in order to prevent random node placement.
+ * A cache manages list of pages per node. So allocations that can be
+ * satisfied from the freelist will only be done so on pages residing
+ * on the same node, in order to prevent random node placement.
  */
 
 #include <linux/kernel.h>
@@ -74,33 +70,12 @@
 #include <linux/atomic.h>
 
 #include "slab.h"
-/*
- * slob_block has a field 'units', which indicates size of block if +ve,
- * or offset of next block if -ve (in SLOB_UNITs).
- *
- * Free blocks of size 1 unit simply contain the offset of the next block.
- * Those with larger size contain their size in the first SLOB_UNIT of
- * memory, and the offset of the next free block in the second SLOB_UNIT.
- */
-#if PAGE_SIZE <= (32767 * 2)
-typedef s16 slobidx_t;
-#else
-typedef s32 slobidx_t;
-#endif
 
-struct slob_block {
-	slobidx_t units;
-};
-typedef struct slob_block slob_t;
 
-/*
- * All partially free slob pages go on these lists.
- */
-#define SLOB_BREAK1 256
-#define SLOB_BREAK2 1024
-static LIST_HEAD(free_slob_small);
-static LIST_HEAD(free_slob_medium);
-static LIST_HEAD(free_slob_large);
+#define for_each_object(__p, __size, __addr, __objects) \
+		for (__p = __addr; \
+		__p < __addr + __objects * __size; \
+		__p += __size)
 
 /*
  * slob_page_free: true for pages on free_slob_pages list.
@@ -122,73 +97,33 @@ static inline void clear_slob_page_free(struct page *sp)
 	__ClearPageSlobFree(sp);
 }
 
-#define SLOB_UNIT sizeof(slob_t)
-#define SLOB_UNITS(size) DIV_ROUND_UP(size, SLOB_UNIT)
-
-/*
- * struct slob_rcu is inserted at the tail of allocated slob blocks, which
- * were created with a SLAB_TYPESAFE_BY_RCU slab. slob_rcu is used to free
- * the block using call_rcu.
- */
-struct slob_rcu {
-	struct rcu_head head;
-	int size;
-};
-
-/*
- * slob_lock protects all slob allocator structures.
- */
-static DEFINE_SPINLOCK(slob_lock);
-
-/*
- * Encode the given size and next info into a free slob block s.
- */
-static void set_slob(slob_t *s, slobidx_t size, slob_t *next)
+static __always_inline unsigned int slob_size(size_t size, int order)
 {
-	slob_t *base = (slob_t *)((unsigned long)s & PAGE_MASK);
-	slobidx_t offset = next - base;
-
-	if (size > 1) {
-		s[0].units = size;
-		s[1].units = offset;
-	} else
-		s[0].units = -offset;
+	return (PAGE_SIZE << order) / size;
 }
 
-/*
- * Return the size of a slob block.
- */
-static slobidx_t slob_units(slob_t *s)
+static void *get_freepointer(void *objp)
 {
-	if (s->units > 0)
-		return s->units;
-	return 1;
+	return (void *)(*(unsigned long *)objp);
 }
 
-/*
- * Return the next free slob block pointer after this one.
- */
-static slob_t *slob_next(slob_t *s)
+static void set_freepointer(void *objp, void *fp)
 {
-	slob_t *base = (slob_t *)((unsigned long)s & PAGE_MASK);
-	slobidx_t next;
-
-	if (s[0].units < 0)
-		next = -s[0].units;
-	else
-		next = s[1].units;
-	return base+next;
+	*(unsigned long *)(objp) = (unsigned long)fp;
 }
 
 /*
- * Returns true if s is the last free block in its page.
+ * struct slob_rcu is inserted at the tail of allocated slob blocks, which
+ * were created with a SLAB_TYPESAFE_BY_RCU slab. slob_rcu is used to free
+ * the block using call_rcu.
  */
-static int slob_last(slob_t *s)
-{
-	return !((unsigned long)slob_next(s) & ~PAGE_MASK);
-}
+struct slob_rcu {
+	struct rcu_head head;
+	unsigned int size;
+};
 
-static void *slob_new_pages(gfp_t gfp, int order, int node)
+
+static struct page *slob_new_pages(gfp_t gfp, int order, int node)
 {
 	struct page *page;
 
@@ -204,10 +139,10 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
 
 	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
 			    PAGE_SIZE << order);
-	return page_address(page);
+	return page;
 }
 
-static void slob_free_pages(void *b, int order)
+static void slob_free_pages(const void *b, int order)
 {
 	struct page *sp = virt_to_page(b);
 
@@ -216,249 +151,156 @@ static void slob_free_pages(void *b, int order)
 
 	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
 			    -(PAGE_SIZE << order));
+
+	sp->mapping = NULL;
 	__free_pages(sp, order);
 }
 
 /*
  * slob_page_alloc() - Allocate a slob block within a given slob_page sp.
  * @sp: Page to look in.
- * @size: Size of the allocation.
- * @align: Allocation alignment.
- * @align_offset: Offset in the allocated block that will be aligned.
- * @page_removed_from_list: Return parameter.
  *
  * Tries to find a chunk of memory at least @size bytes big within @page.
+ * Caller must hold slob->lock.
  *
- * Return: Pointer to memory if allocated, %NULL otherwise.  If the
- *         allocation fills up @page then the page is removed from the
- *         freelist, in this case @page_removed_from_list will be set to
- *         true (set to false otherwise).
+ * Return: Pointer to memory if allocated, %NULL otherwise.
+ * it is wrong if slob_alloc_page() returns NULL because a page should
+ * be removed when it becomes empty.
  */
-static void *slob_page_alloc(struct page *sp, size_t size, int align,
-			      int align_offset, bool *page_removed_from_list)
-{
-	slob_t *prev, *cur, *aligned = NULL;
-	int delta = 0, units = SLOB_UNITS(size);
-
-	*page_removed_from_list = false;
-	for (prev = NULL, cur = sp->freelist; ; prev = cur, cur = slob_next(cur)) {
-		slobidx_t avail = slob_units(cur);
-
-		/*
-		 * 'aligned' will hold the address of the slob block so that the
-		 * address 'aligned'+'align_offset' is aligned according to the
-		 * 'align' parameter. This is for kmalloc() which prepends the
-		 * allocated block with its size, so that the block itself is
-		 * aligned when needed.
-		 */
-		if (align) {
-			aligned = (slob_t *)
-				(ALIGN((unsigned long)cur + align_offset, align)
-				 - align_offset);
-			delta = aligned - cur;
-		}
-		if (avail >= units + delta) { /* room enough? */
-			slob_t *next;
-
-			if (delta) { /* need to fragment head to align? */
-				next = slob_next(cur);
-				set_slob(aligned, avail - delta, next);
-				set_slob(cur, delta, aligned);
-				prev = cur;
-				cur = aligned;
-				avail = slob_units(cur);
-			}
-
-			next = slob_next(cur);
-			if (avail == units) { /* exact fit? unlink. */
-				if (prev)
-					set_slob(prev, slob_units(prev), next);
-				else
-					sp->freelist = next;
-			} else { /* fragment */
-				if (prev)
-					set_slob(prev, slob_units(prev), cur + units);
-				else
-					sp->freelist = cur + units;
-				set_slob(cur + units, avail - units, next);
-			}
-
-			sp->units -= units;
-			if (!sp->units) {
-				clear_slob_page_free(sp);
-				*page_removed_from_list = true;
-			}
-			return cur;
-		}
-		if (slob_last(cur))
-			return NULL;
+static void *slob_page_alloc(struct page *sp)
+{
+	void *cur;
+
+	cur = sp->freelist;
+	VM_BUG_ON(!cur);
+	sp->freelist = get_freepointer(cur);
+	sp->inuse++;
+
+	return cur;
+}
+
+/*
+ * slob_init_page() - Initialize a page for slab allocation
+ *
+ * Initializes free objects and its free pointer.
+ * Caller must hold slob->lock.
+ */
+static void slob_init_page(struct kmem_cache *s, struct page *sp,
+		int order, size_t size)
+{
+	void *cur, *prev, *addr = page_address(sp);
+	struct slob *slob = &s->slob;
+	int node = page_to_nid(sp);
+	struct list_head *head = &slob->head[node];
+
+	size = ALIGN(size, sizeof(void *));
+	size = ALIGN(size, s->align);
+
+	__SetPageSlab(sp);
+	sp->objects = slob_size(size, order);
+	sp->inuse = 0;
+	sp->freelist = addr;
+	sp->slab_cache = s;
+	INIT_LIST_HEAD(&sp->slab_list);
+
+	prev = NULL;
+	for_each_object(cur, size, addr, sp->objects) {
+		if (prev)
+			set_freepointer(prev, cur);
+		set_freepointer(cur, NULL);
+		prev = cur;
 	}
+
+	set_slob_page_free(sp, head);
 }
 
 /*
  * slob_alloc: entry point into the slob allocator.
  */
-static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
-							int align_offset)
+static void *slob_alloc(struct kmem_cache *s, gfp_t gfp, int node)
 {
+	struct slob *slob;
 	struct page *sp;
-	struct list_head *slob_list;
-	slob_t *b = NULL;
+	struct list_head *head;
+	void *objp = NULL;
 	unsigned long flags;
-	bool _unused;
 
-	if (size < SLOB_BREAK1)
-		slob_list = &free_slob_small;
-	else if (size < SLOB_BREAK2)
-		slob_list = &free_slob_medium;
-	else
-		slob_list = &free_slob_large;
+	if (node == NUMA_NO_NODE)
+		node = numa_mem_id();
 
-	spin_lock_irqsave(&slob_lock, flags);
-	/* Iterate through each partially free page, try to find room */
-	list_for_each_entry(sp, slob_list, slab_list) {
-		bool page_removed_from_list = false;
-#ifdef CONFIG_NUMA
-		/*
-		 * If there's a node specification, search for a partial
-		 * page with a matching node id in the freelist.
-		 */
-		if (node != NUMA_NO_NODE && page_to_nid(sp) != node)
-			continue;
-#endif
-		/* Enough room on this page? */
-		if (sp->units < SLOB_UNITS(size))
-			continue;
-
-		b = slob_page_alloc(sp, size, align, align_offset, &page_removed_from_list);
-		if (!b)
-			continue;
-
-		/*
-		 * If slob_page_alloc() removed sp from the list then we
-		 * cannot call list functions on sp.  If so allocation
-		 * did not fragment the page anyway so optimisation is
-		 * unnecessary.
-		 */
-		if (!page_removed_from_list) {
-			/*
-			 * Improve fragment distribution and reduce our average
-			 * search time by starting our next search here. (see
-			 * Knuth vol 1, sec 2.5, pg 449)
-			 */
-			if (!list_is_first(&sp->slab_list, slob_list))
-				list_rotate_to_front(&sp->slab_list, slob_list);
-		}
-		break;
-	}
-	spin_unlock_irqrestore(&slob_lock, flags);
+	slob = &s->slob;
+	head = &slob->head[node];
+
+	spin_lock_irqsave(&slob->lock, flags);
+
+	if (list_empty(head)) {
+		spin_unlock_irqrestore(&slob->lock, flags);
+		sp = slob_new_pages(gfp & ~__GFP_ZERO, 0, node);
 
-	/* Not enough space: must allocate a new page */
-	if (!b) {
-		b = slob_new_pages(gfp & ~__GFP_ZERO, 0, node);
-		if (!b)
+		if (!sp)
 			return NULL;
-		sp = virt_to_page(b);
-		__SetPageSlab(sp);
-
-		spin_lock_irqsave(&slob_lock, flags);
-		sp->units = SLOB_UNITS(PAGE_SIZE);
-		sp->freelist = b;
-		INIT_LIST_HEAD(&sp->slab_list);
-		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
-		set_slob_page_free(sp, slob_list);
-		b = slob_page_alloc(sp, size, align, align_offset, &_unused);
-		BUG_ON(!b);
-		spin_unlock_irqrestore(&slob_lock, flags);
-	}
+
+		spin_lock_irqsave(&slob->lock, flags);
+		slob_init_page(s, sp, 0, s->size);
+	} else
+		sp = list_first_entry(head, struct page, slab_list);
+
+	objp = slob_page_alloc(sp);
+
+	VM_BUG_ON(((unsigned long)objp & PAGE_MASK) !=
+			((unsigned long)page_address(sp) & PAGE_MASK));
+
+	if (sp->inuse == sp->objects)
+		clear_slob_page_free(sp);
+
+	spin_unlock_irqrestore(&slob->lock, flags);
+
 	if (unlikely(gfp & __GFP_ZERO))
-		memset(b, 0, size);
-	return b;
+		memset(objp, 0, s->size);
+	return objp;
 }
 
 /*
  * slob_free: entry point into the slob allocator.
  */
-static void slob_free(void *block, int size)
+static void slob_free(struct kmem_cache *c, void *block)
 {
 	struct page *sp;
-	slob_t *prev, *next, *b = (slob_t *)block;
-	slobidx_t units;
+	struct slob *slob;
 	unsigned long flags;
-	struct list_head *slob_list;
+	int node;
 
 	if (unlikely(ZERO_OR_NULL_PTR(block)))
 		return;
-	BUG_ON(!size);
 
 	sp = virt_to_page(block);
-	units = SLOB_UNITS(size);
+	slob = &c->slob;
+	node = page_to_nid(sp);
+
+	spin_lock_irqsave(&slob->lock, flags);
+
+	set_freepointer(block, sp->freelist);
+	sp->freelist = block;
+	sp->inuse--;
 
-	spin_lock_irqsave(&slob_lock, flags);
+	VM_BUG_ON(((unsigned long)block & PAGE_MASK) !=
+			((unsigned long)page_address(sp) & PAGE_MASK));
 
-	if (sp->units + units == SLOB_UNITS(PAGE_SIZE)) {
+	if (!sp->inuse) {
 		/* Go directly to page allocator. Do not pass slob allocator */
 		if (slob_page_free(sp))
 			clear_slob_page_free(sp);
-		spin_unlock_irqrestore(&slob_lock, flags);
+		spin_unlock_irqrestore(&slob->lock, flags);
+
 		__ClearPageSlab(sp);
-		page_mapcount_reset(sp);
-		slob_free_pages(b, 0);
+		slob_free_pages(block, 0);
 		return;
 	}
 
-	if (!slob_page_free(sp)) {
-		/* This slob page is about to become partially free. Easy! */
-		sp->units = units;
-		sp->freelist = b;
-		set_slob(b, units,
-			(void *)((unsigned long)(b +
-					SLOB_UNITS(PAGE_SIZE)) & PAGE_MASK));
-		if (size < SLOB_BREAK1)
-			slob_list = &free_slob_small;
-		else if (size < SLOB_BREAK2)
-			slob_list = &free_slob_medium;
-		else
-			slob_list = &free_slob_large;
-		set_slob_page_free(sp, slob_list);
-		goto out;
-	}
+	if (!slob_page_free(sp))
+		set_slob_page_free(sp, &slob->head[node]);
 
-	/*
-	 * Otherwise the page is already partially free, so find reinsertion
-	 * point.
-	 */
-	sp->units += units;
-
-	if (b < (slob_t *)sp->freelist) {
-		if (b + units == sp->freelist) {
-			units += slob_units(sp->freelist);
-			sp->freelist = slob_next(sp->freelist);
-		}
-		set_slob(b, units, sp->freelist);
-		sp->freelist = b;
-	} else {
-		prev = sp->freelist;
-		next = slob_next(prev);
-		while (b > next) {
-			prev = next;
-			next = slob_next(prev);
-		}
-
-		if (!slob_last(prev) && b + units == next) {
-			units += slob_units(next);
-			set_slob(b, units, slob_next(next));
-		} else
-			set_slob(b, units, next);
-
-		if (prev + slob_units(prev) == b) {
-			units = slob_units(b) + slob_units(prev);
-			set_slob(prev, units, slob_next(b));
-		} else
-			set_slob(prev, slob_units(prev), b);
-	}
-out:
-	spin_unlock_irqrestore(&slob_lock, flags);
+	spin_unlock_irqrestore(&slob->lock, flags);
 }
 
 #ifdef CONFIG_PRINTK
@@ -476,43 +318,36 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
-	unsigned int *m;
-	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *ret;
+	struct page *sp;
 
 	gfp &= gfp_allowed_mask;
 
 	might_alloc(gfp);
 
-	if (size < PAGE_SIZE - minalign) {
-		int align = minalign;
-
-		/*
-		 * For power of two sizes, guarantee natural alignment for
-		 * kmalloc()'d objects.
-		 */
-		if (is_power_of_2(size))
-			align = max(minalign, (int) size);
+	if (unlikely(!size))
+		return ZERO_SIZE_PTR;
 
-		if (!size)
-			return ZERO_SIZE_PTR;
+	size = ALIGN(size, ARCH_KMALLOC_MINALIGN);
 
-		m = slob_alloc(size + minalign, gfp, align, node, minalign);
-
-		if (!m)
-			return NULL;
-		*m = size;
-		ret = (void *)m + minalign;
+	if (size < PAGE_SIZE) {
+		struct kmem_cache *s;
 
+		s = kmalloc_slab(size, gfp);
+		ret = slob_alloc(s, gfp, node);
 		trace_kmalloc_node(caller, ret,
-				   size, size + minalign, gfp, node);
+				   size, s->size, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
 		if (likely(order))
 			gfp |= __GFP_COMP;
-		ret = slob_new_pages(gfp, order, node);
 
+		sp = slob_new_pages(gfp, order, node);
+		if (!sp)
+			return NULL;
+
+		ret = page_address(sp);
 		trace_kmalloc_node(caller, ret,
 				   size, PAGE_SIZE << order, gfp, node);
 	}
@@ -553,28 +388,20 @@ void kfree(const void *block)
 	kmemleak_free(block);
 
 	sp = virt_to_page(block);
-	if (PageSlab(sp)) {
-		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
-		unsigned int *m = (unsigned int *)(block - align);
-		slob_free(m, *m + align);
-	} else {
-		unsigned int order = compound_order(sp);
-		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
-				    -(PAGE_SIZE << order));
-		__free_pages(sp, order);
 
-	}
+	if (PageSlab(sp))
+		slob_free(sp->slab_cache, (void *)block);
+	else
+		slob_free_pages(block, compound_order(sp));
 }
 EXPORT_SYMBOL(kfree);
 
-/* can't use ksize for kmem_cache_alloc memory, only kmalloc */
 size_t __ksize(const void *block)
 {
 	struct page *sp;
-	int align;
-	unsigned int *m;
 
 	BUG_ON(!block);
+
 	if (unlikely(block == ZERO_SIZE_PTR))
 		return 0;
 
@@ -582,18 +409,26 @@ size_t __ksize(const void *block)
 	if (unlikely(!PageSlab(sp)))
 		return page_size(sp);
 
-	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
-	m = (unsigned int *)(block - align);
-	return SLOB_UNITS(*m) * SLOB_UNIT;
+	return sp->slab_cache->size;
 }
 EXPORT_SYMBOL(__ksize);
 
 int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 {
+	int node;
+	struct slob *slob;
+
 	if (flags & SLAB_TYPESAFE_BY_RCU) {
 		/* leave room for rcu footer at the end of object */
 		c->size += sizeof(struct slob_rcu);
 	}
+
+	slob = &c->slob;
+	spin_lock_init(&slob->lock);
+	for_each_node(node) {
+		INIT_LIST_HEAD(&slob->head[node]);
+	}
+
 	c->flags = flags;
 	return 0;
 }
@@ -601,21 +436,26 @@ int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 {
 	void *b;
+	struct page *sp;
 
 	flags &= gfp_allowed_mask;
 
 	might_alloc(flags);
 
 	if (c->size < PAGE_SIZE) {
-		b = slob_alloc(c->size, flags, c->align, node, 0);
+		b = slob_alloc(c, flags, node);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
-					    flags, node);
+					    c->size, flags, node);
 	} else {
-		b = slob_new_pages(flags, get_order(c->size), node);
+		unsigned int order = get_order(c->size);
+
+		sp = slob_new_pages(flags, order, node);
+		if (!sp)
+			return NULL;
+
+		b = page_address(sp);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    PAGE_SIZE << get_order(c->size),
-					    flags, node);
+					    PAGE_SIZE << order, flags, node);
 	}
 
 	if (b && c->ctor) {
@@ -647,33 +487,36 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 #endif
 
-static void __kmem_cache_free(void *b, int size)
+static void __kmem_cache_free(struct kmem_cache *c, void *b)
 {
-	if (size < PAGE_SIZE)
-		slob_free(b, size);
+	struct page *sp = virt_to_page(b);
+
+	if (PageSlab(sp))
+		slob_free(c, b);
 	else
-		slob_free_pages(b, get_order(size));
+		slob_free_pages(b, get_order(c->size));
 }
 
 static void kmem_rcu_free(struct rcu_head *head)
 {
 	struct slob_rcu *slob_rcu = (struct slob_rcu *)head;
 	void *b = (void *)slob_rcu - (slob_rcu->size - sizeof(struct slob_rcu));
+	struct page *sp = virt_to_page(b);
 
-	__kmem_cache_free(b, slob_rcu->size);
+	__kmem_cache_free(sp->slab_cache, b);
 }
 
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
 	kmemleak_free_recursive(b, c->flags);
+
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
 		slob_rcu->size = c->size;
 		call_rcu(&slob_rcu->head, kmem_rcu_free);
-	} else {
-		__kmem_cache_free(b, c->size);
-	}
+	} else
+		__kmem_cache_free(c, b);
 
 	trace_kmem_cache_free(_RET_IP_, b, c->name);
 }
@@ -716,7 +559,13 @@ struct kmem_cache kmem_cache_boot = {
 
 void __init kmem_cache_init(void)
 {
+
 	kmem_cache = &kmem_cache_boot;
+	__kmem_cache_create(kmem_cache, kmem_cache->flags);
+
+	setup_kmalloc_cache_index_table();
+	create_kmalloc_caches(0);
+
 	slab_state = UP;
 }
 
@@ -724,3 +573,48 @@ void __init kmem_cache_init_late(void)
 {
 	slab_state = FULL;
 }
+
+struct kmem_cache *
+__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
+		   slab_flags_t flags, void (*ctor)(void *))
+{
+	struct kmem_cache *s = NULL;
+
+	s = find_mergeable(size, align, flags, name, ctor);
+	if (s) {
+		s->refcount++;
+		s->object_size = max(s->object_size, size);
+	}
+
+	return s;
+}
+
+slab_flags_t kmem_cache_flags(unsigned int object_size,
+	slab_flags_t flags, const char *name)
+{
+	return flags;
+}
+
+#ifdef CONFIG_TRACING
+void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfp, size_t size)
+{
+	void *ret = slob_alloc_node(s, gfp, NUMA_NO_NODE);
+
+	trace_kmalloc(_RET_IP, ret, size, s->size, gfp);
+	return ret
+}
+
+#ifdef CONFIG_NUMA
+void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
+					   gfp_t gfp,
+					   int node, size_t size)
+{
+	void *ret = slob_alloc_node(s, gfp, node);
+
+	trace_kmalloc_node(_RET_IP, ret,
+			   size, s->size, gfp, node);
+	return ret;
+}
+#endif
+
+#endif
-- 
2.27.0

