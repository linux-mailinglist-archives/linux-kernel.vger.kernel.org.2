Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D436C93A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhD0QVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237546AbhD0QOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LT2kIK8sipp9j2ir2CNI9ANhHohLPp0GAzeCrbDSG6A=;
        b=BTn4sHHB3ysuT9rpvA0HRxxvvqNHL4dqToKJYckboElwY1dMvVcG8Zqno8sPFB3Kc1Wv78
        GVC0jbb2FhgZig6deewK7Lk97m2UVkiD0UA7BhoD9UYOQI8tghgPGr7kYwvBuGi4Upxlyj
        h9A3ORF3yTtkzN2SnuuzdGMggJ0Y/8E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-pWtVKdgfORaPwLBsH4mSYQ-1; Tue, 27 Apr 2021 12:13:37 -0400
X-MC-Unique: pWtVKdgfORaPwLBsH4mSYQ-1
Received: by mail-qk1-f197.google.com with SMTP id c4-20020a3781040000b02902e46e29acf5so6442205qkd.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LT2kIK8sipp9j2ir2CNI9ANhHohLPp0GAzeCrbDSG6A=;
        b=kBQnrGE3DLKm8brWpS/IZ4CxTNDwboOmE+8aiOgOWnT/cJpj3qJ3WJ6gUw3TVKdy6F
         2de+1ZzBRinhHInroSG7Z56qS6z9l9TFXhT4Mkwnf3GLRrzIi9oLcjPt75D4zP7Uw3p1
         yfO+7KfJLHbNGYwU/7An3WSC7vA9hucbbwfpiF07Gs/9JZuywrXjMQLlzVTmMbly/dDD
         icErwNq0oxS5p0dgPxsDivE2Njp1J5bLFyhtuzaffIbb1x4ZCl0AT04Xvy7z50+g9ygU
         CvXqcOQ7qLV6591lHFyaeZfaWlxxQRAzvnFJ7VgJ2Pef6YxGdoEKobIeydmO5e6TVT4u
         4Nvg==
X-Gm-Message-State: AOAM531GbFwPgy39B1lSe7mqABg6YkSt7fi3wTD/WSZtziXfwr4Oisf9
        vqGVXhAQV+N6FteeIDe0kEAhZyO6Tc2AfP2S/+z/6N8VaAn5FsaBlTXfEtyRiewMrCmXEoMTi2Y
        KvRhbG9qH2bR5UkcfsjoeGuT+
X-Received: by 2002:a0c:bec3:: with SMTP id f3mr24412570qvj.49.1619540016883;
        Tue, 27 Apr 2021 09:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBrjIhgyXc8ASqxD1DOx8zVV0xPaGMkLyYwUGO30ydezgxooODIclnDbUOAGjmE/pwb1KXEg==
X-Received: by 2002:a0c:bec3:: with SMTP id f3mr24412535qvj.49.1619540016586;
        Tue, 27 Apr 2021 09:13:36 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:36 -0700 (PDT)
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
Subject: [PATCH v2 09/24] mm: Pass zap_flags into unmap_mapping_pages()
Date:   Tue, 27 Apr 2021 12:13:02 -0400
Message-Id: <20210427161317.50682-10-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index 69216241392f2..20ca8d7d36ebb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -517,7 +517,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_unlock_irq(xas);
 			unmap_mapping_pages(mapping,
 					xas->xa_index & ~PG_PMD_COLOUR,
-					PG_PMD_NR, false);
+					PG_PMD_NR, ZAP_FLAG_CHECK_MAPPING);
 			xas_reset(xas);
 			xas_lock_irq(xas);
 		}
@@ -612,7 +612,8 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
+	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1,
+			    ZAP_FLAG_CHECK_MAPPING);
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end_idx) {
@@ -743,9 +744,10 @@ static void *dax_insert_entry(struct xa_state *xas,
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
index 2227e9107e53e..b8aa81a064a55 100644
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
index e8b299aa32d06..64a36cd375359 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1831,7 +1831,8 @@ static void collapse_file(struct mm_struct *mm,
 		}
 
 		if (page_mapped(page))
-			unmap_mapping_pages(mapping, index, 1, false);
+			unmap_mapping_pages(mapping, index, 1,
+					    ZAP_FLAG_CHECK_MAPPING);
 
 		xas_lock_irq(&xas);
 		xas_set(&xas, index);
diff --git a/mm/memory.c b/mm/memory.c
index 5325c1c2cbd78..189f60853a51d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3224,7 +3224,10 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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
@@ -3232,17 +3235,14 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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
 
@@ -3284,7 +3284,8 @@ void unmap_mapping_range(struct address_space *mapping,
 			hlen = ULONG_MAX - hba + 1;
 	}
 
-	unmap_mapping_pages(mapping, hba, hlen, even_cows);
+	unmap_mapping_pages(mapping, hba, hlen, even_cows ?
+			    0 : ZAP_FLAG_CHECK_MAPPING);
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 95af244b112a0..ba2cbe300e83e 100644
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

