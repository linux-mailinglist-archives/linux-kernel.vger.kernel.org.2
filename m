Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8727642AB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJLSD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:55 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C25C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m13so206013qvk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbJgcnawwGjXwGJ+K39oDahwdZcJV0i7dw3hiC/LbPg=;
        b=5QzNpr2BLUJljDOokSOrPvDtFpuVc2sQczyen4O28zLyi/SZAeeUF4PZj3EHu1Ejh9
         6og8K5GbRhy0s+5frTMlywctpmIm/awkwIE+1yomNj0vZKSHX6Ykd7HM8741HuQ+Y4Ym
         N/XcCd5KEM05IRe9srxI+6keDwm0vLRzuxMweb1LwgLKsc6qMs9pg0wSz3vmByeUZZMA
         miMRtC7mZqhHfFSUCPkMCn4WmMInn0NwC/CHd8syZKbLSPREr1uhq4EQTmPcS6qVya8g
         zebI/wMDknFkZfUs5J4RUw+pDv8zVzF0bQzTlSwdT+jjL1l2qUuVOQbluBQUqReRXvr4
         w71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbJgcnawwGjXwGJ+K39oDahwdZcJV0i7dw3hiC/LbPg=;
        b=cA98C/0X7p53Sk8x3nou3nDJ+JwgVJuwxuYAeuO6e9wOASz+33vi7L397/wOwe/Klh
         NTv8XGnYBbv2rEs4TIZx7GD36zp42f/BRZEckfBr7qbdlyplLK1DK7j/YN37Da1cVPF3
         L8oHb9ny/10eY2IRHnHz6odey+3Zyx/Qt2wK6apkk7MXs/xsgztoosLGXv5v/NGKiv/w
         49M4i6pFA3uKIOMjAfwD7rdEtwrgFOGwl4wkO5ptIw8ZfgniKiz8Qje6/TpOwo5fK6Gm
         vFl0QpCr9tOmlhvf6yIzPLGp/lDA7dPTbGvMKuRwgYtXcik45fl2Io6TobscTHYGl19C
         X/AA==
X-Gm-Message-State: AOAM531PknhlQnqW9v1VVi19W5KERdR7b8xVgC4ebwIJQug66AhOzMMK
        aRyskA3hcuH/T0WMFPCEROqxtA==
X-Google-Smtp-Source: ABdhPJzTe2asDGWWbqqNCni7taALl8el2xqT2c/oJLsadygVsrY+qHQZwzxlTiPhVhwsEAu/G5f6FQ==
X-Received: by 2002:ad4:470e:: with SMTP id k14mr30980031qvz.55.1634061712890;
        Tue, 12 Oct 2021 11:01:52 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id o130sm3304642qke.123.2021.10.12.11.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:52 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/11] PageSlab: bubble compound_head() into callsites
Date:   Tue, 12 Oct 2021 14:01:38 -0400
Message-Id: <20211012180148.1669685-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be safe to call on tail pages, PageSlab() currently does
an unconditional compound_head() lookup. This adds overhead to many
contexts in which tail pages cannot occur.

To have tailpage resolution only in places that need it, move the
compound_head() call from PageSlab() into all current callsites. This
is a mechanical replacement with no change in behavior or overhead.

Subsequent patches will be able to eliminate the compound_head() calls
from contexts in which they are not needed.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 arch/ia64/kernel/mca_drv.c |  2 +-
 drivers/ata/libata-sff.c   |  2 +-
 fs/proc/page.c             |  6 ++++--
 include/linux/memcontrol.h |  6 +++---
 include/linux/net.h        |  2 +-
 include/linux/page-flags.h | 10 +++++-----
 kernel/resource.c          |  2 +-
 mm/debug.c                 |  2 +-
 mm/kasan/common.c          |  4 ++--
 mm/kasan/generic.c         |  2 +-
 mm/kasan/report.c          |  2 +-
 mm/kasan/report_tags.c     |  2 +-
 mm/memory-failure.c        |  6 +++---
 mm/memory.c                |  3 ++-
 mm/nommu.c                 |  2 +-
 mm/slab.c                  |  2 +-
 mm/slab.h                  |  5 +++--
 mm/slab_common.c           |  4 ++--
 mm/slob.c                  |  4 ++--
 mm/slub.c                  | 12 ++++++------
 mm/usercopy.c              |  2 +-
 mm/util.c                  |  2 +-
 22 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/arch/ia64/kernel/mca_drv.c b/arch/ia64/kernel/mca_drv.c
index 5bfc79be4cef..903e7c26b63e 100644
--- a/arch/ia64/kernel/mca_drv.c
+++ b/arch/ia64/kernel/mca_drv.c
@@ -136,7 +136,7 @@ mca_page_isolate(unsigned long paddr)
 		return ISOLATE_NG;
 
 	/* kick pages having attribute 'SLAB' or 'Reserved' */
-	if (PageSlab(p) || PageReserved(p))
+	if (PageSlab(compound_head(p)) || PageReserved(p))
 		return ISOLATE_NG;
 
 	/* add attribute 'Reserved' and register the page */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b71ea4a680b0..3a46d305616e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -647,7 +647,7 @@ static void ata_pio_xfer(struct ata_queued_cmd *qc, struct page *page,
 	qc->ap->ops->sff_data_xfer(qc, buf + offset, xfer_size, do_write);
 	kunmap_atomic(buf);
 
-	if (!do_write && !PageSlab(page))
+	if (!do_write && !PageSlab(compound_head(page)))
 		flush_dcache_page(page);
 }
 
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9f1077d94cde..2c249f84e1fd 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -66,7 +66,8 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 		 */
 		ppage = pfn_to_online_page(pfn);
 
-		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
+		if (!ppage ||
+		    PageSlab(compound_head(ppage)) || page_has_type(ppage))
 			pcount = 0;
 		else
 			pcount = page_mapcount(ppage);
@@ -126,7 +127,7 @@ u64 stable_page_flags(struct page *page)
 	 * Note that page->_mapcount is overloaded in SLOB/SLUB/SLQB, so the
 	 * simple test in page_mapped() is not enough.
 	 */
-	if (!PageSlab(page) && page_mapped(page))
+	if (!PageSlab(compound_head(page)) && page_mapped(page))
 		u |= 1 << KPF_MMAP;
 	if (PageAnon(page))
 		u |= 1 << KPF_ANON;
@@ -152,6 +153,7 @@ u64 stable_page_flags(struct page *page)
 	else if (PageTransCompound(page)) {
 		struct page *head = compound_head(page);
 
+		/* XXX: misses isolated file THPs */
 		if (PageLRU(head) || PageAnon(head))
 			u |= 1 << KPF_THP;
 		else if (is_huge_zero_page(head)) {
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3096c9a0ee01..02394f802698 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -397,7 +397,7 @@ static inline struct mem_cgroup *__page_memcg(struct page *page)
 {
 	unsigned long memcg_data = page->memcg_data;
 
-	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(PageSlab(compound_head(page)), page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
 
@@ -418,7 +418,7 @@ static inline struct obj_cgroup *__page_objcg(struct page *page)
 {
 	unsigned long memcg_data = page->memcg_data;
 
-	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(PageSlab(compound_head(page)), page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
 	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
 
@@ -466,7 +466,7 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
 	unsigned long memcg_data = READ_ONCE(page->memcg_data);
 
-	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(PageSlab(compound_head(page)), page);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
diff --git a/include/linux/net.h b/include/linux/net.h
index ba736b457a06..79767ae262ef 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -299,7 +299,7 @@ do {									\
  */
 static inline bool sendpage_ok(struct page *page)
 {
-	return !PageSlab(page) && page_count(page) >= 1;
+	return !PageSlab(compound_head(page)) && page_count(page) >= 1;
 }
 
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a558d67ee86f..e96c9cb5bf8b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -344,7 +344,7 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
-__PAGEFLAG(Slab, slab, PF_NO_TAIL)
+__PAGEFLAG(Slab, slab, PF_ONLY_HEAD)
 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
@@ -776,7 +776,7 @@ __PAGEFLAG(Isolated, isolated, PF_ANY);
  */
 static inline int PageSlabPfmemalloc(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
+	VM_BUG_ON_PAGE(!PageSlab(compound_head(page)), page);
 	return PageActive(page);
 }
 
@@ -791,19 +791,19 @@ static inline int __PageSlabPfmemalloc(struct page *page)
 
 static inline void SetPageSlabPfmemalloc(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
+	VM_BUG_ON_PAGE(!PageSlab(compound_head(page)), page);
 	SetPageActive(page);
 }
 
 static inline void __ClearPageSlabPfmemalloc(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
+	VM_BUG_ON_PAGE(!PageSlab(compound_head(page)), page);
 	__ClearPageActive(page);
 }
 
 static inline void ClearPageSlabPfmemalloc(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
+	VM_BUG_ON_PAGE(!PageSlab(compound_head(page)), page);
 	ClearPageActive(page);
 }
 
diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..a363211fda99 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -151,7 +151,7 @@ static void free_resource(struct resource *res)
 	if (!res)
 		return;
 
-	if (!PageSlab(virt_to_head_page(res))) {
+	if (!PageSlab(compound_head(virt_to_head_page(res)))) {
 		spin_lock(&bootmem_resource_lock);
 		res->sibling = bootmem_resource_free;
 		bootmem_resource_free = res;
diff --git a/mm/debug.c b/mm/debug.c
index fae0f81ad831..500f5adce00e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -84,7 +84,7 @@ static void __dump_page(struct page *page)
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(compound_head(head)) ? 0 : page_mapcount(page);
 
 	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
 			page, page_ref_count(head), mapcount, mapping,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2baf121fb8c5..b5e81273fc6b 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -411,7 +411,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	 * !PageSlab() when the size provided to kmalloc is larger than
 	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
 	 */
-	if (unlikely(!PageSlab(page))) {
+	if (unlikely(!PageSlab(compound_head(page)))) {
 		if (____kasan_kfree_large(ptr, ip))
 			return;
 		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE, false);
@@ -575,7 +575,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	page = virt_to_head_page(object);
 
 	/* Piggy-back on kmalloc() instrumentation to poison the redzone. */
-	if (unlikely(!PageSlab(page)))
+	if (unlikely(!PageSlab(compound_head(page))))
 		return __kasan_kmalloc_large(object, size, flags);
 	else
 		return ____kasan_kmalloc(page->slab_cache, object, size, flags);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index c3f5ba7a294a..94c0c86c79d9 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -335,7 +335,7 @@ void kasan_record_aux_stack(void *addr)
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
 
-	if (is_kfence_address(addr) || !(page && PageSlab(page)))
+	if (is_kfence_address(addr) || !(page && PageSlab(compound_head(page))))
 		return;
 
 	cache = page->slab_cache;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 884a950c7026..7cdcf968f43f 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -256,7 +256,7 @@ static void print_address_description(void *addr, u8 tag)
 	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
-	if (page && PageSlab(page)) {
+	if (page && PageSlab(compound_head(page))) {
 		struct kmem_cache *cache = page->slab_cache;
 		void *object = nearest_obj(cache, page,	addr);
 
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 8a319fc16dab..32f955d98e76 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -21,7 +21,7 @@ const char *kasan_get_bug_type(struct kasan_access_info *info)
 	tag = get_tag(info->access_addr);
 	addr = kasan_reset_tag(info->access_addr);
 	page = kasan_addr_to_page(addr);
-	if (page && PageSlab(page)) {
+	if (page && PageSlab(compound_head(page))) {
 		cache = page->slab_cache;
 		object = nearest_obj(cache, page, (void *)addr);
 		alloc_meta = kasan_get_alloc_meta(cache, object);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e6449f2102a..0d214f800a4e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -131,7 +131,7 @@ static int hwpoison_filter_dev(struct page *p)
 	/*
 	 * page_mapping() does not accept slab pages.
 	 */
-	if (PageSlab(p))
+	if (PageSlab(compound_head(p)))
 		return -EINVAL;
 
 	mapping = page_mapping(p);
@@ -289,7 +289,7 @@ void shake_page(struct page *p)
 	if (PageHuge(p))
 		return;
 
-	if (!PageSlab(p)) {
+	if (!PageSlab(compound_head(p))) {
 		lru_add_drain_all();
 		if (PageLRU(p) || is_free_buddy_page(p))
 			return;
@@ -1285,7 +1285,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * Here we are interested only in user-mapped pages, so skip any
 	 * other types of pages.
 	 */
-	if (PageReserved(p) || PageSlab(p))
+	if (PageReserved(p) || PageSlab(compound_head(p)))
 		return true;
 	if (!(PageLRU(hpage) || PageHuge(p)))
 		return true;
diff --git a/mm/memory.c b/mm/memory.c
index adf9b9ef8277..a789613af270 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1738,7 +1738,8 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 
 static int validate_page_before_insert(struct page *page)
 {
-	if (PageAnon(page) || PageSlab(page) || page_has_type(page))
+	if (PageAnon(page) ||
+	    PageSlab(compound_head(page)) || page_has_type(page))
 		return -EINVAL;
 	flush_dcache_page(page);
 	return 0;
diff --git a/mm/nommu.c b/mm/nommu.c
index 02d2427b8f9e..c233126dd476 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -87,7 +87,7 @@ unsigned int kobjsize(const void *objp)
 	 * If the allocator sets PageSlab, we know the pointer came from
 	 * kmalloc().
 	 */
-	if (PageSlab(page))
+	if (PageSlab(compound_head(page)))
 		return ksize(objp);
 
 	/*
diff --git a/mm/slab.c b/mm/slab.c
index d0f725637663..829f2b6d4af7 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1396,7 +1396,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
 {
 	int order = cachep->gfporder;
 
-	BUG_ON(!PageSlab(page));
+	BUG_ON(!PageSlab(compound_head(page)));
 	__ClearPageSlabPfmemalloc(page);
 	__ClearPageSlab(page);
 	page_mapcount_reset(page);
diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..0446948c9c4e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -410,8 +410,9 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 	struct page *page;
 
 	page = virt_to_head_page(obj);
-	if (WARN_ONCE(!PageSlab(page), "%s: Object is not a Slab page!\n",
-					__func__))
+	if (WARN_ONCE(!PageSlab(compound_head(page)),
+		      "%s: Object is not a Slab page!\n",
+		      __func__))
 		return NULL;
 	return page->slab_cache;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..5f7063797f0e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -564,7 +564,7 @@ bool kmem_valid_obj(void *object)
 	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
 		return false;
 	page = virt_to_head_page(object);
-	return PageSlab(page);
+	return PageSlab(compound_head(page));
 }
 EXPORT_SYMBOL_GPL(kmem_valid_obj);
 
@@ -594,7 +594,7 @@ void kmem_dump_obj(void *object)
 	if (WARN_ON_ONCE(!virt_addr_valid(object)))
 		return;
 	page = virt_to_head_page(object);
-	if (WARN_ON_ONCE(!PageSlab(page))) {
+	if (WARN_ON_ONCE(!PageSlab(compound_head(page)))) {
 		pr_cont(" non-slab memory.\n");
 		return;
 	}
diff --git a/mm/slob.c b/mm/slob.c
index 74d3f6e60666..4115788227fb 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -553,7 +553,7 @@ void kfree(const void *block)
 	kmemleak_free(block);
 
 	sp = virt_to_page(block);
-	if (PageSlab(sp)) {
+	if (PageSlab(compound_head(sp))) {
 		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 		unsigned int *m = (unsigned int *)(block - align);
 		slob_free(m, *m + align);
@@ -579,7 +579,7 @@ size_t __ksize(const void *block)
 		return 0;
 
 	sp = virt_to_page(block);
-	if (unlikely(!PageSlab(sp)))
+	if (unlikely(!PageSlab(compound_head(sp))))
 		return page_size(sp);
 
 	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..37a4cc1e73a7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1089,7 +1089,7 @@ static int check_slab(struct kmem_cache *s, struct page *page)
 {
 	int maxobj;
 
-	if (!PageSlab(page)) {
+	if (!PageSlab(compound_head(page))) {
 		slab_err(s, page, "Not a valid slab page");
 		return 0;
 	}
@@ -1295,7 +1295,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 	return 1;
 
 bad:
-	if (PageSlab(page)) {
+	if (PageSlab(compound_head(page))) {
 		/*
 		 * If this is a slab page then lets do the best we can
 		 * to avoid issues in the future. Marking all objects
@@ -1325,7 +1325,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 		return 0;
 
 	if (unlikely(s != page->slab_cache)) {
-		if (!PageSlab(page)) {
+		if (!PageSlab(compound_head(page))) {
 			slab_err(s, page, "Attempt to free object(0x%p) outside of slab",
 				 object);
 		} else if (!page->slab_cache) {
@@ -3554,7 +3554,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	page = virt_to_head_page(object);
 	if (!s) {
 		/* Handle kalloc'ed objects */
-		if (unlikely(!PageSlab(page))) {
+		if (unlikely(!PageSlab(compound_head(page)))) {
 			free_nonslab_page(page, object);
 			p[size] = NULL; /* mark object processed */
 			return size;
@@ -4516,7 +4516,7 @@ size_t __ksize(const void *object)
 
 	page = virt_to_head_page(object);
 
-	if (unlikely(!PageSlab(page))) {
+	if (unlikely(!PageSlab(compound_head(page)))) {
 		WARN_ON(!PageCompound(page));
 		return page_size(page);
 	}
@@ -4536,7 +4536,7 @@ void kfree(const void *x)
 		return;
 
 	page = virt_to_head_page(x);
-	if (unlikely(!PageSlab(page))) {
+	if (unlikely(!PageSlab(compound_head(page)))) {
 		free_nonslab_page(page, object);
 		return;
 	}
diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..924e236522da 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -235,7 +235,7 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	 */
 	page = compound_head(kmap_to_page((void *)ptr));
 
-	if (PageSlab(page)) {
+	if (PageSlab(compound_head(page))) {
 		/* Check slab allocator for flags and size. */
 		__check_heap_object(ptr, n, page, to_user);
 	} else {
diff --git a/mm/util.c b/mm/util.c
index bacabe446906..6e6abdc9f62e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -712,7 +712,7 @@ struct address_space *page_mapping(struct page *page)
 	page = compound_head(page);
 
 	/* This happens if someone calls flush_dcache_page on slab page */
-	if (unlikely(PageSlab(page)))
+	if (unlikely(PageSlab(compound_head(page))))
 		return NULL;
 
 	if (unlikely(PageSwapCache(page))) {
-- 
2.32.0

