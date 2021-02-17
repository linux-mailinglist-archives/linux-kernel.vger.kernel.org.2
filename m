Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6031631E318
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhBQXim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232827AbhBQXh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613604960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSh1ft3TkUZQw5lT26Ir4z6+mrJgP1tvshvl4KSiDTY=;
        b=AgjJguGk/A7DX0emNt8qDlVmnCdvYxFtS6saJUXv+ZT25UKPb0u5Pqpi+NMK8qVIvEqMRg
        E7dmUn8Q7AeuopLYkqbxoV+5+H7CumhmlP8uSqnX1XqcBOeJkDm++TV3SaZXME35q9/nFw
        zaVQEBxfdsQ3FiBZuBG8rCOxmDqa8PM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-rnYI3hsmO-ig0foFdobDqw-1; Wed, 17 Feb 2021 18:35:58 -0500
X-MC-Unique: rnYI3hsmO-ig0foFdobDqw-1
Received: by mail-qk1-f198.google.com with SMTP id u66so121310qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSh1ft3TkUZQw5lT26Ir4z6+mrJgP1tvshvl4KSiDTY=;
        b=ZnXUlpEY+G/Lo5LGMNtw+E4YR9qED4zR+ejGHYYetK48zxtPJauYoOagn2ShGi1JZs
         mTQdVNOJjYY7K+Gkz35tH0cHKAnDxVSPCeJe52qk84eShwuQh4nyttmAY8Ia3UfofKkG
         n7HJFl4W0biMdkWhYGElt4ajfrSS4wiOr+snBlqB1Voazl21IJi+FMwEFKfgOAghH5Ha
         9pfZuEzx4+L9i/ydDKRN7PL2eyV+TTPqi5VI2YRRIkSlki1kt7XTxBlpm7VXwBba5d09
         SKMtqiAhWM6hpPitLVOCctUnptySI5pmC6fEiLo+h414M0Dp38LeBNQcwDxWoDsI05zC
         V/AQ==
X-Gm-Message-State: AOAM5335yf/9i7K74lliBAUU3c4+XmMZJi6egMoKLyc3pXe5UP0xoDiD
        nok2y2dUNTQA6M/SgBBVq9b6pOVLeeq8dbYhzrk9uAiyrS7EkcObs3mRJRzdGGBPeus/QRH/kKj
        b2ft3oV2KySB6+CiFidYoc6TY
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr1827727qtv.92.1613604958219;
        Wed, 17 Feb 2021 15:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ/yEV04MLom7yxkWLFWTI5mn1lD6GWwzpCnVnvrYHJZXeaz6IYDZJzbezFjqMM5XCtZhhUA==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr1827704qtv.92.1613604957958;
        Wed, 17 Feb 2021 15:35:57 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o5sm2739622qkh.59.2021.02.17.15.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:35:57 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v5 5/5] hugetlb: Do early cow when page pinned on src mm
Date:   Wed, 17 Feb 2021 18:35:47 -0500
Message-Id: <20210217233547.93892-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217233547.93892-1-peterx@redhat.com>
References: <20210217233547.93892-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last missing piece of the COW-during-fork effort when there're
pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
pinned pages during fork() for ptes", 2020-09-27) for more information, since
we do similar things here rather than pte this time, but just for hugetlb.

Note that after Jason's recent work on 57efa1fe5957 ("mm/gup: prevent gup_fast
from racing with COW during fork", 2020-12-15) which is safer and easier to
understand, we're safe now within the whole copy_page_range() against gup-fast,
we don't need the wr-protect trick that proposed in 70e806e4e645 anymore.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8379224e1d43..0b45ff7df708 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3725,6 +3725,18 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 		return false;
 }
 
+static void
+hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
+		     struct page *new_page)
+{
+	__SetPageUptodate(new_page);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
+	hugepage_add_new_anon_rmap(new_page, vma, addr);
+	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
+	ClearHPageRestoreReserve(new_page);
+	SetHPageMigratable(new_page);
+}
+
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
@@ -3734,6 +3746,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	bool cow = is_cow_mapping(vma->vm_flags);
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
+	unsigned long npages = pages_per_huge_page(h);
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
@@ -3782,6 +3795,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
+again:
 		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
 			/*
 			 * Skip if src entry none.  Also, skip in the
@@ -3805,6 +3819,52 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
+			 * When pre-allocating the page or copying data, we
+			 * need to be without the pgtable locks since we could
+			 * sleep during the process.
+			 */
+			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+				pte_t src_pte_old = entry;
+				struct page *new;
+
+				spin_unlock(src_ptl);
+				spin_unlock(dst_ptl);
+				/* Do not use reserve as it's private owned */
+				new = alloc_huge_page(vma, addr, 1);
+				if (IS_ERR(new)) {
+					put_page(ptepage);
+					ret = PTR_ERR(new);
+					break;
+				}
+				copy_user_huge_page(new, ptepage, addr, vma,
+						    npages);
+				put_page(ptepage);
+
+				/* Install the new huge page if src pte stable */
+				dst_ptl = huge_pte_lock(h, dst, dst_pte);
+				src_ptl = huge_pte_lockptr(h, src, src_pte);
+				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+				entry = huge_ptep_get(src_pte);
+				if (!pte_same(src_pte_old, entry)) {
+					put_page(new);
+					/* dst_entry won't change as in child */
+					goto again;
+				}
+				hugetlb_install_page(vma, dst_pte, addr, new);
+				spin_unlock(src_ptl);
+				spin_unlock(dst_ptl);
+				continue;
+			}
+
 			if (cow) {
 				/*
 				 * No need to notify as we are downgrading page
@@ -3815,12 +3875,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 */
 				huge_ptep_set_wrprotect(src, addr, src_pte);
 			}
-			entry = huge_ptep_get(src_pte);
-			ptepage = pte_page(entry);
-			get_page(ptepage);
+
 			page_dup_rmap(ptepage, true);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
-			hugetlb_count_add(pages_per_huge_page(h), dst);
+			hugetlb_count_add(npages, dst);
 		}
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
-- 
2.26.2

