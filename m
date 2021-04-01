Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FD351F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhDATVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhDATVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:21:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B83C05BD12
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 11:17:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v6so6571297ybk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zj6gtvaZjQIgZc62gAWXEdUGn4ceYnrbr7Zk4v3KyJw=;
        b=FlA6Ify3u1OV06IaOI9B0LYyrXeZoWmreC02IOZYYHu/MUJtSU4Ou9/vrF9K3qQLhe
         ygWgDaWkNlXAF60dV7Xw/XO2/jYyTfw4V+h4JT5W2aDrN/fB7OLEY8Zrzsa4E6oUy4I8
         zHOjRf0KeBX3ep2aOKMWt4ZRRMLdYopkba6YGvBXqLCQ2D+uN/boZ6AcDKPJqlcrJ/9c
         UJ5UBcD0kgKpTYW+9N4gwGEWWt35JbzTQKTS4CU9RcC+STB+pQDPVGfLeZN6TJ8VfQ78
         xdHc4e8SYRY69SOBF0lCvOxO5UJOJyZIghev2lg2vbU1llQ66geybPr2oZk/lgpDY+cg
         FyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zj6gtvaZjQIgZc62gAWXEdUGn4ceYnrbr7Zk4v3KyJw=;
        b=R98laJq47OE7RqmOpjBilMVtbGrkg3X5hd/u/42o6WU2xne84arHBL80nXzp1TWPf8
         USImJiZU1jfUXEW9r45Us1l9GpwuBCt37PrKq3e5HJL+J23zMKjYHO3KWrHeq07Go+1P
         ThD49epJVcUGXNE5/osA0SqZeUiZHxs2cX67te5aYISREDvXBV5tyJMRX268bHGpPXXW
         FYDrfKe9D9jL/BFHzMyzTf+YvUqkCZo6+a1FQRO/6ccpwJ0NU+flfZyplmMIldhyrAbc
         eO1/rGeNNv5erfSUc5U1AWSQMSGOvX/IPp7Vm4GAjlOmpThP6hR/FUAI7m1z3kBlkHOC
         GGWw==
X-Gm-Message-State: AOAM5332rRRTFNFUZJs2P4I+hOLTw0KoTwSOo0fdp5qX8gOGy5/GrkU8
        YoQfEIneW0va0+Ag8vgzhTpEiFYIeNY=
X-Google-Smtp-Source: ABdhPJw6plyA7HOAVbYj4YxkjtOsN3J8EjN491Hael5AJaDEpRN8aRsEoywhiYhU2sbcxncxqauJJ1bpc74=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:899:1066:21fc:b3c5])
 (user=surenb job=sendgmr) by 2002:a25:2b08:: with SMTP id r8mr13820232ybr.194.1617301069769;
 Thu, 01 Apr 2021 11:17:49 -0700 (PDT)
Date:   Thu,  1 Apr 2021 11:17:37 -0700
In-Reply-To: <20210401181741.168763-1-surenb@google.com>
Message-Id: <20210401181741.168763-2-surenb@google.com>
Mime-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 1/5] mm: reuse only-pte-mapped KSM page in do_wp_page()
From:   Suren Baghdasaryan <surenb@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jannh@google.com, ktkhai@virtuozzo.com,
        torvalds@linux-foundation.org, shli@fb.com, namit@vmware.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

Add an optimization for KSM pages almost in the same way that we have
for ordinary anonymous pages.  If there is a write fault in a page,
which is mapped to an only pte, and it is not related to swap cache; the
page may be reused without copying its content.

[ Note that we do not consider PageSwapCache() pages at least for now,
  since we don't want to complicate __get_ksm_page(), which has nice
  optimization based on this (for the migration case). Currenly it is
  spinning on PageSwapCache() pages, waiting for when they have
  unfreezed counters (i.e., for the migration finish). But we don't want
  to make it also spinning on swap cache pages, which we try to reuse,
  since there is not a very high probability to reuse them. So, for now
  we do not consider PageSwapCache() pages at all. ]

So in reuse_ksm_page() we check for 1) PageSwapCache() and 2)
page_stable_node(), to skip a page, which KSM is currently trying to
link to stable tree.  Then we do page_ref_freeze() to prohibit KSM to
merge one more page into the page, we are reusing.  After that, nobody
can refer to the reusing page: KSM skips !PageSwapCache() pages with
zero refcount; and the protection against of all other participants is
the same as for reused ordinary anon pages pte lock, page lock and
mmap_sem.

[akpm@linux-foundation.org: replace BUG_ON()s with WARN_ON()s]
Link: http://lkml.kernel.org/r/154471491016.31352.1168978849911555609.stgit@localhost.localdomain
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/ksm.h |  7 +++++++
 mm/ksm.c            | 30 ++++++++++++++++++++++++++++--
 mm/memory.c         | 16 ++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 44368b19b27e..def48a2d87aa 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -64,6 +64,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 
 void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
 void ksm_migrate_page(struct page *newpage, struct page *oldpage);
+bool reuse_ksm_page(struct page *page,
+			struct vm_area_struct *vma, unsigned long address);
 
 #else  /* !CONFIG_KSM */
 
@@ -103,6 +105,11 @@ static inline void rmap_walk_ksm(struct page *page,
 static inline void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 {
 }
+static inline bool reuse_ksm_page(struct page *page,
+			struct vm_area_struct *vma, unsigned long address)
+{
+	return false;
+}
 #endif /* CONFIG_MMU */
 #endif /* !CONFIG_KSM */
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 65d4bf52f543..62419735ee9c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -695,8 +695,9 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
 	 * case this node is no longer referenced, and should be freed;
 	 * however, it might mean that the page is under page_freeze_refs().
 	 * The __remove_mapping() case is easy, again the node is now stale;
-	 * but if page is swapcache in migrate_page_move_mapping(), it might
-	 * still be our page, in which case it's essential to keep the node.
+	 * the same is in reuse_ksm_page() case; but if page is swapcache
+	 * in migrate_page_move_mapping(), it might still be our page,
+	 * in which case it's essential to keep the node.
 	 */
 	while (!get_page_unless_zero(page)) {
 		/*
@@ -2609,6 +2610,31 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
 		goto again;
 }
 
+bool reuse_ksm_page(struct page *page,
+		    struct vm_area_struct *vma,
+		    unsigned long address)
+{
+#ifdef CONFIG_DEBUG_VM
+	if (WARN_ON(is_zero_pfn(page_to_pfn(page))) ||
+			WARN_ON(!page_mapped(page)) ||
+			WARN_ON(!PageLocked(page))) {
+		dump_page(page, "reuse_ksm_page");
+		return false;
+	}
+#endif
+
+	if (PageSwapCache(page) || !page_stable_node(page))
+		return false;
+	/* Prohibit parallel get_ksm_page() */
+	if (!page_ref_freeze(page, 1))
+		return false;
+
+	page_move_anon_rmap(page, vma);
+	page->index = linear_page_index(vma, address);
+	page_ref_unfreeze(page, 1);
+
+	return true;
+}
 #ifdef CONFIG_MIGRATION
 void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 21a0bbb9c21f..6920bfb3f89c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2831,8 +2831,11 @@ static int do_wp_page(struct vm_fault *vmf)
 	 * Take out anonymous pages first, anonymous shared vmas are
 	 * not dirty accountable.
 	 */
-	if (PageAnon(vmf->page) && !PageKsm(vmf->page)) {
+	if (PageAnon(vmf->page)) {
 		int total_map_swapcount;
+		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
+					   page_count(vmf->page) != 1))
+			goto copy;
 		if (!trylock_page(vmf->page)) {
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -2847,6 +2850,15 @@ static int do_wp_page(struct vm_fault *vmf)
 			}
 			put_page(vmf->page);
 		}
+		if (PageKsm(vmf->page)) {
+			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
+						     vmf->address);
+			unlock_page(vmf->page);
+			if (!reused)
+				goto copy;
+			wp_page_reuse(vmf);
+			return VM_FAULT_WRITE;
+		}
 		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
 			if (total_map_swapcount == 1) {
 				/*
@@ -2867,7 +2879,7 @@ static int do_wp_page(struct vm_fault *vmf)
 					(VM_WRITE|VM_SHARED))) {
 		return wp_page_shared(vmf);
 	}
-
+copy:
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-- 
2.31.0.291.g576ba9dcdaf-goog

