Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31F3C93C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhGNW2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235787AbhGNW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxMjY2pIac+F3Pu7DKFzRfyzJMN42tR8v58EMRPGSu0=;
        b=XWJln699btzePUF2W7Q7G+5k5B/xse5UNYRn2w+6siV+EW085iwLG2ysQPxanc7b/ZPcj1
        m8aX7VoGCdACaURQLfyutPwL7D+BrQXD+3JAXpwICrMpZItP69sXJjhFyK9E7ToSSYHSzF
        Xg9QDVfifdD9MTry5d3/kZ6Dw+Uiej8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-gmBdoDDCO3q-ERY6enDAKA-1; Wed, 14 Jul 2021 18:25:07 -0400
X-MC-Unique: gmBdoDDCO3q-ERY6enDAKA-1
Received: by mail-qk1-f200.google.com with SMTP id b6-20020a05620a1186b02903b429a7ee4bso2323428qkk.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxMjY2pIac+F3Pu7DKFzRfyzJMN42tR8v58EMRPGSu0=;
        b=USNvYG6K+K+EuSvpqmu4g3ZMtThaLv94Nrw4vxeRtE5nQcAkBkn3QNgzlnk64Nm4uU
         aK84HcIb9zuNaK1u4nXPyTsNT6eDrJH9jb9ft9/U1By2//xQoolcXsYe6QLVzE0ewocp
         16CBB1vkXbRxghoVAjLyBUQE9vgdc7OCruaUjRtw/hFlqhdvf6QTn3fQa4KHdOBA4+VJ
         7YpCYrNxGK1PEx+GQQZGvuPzFWZmPds3lbS9V2vpisafkh2dOT4YpB2BjPTeyKU03NZ5
         9ZA9nNu9DpvT+f96zkT/i/ez4X9JC2JCNgdUDfLdKy2IPrPzF9XquyPFdBCnEUPOijoU
         9CCg==
X-Gm-Message-State: AOAM5300lBnRqwJukvQRtanziBlJ6l9CC2PWXLfOtj2A09Dv60L4JdSQ
        Tf+cUWlWaTztV5uQDKBey0rZVfNRCjDSP6UxRDjzXf6VLEZsQGiVMBjrQpVWlE64DEZmPZotShp
        1udtm/Mtxiiw7WUNR7os8o6lT
X-Received: by 2002:ac8:58cb:: with SMTP id u11mr335293qta.342.1626301507095;
        Wed, 14 Jul 2021 15:25:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIZlX8JAribpNrq0wkAFbGM0ZiKXb3wEfDbm8EyndS32qRWndHNP3FXvvKZoMsl3TvmITdTw==
X-Received: by 2002:ac8:58cb:: with SMTP id u11mr335254qta.342.1626301506807;
        Wed, 14 Jul 2021 15:25:06 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id 7sm1300668qtx.33.2021.07.14.15.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:06 -0700 (PDT)
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
Subject: [PATCH v4 18/26] hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Wed, 14 Jul 2021 18:25:02 -0400
Message-Id: <20210714222502.48992-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
index c30f39815e13..fcdbf9f46d85 100644
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
@@ -336,7 +337,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 8559b8bb7fa5..f4efcb8c6214 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5141,7 +5141,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
@@ -5277,17 +5278,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
index 0c7212dfb95d..501d6b9f7a5a 100644
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
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
@@ -393,7 +394,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page);
+					       dst_addr, src_addr, mode, &page,
+					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -448,7 +450,8 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      enum mcopy_atomic_mode mode);
+				      enum mcopy_atomic_mode mode,
+				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -568,7 +571,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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

