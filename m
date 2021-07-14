Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4543C93B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhGNWYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235314AbhGNWYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H812mv/wTrZmXHNWLysXz5OhepU17RDOgYfB/9PUivE=;
        b=fnOy5sZeI7UYQGFw9zPqjZ1gg6yuM0cQKN5k+oYe+ZvdAAKfo+KY9yYhSEkF0Cd/mG/+V9
        GAiBFcCXwr94k7ri9mT0Uy5ZSuIVI9UCquUssAW03nnQ2kzlKHa+D65UHUzDXtwGtUpvz4
        eMFvIciRuLkAXH9V7iHGFv15Zjd/gh8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-0fBqmDXiMTGkP9pa5pr8HQ-1; Wed, 14 Jul 2021 18:21:39 -0400
X-MC-Unique: 0fBqmDXiMTGkP9pa5pr8HQ-1
Received: by mail-qk1-f197.google.com with SMTP id bk12-20020a05620a1a0cb02903b899a4309cso2297662qkb.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H812mv/wTrZmXHNWLysXz5OhepU17RDOgYfB/9PUivE=;
        b=iTh4xY5GFuw7hrhID5BUxE1lwWC4kIvoGYMqLNlXQDnnvRQHgZF3ZpNXuIPrY++cYH
         WYZEMp44georEb0mYjxp5hW70Ds1RcKqFRcw/bafk5fM2fTU4qzNqlt5J9adHwnNlBLC
         4pzGBHXDVgD3PHmnQalYTil/VjMCpdj0lTmLL9yb7RL3s56KXkC5kwNGtVWuPct4CjTD
         EEafsch/ABuQPH4XW719YLzCG986AP/TTw3FLkNthsPSsyGKwdJvxRygF2X3NCajmMAG
         r55weURhgret/E6W4g17BZ7QSP+3u1+KhWJ0Q/q+59uvwxu2IM2m26yS0FNMMz1/Wznx
         WCQQ==
X-Gm-Message-State: AOAM531X1EYVkzb/3Yv+OybjlipKwxTwHM7MyJeJ3GuAa7+u7TPed05U
        mOt9s08O2AZHAUdlDdFsiaz1XEwsei3nnpKlJgGuQkQjy8STcVC1yPuPajGdoiEuJje/CShynzo
        srJz2QeyParD/kGSPvWzauP2gnU6WvWcyqUt8exckPl/eGUVix2kbmnka8PWJeD4/2NPXxN2qEg
        ==
X-Received: by 2002:a05:620a:749:: with SMTP id i9mr197431qki.307.1626301298499;
        Wed, 14 Jul 2021 15:21:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHYlutPxUiBbHqP+vSZyJAcuxKco53LdGPPWF3poLQbmRvjHjziOODXUM7Cndyj1DnANybjA==
X-Received: by 2002:a05:620a:749:: with SMTP id i9mr197388qki.307.1626301298138;
        Wed, 14 Jul 2021 15:21:38 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 10/26] shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed
Date:   Wed, 14 Jul 2021 18:21:01 -0400
Message-Id: <20210714222117.47648-11-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory is prone to being unmapped at any time.  It means all
information in the pte will be dropped, including the uffd-wp flag.

Since the uffd-wp info cannot be stored in page cache or swap cache, persist
this wr-protect information by installing the special uffd-wp marker pte when
we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
we will know it's previously wr-protected by recognizing the special pte.

Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
persist such an information.  For example, when destroying the whole vma, or
punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
bit when holding the page lock.  It means the unmap_mapping_range() in
shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
because that's still racy with the page faults.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h        | 11 +++++++++
 include/linux/mm_inline.h | 42 +++++++++++++++++++++++++++++++++
 mm/memory.c               | 49 +++++++++++++++++++++++++++++++++++++--
 mm/rmap.c                 |  8 +++++++
 4 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 62a75e4414e3..8de230fc7b84 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1719,6 +1719,8 @@ extern void user_shm_unlock(size_t, struct ucounts *);
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
 /* Whether to skip zapping swap entries */
 #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
+/* Whether to completely drop uffd-wp entries for file-backed memory */
+#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1752,6 +1754,15 @@ zap_skip_swap(struct zap_details *details)
 	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
 }
 
+static inline bool
+zap_drop_file_uffd_wp(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..95556b4bfe7a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,8 @@
 
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
+#include <linux/swapops.h>
 
 /**
  * page_is_file_lru - should the page be on a file LRU or anon LRU?
@@ -104,4 +106,44 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
 			-thp_nr_pages(page));
 }
+
+/*
+ * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
+ * replace a none pte.  NOTE!  This should only be called when *pte is already
+ * cleared so we will never accidentally replace something valuable.  Meanwhile
+ * none pte also means we are not demoting the pte so tlb flushed is not needed.
+ * E.g., when pte cleared the caller should have taken care of the tlb flush.
+ *
+ * Must be called with pgtable lock held.
+ */
+static inline void
+pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t *pte, pte_t pteval)
+{
+#ifdef CONFIG_USERFAULTFD
+	bool arm_uffd_pte = false;
+
+	/* The current status of the pte should be "cleared" before calling */
+	WARN_ON_ONCE(!pte_none(*pte));
+
+	if (vma_is_anonymous(vma))
+		return;
+
+	/* A uffd-wp wr-protected normal pte */
+	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
+		arm_uffd_pte = true;
+
+	/*
+	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
+	 * pte_swp_uffd_wp_special() too.
+	 */
+	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
+		arm_uffd_pte = true;
+
+	if (unlikely(arm_uffd_pte))
+		set_pte_at(vma->vm_mm, addr, pte,
+			   pte_swp_mkuffd_wp_special(vma));
+#endif
+}
+
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index d6b1adbf29e4..223781f115e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/mm_inline.h>
 
 #include <trace/events/kmem.h>
 
@@ -1301,6 +1302,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	return ret;
 }
 
+/*
+ * This function makes sure that we'll replace the none pte with an uffd-wp
+ * swap special pte marker when necessary. Must be with the pgtable lock held.
+ */
+static inline void
+zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
+			      unsigned long addr, pte_t *pte,
+			      struct zap_details *details, pte_t pteval)
+{
+	if (zap_drop_file_uffd_wp(details))
+		return;
+
+	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1338,6 +1354,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			if (unlikely(!page))
 				continue;
 
@@ -1362,6 +1380,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
+		/*
+		 * If this is a special uffd-wp marker pte... Drop it only if
+		 * enforced to do so.
+		 */
+		if (unlikely(is_swap_special_pte(ptent))) {
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
+			/*
+			 * If this is a common unmap of ptes, keep this as is.
+			 * Drop it only if this is a whole-vma destruction.
+			 */
+			if (zap_drop_file_uffd_wp(details))
+				ptep_get_and_clear_full(mm, addr, pte,
+							tlb->fullmm);
+			continue;
+		}
+
 		entry = pte_to_swp_entry(ptent);
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
@@ -1369,6 +1403,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
+			/*
+			 * Both device private/exclusive mappings should only
+			 * work with anonymous page so far, so we don't need to
+			 * consider uffd-wp bit when zap. For more information,
+			 * see zap_install_uffd_wp_if_needed().
+			 */
+			WARN_ON_ONCE(!vma_is_anonymous(vma));
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
 
@@ -1393,6 +1434,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1603,12 +1645,15 @@ void unmap_vmas(struct mmu_gather *tlb,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	struct zap_details details = {
+		.zap_flags = ZAP_FLAG_DROP_FILE_UFFD_WP,
+	};
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
@@ -3353,7 +3398,7 @@ void unmap_mapping_page(struct page *page)
 
 	details.zap_mapping = mapping;
 	details.single_page = page;
-	details.zap_flags = ZAP_FLAG_CHECK_MAPPING;
+	details.zap_flags = ZAP_FLAG_CHECK_MAPPING | ZAP_FLAG_DROP_FILE_UFFD_WP;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
diff --git a/mm/rmap.c b/mm/rmap.c
index 795f9d5f8386..92ba81567089 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -72,6 +72,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -1515,6 +1516,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			pteval = ptep_clear_flush(vma, address, pvmw.pte);
 		}
 
+		/*
+		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
+		 * may want to replace a none pte with a marker pte if it's
+		 * file-backed, so we don't lose the tracking information.
+		 */
+		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
+
 		/* Move the dirty bit to the page. Now the pte is gone. */
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
-- 
2.31.1

