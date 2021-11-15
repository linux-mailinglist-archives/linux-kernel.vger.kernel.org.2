Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A244FFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhKOIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235183AbhKOIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Iv5CypmvIVE6oMVapm0QBWFP5IxCJXl/Bg1UzUVmko=;
        b=Azrr1UycFvJ406I8VXr/O+bI1sY9o6eICwX8VsEY1KUoODm1xR78J+QO8/2O3Nvd8x0CIu
        zG39oMSKcjEYLWHLgOlLCQzr7tT10PBMaeJ65zugQJ7BBvsUoOOKhaB0zmUSufUi9C2Fvg
        C/uKQYOU+KLwjFNrvWPnutNgi3ECArk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-IR2xB2G3M2uhiltCH_eZGQ-1; Mon, 15 Nov 2021 03:02:15 -0500
X-MC-Unique: IR2xB2G3M2uhiltCH_eZGQ-1
Received: by mail-pl1-f200.google.com with SMTP id z3-20020a170903018300b0014224dca4a1so5887410plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Iv5CypmvIVE6oMVapm0QBWFP5IxCJXl/Bg1UzUVmko=;
        b=IuQrqUW//tyAN0iODEIt/eFZLx3G9lqIBYVcXruW0s5lg252+fIaqnvqRLo3tvsla3
         wv+ALqLspQODt6B0Yj879zR8ZSsNx+VyIG2pky2p4VE7mPbiIASLgXf+0D4njLE7u14k
         V+FzJv8ZwvyKkbAx3ezl4r4s37JburyQc8VNmYD44fyGx8TCiDfn2O1zgwkpn2AgzSmS
         ++f7mIlFTgI2LJClZx51CalOOWGznkRQXAiV1EZdyyQYye9bnDOGjL/f1oQlJyY3fWFo
         remX2OJwirTg8EgWsnPFBR+x3UsAKT3GLPCYu9GZT776dTcx0EZji+yz/fdrY8+NF/C5
         N51w==
X-Gm-Message-State: AOAM53194cnf3aINrgF6e34nScReb5VBflKG2D6DLYeLyq3ltyhr+NoR
        sxCNwmhuZ42JWHRe6aKsQIcY3u/cdZZsZ7r8wrnySHelIf/1+xPmoGbZqUpDH0x4RIzfjWpz7x9
        LayXeJd1hrr/rQJ4Pa/qppWIK
X-Received: by 2002:a17:90b:38c5:: with SMTP id nn5mr61485311pjb.220.1636963334076;
        Mon, 15 Nov 2021 00:02:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNSkZ/vww+jPhvco2wNnlsy70sP9i0ZGZit2163wehM7xneRAKVX66NU/eBtol2Mp8mRmPcQ==
X-Received: by 2002:a17:90b:38c5:: with SMTP id nn5mr61485283pjb.220.1636963333787;
        Mon, 15 Nov 2021 00:02:13 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id h25sm10459878pgm.33.2021.11.15.00.02.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:02:13 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 14/23] mm/hugetlb: Handle UFFDIO_WRITEPROTECT
Date:   Mon, 15 Nov 2021 16:02:00 +0800
Message-Id: <20211115080200.74866-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
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
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 13 ++++++++++++-
 mm/mprotect.c           |  3 ++-
 mm/userfaultfd.c        |  8 ++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4da0c4b4159a..a46011510e49 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -210,7 +210,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -391,7 +392,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8146240eefc6..7fc213c0ebf8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6127,7 +6127,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -6137,6 +6138,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -6178,6 +6181,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				entry = make_readable_migration_entry(
 							swp_offset(entry));
 				newpte = swp_entry_to_pte(entry);
+				if (uffd_wp)
+					newpte = pte_swp_mkuffd_wp(newpte);
+				else if (uffd_wp_resolve)
+					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
 						     newpte, huge_page_size(h));
 				pages++;
@@ -6192,6 +6199,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
 			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
+			if (uffd_wp)
+				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+			else if (uffd_wp_resolve)
+				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0d4bf755cee8..1cc4a6d1886b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -441,7 +441,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot);
+		pages = hugetlb_change_protection(vma, start, end, newprot,
+						  cp_flags);
 	else
 		pages = change_protection_range(vma, start, end, newprot,
 						cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 6174a212c72f..037f82719e64 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -690,6 +690,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -726,6 +727,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
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
2.32.0

