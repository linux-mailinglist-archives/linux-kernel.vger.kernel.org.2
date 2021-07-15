Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E813CADBA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbhGOUUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241870AbhGOUT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMBtlxFg4n27f91rtS7zXaKqOiqv9TDTO7vSN67CwFo=;
        b=NGoo3Y7xl9r79xDhJ89OeUTM0Pix7oABstzKrkceYTuyYk1fySKbho+R7I/kZ3Ov7+7zGA
        EHYICs89t4F3I1yZ9sBXXQ81O41bhJbhl+S+Be+4PFEWMMJKag6nxSHuayDQ//G8oZprQ6
        UrKnbAJfWw+WgHoqFU1mS2KHBRfcpBk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-xuhOrirDNVCq19ssY_jFig-1; Thu, 15 Jul 2021 16:16:31 -0400
X-MC-Unique: xuhOrirDNVCq19ssY_jFig-1
Received: by mail-qk1-f199.google.com with SMTP id h12-20020a05620a400cb02903b8e915ccceso1330248qko.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMBtlxFg4n27f91rtS7zXaKqOiqv9TDTO7vSN67CwFo=;
        b=MMavCPaFpAwswiRDq0Ix2uBOydP5dUIXKn5KZr474EI7INc8Qd59mi8QSOIXy++FXr
         bV/W7viLIG/NUG3g3+U4vbFwx6B0eUNPZWJtO1o4orq96mkXkcuLEmEPtBO/i9+LouoN
         7fYT3CwM5wXP6RloliDJrPS7tAbpYO1WreUFIloa0CsN9JYJxG9bJ4sElCxTG1jmm13M
         OeDJsvZfX78pFs+6znKFY+IFytjYRvjpz5QD3dUlSOE30JY5WtCPJMWsLTIKPqnacVQ6
         UTkVhNLROhmMNYeTHe9ifjRk966dD547ZBr+WkRFHX4spw4iJpAu5ND3TqmffBfTuiao
         3dVQ==
X-Gm-Message-State: AOAM533Zvg1Mix+U0SxrRIh2BO/3hTnr0FbDcnDrX4CInKgcEh0aul4p
        lxqFL5Zg4zkfwMpgLD5c2Db9Nm6n6v10ViJ4alBszEYUOFfXnk1+LyS+Vi37WFj9Db1T7CIgwkr
        mv7f6eezMLUASiMPzDvLia1CusrO/scet2z+p4OB49nM1Zom3jZLRYqJcmss8Mlrt0U/ioETfcw
        ==
X-Received: by 2002:a37:9d12:: with SMTP id g18mr5605907qke.457.1626380190737;
        Thu, 15 Jul 2021 13:16:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNuixvDlfkRWt4KafbV8fooXyPXVrZeuGHjP+wus+I0LUnSews9Nd0V0qylOk23o20G6gv1w==
X-Received: by 2002:a37:9d12:: with SMTP id g18mr5605869qke.457.1626380190410;
        Thu, 15 Jul 2021 13:16:30 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id r4sm2526758qtc.66.2021.07.15.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:29 -0700 (PDT)
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
Subject: [PATCH v5 18/26] hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Thu, 15 Jul 2021 16:16:26 -0400
Message-Id: <20210715201626.211813-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index d34636085eaf..880cb2137d04 100644
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

