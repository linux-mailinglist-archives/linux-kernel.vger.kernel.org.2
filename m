Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B79393707
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhE0UXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236131AbhE0UXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXc/mxSeZGULf6gugl776EzWZkGQ1iCBUhKtJkC//uw=;
        b=AD2K367oGKUwQzO45n/lqvoGE6U/mfdOhNzsHLAupaz5FkcYP8+ElEV0a2MqCbBhp3PzB2
        nJNydXHz5AWUhC46jzO48DB214LrqFMGK9kkxJBtf7dmaNlE0f3/GAD/BhwvLhXAfVYc8W
        ZBsHKfHBM4bqevl+or32cPCR9xnxqbU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-UklK0RDwN1mCy3XvTC30Qg-1; Thu, 27 May 2021 16:21:47 -0400
X-MC-Unique: UklK0RDwN1mCy3XvTC30Qg-1
Received: by mail-qv1-f70.google.com with SMTP id n12-20020a0cdc8c0000b02901efdf8d3bc7so977755qvk.23
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXc/mxSeZGULf6gugl776EzWZkGQ1iCBUhKtJkC//uw=;
        b=JhkYMRTYjBHDacDggyzH6ZZvZVE0ZjC/Oc1/7+YtBntX6LMngTEQrdW/RWnSUnezkG
         gR+gaqbn0KjyhB1vVrWTKfz+KMGwco6D0sw/JrIM63PZPdtNlImIpT6WsaYSazq2bNGY
         dMMTUleWtORn18aJuRdDzDzXiIkIE/oBlyzLanOjO5sGDvxQvB8siJvF9Wi7CbEb7RhU
         ghgSJ6ci2fmwdLa67BYm3el7jx5t9MS88FQYYKD1ijCBh1mgJXOGakceIcyKcDZgzXu8
         stjInb2EtR86CV7Ssf4tODjSnIuAGkJROp6ZMbwr3SYScmikOfu/SxpxKB0C1izoL+IZ
         C+AA==
X-Gm-Message-State: AOAM530mteB0ov/aWUlFd6jcRd5gKjwE1o66pE3hFog/FLEtwHIJhJXF
        zSRgo0/q+GK0z3rxlUta6AHBlf1WOaiBh6F4NVxnDsld6au7GfZ1YUMBK/feyg+IAVSl7xq2nHC
        ko1pcczYHKYZDXvP4gelnjv5f
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr358538qkk.186.1622146903237;
        Thu, 27 May 2021 13:21:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Oz7COp0aUtdezIVVE5UQeBKcbJN8nq1U8uOtI97y0IFIL9UJHzPhkuIkBKyAiw7/snh96w==
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr358500qkk.186.1622146902914;
        Thu, 27 May 2021 13:21:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id e19sm2042910qtr.45.2021.05.27.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:21:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 10/27] mm: Pass zap_flags into unmap_mapping_pages()
Date:   Thu, 27 May 2021 16:21:39 -0400
Message-Id: <20210527202139.30942-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give unmap_mapping_pages() more power by allowing to specify a zap flag so that
it can pass in more information than "whether we'd also like to zap cow pages".
With the new flag, we can remove the even_cow parameter because even_cow==false
equals to zap_flags==ZAP_FLAG_CHECK_MAPPING, while even_cow==true means a none
zap flag to pass in (though in most cases we have had even_cow==false).

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/dax.c           | 10 ++++++----
 include/linux/mm.h |  4 ++--
 mm/khugepaged.c    |  3 ++-
 mm/memory.c        | 15 ++++++++-------
 mm/truncate.c      | 11 +++++++----
 5 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 62352cbcf0f4..09d482c1595b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -528,7 +528,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_unlock_irq(xas);
 			unmap_mapping_pages(mapping,
 					xas->xa_index & ~PG_PMD_COLOUR,
-					PG_PMD_NR, false);
+					PG_PMD_NR, ZAP_FLAG_CHECK_MAPPING);
 			xas_reset(xas);
 			xas_lock_irq(xas);
 		}
@@ -623,7 +623,8 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
+	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1,
+			    ZAP_FLAG_CHECK_MAPPING);
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end_idx) {
@@ -754,9 +755,10 @@ static void *dax_insert_entry(struct xa_state *xas,
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
 			unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
-					PG_PMD_NR, false);
+					PG_PMD_NR, ZAP_FLAG_CHECK_MAPPING);
 		else /* pte entry */
-			unmap_mapping_pages(mapping, index, 1, false);
+			unmap_mapping_pages(mapping, index, 1,
+					    ZAP_FLAG_CHECK_MAPPING);
 	}
 
 	xas_reset(xas);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1adf313a01fe..b1fb2826e29c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1803,7 +1803,7 @@ extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
 void unmap_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t nr, bool even_cows);
+		pgoff_t start, pgoff_t nr, unsigned long zap_flags);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
 #else
@@ -1823,7 +1823,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 	return -EFAULT;
 }
 static inline void unmap_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t nr, bool even_cows) { }
+		pgoff_t start, pgoff_t nr, unsigned long zap_flags) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows) { }
 #endif
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7376a9b5bfc9..9e89a032e2fd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1830,7 +1830,8 @@ static void collapse_file(struct mm_struct *mm,
 		}
 
 		if (page_mapped(page))
-			unmap_mapping_pages(mapping, index, 1, false);
+			unmap_mapping_pages(mapping, index, 1,
+					    ZAP_FLAG_CHECK_MAPPING);
 
 		xas_lock_irq(&xas);
 		xas_set(&xas, index);
diff --git a/mm/memory.c b/mm/memory.c
index 8a3751be87ba..319552efc782 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3316,7 +3316,10 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
  * @mapping: The address space containing pages to be unmapped.
  * @start: Index of first page to be unmapped.
  * @nr: Number of pages to be unmapped.  0 to unmap to end of file.
- * @even_cows: Whether to unmap even private COWed pages.
+ * @zap_flags: Zap flags for the process.  E.g., when ZAP_FLAG_CHECK_MAPPING is
+ *   passed into it, we will only zap the pages that are in the same mapping
+ *   specified in the @mapping parameter; otherwise we will not check mapping,
+ *   IOW cow pages will be zapped too.
  *
  * Unmap the pages in this address space from any userspace process which
  * has them mmaped.  Generally, you want to remove COWed pages as well when
@@ -3324,17 +3327,14 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
  * cache.
  */
 void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
-		pgoff_t nr, bool even_cows)
+		pgoff_t nr, unsigned long zap_flags)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
 	struct zap_details details = {
 		.zap_mapping = mapping,
-		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+		.zap_flags = zap_flags | ZAP_FLAG_SKIP_SWAP,
 	};
 
-	if (!even_cows)
-		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
@@ -3376,7 +3376,8 @@ void unmap_mapping_range(struct address_space *mapping,
 			hlen = ULONG_MAX - hba + 1;
 	}
 
-	unmap_mapping_pages(mapping, hba, hlen, even_cows);
+	unmap_mapping_pages(mapping, hba, hlen, even_cows ?
+			    0 : ZAP_FLAG_CHECK_MAPPING);
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 57a618c4a0d6..85cd84486589 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -172,7 +172,8 @@ truncate_cleanup_page(struct address_space *mapping, struct page *page)
 {
 	if (page_mapped(page)) {
 		unsigned int nr = thp_nr_pages(page);
-		unmap_mapping_pages(mapping, page->index, nr, false);
+		unmap_mapping_pages(mapping, page->index, nr,
+				    ZAP_FLAG_CHECK_MAPPING);
 	}
 
 	if (page_has_private(page))
@@ -652,14 +653,15 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 					 * Zap the rest of the file in one hit.
 					 */
 					unmap_mapping_pages(mapping, index,
-						(1 + end - index), false);
+							    (1 + end - index),
+							    ZAP_FLAG_CHECK_MAPPING);
 					did_range_unmap = 1;
 				} else {
 					/*
 					 * Just zap this page
 					 */
 					unmap_mapping_pages(mapping, index,
-								1, false);
+							    1, ZAP_FLAG_CHECK_MAPPING);
 				}
 			}
 			BUG_ON(page_mapped(page));
@@ -685,7 +687,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	 * get remapped later.
 	 */
 	if (dax_mapping(mapping)) {
-		unmap_mapping_pages(mapping, start, end - start + 1, false);
+		unmap_mapping_pages(mapping, start, end - start + 1,
+				    ZAP_FLAG_CHECK_MAPPING);
 	}
 out:
 	cleancache_invalidate_inode(mapping);
-- 
2.31.1

