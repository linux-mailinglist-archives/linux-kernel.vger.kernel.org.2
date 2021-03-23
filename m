Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63019345434
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhCWAu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhCWAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiO26VDrmUg6vB+7BT5Jj5YPPTcAM0VGHQAxP1RtUns=;
        b=EBbBdeHDxfW7hSWfuaCz4ErdajgDYDANHMNX/SIKF2XqD0wUIWFqXBt8G9MtpWqL7+uxhg
        nXi/myr/4i2FzunJuNyaS28NvQvSq+9xyE0PcClqirIi0/A4Pxtg1H7g80zwdiqsVhGcp4
        xevTbr8AX7JW+3773VV4QwJ0DyzRcIw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-8h9rRDZHMbK4gs3PliKX3g-1; Mon, 22 Mar 2021 20:49:44 -0400
X-MC-Unique: 8h9rRDZHMbK4gs3PliKX3g-1
Received: by mail-qt1-f200.google.com with SMTP id f26so389306qtq.17
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiO26VDrmUg6vB+7BT5Jj5YPPTcAM0VGHQAxP1RtUns=;
        b=g9jv7m5EJ0mwqAjXj6m7nSEEt1CMJzzemvtLg029WlIQ9Z7qhSEpqQDpQid/kGd5mK
         3dSBfkxptuV2DD1zop1jt+xl96wdrBksA9W4d+WOgGrhQawMvprNq3XCd9jGiEWfCrZw
         DqSMfekF42PwdRO9NEoj2pEoOmpCvito7hZcz5HUHO+5xhzsCqCuYnLWTbQjfC+p8J3N
         xLsE2PxNejsw8Bx4WoTGbfV9L3CLu8qUO0+guSuYLLQiSEg3KbwM98l5Cz2Vjkhzh/cN
         kvlHRsRNyt68GTganJfGV8ugBrqhv/zfnTVicYUHgDYTPiM03iAn3X+WN9xRRBrwiAtx
         AR/Q==
X-Gm-Message-State: AOAM532uagAE1sy0yD08+uL6VVk1Xt/26QfjDLer0QJGcE9rfspZ7KGG
        o0fa9Ybj2OABZXk2t8cYn8Krp4bHz1VzKcLejt4LrhIZIK+3BOeafhpgwkPKxp5WF++vedMbdA8
        BNNio/+CSnF0bC7rUIIFzitlSCDQH7/pehGwf6cBIHUhoaGW1Vw3MU6Y55g9o4ELU2jvy7Rez6Q
        ==
X-Received: by 2002:a05:620a:244f:: with SMTP id h15mr2827108qkn.235.1616460582889;
        Mon, 22 Mar 2021 17:49:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWIpDXhwdNCAyIRtAVCaaAMdmYrNrenAgax2tWD83MS43YI42hO1l+4DhwqPJ+NaQThw1Wgg==
X-Received: by 2002:a05:620a:244f:: with SMTP id h15mr2827076qkn.235.1616460582571;
        Mon, 22 Mar 2021 17:49:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:41 -0700 (PDT)
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
Subject: [PATCH 16/23] hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Mon, 22 Mar 2021 20:49:05 -0400
Message-Id: <20210323004912.35132-17-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout
the stack.  Then, apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with
UFFDIO_COPY.  Introduce huge_pte_mkuffd_wp() for it.

Note that similar to how we've handled shmem, we'd better keep setting the
dirty bit even if UFFDIO_COPY_MODE_WP is provided, so that the core mm will
know this page contains valid data and never drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  5 +++++
 include/linux/hugetlb.h       |  6 ++++--
 mm/hugetlb.c                  | 22 +++++++++++++++++-----
 mm/userfaultfd.c              | 12 ++++++++----
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..548212eccbd6 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -27,6 +27,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
 	return pte_mkdirty(pte);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte_mkuffd_wp(pte);
+}
+
 static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return pte_modify(pte, newprot);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a7f7d5f328dc..ef8d2b8427b1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -141,7 +141,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
-				struct page **pagep);
+				struct page **pagep,
+				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -321,7 +322,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index def2c7ddf3ae..f0e55b341ebd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4725,7 +4725,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct address_space *mapping;
@@ -4822,17 +4823,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 0963e0d9ed20..78471ae3d25c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -207,7 +207,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode)
+					      enum mcopy_atomic_mode mode,
+					      bool wp_copy)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -304,7 +305,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page);
+					       dst_addr, src_addr, mode, &page,
+					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -406,7 +408,8 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      enum mcopy_atomic_mode mode);
+				      enum mcopy_atomic_mode mode,
+				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -527,7 +530,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, mcopy_mode);
+					       src_start, len, mcopy_mode,
+					       wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.26.2

