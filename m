Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B6345435
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhCWAvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhCWAtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhBZPg5Z3WMoKN7PnLVoaXXwSSsImCDdZ5uN4rmdysI=;
        b=HSH4eEezB2yZtOOpf8DQsAe6q/k4IWieJgMegiMv6VtfYDPBxL/gKEPuZY2RMBfR7ZUdQh
        pOuEoiQJ2J6ASeRWnt/hQbv40UFPeKVkryfVOrkbwZ5jT4H3LxgpqSNLsTEL8BVndYNbI7
        DMk6GX0O0tvvHH2OpHokVppYh940Ksw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-7k-2_avcMq-2Iu-WpgkxYw-1; Mon, 22 Mar 2021 20:49:45 -0400
X-MC-Unique: 7k-2_avcMq-2Iu-WpgkxYw-1
Received: by mail-qt1-f200.google.com with SMTP id j2so398290qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhBZPg5Z3WMoKN7PnLVoaXXwSSsImCDdZ5uN4rmdysI=;
        b=FwmMzIPbWXwWZsusD67IoOa094WD5yP+FzXY6LlCl9t4qJIfbWE+R3pwOobkwaQLcL
         h5qhRhcxorgUeNU4gLYJLhUap26AcKnqwwHymzFvyGruBs5dX/FpvlZSyClOk5RtquQS
         hZ5uL9VrWaO9C8W9JfKIvDS1oOxHs56W0O4SO5KTeel75jwCt8IjjWb5Qs+mEALrIpeE
         oULsajYqkpzLnHWg/JySZJtllAPP6ifWn8xR9HK6wjp6I2ZM/EMcDzhTwWCoGIlnpcPl
         5c2soGH8uPnzDwqyIbAcjkiu+c1+1+Y/1N70FJvP3xU9vFKxiTJg1OGfCNF/fqrCL13o
         5j5A==
X-Gm-Message-State: AOAM530kgz/kHwgYWvuPzRBHuwEFoePybQbbKoh75nTWTk9sWXqQ+HBY
        qzsxVYc9MS87aMKhvxNb4SZMnJ13jVTtyB/6g97IBD5oUKAF488vhR8TcdwC94yhcPvWeQvkM1t
        idB15G3ClqZFMmuNIkti10/0qAwh2Moamt6fakHro7MbjQOF7hByqzS9DIbyq7ITMCcIUZ58f0Q
        ==
X-Received: by 2002:ae9:e513:: with SMTP id w19mr3120262qkf.231.1616460584811;
        Mon, 22 Mar 2021 17:49:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCH+SBGMXuDXb1jmvEX2TeCWc+Nab5QwAa3TRvreNK9N+mjxOgDxPA3LiapLQzrImvnQdEXA==
X-Received: by 2002:ae9:e513:: with SMTP id w19mr3120225qkf.231.1616460584478;
        Mon, 22 Mar 2021 17:49:44 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 17/23] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
Date:   Mon, 22 Mar 2021 20:49:06 -0400
Message-Id: <20210323004912.35132-18-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This starts from passing cp_flags into hugetlb_change_protection() so hugetlb
will be able to handle MM_CP_UFFD_WP[_RESOLVE] requests.

huge_pte_clear_uffd_wp() is introduced to handle the case where the
UFFDIO_WRITEPROTECT is requested upon migrating huge page entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  5 +++++
 include/linux/hugetlb.h       |  6 ++++--
 mm/hugetlb.c                  | 13 ++++++++++++-
 mm/mprotect.c                 |  3 ++-
 mm/userfaultfd.c              |  8 ++++++++
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 548212eccbd6..181cdc3297e7 100644
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
index ef8d2b8427b1..92710600596e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -190,7 +190,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -352,7 +353,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f0e55b341ebd..fd3e87517e10 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5063,7 +5063,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -5073,6 +5074,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -5113,6 +5116,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 				make_migration_entry_read(&entry);
 				newpte = swp_entry_to_pte(entry);
+				if (uffd_wp)
+					newpte = pte_swp_mkuffd_wp(newpte);
+				else if (uffd_wp_resolve)
+					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
 						     newpte, huge_page_size(h));
 				pages++;
@@ -5126,6 +5133,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
index 51c954afa406..fe5a5b96a61f 100644
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
index 78471ae3d25c..01170197a3d7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -654,6 +654,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp, bool *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -690,6 +691,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
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

