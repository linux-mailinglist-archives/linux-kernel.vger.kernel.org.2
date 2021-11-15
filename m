Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86B44FF95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhKOIAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236397AbhKOH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNc70TgztEilFYXrr/S3QzbmII7tOwB+GzXzdIRG250=;
        b=I3d6NV6S79SbdI/EqQHpvnf+HKSOVRvJ4kPICHWZ3xcj/z22ci4DTJVG+z3GgSc0AatzrY
        hG9kBRQgQkpH3rhRFVdz3m5AXcN3dlQKdM0tpXNCF3mvdBdLM7K3VTxYmLah58ipdegRQr
        Szm+lMD9/sSNqswNQGlmnx/7C1jfKZ4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-zwEWQSU6PNWHYIvHwZpEyA-1; Mon, 15 Nov 2021 02:56:33 -0500
X-MC-Unique: zwEWQSU6PNWHYIvHwZpEyA-1
Received: by mail-pj1-f72.google.com with SMTP id l10-20020a17090a4d4a00b001a6f817f57eso8612410pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNc70TgztEilFYXrr/S3QzbmII7tOwB+GzXzdIRG250=;
        b=D6KltdgCGxwLMmK3KiRRK0bqRMoJ3jLLpxLVMREt6ETnjl1dRmyG75tfEkYkWsZLRP
         gah2LwTny5IbiPhRCo8VPMahcWBiFZZsaEq5RwDEhLOuJJ5AYVW46nd40jokODkLEEhz
         7g0iPunPFvLsREC0wpQdXxR4En7hL61mtCLnz/7aNEZABOqEMVayTVTTun3IqZkfEbim
         DqgG8QgEW8CXbtbvB53xyY4T0fKc2GDRniRZrzmA34UWQa/osmgXhEQFR4v3Sg5FclV6
         6JNM3jVJFmX4wnGlLHIECAvW/24S2ftPPUvypWH2C+KKgSDWqUvkpPymR7h5U3YJU7zB
         ZH+Q==
X-Gm-Message-State: AOAM533VOZOaBaDxnow+GFoQaGbHP1XAOyc+C4ueD/MsXqsLSppS5hVL
        3cmsdVWwA4yGoP+2NSYlPPPh6IaHQtmmajID7rc0L5ko0WcxAdOV5jn3GGR4hvx1fjbH/yHKGdb
        ZgveRNFF1XbNqmGUsXh5KMEQ1
X-Received: by 2002:a17:90a:ec15:: with SMTP id l21mr6509920pjy.48.1636962991987;
        Sun, 14 Nov 2021 23:56:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcWLiSu54dg3NGApWSpCAOU0KSpIFrzWp5wpXMgcgfTovXA+wja+X2pK0NLh2KBFy3bdsyhw==
X-Received: by 2002:a17:90a:ec15:: with SMTP id l21mr6509874pjy.48.1636962991714;
        Sun, 14 Nov 2021 23:56:31 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.56.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:56:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v6 07/23] mm/shmem: Persist uffd-wp bit across zapping for file-backed
Date:   Mon, 15 Nov 2021 15:55:06 +0800
Message-Id: <20211115075522.73795-8-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory is prone to being unmapped at any time.  It means all
information in the pte will be dropped, including the uffd-wp flag.

To persist the uffd-wp flag, we'll use the pte markers.  This patch teaches the
zap code to understand uffd-wp and know when to keep or drop the uffd-wp bit.

Add a new flag ZAP_FLAG_DROP_MARKER and set it in zap_details when we don't
want to persist such an information, for example, when destroying the whole
vma, or punching a hole in a shmem file.  For the rest cases we should never
drop the uffd-wp bit, or the wr-protect information will get lost.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h        | 20 +++++++++++++++++
 include/linux/mm_inline.h | 45 +++++++++++++++++++++++++++++++++++++++
 mm/memory.c               | 38 +++++++++++++++++++++++++++++++--
 mm/rmap.c                 |  8 +++++++
 4 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..015e287063a8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1825,12 +1825,23 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+typedef unsigned int __bitwise zap_flags_t;
+
+/*
+ * Whether to drop the pte markers, for example, the uffd-wp information for
+ * file-backed memory.  This should only be specified when we will completely
+ * drop the page in the mm, either by truncation or unmapping of the vma.  By
+ * default, the flag is not set.
+ */
+#define  ZAP_FLAG_DROP_MARKER        ((__force zap_flags_t) BIT(0))
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
 	struct address_space *zap_mapping;	/* Check page->mapping if set */
 	struct page *single_page;		/* Locked page to be unmapped */
+	zap_flags_t zap_flags;			/* Extra flags for zapping */
 };
 
 /*
@@ -1847,6 +1858,15 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
 	    (details->zap_mapping != page_rmapping(page));
 }
 
+static inline bool
+zap_drop_file_uffd_wp(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_DROP_MARKER;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e2ec68b0515c..ca861e910938 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,8 @@
 
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
+#include <linux/swapops.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -135,4 +137,47 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 {
 	lruvec_del_folio(lruvec, page_folio(page));
 }
+
+/*
+ * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
+ * replace a none pte.  NOTE!  This should only be called when *pte is already
+ * cleared so we will never accidentally replace something valuable.  Meanwhile
+ * none pte also means we are not demoting the pte so tlb flushed is not needed.
+ * E.g., when pte cleared the caller should have taken care of the tlb flush.
+ *
+ * Must be called with pgtable lock held so that no thread will see the none
+ * pte, and if they see it, they'll fault and serialize at the pgtable lock.
+ *
+ * This function is a no-op if PTE_MARKER_UFFD_WP is not enabled.
+ */
+static inline void
+pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t *pte, pte_t pteval)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
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
+	 * A uffd-wp wr-protected swap pte.  Note: this should even cover an
+	 * existing pte marker with uffd-wp bit set.
+	 */
+	if (unlikely(pte_swp_uffd_wp_any(pteval)))
+		arm_uffd_pte = true;
+
+	if (unlikely(arm_uffd_pte))
+		set_pte_at(vma->vm_mm, addr, pte,
+			   make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif
+}
+
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index e8557d43a87d..fef6a91c5dfb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/mm_inline.h>
 
 #include <trace/events/kmem.h>
 
@@ -1306,6 +1307,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
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
@@ -1343,6 +1359,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			if (unlikely(!page))
 				continue;
 
@@ -1373,6 +1391,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page = pfn_swap_entry_to_page(entry);
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
+			/*
+			 * Both device private/exclusive mappings should only
+			 * work with anonymous page so far, so we don't need to
+			 * consider uffd-wp bit when zap. For more information,
+			 * see zap_install_uffd_wp_if_needed().
+			 */
+			WARN_ON_ONCE(!vma_is_anonymous(vma));
 			rss[mm_counter(page)]--;
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, false);
@@ -1383,13 +1408,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			rss[mm_counter(page)]--;
 		} else if (is_pte_marker_entry(entry)) {
-			/* By default, simply drop all pte markers when zap */
+			/* Currently there's only uffd-wp marker bit */
+			WARN_ON_ONCE(!(pte_marker_get(entry) & PTE_MARKER_UFFD_WP));
+			/* Only drop the uffd-wp marker if explicitly requested */
+			if (!zap_drop_file_uffd_wp(details))
+				continue;
 		} else if (!non_swap_entry(entry)) {
 			rss[MM_SWAPENTS]--;
 			if (unlikely(!free_swap_and_cache(entry)))
 				print_bad_pte(vma, addr, ptent, NULL);
 		}
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1600,12 +1630,15 @@ void unmap_vmas(struct mmu_gather *tlb,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	struct zap_details details = {
+		.zap_flags = ZAP_FLAG_DROP_MARKER,
+	};
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
@@ -3350,6 +3383,7 @@ void unmap_mapping_page(struct page *page)
 
 	details.zap_mapping = mapping;
 	details.single_page = page;
+	details.zap_flags = ZAP_FLAG_DROP_MARKER;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
diff --git a/mm/rmap.c b/mm/rmap.c
index 163ac4e6bcee..89068e957486 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -73,6 +73,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -1517,6 +1518,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
2.32.0

