Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36236C957
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhD0QZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237421AbhD0QQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXCghrNNWHRRCCV5QV6/ctMnnQcSJJc61Ke+xYUBfck=;
        b=jVRTEl8bOhg/+uDzAv1FS7tqXfs6sYLfGSYbJCwrmLyD9nYApsgwo4buUWcZJM1IxWkdMJ
        H7Vig56QBmvvdoVERWotqoHJv6458/NzOzfK34gwt9vJY1akIcqU3AoRKV126j5sDK+U6l
        p09bAStzAA8d2hyO87WWFfVxwCydF4c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-wvlWsRIDMBGaHAEF3JWPVA-1; Tue, 27 Apr 2021 12:13:50 -0400
X-MC-Unique: wvlWsRIDMBGaHAEF3JWPVA-1
Received: by mail-qt1-f200.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so20837890qta.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXCghrNNWHRRCCV5QV6/ctMnnQcSJJc61Ke+xYUBfck=;
        b=hPmte1FwMdXs3GWl561WblLw3u2XA4Us6wUMntzMiJc73Yex9t+cBeb8fXi8fntbT8
         Gmtqns9LcAP9JMv0Bp0is6vvIW02UMEybGibrsyZWuxTRRlcPKVc/Am0u4mWL/GvNYg9
         MZreHeKJKwZ852KbqXbaCRqgvvQXTKVB+tqbdN5srZkXKt1ejhsF6qlGx8qTzh+i25WS
         WMj5dDv5bstdUgQXB3SFfIASQifoDGmYmGMmU1SaILHV7D1P3pnvxRwOibkmVI3sMAsg
         vGyhApSMTqVgt1Mv8W6MFzI/jrf/lUkzfxIG21gx2xy64Sc/rTLQfOx3vaRuqm5IvQRg
         H+ug==
X-Gm-Message-State: AOAM5305QvktG6OGwEa1Q0CnCmOdycBB2u411SJX2y7GGI0j02rBVECk
        QPO8zS/yO2iYy0Cf4iJ60v7aX8L+YiM1CT0f8UMLq6JqPwWvP8ArBl4z1Jk4MAHWQtpb/53ltDV
        jGKuaf4Ppl3r3HUX+BgytUqLg
X-Received: by 2002:a0c:fcc8:: with SMTP id i8mr12477256qvq.31.1619540029944;
        Tue, 27 Apr 2021 09:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxguoAyDMHYkFEYl63WpQWxcE8JjPIEI2Z6YlCr7tNl/+SaEdw+TPXCtDuapevxol/5mZyGrg==
X-Received: by 2002:a0c:fcc8:: with SMTP id i8mr12477221qvq.31.1619540029712;
        Tue, 27 Apr 2021 09:13:49 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:49 -0700 (PDT)
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
Subject: [PATCH v2 17/24] hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Tue, 27 Apr 2021 12:13:10 -0400
Message-Id: <20210427161317.50682-18-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout
the stack.  Then, apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with
UFFDIO_COPY.  Introduce huge_pte_mkuffd_wp() for it.

Hugetlb pages are only managed by hugetlbfs, so we're safe even without setting
dirty bit in the huge pte if the page is installed as read-only.  However we'd
better still keep the dirty bit set for a read-only UFFDIO_COPY pte (when
UFFDIO_COPY_MODE_WP bit is set), not only to match what we do with shmem, but
also because the page does contain dirty data that the kernel just copied from
the userspace.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  5 +++++
 include/linux/hugetlb.h       |  6 ++++--
 mm/hugetlb.c                  | 22 +++++++++++++++++-----
 mm/userfaultfd.c              | 12 ++++++++----
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89da..548212eccbd61 100644
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
index eb134a75cad41..e38077918330f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -138,7 +138,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
-				struct page **pagep);
+				struct page **pagep,
+				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -318,7 +319,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 8e234ee9a15e2..20ee8fdf6507d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4884,7 +4884,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct address_space *mapping;
@@ -4981,17 +4982,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 7adaebe222b8e..4f716838f1fdb 100644
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
@@ -526,7 +529,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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

