Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A936C946
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhD0QYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237548AbhD0QOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOidGBu67rggbabLyL6x5COAOqvbxp3OOia9m+3YHH4=;
        b=POvLw5VuhyaRZKeAr2ysTuR1ttvxMmBHNDqzCsM8T+CUisCi3HDglLHPpJw3IHH1ThcmSq
        L8YBoavboFZyrBQKaj9YsdcnIc4e2S9thN5OieiwwpyJ0bSFtnzTSrA8oUphpMI/K9brdk
        PJy+X5G0yzCrnLB47+t3cVHJawP96lk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-3PmkcXtWPPu20Ne_AYpXrw-1; Tue, 27 Apr 2021 12:13:40 -0400
X-MC-Unique: 3PmkcXtWPPu20Ne_AYpXrw-1
Received: by mail-qk1-f197.google.com with SMTP id p17-20020a05620a1131b02902e45c6e4d33so7133199qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOidGBu67rggbabLyL6x5COAOqvbxp3OOia9m+3YHH4=;
        b=YdtaGdA+VHwHhrrz9slhmL5E5UkyyUlcEIXVTYqtFpxAlkx9LGUCL0QHFleoqIDrPl
         MNnGF5EjT/gni1WLAXwYlPk8VtPrTAA/29lfVmOK1sThvU6oLPPoEn9xRslx0SQ1qQPH
         sm/JMirprOzBfpUqtt1mXqQ5UdQftHcLwDP0JA7B2DLpgtvQh2rMs0S3A/cYQ8y/9ll7
         ks78Ny/QVt7le8q5hBpByavM2udW9h5kL8efqcUCl0P0L0CsQP3vr0xvXQhaNTKk2Pxy
         OVCfbOtS3H7MFn2wWAruUqAy5TW2XQGwx+mRaE4SpAWImUeUgWVDxMnYVcHV2Er/K5pG
         pSMA==
X-Gm-Message-State: AOAM533VhoAw5PM3iicbmf76r9EL65v/qyDvhdRrBoql5zB7EnD0/QAG
        61N085u2Litw/+2HLkUsevFoS7vrRRBaQfP17TX750dIZURmvWRbeZ2TVCbZHCNnBgLIybfutnJ
        FGrG0BJdk8gIEh4JoaP3J+b7r
X-Received: by 2002:a05:622a:15c6:: with SMTP id d6mr21539270qty.172.1619540018347;
        Tue, 27 Apr 2021 09:13:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPwsZSjtPtUeVC6HEWqXxrayaBTQUK6a/jnkm2j/6sjjPcAvNZHssIXgu3pSQdPgQjGRU+Iw==
X-Received: by 2002:a05:622a:15c6:: with SMTP id d6mr21539233qty.172.1619540017940;
        Tue, 27 Apr 2021 09:13:37 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:37 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 10/24] shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed
Date:   Tue, 27 Apr 2021 12:13:03 -0400
Message-Id: <20210427161317.50682-11-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
 include/linux/mm.h        | 11 ++++++++++
 include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
 mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
 mm/rmap.c                 |  8 ++++++++
 mm/truncate.c             |  8 +++++++-
 5 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b8aa81a064a55..d6790ab0cf575 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1706,6 +1706,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
 /* Whether to skip zapping swap entries */
 #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
+/* Whether to completely drop uffd-wp entries for file-backed memory */
+#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1738,6 +1740,15 @@ zap_skip_swap(struct zap_details *details)
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
index 355ea1ee32bd7..c29a6ef3a642a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,8 @@
 
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
+#include <linux/swapops.h>
 
 /**
  * page_is_file_lru - should the page be on a file LRU or anon LRU?
@@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
 			-thp_nr_pages(page));
 }
+
+/*
+ * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
+ * replace a none pte.  NOTE!  This should only be called when *pte is already
+ * cleared so we will never accidentally replace something valuable.  Meanwhile
+ * none pte also means we are not demoting the pte so if tlb flushed then we
+ * don't need to do it again; otherwise if tlb flush is postponed then it's
+ * even better.
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
index 189f60853a51d..872fb59192277 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/mm_inline.h>
 
 #include <trace/events/kmem.h>
 
@@ -1210,6 +1211,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
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
@@ -1247,6 +1263,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			if (unlikely(!page))
 				continue;
 
@@ -1271,6 +1289,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
 		if (is_device_private_entry(entry)) {
 			struct page *page = device_private_entry_to_page(entry);
@@ -1281,6 +1315,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			rss[mm_counter(page)]--;
 			page_remove_rmap(page, false);
 			put_page(page);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			continue;
 		}
 
@@ -1298,6 +1334,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1497,12 +1534,15 @@ void unmap_vmas(struct mmu_gather *tlb,
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
 
diff --git a/mm/rmap.c b/mm/rmap.c
index b0fc27e77d6d7..5e25c57164fcf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -72,6 +72,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -1571,6 +1572,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
diff --git a/mm/truncate.c b/mm/truncate.c
index ba2cbe300e83e..65fed21e52bd0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -173,7 +173,13 @@ truncate_cleanup_page(struct address_space *mapping, struct page *page)
 	if (page_mapped(page)) {
 		unsigned int nr = thp_nr_pages(page);
 		unmap_mapping_pages(mapping, page->index, nr,
-				    ZAP_FLAG_CHECK_MAPPING);
+				    ZAP_FLAG_CHECK_MAPPING |
+				    /*
+				     * Now it's safe to drop uffd-wp because
+				     * we're with page lock, and the page is
+				     * being truncated.
+				     */
+				    ZAP_FLAG_DROP_FILE_UFFD_WP);
 	}
 
 	if (page_has_private(page))
-- 
2.26.2

