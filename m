Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B83C93CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhGNW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236974AbhGNW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xF0M7X1DsWIfOb+PL4bMVWgDi6eXN7r5W8R38MPpTs=;
        b=Mv9Zh5myQ0ENcL2TCOcgUFWoa7cfWzxgS0rpGfSUFsexBpsO8ASyMQpBQoQ8yPoA/BI/78
        UdeJfRDW19XIKHzXIUrAnKQjFzaigQLVlmTrcf5WmJjzHhOu9hWCncEm7JdXhMWfbRoMJq
        ld1LeAWzaUH9wRrzTjfCgJetFFqTdLg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-7vllgGpDNpGHRMcmmS0c2Q-1; Wed, 14 Jul 2021 18:25:11 -0400
X-MC-Unique: 7vllgGpDNpGHRMcmmS0c2Q-1
Received: by mail-qv1-f69.google.com with SMTP id y12-20020a0ceacc0000b02902eaed054a57so2684091qvp.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xF0M7X1DsWIfOb+PL4bMVWgDi6eXN7r5W8R38MPpTs=;
        b=XrzxEJBfQlQfCVbu8M4RV8vsTYZr+e4d2VEzp4rZHfgUdSZxdWCN9FTA97YMtx0pua
         610WoKu5EHuFT51jwpn7XgDlj3PdkWIB3whXZDSXTnF+D9pWaJfkwK/2qsxhlU32OeHQ
         MeocGFTncHHqSKdxl6dBQ+tx9JRQeikpiUnsWGCZG3yJGKQXLErBLJN+e8/O+9DtTIKs
         NKhGykWM3X6hy6v8fHPnvcgz8f8E79ik1xO2EjQSkADtMLFZGRM4uVhqsyPvcwdxZ3Wf
         7Gj+ylrF7islB9v0VZrDVC2hDU5BzcdyRCcnaAqRM3ef5xaifUenbmaifIGVmlfwGt1M
         wHCg==
X-Gm-Message-State: AOAM532dIG0llE/bwpcYLUzEDhgz4EqUYtXzBG2xd/TuGtlsCuO1O3ZC
        3jg5YzDKlCDuWYzlW4rUs7ounikuV2Hsc2i608h4nTEy2JuV1Pzba8FbFyH0wS/gLsWv0HgW/FY
        WeoK+Jq68G8H4XFFipG/mCLPZ
X-Received: by 2002:a05:620a:21da:: with SMTP id h26mr234707qka.364.1626301511102;
        Wed, 14 Jul 2021 15:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAzfpIJGP3b/Bp6JWursq5waaz3pJsfn/nHxprQEqq4SvYcLJVducew1EhJJTmsYUN8IEusQ==
X-Received: by 2002:a05:620a:21da:: with SMTP id h26mr234684qka.364.1626301510880;
        Wed, 14 Jul 2021 15:25:10 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id i123sm16830qkf.60.2021.07.14.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 19/26] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
Date:   Wed, 14 Jul 2021 18:25:07 -0400
Message-Id: <20210714222507.49042-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
index f4efcb8c6214..7d3558265b6f 100644
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

