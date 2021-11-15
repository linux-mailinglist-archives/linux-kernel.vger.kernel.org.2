Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0344FFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhKOIHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237373AbhKOIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlsVhTui5YYYuoTB5Im50dnZjt4bHIyLERdEUNhIhqY=;
        b=UmP5a45vtfZzsTvMuMtv9KGCILNf9ja7NMLs7mgfR+0Jg090SsmRYB0Qxd3b4OBJWxdEds
        2c734DdkwnVi8rKzQGLLlpCrGxgMSeIYCNHY9NiJ7006pSWEaD74Qy4of7l2EReXuglc7c
        rCzvPh+MQSkbk0TkSSg9zlelImUL/zE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-49GsGH__MB-tXAggVzckzg-1; Mon, 15 Nov 2021 03:03:10 -0500
X-MC-Unique: 49GsGH__MB-tXAggVzckzg-1
Received: by mail-pj1-f72.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so4881495pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlsVhTui5YYYuoTB5Im50dnZjt4bHIyLERdEUNhIhqY=;
        b=u1B8IQzBjUKlq9Owqg24QpnlPmj5MGyc7hMwAzdfn8yGNjs4zJeZ1ugEmUOhcVRzVp
         A99HyuU0kWQYIXTsZlKd6rwjH4jxVgtuKBpGydXJF8MhwX58Jh5xhhE8BX7Kl3FXZ+kI
         c/U2WK8yuO0Fz+GgAFMlwbiOvtKP2gOPvFN/Kf9ssfzQLTUJielymRiIQMwRcLxICd0r
         5vWsukJlqW2hPs52EZr8lQwXw8oPAsWA9+dl5VFxU3au6T8vg/wiNjWwue/DimaYDzrJ
         HuEzl2ZM+qdu+wjEhKUdsTMGU8pqEqsElzuhUu/dQMgf3TjMsvB0rAsnm0GE4O++feNH
         0ANQ==
X-Gm-Message-State: AOAM532s7AiHGBdFf4JK5IJJs2HQzgSuaY/KqCx45fI5sYu/7qmF6XR2
        kQJ5ZlXFsrei2ppg2mIdOCkkQO7vao+fOqn1/ZS3hqsIqrRKRzrBJ5dkYKk/Lja/RQJEZ39Fug9
        xHvNLu0vFcA0J78Lut3DYj0CW
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr63063510pjb.145.1636963389732;
        Mon, 15 Nov 2021 00:03:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQjMvgZ1MCPpUCZR/YQLBlvTIXbGd+IIXURYXaaXpubOwQw7QvuE9XXYAbw3RiQ73tuH1vFg==
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr63063457pjb.145.1636963389453;
        Mon, 15 Nov 2021 00:03:09 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id x20sm11712603pjp.48.2021.11.15.00.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:03:08 -0800 (PST)
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
Subject: [PATCH v6 18/23] mm/hugetlb: Handle uffd-wp during fork()
Date:   Mon, 15 Nov 2021 16:02:56 +0800
Message-Id: <20211115080256.75095-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, we'll need to pass in dst_vma into copy_hugetlb_page_range() because
for uffd-wp it's the dst vma that matters on deciding how we should treat
uffd-wp protected ptes.

We should recognize pte markers during fork and do the pte copy if needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  7 +++++--
 mm/hugetlb.c            | 41 +++++++++++++++++++++++++++--------------
 mm/memory.c             |  2 +-
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4c3ea7ee8ce8..6935b02f1081 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,7 +137,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     struct vm_area_struct *new_vma,
 			     unsigned long old_addr, unsigned long new_addr,
 			     unsigned long len);
-int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
+int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
+			    struct vm_area_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
 			 unsigned long *, unsigned long *, long, unsigned int,
@@ -268,7 +269,9 @@ static inline struct page *follow_huge_addr(struct mm_struct *mm,
 }
 
 static inline int copy_hugetlb_page_range(struct mm_struct *dst,
-			struct mm_struct *src, struct vm_area_struct *vma)
+					  struct mm_struct *src,
+					  struct vm_area_struct *dst_vma,
+					  struct vm_area_struct *src_vma)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16fb9cd8d9c5..cf9a0e8c32ba 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4690,23 +4690,24 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 }
 
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			    struct vm_area_struct *vma)
+			    struct vm_area_struct *dst_vma,
+			    struct vm_area_struct *src_vma)
 {
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
-	bool cow = is_cow_mapping(vma->vm_flags);
-	struct hstate *h = hstate_vma(vma);
+	bool cow = is_cow_mapping(src_vma->vm_flags);
+	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
 	if (cow) {
-		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, src,
-					vma->vm_start,
-					vma->vm_end);
+		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_vma, src,
+					src_vma->vm_start,
+					src_vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
 	} else {
 		/*
@@ -4718,12 +4719,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		i_mmap_lock_read(mapping);
 	}
 
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
+	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
-		dst_pte = huge_pte_alloc(dst, vma, addr, sz);
+		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
 			break;
@@ -4758,6 +4759,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
 				    is_hugetlb_entry_hwpoisoned(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
+			bool uffd_wp = huge_pte_uffd_wp(entry);
 
 			if (is_writable_migration_entry(swp_entry) && cow) {
 				/*
@@ -4767,10 +4769,21 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				swp_entry = make_readable_migration_entry(
 							swp_offset(swp_entry));
 				entry = swp_entry_to_pte(swp_entry);
+				if (userfaultfd_wp(src_vma) && uffd_wp)
+					entry = huge_pte_mkuffd_wp(entry);
 				set_huge_swap_pte_at(src, addr, src_pte,
 						     entry, sz);
 			}
+			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
+		} else if (unlikely(is_pte_marker(entry))) {
+			/*
+			 * We copy the pte marker only if the dst vma has
+			 * uffd-wp enabled.
+			 */
+			if (userfaultfd_wp(dst_vma))
+				set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else {
 			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
@@ -4785,20 +4798,20 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * need to be without the pgtable locks since we could
 			 * sleep during the process.
 			 */
-			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+			if (unlikely(page_needs_cow_for_dma(src_vma, ptepage))) {
 				pte_t src_pte_old = entry;
 				struct page *new;
 
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new = alloc_huge_page(vma, addr, 1);
+				new = alloc_huge_page(dst_vma, addr, 1);
 				if (IS_ERR(new)) {
 					put_page(ptepage);
 					ret = PTR_ERR(new);
 					break;
 				}
-				copy_user_huge_page(new, ptepage, addr, vma,
+				copy_user_huge_page(new, ptepage, addr, dst_vma,
 						    npages);
 				put_page(ptepage);
 
@@ -4808,13 +4821,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
-					restore_reserve_on_error(h, vma, addr,
+					restore_reserve_on_error(h, dst_vma, addr,
 								new);
 					put_page(new);
 					/* dst_entry won't change as in child */
 					goto again;
 				}
-				hugetlb_install_page(vma, dst_pte, addr, new);
+				hugetlb_install_page(dst_vma, dst_pte, addr, new);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
diff --git a/mm/memory.c b/mm/memory.c
index 69a73d47513b..89715d1ec956 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1284,7 +1284,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return 0;
 
 	if (is_vm_hugetlb_page(src_vma))
-		return copy_hugetlb_page_range(dst_mm, src_mm, src_vma);
+		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
 		/*
-- 
2.32.0

