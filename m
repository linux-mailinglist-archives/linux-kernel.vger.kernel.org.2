Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219D34542E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCWAuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhCWAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycNGR7jI4EfGPoKNtAWo/hwPX/71F3+EQicoRsueR2k=;
        b=P5KbGEvfFlKKnBql8ROUzmiuCnppxVxoNaGLXuY1uTWs+rjnG+9g2r4OUztNee1rGweQ0O
        WbfU3DZnAXy09Czsr4acr5nPGY+c9caJCMG/nVkAl45zgxQ/fYU+b52MySBmZwebMgAhOL
        1T8TIBd/vRvZldE9DqY17jzzJSWT0kA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-Iy8S25knMm2ADaWPdzscig-1; Mon, 22 Mar 2021 20:49:31 -0400
X-MC-Unique: Iy8S25knMm2ADaWPdzscig-1
Received: by mail-qk1-f200.google.com with SMTP id t24so831534qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycNGR7jI4EfGPoKNtAWo/hwPX/71F3+EQicoRsueR2k=;
        b=mETHctO+j/PsAs14v4MfsGMEB4eN43dBl8WhT/lp7qnuSOBqbI9ADvKkHVuLu2LO9A
         AInJ7IxEhCM8knqb9u0dyHUsuMfZOVG3aQHxBzc7TM5C6x3Kw9nn6YS21ZeD7XpZoqUd
         +6+iC08nWbds0qkSlW5psYVwgIZYrg37rHyK9v3XOiNDLgI1v22yNCOQm6fUjgQUPqgc
         c170jpMRcNEKKFm2ry64j3NNdZo0vEv/MZ7zmMHSPdMIXAG1LPyBpmyHVA2w8bCIFrKa
         sbhdPJoRmGcY0L+2tA2qS+CfpQiL8fvzvIVnuINQGXOF+SDW/+jjk57e56PHQb0NOKXT
         sTBQ==
X-Gm-Message-State: AOAM5310U8WFf+VINzheFt0P2p4okZSE4uhC/67KKcBWLbhDed2y33xU
        CUpGc1K8ujXOZ4kKpHf7K7pRAgmtv0hfgxLUdHhItc5FYf7UBUnJZ5uqo+eqt5viDqKvHTm/Ext
        x76PDilH4uoeGf/gSyeA2ThKilROw0eRHN/ewIEkGKQCglX6J4IhWEgR7Z44HLlwLX3ms2FT2qg
        ==
X-Received: by 2002:ac8:6059:: with SMTP id k25mr2375062qtm.251.1616460569807;
        Mon, 22 Mar 2021 17:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtV0VT7cWYfkT7bF1v+/17du36Bhz1HhGotTYXOvU4CEqVh7lpJjcB0mZq2d3qpwefNyxi1w==
X-Received: by 2002:ac8:6059:: with SMTP id k25mr2375035qtm.251.1616460569403;
        Mon, 22 Mar 2021 17:49:29 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 09/23] mm: Pass zap_flags into unmap_mapping_pages()
Date:   Mon, 22 Mar 2021 20:48:58 -0400
Message-Id: <20210323004912.35132-10-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index 177b7d305a52..dd90a35d38be 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -514,7 +514,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_unlock_irq(xas);
 			unmap_mapping_pages(mapping,
 					xas->xa_index & ~PG_PMD_COLOUR,
-					PG_PMD_NR, false);
+					PG_PMD_NR, ZAP_FLAG_CHECK_MAPPING);
 			xas_reset(xas);
 			xas_lock_irq(xas);
 		}
@@ -609,7 +609,8 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
+	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1,
+			    ZAP_FLAG_CHECK_MAPPING);
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end_idx) {
@@ -740,9 +741,10 @@ static void *dax_insert_entry(struct xa_state *xas,
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
index c11fbce0d557..d38cd23a08be 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1784,7 +1784,7 @@ extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
 void unmap_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t nr, bool even_cows);
+		pgoff_t start, pgoff_t nr, unsigned long zap_flags);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
 #else
@@ -1804,7 +1804,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 	return -EFAULT;
 }
 static inline void unmap_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t nr, bool even_cows) { }
+		pgoff_t start, pgoff_t nr, unsigned long zap_flags) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows) { }
 #endif
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 419a6acce326..7c75dff637e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1837,7 +1837,8 @@ static void collapse_file(struct mm_struct *mm,
 		}
 
 		if (page_mapped(page))
-			unmap_mapping_pages(mapping, index, 1, false);
+			unmap_mapping_pages(mapping, index, 1,
+					    ZAP_FLAG_CHECK_MAPPING);
 
 		xas_lock_irq(&xas);
 		xas_set(&xas, index);
diff --git a/mm/memory.c b/mm/memory.c
index a02c4d851cd4..36204b898894 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3213,7 +3213,10 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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
@@ -3221,17 +3224,14 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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
 
@@ -3273,7 +3273,8 @@ void unmap_mapping_range(struct address_space *mapping,
 			hlen = ULONG_MAX - hba + 1;
 	}
 
-	unmap_mapping_pages(mapping, hba, hlen, even_cows);
+	unmap_mapping_pages(mapping, hba, hlen, even_cows ?
+			    0 : ZAP_FLAG_CHECK_MAPPING);
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 95af244b112a..ba2cbe300e83 100644
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
2.26.2

