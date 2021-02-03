Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27730E4BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhBCVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhBCVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612386524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAR5UYzoAPy14j76vk233Tw9s0t/A46HICdSqrKjEFQ=;
        b=UBqnkgzL9WsYRs1yvRv5Dl8tdvO3fDc3C3yx7ynP3Euk2InLhY/wzQiQCTAbtwUB8uymW/
        9E1I8kypWvwBqqu1BPNS73A3CnpcLyeM2xNHXU/xOqxkrnptFmA5nYVkkuzTW8lnczM03k
        bWk8Mm8ZzcTurgNghPBGh8+4Y1kLNks=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-eG9rFEH0OruSISjk0x52QA-1; Wed, 03 Feb 2021 16:08:43 -0500
X-MC-Unique: eG9rFEH0OruSISjk0x52QA-1
Received: by mail-qt1-f200.google.com with SMTP id i1so897866qtp.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAR5UYzoAPy14j76vk233Tw9s0t/A46HICdSqrKjEFQ=;
        b=XsZLTBW7AW+uuDK8zq4CuuGCm3H33JTRdbseNUt/W1qOxdpEsxL5ZMT0UKq++xZnXx
         jhrmOCptuTKYzlisw0f9HeieUlFkuh+nHq5+oRlHpn7fVN3em7tLjznmi5WV127wgdgg
         BS+YCTiB5gC1emQxlXhxOjEo7nElOh/9c6tpxF1i9lUhkol8T/M9I5GhDCsMbDxbk/CL
         o4GQoaJpcPIukds/+XXI8a0EszGadXUUbMNRJeJAsX/4kXLKr2Q4QLZn3brNw574H9GI
         NQZaR5Tay0doQYk5xsM9G56dlIf0gaRnK3l7VCqAU8zLIs9CJUuH+0N2revHF17fc3b1
         PFtQ==
X-Gm-Message-State: AOAM5326CFBeomHBtoIAKPofBByBLUJdN52vQV/3t2EPPuXhKN+7rbvd
        WUlL3Y5zSQeCPrv0JJeVnpm7NZezJpImjaS0mgihBjmKlcxP3cJ+VfWJBR4uVT/f7UsE2Nek1Ry
        BQeGpEN2KlfNrrbIwqSKRJCBtOlYXZM/RkFn8FQEA2Q2S7YCJJnAtu3rl6Dv7nCc7Oh3cuN+fxg
        ==
X-Received: by 2002:ac8:82b:: with SMTP id u40mr4391943qth.332.1612386522774;
        Wed, 03 Feb 2021 13:08:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVVt5kjHSDTzY5qynUdx3KoddfTDU7c0XF5xIku0zmBdUNWjFgD59RCmSGKUsLIoLJfGy42A==
X-Received: by 2002:ac8:82b:: with SMTP id u40mr4391895qth.332.1612386522444;
        Wed, 03 Feb 2021 13:08:42 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id t6sm2507659qti.2.2021.02.03.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:08:41 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>, peterx@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] hugetlb: Do early cow when page pinned on src mm
Date:   Wed,  3 Feb 2021 16:08:32 -0500
Message-Id: <20210203210832.113685-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203210832.113685-1-peterx@redhat.com>
References: <20210203210832.113685-1-peterx@redhat.com>
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
 mm/hugetlb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9e6ea96bf33b..931bf1a81c16 100644
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
@@ -3816,6 +3832,54 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
+			entry = huge_ptep_get(src_pte);
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+
+			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+				/* This is very possibly a pinned huge page */
+				if (!prealloc) {
+					/*
+					 * Preallocate the huge page without
+					 * tons of locks since we could sleep.
+					 * Note: we can't use any reservation
+					 * because the page will be exclusively
+					 * owned by the child later.
+					 */
+					put_page(ptepage);
+					spin_unlock(src_ptl);
+					spin_unlock(dst_ptl);
+					prealloc = alloc_huge_page(vma, addr, 0);
+					if (!prealloc) {
+						/*
+						 * hugetlb_cow() seems to be
+						 * more careful here than us.
+						 * However for fork() we could
+						 * be strict not only because
+						 * no one should be referencing
+						 * the child mm yet, but also
+						 * if resources are rare we'd
+						 * better simply fail the
+						 * fork() even earlier.
+						 */
+						ret = -ENOMEM;
+						break;
+					}
+					goto again;
+				}
+				/*
+				 * We have page preallocated so that we can do
+				 * the copy right now.
+				 */
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
@@ -3826,9 +3890,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -3842,6 +3904,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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

