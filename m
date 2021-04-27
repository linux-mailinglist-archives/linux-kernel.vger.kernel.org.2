Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DFF36C95E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhD0QZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237509AbhD0QQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3STWoX+h+7H6Wj9KnSBfR38e0Bi1l3dmByZQ1yWWdw=;
        b=WqqcMlMfmAMcEh0OamCjt3xLImlnc8g2A2YIYKDFXyQEbgZhc2ZmWRrFiMIrS6/BP09U9A
        6Gtv2mbNVc+JJQrvIJZ2h/vNLQA81CSF4/ASzVlOBPPA5uB5+pri56S8NIXZJAYSfCfDgh
        Px60mYJW4P68Lr1jNvTHdnZUw4BbouE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-rzwVQlSeNS-9UG6fSkZBBw-1; Tue, 27 Apr 2021 12:13:52 -0400
X-MC-Unique: rzwVQlSeNS-9UG6fSkZBBw-1
Received: by mail-qt1-f199.google.com with SMTP id p15-20020a05622a00cfb02901ae13813340so23582527qtw.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3STWoX+h+7H6Wj9KnSBfR38e0Bi1l3dmByZQ1yWWdw=;
        b=RpRaPrWwK8XKoXlMDgrU47GnzynVvPsVyGm4X5S4mTNWZWejL0LGMoP8GHFXjBaQai
         6wYjgxElm1RZB9rOtALTWVrbKPzksYVGf7gnqzA1iDc9fNdFEPMXaswo7nq7gTRdCO3q
         3i5vq9R4aJcCnrzZ8HI4LUXOu+78WlePQzk2lD3sdM3y1t6zBIsQQFjVq+g6vx1xfi9s
         BkvXyAgeS/ktSQiphoBY8FQnKoA0Kaw6ozDUtjl0XPbl1mcg4SfPjz+tWTygyH6o4vrm
         eWHHCe785myG9XXKS3kCiyih58fP36X0uU6ro2pNVgU7L/1unsg/PIq3d9zNA4i6lFzo
         rASA==
X-Gm-Message-State: AOAM530NvQh/i/ZY/kWCR2UyL8bMKlb5LvJfSmr4DcO3VQde/EwK1Y9o
        3Y/wyMfp/RdTt72oyXB812K+P0Qfqaf7ZfLxtVPc4MwTbc2H7GVHD+QF4Cr+7t2I2h2lWPd3owM
        2vzFqYMzVO4wQxQoujaH0kiwy
X-Received: by 2002:ac8:7415:: with SMTP id p21mr4673978qtq.182.1619540032331;
        Tue, 27 Apr 2021 09:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuCqNWpL5G+yOlcCNJxU5kGyB20g5K62154tFThtBHit8TA/uPr1LYDNPdz/VW8nA8Z0hNFQ==
X-Received: by 2002:ac8:7415:: with SMTP id p21mr4673949qtq.182.1619540032082;
        Tue, 27 Apr 2021 09:13:52 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:50 -0700 (PDT)
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
Subject: [PATCH v2 18/24] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
Date:   Tue, 27 Apr 2021 12:13:11 -0400
Message-Id: <20210427161317.50682-19-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This starts from passing cp_flags into hugetlb_change_protection() so hugetlb
will be able to handle MM_CP_UFFD_WP[_RESOLVE] requests.

huge_pte_clear_uffd_wp() is introduced to handle the case where the
UFFDIO_WRITEPROTECT is requested upon migrating huge page entries.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  5 +++++
 include/linux/hugetlb.h       |  6 ++++--
 mm/hugetlb.c                  | 13 ++++++++++++-
 mm/mprotect.c                 |  3 ++-
 mm/userfaultfd.c              |  8 ++++++++
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 548212eccbd61..181cdc3297e7b 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -32,6 +32,11 @@ static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
 	return pte_mkuffd_wp(pte);
 }
 
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte_clear_uffd_wp(pte);
+}
+
 static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return pte_modify(pte, newprot);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e38077918330f..652660fd6ec8a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -187,7 +187,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -349,7 +350,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 20ee8fdf6507d..3cad5d7726614 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5222,7 +5222,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -5232,6 +5233,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -5272,6 +5275,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 				make_migration_entry_read(&entry);
 				newpte = swp_entry_to_pte(entry);
+				if (uffd_wp)
+					newpte = pte_swp_mkuffd_wp(newpte);
+				else if (uffd_wp_resolve)
+					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
 						     newpte, huge_page_size(h));
 				pages++;
@@ -5285,6 +5292,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
 			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
 			pte = arch_make_huge_pte(pte, vma, NULL, 0);
+			if (uffd_wp)
+				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+			else if (uffd_wp_resolve)
+				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 51c954afa4069..fe5a5b96a61f9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -416,7 +416,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot);
+		pages = hugetlb_change_protection(vma, start, end, newprot,
+						  cp_flags);
 	else
 		pages = change_protection_range(vma, start, end, newprot,
 						cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4f716838f1fdb..ceb77ea24497e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -653,6 +653,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp, bool *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -689,6 +690,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	if (!vma_is_anonymous(dst_vma))
 		goto out_unlock;
 
+	if (is_vm_hugetlb_page(dst_vma)) {
+		err = -EINVAL;
+		page_mask = vma_kernel_pagesize(dst_vma) - 1;
+		if ((start & page_mask) || (len & page_mask))
+			goto out_unlock;
+	}
+
 	if (enable_wp)
 		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
 	else
-- 
2.26.2

