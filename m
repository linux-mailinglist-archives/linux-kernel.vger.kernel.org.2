Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E751393714
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhE0UZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236591AbhE0UZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbZt0eoEWLox3U/frFubDdAmo5YNm3Rwmy7KTYyiQYM=;
        b=fEBllCdj4KipenFJAPDb+gEbTODiR5kqXLC3MM+Fte6rpUuHfppgySssPtakZJHKoVuadm
        eJ1610h0zXSbonu62SFe4zAnIV5aIdb7PIWjQ7dUe1n/AaAmES2Y93CfA49/FerklcK7r+
        eOgoLt3BIgy9nCEdqbSJ0cSGnqR//u4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-ej7WcUOTPuOSBZtfhASgLg-1; Thu, 27 May 2021 16:23:25 -0400
X-MC-Unique: ej7WcUOTPuOSBZtfhASgLg-1
Received: by mail-qv1-f69.google.com with SMTP id j14-20020a0cf30e0000b02902142ba51ef2so1022298qvl.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbZt0eoEWLox3U/frFubDdAmo5YNm3Rwmy7KTYyiQYM=;
        b=UNTV+QdAjprJakYAx/KdUD1+HxI8qRvbWe27KUagd37C8tJfv6VrWVse+oDyLnN6po
         V2+91qsweLsUCyzO316MMX3RekxFg0K6eO6v94VZEAMDJrX14j+FFR50aXM73Y2/erjl
         UtRdXRwd/2pEbisyEWr/+pwRji5VnqA+7lzxYPm/44DTWNalyCHwNY2R8g3OIBnkTjdU
         oBGlTM7540V8NBXxL6gKdB8RM5hcAp7034HNSPWzWKiJ/Tc9LAdCQXvf18spftnej035
         k1zeUpiAdHJcETjMD6uytOwXorKoShAyONYGFdC4lmUAhrQzDeijxk6mc2iHLw0JUUuv
         BROw==
X-Gm-Message-State: AOAM532FzYZmT2R9Qxe8jb6w2pmWV4LcnIG1zvD7UE5m+Z/kD4HXbOdq
        GTyusFSEauOoO3vAzuyHMYeQf9/hK+IM39E582EOCZvDZUFjI+jtHNHDoYOnQWPMfHs9TbytAgX
        QlfLuXJbdpS/6tY0fKpQqyOWElYpBTxl+vkDMPVOR0vjZbLVL3QBeW64raxCGTYz7K/iaOgjY2w
        ==
X-Received: by 2002:a05:620a:8d6:: with SMTP id z22mr289802qkz.407.1622147004669;
        Thu, 27 May 2021 13:23:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7EDf1VO1anNf/T5xNjyyn6/xaNm6K5kKhKB1cqb49ErCH+/+zpWA+AqfvzIh476npMMVMZA==
X-Received: by 2002:a05:620a:8d6:: with SMTP id z22mr289770qkz.407.1622147004349;
        Thu, 27 May 2021 13:23:24 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id t25sm2011860qkt.62.2021.05.27.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 20/27] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
Date:   Thu, 27 May 2021 16:23:20 -0400
Message-Id: <20210527202320.32048-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index d238a69bcbb3..3e4c5c64d867 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -204,7 +204,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -368,7 +369,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9bdcc208f5d9..b101c3af3ab5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5444,7 +5444,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -5454,6 +5455,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -5495,6 +5498,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
@@ -5509,6 +5516,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
index 424d0adc3f80..82c235f555b8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -743,6 +743,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp, bool *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -779,6 +780,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
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

