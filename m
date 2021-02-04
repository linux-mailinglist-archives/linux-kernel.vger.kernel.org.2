Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68930F577
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhBDOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236898AbhBDOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1qA8YDBc2tuVyycbGtMSDtlYrQVjFJWlhZm/wJFwx8=;
        b=D77biDdBwW8DKoGboTvkxUghSISOtEBnz57ggr87RKvF9h6Gs1XhNsMCtpBNcmnyl/a4Jw
        CIsqB+yz7XTsOv9IHF3RVnxWLKoCrok0MZ5S5ldLL3b2U3RY508SMbLQIibWNRFP+oLdUH
        8//MEgV4Q46JUt+obw6hy2Eyjhd5U9Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-ctz_1DHiMGaTteHUBBrD6g-1; Thu, 04 Feb 2021 09:50:44 -0500
X-MC-Unique: ctz_1DHiMGaTteHUBBrD6g-1
Received: by mail-qk1-f199.google.com with SMTP id s66so2812217qkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1qA8YDBc2tuVyycbGtMSDtlYrQVjFJWlhZm/wJFwx8=;
        b=NVheDansbmR0dVIiOd1g1haadIa8fGOgxgEjsgRRnmXZBbmwKpvEcIpFbCnkzLh8wc
         rSfuW11vkSJXz0EtmN/I4uoEYXWJNzRJrFO/cgw48oxWUABcKE9dwlS5PZVN1gutHwEJ
         Xknl7Rp9TWaA5QYxGbjO7Ml0Wo/FRPgNtLJMXyANsJG2XJ44m4N3nuFRbwm5dH2rJF0+
         upwMw50GFyNCZtPdWtXjnUp9nzFft2A50onJcYY8377VFkw32avyGBtc9U5SwwmJ9x6l
         5Pz3fllzB7BLKIzQ+s0npvUQVvXihEmQrkyFg2764mRjVFqKOvgK0yBvxUDLOd731WxE
         RVWA==
X-Gm-Message-State: AOAM530q5h7VH7yby+h1mWh8nT1fXU8JaIgss68IR8TBiMCeYyQ0q4+r
        B8+P1OJwsS2bKaiaxhPXwtySK1K2Sl1ciV5aKoLp+fNb4mZcxB4ZVRlxuUJRk9E05y74pxTdWDs
        f7cQyYPpWnLuU3Zk/oag3eY7T
X-Received: by 2002:ac8:6712:: with SMTP id e18mr7358796qtp.15.1612450243076;
        Thu, 04 Feb 2021 06:50:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGPdLTx9+uGrpdLPJ2GgjaQeEj+B8me3HP+fj+LrnvfPOpIo+YyzJ1xNFxxr0eOPO00kg2rw==
X-Received: by 2002:ac8:6712:: with SMTP id e18mr7358766qtp.15.1612450242858;
        Thu, 04 Feb 2021 06:50:42 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id e14sm4697589qte.18.2021.02.04.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:50:42 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
Date:   Thu,  4 Feb 2021 09:50:33 -0500
Message-Id: <20210204145033.136755-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204145033.136755-1-peterx@redhat.com>
References: <20210204145033.136755-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last missing piece of the COW-during-fork effort when there're
pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
pinned pages during fork() for ptes", 2020-09-27) for more information, since
we do similar things here rather than pte this time, but just for hugetlb.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9e6ea96bf33b..5793936e00ef 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3734,11 +3734,27 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 		return false;
 }
 
+static void
+hugetlb_copy_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
+		  struct page *old_page, struct page *new_page)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned int psize = pages_per_huge_page(h);
+
+	copy_user_huge_page(new_page, old_page, addr, vma, psize);
+	__SetPageUptodate(new_page);
+	ClearPagePrivate(new_page);
+	set_page_huge_active(new_page);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
+	hugepage_add_new_anon_rmap(new_page, vma, addr);
+	hugetlb_count_add(psize, vma->vm_mm);
+}
+
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
-	struct page *ptepage;
+	struct page *ptepage, *prealloc = NULL;
 	unsigned long addr;
 	int cow;
 	struct hstate *h = hstate_vma(vma);
@@ -3787,7 +3803,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		dst_entry = huge_ptep_get(dst_pte);
 		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
 			continue;
-
+again:
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -3816,6 +3832,39 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
+			entry = huge_ptep_get(src_pte);
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+
+			/*
+			 * This is a rare case where we see pinned hugetlb
+			 * pages while they're prone to COW.  We need to do the
+			 * COW earlier during fork.
+			 *
+			 * When pre-allocating the page we need to be without
+			 * all the locks since we could sleep when allocate.
+			 */
+			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+				if (!prealloc) {
+					put_page(ptepage);
+					spin_unlock(src_ptl);
+					spin_unlock(dst_ptl);
+					prealloc = alloc_huge_page(vma, addr, 1);
+					if (!prealloc) {
+						ret = -ENOMEM;
+						break;
+					}
+					goto again;
+				}
+				hugetlb_copy_page(vma, dst_pte, addr, ptepage,
+						  prealloc);
+				put_page(ptepage);
+				spin_unlock(src_ptl);
+				spin_unlock(dst_ptl);
+				prealloc = NULL;
+				continue;
+			}
+
 			if (cow) {
 				/*
 				 * No need to notify as we are downgrading page
@@ -3826,9 +3875,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 */
 				huge_ptep_set_wrprotect(src, addr, src_pte);
 			}
-			entry = huge_ptep_get(src_pte);
-			ptepage = pte_page(entry);
-			get_page(ptepage);
+
 			page_dup_rmap(ptepage, true);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 			hugetlb_count_add(pages_per_huge_page(h), dst);
@@ -3842,6 +3889,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	else
 		i_mmap_unlock_read(mapping);
 
+	/* Free the preallocated page if not used at last */
+	if (prealloc)
+		put_page(prealloc);
+
 	return ret;
 }
 
-- 
2.26.2

