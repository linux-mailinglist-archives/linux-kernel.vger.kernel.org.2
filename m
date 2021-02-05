Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E847310E50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhBEPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbhBEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBcsouZewuvk8KZODy/tJjYpoCFexLf8th1hdmd2fdU=;
        b=jBGc86R/zdSHU30Sa90TFlaf1YCdIAFMzYGzHI/SQ/XojxcN6AqAeTQs9m+FcuRPPkq0Q7
        C9YH4ur8QsI5oYQMrPvDJu2K+yaxZDWP8RjPCErRDBYRo9qmpXtFbbIrVJMD++3Qiyb/0z
        ZALZJG+8ZYFpS7uA/Eq/0cjZQBefKYQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-kJMfH5zLOUmOMKWuBYZudQ-1; Fri, 05 Feb 2021 11:53:40 -0500
X-MC-Unique: kJMfH5zLOUmOMKWuBYZudQ-1
Received: by mail-qk1-f198.google.com with SMTP id e5so6364942qkn.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBcsouZewuvk8KZODy/tJjYpoCFexLf8th1hdmd2fdU=;
        b=S//0PGrQJaNNsA9crVewAnOTHaLIhoNcNSvDwqeLG4Nkne5N82bhxRbSyMkLXRBdHO
         CVaTwzi2OrZigICXSACsngF8yxAeDdPZKxodEpnyImv9x0yJgVAPwEkpLA6mYh0PUfpR
         BTAQ3z1TcoaTcwg116MfyKiNfCV0jsVmKb4ABG7fIu//GyzoC8qdFHzepNpTRXzjCQdv
         /712D3Ywtao/+yK3xqZQFlfr6zrNNQmCjSWBsd25fNY0PQW91Rho9DmjalNzL7kMbca5
         hcXT9p5O5dS0HP+z94fqk+1PNA5hfc4jmYi6pi+SUAHFUsDqWaTuWcYbx7zDYrzrmmSi
         o9YQ==
X-Gm-Message-State: AOAM533GlbMOcCL1/Tc1nSxYgZMCTGXgICj9mbtZDZJNSqMbJ1tdwjuD
        8PhHYtFswpvXF+Ww+Np0JP4Sx9V8sIB52jtoc499qxjGsSgp6PVXxgrhFsrRsJSyGvEV7S7I2EE
        8AuwxqqZOZqIHgS2HIY6MwX5c
X-Received: by 2002:ac8:5c0a:: with SMTP id i10mr4900099qti.239.1612544019908;
        Fri, 05 Feb 2021 08:53:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFpCiS7vlmmziN/8ahxv+juOeWp1Z1zPJrlPr5nMSaR9n55md55zNusgN1cZRy2ABzzKQMqw==
X-Received: by 2002:ac8:5c0a:: with SMTP id i10mr4900071qti.239.1612544019658;
        Fri, 05 Feb 2021 08:53:39 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm9618893qkg.39.2021.02.05.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:53:39 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 5/5] hugetlb: Do early cow when page pinned on src mm
Date:   Fri,  5 Feb 2021 11:54:06 -0500
Message-Id: <20210205165406.4655-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205165406.4655-1-peterx@redhat.com>
References: <20210205165406.4655-1-peterx@redhat.com>
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

