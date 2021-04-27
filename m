Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3136C91E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhD0QSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237513AbhD0QOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHnDMU05VPiYnBKDqKuhxjdmmK4rVbQVkQv2fE0zGZ4=;
        b=Pydb9Tyb9k+O/ZSNP4xK6psBXOlSeGM5Mr25sXYUnL7nPPtOdtXFwu5PgcwN0OUF7ctC3m
        BVeXGsPRm3jDxwgvoRxZ/D4TFdu7mOXwg0Wh1vLt6R/NrOfJv18INybptcPIfGxLM77S5b
        Ue4dYllB1T2gWo0D1+p8HnKNyiD/yF0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-GWm7Jy7lM0us-LWh0hXVMg-1; Tue, 27 Apr 2021 12:13:22 -0400
X-MC-Unique: GWm7Jy7lM0us-LWh0hXVMg-1
Received: by mail-qt1-f199.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso4393231qtr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHnDMU05VPiYnBKDqKuhxjdmmK4rVbQVkQv2fE0zGZ4=;
        b=cVoPXx0gOtDsCAbJAblWzKONcxTwO3JEqMl1WMAHJRLNdeLluojMPytCV+r7YEU+yK
         +pSYPXuI7556mmyCbHg36EUDk3W25Ong2qI0M0ckMIadPIwWXycl7Wbk/pvddNm/u8M7
         awgAq6t9A1pynu/LA4tU4zk0Bn0SXI75U8u//IHlDqhuXhg212LkNDBHMfPVvgV4R3Xy
         dV+1CdbNKW0TRgBgJdbsFNqBWeJ2/Lq8ro245hDxfTRfFy5SYLwsmKM6MeR7eqm6C8VN
         SbP4nOGJYRKet10enmam7W1c/nBJvnYSF0HZ2KDArjaZt0trpfoTOznqge510192jwe+
         ytnA==
X-Gm-Message-State: AOAM533zDLGGJNI041M/JtyzKNgqx1s9rQCmfa7qbrb5EFyWP6UBqs6m
        67AvUBziioUen2aMqD/3pcGdZIVam/ElcrBRVYk5z1pRX6SJs22HqN1YB8b6JlddUEbzf2yrk32
        MvEnVtgRFwLXlQslj4KSGzRfm
X-Received: by 2002:a05:620a:1026:: with SMTP id a6mr16061596qkk.357.1619540002135;
        Tue, 27 Apr 2021 09:13:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK7lRS/kPuU3kySXb7Ky2ewLEdvChHwX5FGOdMQ2X/Vpu9E4UvJ1aP8a2K5CItcnmpbfQx2g==
X-Received: by 2002:a05:620a:1026:: with SMTP id a6mr16061570qkk.357.1619540001874;
        Tue, 27 Apr 2021 09:13:21 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:20 -0700 (PDT)
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
Subject: [PATCH v2 01/24] shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Tue, 27 Apr 2021 12:12:54 -0400
Message-Id: <20210427161317.50682-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, pass wp_copy into shmem_mfill_atomic_pte() through the stack.
Then apply the UFFD_WP bit properly when the UFFDIO_COPY on shmem is with
UFFDIO_COPY_MODE_WP.

One thing to mention is that shmem_mfill_atomic_pte() needs to set the dirty
bit in pte even if UFFDIO_COPY_MODE_WP is set.  The reason is similar to
dcf7fe9d8976 ("userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE
is not set") where we need to set page as dirty even if VM_WRITE is no there.
It's just that shmem can drop the pte any time later, and if it's not dirty the
data will be dropped.  For uffd-wp, that could lead to data loss if without the
dirty bit set.

Note that shmem_mfill_zeropage_pte() will always call shmem_mfill_atomic_pte()
with wp_copy==false because UFFDIO_ZEROCOPY does not support UFFDIO_COPY_MODE_WP.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/shmem_fs.h |  5 +++--
 mm/shmem.c               | 27 ++++++++++++++++++++-------
 mm/userfaultfd.c         |  2 +-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d82b6f3965885..a21eb25183d02 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -127,14 +127,15 @@ extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  struct page **pagep);
+				  struct page **pagep,
+				  bool wp_copy);
 extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
 				    pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr);
 #else
 #define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
-			       src_addr, pagep)        ({ BUG(); 0; })
+			       src_addr, pagep, wp_copy)    ({ BUG(); 0; })
 #define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
 				 dst_addr)      ({ BUG(); 0; })
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad233..8fbf7680f044c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2360,7 +2360,8 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
 				  bool zeropage,
-				  struct page **pagep)
+				  struct page **pagep,
+				  bool wp_copy)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2422,9 +2423,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
-	if (dst_vma->vm_flags & VM_WRITE)
-		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
-	else {
+	if (dst_vma->vm_flags & VM_WRITE) {
+		if (wp_copy)
+			_dst_pte = pte_mkuffd_wp(pte_wrprotect(_dst_pte));
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+		/*
+		 * Similar reason to set_page_dirty(), that we need to mark the
+		 * pte dirty even if wp_copy==true here, otherwise the pte and
+		 * its page could be dropped at anytime when e.g. swapped out.
+		 */
+		_dst_pte = pte_mkdirty(_dst_pte);
+	} else {
 		/*
 		 * We don't set the pte dirty if the vma has no
 		 * VM_WRITE permission, so mark the page dirty or it
@@ -2482,10 +2492,12 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   struct page **pagep)
+			   struct page **pagep,
+			   bool wp_copy)
 {
 	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, src_addr, false, pagep);
+				      dst_addr, src_addr, false, pagep,
+				      wp_copy);
 }
 
 int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
@@ -2496,7 +2508,8 @@ int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
 	struct page *page = NULL;
 
 	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, 0, true, &page);
+				      dst_addr, 0, true, &page,
+				      false);
 }
 
 #ifdef CONFIG_TMPFS
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e14b3820c6a81..7adaebe222b8e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -443,7 +443,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 		if (!zeropage)
 			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
 						     dst_vma, dst_addr,
-						     src_addr, page);
+						     src_addr, page, wp_copy);
 		else
 			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
 						       dst_vma, dst_addr);
-- 
2.26.2

