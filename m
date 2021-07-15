Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E43CADBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhGOUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245333AbhGOUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaAa2f5HhiDdTwzlDRlFEqwUvqKvM7+1vDjPPjycPYg=;
        b=agFxFzVrYa5bVBXkuwz5E8V11o+fVaJYUM9Zpp7Q3zM/vPXuPbvJ5SpbCaYk+4KxdJpMt/
        BAZMobRfSKIw2EU9DSK/glnkZFnfm2YF+UV6Xdy8fkioxKhFCtVQixO5h3M56BCmCvQp8i
        iO0FQi9HVWU2bcdgOUxWQ96Y7IzCnFU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-JRxFpMzFOQOljHErhHghUg-1; Thu, 15 Jul 2021 16:16:35 -0400
X-MC-Unique: JRxFpMzFOQOljHErhHghUg-1
Received: by mail-qv1-f70.google.com with SMTP id c5-20020a0562141465b02902e2f9404330so5027546qvy.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaAa2f5HhiDdTwzlDRlFEqwUvqKvM7+1vDjPPjycPYg=;
        b=NvbmUp55SPXBOSz0tpM54+wipEETpDkp0EzK8XxSfm5tI51i8KTjXkkrWEA4mqA4jw
         rnqzGeezDTFOv0iwHNND1npgz3Ai/Y+FvuWAmT2NBv691uGKAPSaMErkErKTZi42Ej8z
         OP3D3X7MIE8736uBZ+fRtVeO6/CWcaJePHGyNFrWOvw9PIGgjkwPIegGalCjeC24zXJ1
         6/TQjR8uRRVlIv7Q0CnhQH8Vb/ROt4OmAjLzuEMIj7QvVNUVW2ooydEQ6mBjNWc7O1rP
         7DdauhI9RTVsph6eNim13ll64lEfoqDWWPefEplGXlEe9OnHJWBJe4c2aj6R8SmPDxgs
         4c7w==
X-Gm-Message-State: AOAM5306c5GV7Ixi1EqAdkkXeRiG6ZMcyKDySAYGHK+nFafiv5x8y3uO
        qzP0MSWsHvIFfUghXUWxWNLk/OvtS9kXP0CtKArXn7kI6QcN+ehvwMNiijA6NiLUCZIJemWxwZC
        1bMIuJjBLjCL8c3ZBIxMvRbxLY1A5PxamdksCBkjQ3APQ7C0SG9hYkVl14t7Qez4H1eScYD+sBg
        ==
X-Received: by 2002:a05:622a:554:: with SMTP id m20mr5586536qtx.179.1626380194741;
        Thu, 15 Jul 2021 13:16:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCYFCYWTao+/GmLyupOP7Orbtxc30SWwQIjFWpns0q/lqsZyOZZQdbkKy3HTSsxYXRi6ymAA==
X-Received: by 2002:a05:622a:554:: with SMTP id m20mr5586498qtx.179.1626380194418;
        Thu, 15 Jul 2021 13:16:34 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id k66sm3157896qke.28.2021.07.15.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 19/26] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
Date:   Thu, 15 Jul 2021 16:16:30 -0400
Message-Id: <20210715201630.211865-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index fcdbf9f46d85..e19ca363803d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -205,7 +205,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -372,7 +373,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 880cb2137d04..4edb3ee885ea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5519,7 +5519,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -5529,6 +5530,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -5570,6 +5573,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
@@ -5584,6 +5591,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
index 3fcb87b59696..96f4df023439 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -426,7 +426,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot);
+		pages = hugetlb_change_protection(vma, start, end, newprot,
+						  cp_flags);
 	else
 		pages = change_protection_range(vma, start, end, newprot,
 						cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 501d6b9f7a5a..7ba721aca1c5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -695,6 +695,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp, bool *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -731,6 +732,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
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
2.31.1

