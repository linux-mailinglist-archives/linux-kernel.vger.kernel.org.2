Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B633146CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhBIDIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230320AbhBIDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/Cml9fJfOIKMiH17sYbLZNb5fx7uhgkIw+TMGyZimw=;
        b=cABNUj/g5LWMuPg7QzSV0AGQEL3T4yJTH2b7QqnLzoQQwBHtlB1uCIwt3fSDh/WMua3Xry
        dtQluDlhWY3wUqhqZydpsU76W4+bu/LlCWJ33i8EmCTZDUhz/LGn5NtXi48yUNvtFofPsi
        BlCG23UiHFBmnzKuaGdxCfAErmFWGUY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-9DzxDGbaMBiTXHYN_4mnAA-1; Mon, 08 Feb 2021 22:02:42 -0500
X-MC-Unique: 9DzxDGbaMBiTXHYN_4mnAA-1
Received: by mail-qt1-f198.google.com with SMTP id p20so11187661qtn.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 19:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/Cml9fJfOIKMiH17sYbLZNb5fx7uhgkIw+TMGyZimw=;
        b=igpKCDeKZ+iNDgEdEaKf9nL55YaIYu8uFYzfqFfUa/dHs3SSQGVjOO7P5aMEXxaEHN
         M52SXRoABcNb1i6QJW2XMjaQibZveom1Lo5Szmbhe/7xop7T66zOFhPL+BXw5S3jDOkB
         ZamDkAFl/CkUTzeQ/az30hmnHbhXOC4HySx2MeZ2ABRX1m+StTmjigUptPaYjkCnBqI1
         IoLu38msVIjkPilmgvztgQOlMupws4T23NQv7CiyTZy0GcTx9nL807ukUL9w4xYNglyG
         jd1mzVX6kbWAcS/d5bYkrGy5uB2z1Hw5+VpP6Fdvj43dIiUeB3tGcT6JXD76YbyTYDT8
         HcHg==
X-Gm-Message-State: AOAM532Ge8n1E4nurbVurFbvDDHosvMBILew30DEjYPHG9pGx4z+NjBk
        4TJUB21DOE0wDKg5j343lG6R5fguVbcuk7qRmgPIm1gRwttSodHKdv4L5m+C+XBJEsOA6yMZGjA
        0uWow0HTa3b37KKW4/oxtZGjv
X-Received: by 2002:a0c:b7a3:: with SMTP id l35mr5881568qve.46.1612839761762;
        Mon, 08 Feb 2021 19:02:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIOEctrkm3l5R6SZkaqR8QWfLpvxLeWV7SKUDmzr17+0bv3pMiSOaRSzsWGdMpQzUXQOlGNA==
X-Received: by 2002:a0c:b7a3:: with SMTP id l35mr5881537qve.46.1612839761506;
        Mon, 08 Feb 2021 19:02:41 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z20sm17078830qki.93.2021.02.08.19.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 19:02:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        peterx@redhat.com, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 5/5] hugetlb: Do early cow when page pinned on src mm
Date:   Mon,  8 Feb 2021 22:02:29 -0500
Message-Id: <20210209030229.84991-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209030229.84991-1-peterx@redhat.com>
References: <20210209030229.84991-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 620700f05ff4..7c1a0ecc130e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3727,6 +3727,18 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
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
@@ -3736,6 +3748,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	int cow = is_cow_mapping(vma->vm_flags);
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
+	unsigned long npages = pages_per_huge_page(h);
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
@@ -3784,6 +3797,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
+again:
 		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
 			/*
 			 * Skip if src entry none.  Also, skip in the
@@ -3807,6 +3821,52 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -3817,12 +3877,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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

