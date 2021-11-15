Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0444FFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhKOIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:06:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236690AbhKOIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hmTwTIZrb3ZAEbduDIRoqEEL0oiwJCe8ujMVDm5FPs=;
        b=R893HvKdbkHUhXEm2SuNZCth5hJcYHKKveZGFzmH2hzLP+SbQPgFs0L9dtyolRTq5Wk9Ts
        FpCeGCDznb+40tURPDNnI5sOGfmzJvft+r4C1dYTKbuj/WShVQp/sZ3nyZSRxfcgOKsFak
        biXJlMjfBKPPyWs/E5z+XVJqeWwg9PI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-qQee54baNmm8FT35soGviQ-1; Mon, 15 Nov 2021 03:02:03 -0500
X-MC-Unique: qQee54baNmm8FT35soGviQ-1
Received: by mail-pf1-f200.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso9585209pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hmTwTIZrb3ZAEbduDIRoqEEL0oiwJCe8ujMVDm5FPs=;
        b=j2quM+qsZk9rnGcxw/B4kl1g8ZXOCuAxqzKewD++lmyZynx2Kus9CdpOxlBN+XE0Zn
         Vnp8WfWhbn5dfR1fIcTuz/2dqiVNmDXb5CgqUQAxwzV6LWRvQVljs9S1pyJ1TmB5E3cF
         fJz6PDZ9zB9a/IkBu539W7WbagdM5AFtKxTCKh+AeevbsaZrU4+YjzqZzGAB84RSrt4m
         W5tU3XmNfj65h95/24pZk0VQyQjuo3CmdCtFozelwcOlx9XuT1tQZk9fDExPNFJk6l2p
         hALRMHXocx8GTMdO9rDV4GEQsslEjKW7jGsHoQhKGhMcMHwrQ29x7RBCYBExWCg/4lBK
         5w0A==
X-Gm-Message-State: AOAM530QwTQ2Dn9twsvN81WvsjATWuhhDRUw3y/QRkfKhatIN6GBHXqE
        KyCdr3gZeNyIh2EcxcuL5JXhjL5AwD15bJemOCoyDUm1Jup/UkGKS+4sYRFfrjFgCqIJHvzM0o8
        D5hLvHJlo/Le3n1uahtJlRBBd
X-Received: by 2002:a17:90a:4b47:: with SMTP id o7mr25848426pjl.92.1636963320391;
        Mon, 15 Nov 2021 00:02:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlWxTaC0v+r/YuGJSh03eszu/Jv/h92Vt+54eS7+7+RnqDDaawpklrXtrShKxo0IbKQ4Ql0g==
X-Received: by 2002:a17:90a:4b47:: with SMTP id o7mr25848392pjl.92.1636963320125;
        Mon, 15 Nov 2021 00:02:00 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id f21sm9904786pfe.69.2021.11.15.00.01.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:01:59 -0800 (PST)
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
Subject: [PATCH v6 13/23] mm/hugetlb: Take care of UFFDIO_COPY_MODE_WP
Date:   Mon, 15 Nov 2021 16:01:46 +0800
Message-Id: <20211115080146.74812-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout the stack.
Apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with UFFDIO_COPY.

Hugetlb pages are only managed by hugetlbfs, so we're safe even without setting
dirty bit in the huge pte if the page is installed as read-only.  However we'd
better still keep the dirty bit set for a read-only UFFDIO_COPY pte (when
UFFDIO_COPY_MODE_WP bit is set), not only to match what we do with shmem, but
also because the page does contain dirty data that the kernel just copied from
the userspace.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 29 +++++++++++++++++++++++------
 mm/userfaultfd.c        | 14 +++++++++-----
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 00351ccb49a3..4da0c4b4159a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -160,7 +160,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
-				struct page **pagep);
+				struct page **pagep,
+				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -355,7 +356,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						enum mcopy_atomic_mode mode,
-						struct page **pagep)
+						struct page **pagep,
+						bool wp_copy)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a10274b2e39..8146240eefc6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5740,7 +5740,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
@@ -5868,7 +5869,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	ret = -EEXIST;
-	if (!huge_pte_none(huge_ptep_get(dst_pte)))
+	/*
+	 * We allow to overwrite a pte marker: consider when both MISSING|WP
+	 * registered, we firstly wr-protect a none pte which has no page cache
+	 * page backing it, then access the page.
+	 */
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
 	if (vm_shared) {
@@ -5878,17 +5884,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-	/* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
-	if (is_continue && !vm_shared)
+	/*
+	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
+	 * with wp flag set, don't set pte write bit.
+	 */
+	if (wp_copy || (is_continue && !vm_shared))
 		writable = 0;
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
 	_dst_pte = make_huge_pte(dst_vma, page, writable);
-	if (writable)
-		_dst_pte = huge_pte_mkdirty(_dst_pte);
+	/*
+	 * Always mark UFFDIO_COPY page dirty; note that this may not be
+	 * extremely important for hugetlbfs for now since swapping is not
+	 * supported, but we should still be clear in that this page cannot be
+	 * thrown away at will, even if write bit not set.
+	 */
+	_dst_pte = huge_pte_mkdirty(_dst_pte);
 	_dst_pte = pte_mkyoung(_dst_pte);
 
+	if (wp_copy)
+		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
+
 	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
 	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 95e5a9ba3196..6174a212c72f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -291,7 +291,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode)
+					      enum mcopy_atomic_mode mode,
+					      bool wp_copy)
 {
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
@@ -379,7 +380,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
@@ -387,7 +388,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page);
+					       dst_addr, src_addr, mode, &page,
+					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -442,7 +444,8 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      enum mcopy_atomic_mode mode);
+				      enum mcopy_atomic_mode mode,
+				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -562,7 +565,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, mcopy_mode);
+					       src_start, len, mcopy_mode,
+					       wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.32.0

