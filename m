Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18F393713
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhE0UZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236505AbhE0UY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GDjCOxfDPOEsRYzqON2M4AMdWZ8835TBDlBiZOtoT4=;
        b=GgkytLTmDYxydKTIrUDmzt8IWWfD0HLD/MEOKR/VM1QDH8axNHoFJohPTa+yF/gCkCuSYr
        AEFKQL61DXMYZ3OFKf7tcq/OcAJSK45RgBCXUpmQExl0/bF1pHhQZmEhKVSIOJnX4X3dQz
        x7PQJPkXPdSnmKX4gtFoaA83ExbJ6IA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-5mM5IzMdN-6F9GaW7X61ig-1; Thu, 27 May 2021 16:23:23 -0400
X-MC-Unique: 5mM5IzMdN-6F9GaW7X61ig-1
Received: by mail-qv1-f72.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso1001266qvb.18
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GDjCOxfDPOEsRYzqON2M4AMdWZ8835TBDlBiZOtoT4=;
        b=qlxwX8dColxJ9pSe1CpW8caqfVpr6GWLCS5E6qfIk3q4gd4YzrMA806bsv+wabE2TM
         bNka+EkZoGUF8XK/ktVeHargq8U/RKBor6XJdAYmUNy0AhFhrqGKOudoHuQ3G5eb1Nkl
         0a7KMEtWp4UJKQt37USuHqxdCnSBBY1/SuIhjbcYzsvWcn0fkGO5ETAz072/Ob71yl98
         x5SvFu4CQQK7hP/9qrJkKYrfWqy1G9gckl/qPIIlz41idlUPiNB8pSgU1CHLD6qdpR3g
         fWAXq69LHYJZh1nI5uJYM6aadXUhAsr7E/6ekDv0OXrfMo8w5+xCRAQ7306XVIfcTRo6
         JnlA==
X-Gm-Message-State: AOAM531azn5hQ1ziEW2T7nzhIAv8IQ8i7beCAIEE5VFcob7n0vmR+CGY
        VtmqXDzDY2lmSQaancZ38neTl5gYbcRYFjYhCovmEjnNZv6CWVbIv3yMCaf5qPrZbXAIL3GseL7
        o/5sjlyTfuTkr7X0PuyS1OboA04MSSYttkprEQ+Y40BzC9KsOrXB2eAbHkXUsGq0WDpCePs/89g
        ==
X-Received: by 2002:a05:620a:248f:: with SMTP id i15mr310917qkn.239.1622146999801;
        Thu, 27 May 2021 13:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt71gbe8C1zJT9R17fnlIm87KTerMisk37d4KUupzC0L7JGl/wu6GvNWmVhJL7cHOazzx7Tw==
X-Received: by 2002:a05:620a:248f:: with SMTP id i15mr310872qkn.239.1622146999420;
        Thu, 27 May 2021 13:23:19 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id x11sm2057642qkh.129.2021.05.27.13.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:18 -0700 (PDT)
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
Subject: [PATCH v3 19/27] hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Thu, 27 May 2021 16:23:15 -0400
Message-Id: <20210527202315.31993-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 22 +++++++++++++++++-----
 mm/userfaultfd.c        | 12 ++++++++----
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7ef2b8c2ff41..d238a69bcbb3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -155,7 +155,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
-				struct page **pagep);
+				struct page **pagep,
+				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -337,7 +338,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 4cbbffd50080..9bdcc208f5d9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5062,7 +5062,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
@@ -5203,17 +5204,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 147e86095070..424d0adc3f80 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -297,7 +297,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode)
+					      enum mcopy_atomic_mode mode,
+					      bool wp_copy)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -394,7 +395,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page);
+					       dst_addr, src_addr, mode, &page,
+					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -496,7 +498,8 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      enum mcopy_atomic_mode mode);
+				      enum mcopy_atomic_mode mode,
+				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -616,7 +619,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, mcopy_mode);
+					       src_start, len, mcopy_mode,
+					       wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.31.1

