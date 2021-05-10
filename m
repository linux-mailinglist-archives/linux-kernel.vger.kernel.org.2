Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72BB3799C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhEJWNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:13:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B19AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=l9FtiIDV2mfZygSpziLx+5U+3AOuj7vS9oooZcZf29A=; b=Jwg0yxMdakokYx5D5pNzvWSYqS
        bD79q+0czvWABJlEvdQ/P+mQSw3RkLmYyhN1b1n7SP4ymu7GYrc5QfMtd3/naY1+wImCNus9xikN4
        eEsjnvPqobwRNuiLVEkg56mEMUtB+/uwzj8qdyt2o2J9Mq1DAcuHclfJb8qhNPM62dJWdmFGXvDPL
        wACUVxBt/3+Q8mjhzWVkhpRafZmEufXqPuD6fDNylMMNnkRBEJIujPyJl3gaQ/9YUgoLlTI0rgWZ+
        5EOCRHmfMthTgOkJZN2ejT6BywSjsQDHHLn0kcrzLPiMrFnn4GT7Iw2wIoft0lHid+Mxp1+caVCn2
        frmIyNJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgE8Q-006d5c-SV; Mon, 10 May 2021 22:12:22 +0000
Date:   Mon, 10 May 2021 23:12:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC] folio_try_get / folio_try_get_rcu
Message-ID: <YJmvwmk85IGS+71+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's something I'm working on for the next revision of the folio
patchset.  If you look at v9, you'll see calls to
page_cache_get_speculative(&folio->page), and I'm trying to avoid
using &folio->page as much as possible.

That led me to examine the various callers of page_cache_get_speculative()
and it turns out that gup-fast calls it as well, so any function name
involving the page cache is definitely wrong.  But it needs a name
that puts people off using it unless they know what they're doing,
so I went with folio_try_get_rcu() to go along with folio_try_get()
that is slightly less optimised and less tricky to use.

commit 01b6b67f1c23b7a10fb8db6c8d4fa2f245a52f34
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon May 10 16:33:22 2021 -0400

    mm: Add folio_try_get_rcu
    
    This is the equivalent of page_cache_get_speculative().  Also add
    folio_ref_try_add_rcu (the equivalent of page_cache_add_speculative)
    and folio_try_get() (the equivalent of get_page_unless_zero()).
    
    The new kernel-doc attempts to explain from the user's point of view
    when to use folio_try_get_rcu() and when to use folio_get_unless_zero(),
    because there seems to be some confusion currently between the users of
    page_cache_get_speculative() and get_page_unless_zero().
    
    Reimplement page_cache_add_speculative() and page_cache_get_speculative()
    as wrappers around the folio equivalents, but leave get_page_unless_zero()
    alone for now.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 85816b2c0496..a4244a17b49a 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -233,20 +233,86 @@ static inline int folio_ref_dec_return(struct folio *folio)
 	return page_ref_dec_return(&folio->page);
 }
 
-static inline int page_ref_add_unless(struct page *page, int nr, int u)
+static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	int ret = atomic_add_unless(&page->_refcount, nr, u);
+	bool ret = atomic_add_unless(&page->_refcount, nr, u);
 
 	if (page_ref_tracepoint_active(page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
 	return ret;
 }
 
-static inline int folio_ref_add_unless(struct folio *folio, int nr, int u)
+static inline bool folio_ref_add_unless(struct folio *folio, int nr, int u)
 {
 	return page_ref_add_unless(&folio->page, nr, u);
 }
 
+/**
+ * folio_try_get - Attempt to increase the refcount on a folio.
+ * @folio: The folio.
+ *
+ * If you do not already have a reference to a folio, you can attempt to
+ * get one using this function.  It may fail if, for example, the folio
+ * has been freed since you found a pointer to it, or it is frozen for
+ * the purposes of splitting or migration.
+ *
+ * Return: true if the reference count was successfully incremented.
+ */
+static inline bool folio_try_get(struct folio *folio)
+{
+	return folio_ref_add_unless(folio, 1, 0);
+}
+
+static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
+{
+#ifdef CONFIG_TINY_RCU
+	/*
+	 * The caller guarantees the folio will not be freed from interrupt
+	 * context, so (on !SMP) we only need preemption to be disabled
+	 * and TINY_RCU does that for us.
+	 */
+# ifdef CONFIG_PREEMPT_COUNT
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
+# endif
+	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
+	folio_ref_add(folio, count);
+#else
+	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
+		/* Either the folio has been freed, or will be freed. */
+		return false;
+	}
+#endif
+	return true;
+}
+
+/**
+ * folio_try_get_rcu - Attempt to increase the refcount on a folio.
+ * @folio: The folio.
+ *
+ * This is a version of folio_try_get() optimised for non-SMP users.
+ * If you are still holding the rcu_read_lock() after looking up the
+ * page and know that the page cannot have its refcount decreased to
+ * zero in interrupt context, you can use this instead of folio_try_get().
+ *
+ * Example users include get_user_pages_fast() (as pages are not unmapped
+ * from interrupt context) and the page cache lookups (as pages are not
+ * truncated from interrupt context).  We also know that pages are not
+ * frozen in interrupt context for the purposes of splitting or migration.
+ *
+ * You can also use this function if you're holding a lock that prevents
+ * pages being removed; eg the xarray lock for the page cache or the
+ * mmap_sem or page table lock for page tables.  In this case, it will
+ * always succeed, and you could have used a plain folio_ref_inc(),
+ * but it's sometimes more convenient to have a common function called
+ * from both locked and RCU-protected contexts.
+ *
+ * Return: true if the reference count was successfully incremented.
+ */
+static inline bool folio_try_get_rcu(struct folio *folio)
+{
+	return folio_ref_try_add_rcu(folio, 1);
+}
+
 static inline int page_ref_freeze(struct page *page, int count)
 {
 	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a4bd41128bf3..4900e64c880d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -172,91 +172,15 @@ static inline struct address_space *page_mapping_file(struct page *page)
 	return page_mapping(page);
 }
 
-/*
- * speculatively take a reference to a page.
- * If the page is free (_refcount == 0), then _refcount is untouched, and 0
- * is returned. Otherwise, _refcount is incremented by 1 and 1 is returned.
- *
- * This function must be called inside the same rcu_read_lock() section as has
- * been used to lookup the page in the pagecache radix-tree (or page table):
- * this allows allocators to use a synchronize_rcu() to stabilize _refcount.
- *
- * Unless an RCU grace period has passed, the count of all pages coming out
- * of the allocator must be considered unstable. page_count may return higher
- * than expected, and put_page must be able to do the right thing when the
- * page has been finished with, no matter what it is subsequently allocated
- * for (because put_page is what is used here to drop an invalid speculative
- * reference).
- *
- * This is the interesting part of the lockless pagecache (and lockless
- * get_user_pages) locking protocol, where the lookup-side (eg. find_get_page)
- * has the following pattern:
- * 1. find page in radix tree
- * 2. conditionally increment refcount
- * 3. check the page is still in pagecache (if no, goto 1)
- *
- * Remove-side that cares about stability of _refcount (eg. reclaim) has the
- * following (with the i_pages lock held):
- * A. atomically check refcount is correct and set it to 0 (atomic_cmpxchg)
- * B. remove page from pagecache
- * C. free the page
- *
- * There are 2 critical interleavings that matter:
- * - 2 runs before A: in this case, A sees elevated refcount and bails out
- * - A runs before 2: in this case, 2 sees zero refcount and retries;
- *   subsequently, B will complete and 1 will find no page, causing the
- *   lookup to return NULL.
- *
- * It is possible that between 1 and 2, the page is removed then the exact same
- * page is inserted into the same position in pagecache. That's OK: the
- * old find_get_page using a lock could equally have run before or after
- * such a re-insertion, depending on order that locks are granted.
- *
- * Lookups racing against pagecache insertion isn't a big problem: either 1
- * will find the page or it will not. Likewise, the old find_get_page could run
- * either before the insertion or afterwards, depending on timing.
- */
-static inline int __page_cache_add_speculative(struct page *page, int count)
+static inline bool page_cache_add_speculative(struct page *page, int count)
 {
-#ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	/*
-	 * Preempt must be disabled here - we rely on rcu_read_lock doing
-	 * this for us.
-	 *
-	 * Pagecache won't be truncated from interrupt context, so if we have
-	 * found a page in the radix tree here, we have pinned its refcount by
-	 * disabling preempt, and hence no need for the "speculative get" that
-	 * SMP requires.
-	 */
-	VM_BUG_ON_PAGE(page_count(page) == 0, page);
-	page_ref_add(page, count);
-
-#else
-	if (unlikely(!page_ref_add_unless(page, count, 0))) {
-		/*
-		 * Either the page has been freed, or will be freed.
-		 * In either case, retry here and the caller should
-		 * do the right thing (see comments above).
-		 */
-		return 0;
-	}
-#endif
 	VM_BUG_ON_PAGE(PageTail(page), page);
-
-	return 1;
-}
-
-static inline int page_cache_get_speculative(struct page *page)
-{
-	return __page_cache_add_speculative(page, 1);
+	return folio_ref_try_add_rcu((struct folio *)page, count);
 }
 
-static inline int page_cache_add_speculative(struct page *page, int count)
+static inline bool page_cache_get_speculative(struct page *page)
 {
-	return __page_cache_add_speculative(page, count);
+	return page_cache_add_speculative(page, 1);
 }
 
 /**
