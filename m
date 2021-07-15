Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753453CADA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhGOURf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240872AbhGOUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlGOfsM9rm2m+cZAonb5FrW/IEnwBmumPPW7EcnV+EI=;
        b=eFT53ED8Favzcna7Pf8oFvf41Qo8JQ8mtfneIH1vvxvCbaeXKIH/L3R3rkmYaWSoFIWRuR
        3LvJoiyAFnJPFysoZc3ZNDMYZ3GLoT+AijXowXDjYQmFRUk57SwBHzGsqEc5TZKjD7rj/a
        PRqTHmcDpJ5V5+lIT6QUW4pB5QVwUqQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-5ysv2p_sOn21R85AcXs3EQ-1; Thu, 15 Jul 2021 16:14:31 -0400
X-MC-Unique: 5ysv2p_sOn21R85AcXs3EQ-1
Received: by mail-qk1-f198.google.com with SMTP id f203-20020a379cd40000b02903b861bec838so4683210qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlGOfsM9rm2m+cZAonb5FrW/IEnwBmumPPW7EcnV+EI=;
        b=nqAKLyb566TDLd9RYZnDdFgo9Lum4E30WyQuUrs/1YMLDS6SCrQ+8IMPdV6tjLJ8jJ
         vy82slKsrhuf0h1V314VjQ1do+HZkt2Aj2aWP7qKGZ/kA+dQHO7V2WkZuVATv7hw6I7q
         a08E2cZN7cF3gNXLQjsLkmcCvcGA+U1NkxixQrplhs5ciIUE8j/ogRu+oEhpJYFZlXtr
         QZL2pYuUmb6uKNw4N7z3RKdobKHh8td/gaxkJqfnLGx2Im3xr2YFb9IcZEsfEcwaXpiU
         YckmolHPSHNiKOgC6vcTo/IvEh/qYCmCohBINnAriiFeQ9BsRz225sk96kSG5JhrqRcq
         1egg==
X-Gm-Message-State: AOAM531Sly5C02i2R/au+hzFasFhyyGH7dPSaHh+dHYKrd7UXMnnB3QN
        d9dPtrHtBG3CvWUhiNUQFOnNOewR2mKaC3rI0aK+ltu0uPN7Z4YUUSWURxeYIxKnGvKrhnSfe98
        bgRaHryNxjL3ohzOeGb0CH73i
X-Received: by 2002:ad4:56e8:: with SMTP id cr8mr6203137qvb.53.1626380070284;
        Thu, 15 Jul 2021 13:14:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0uhkf6wYkI04VL2sZsW5m+cA6f4n1NaOa24iDjGZ7k4OHdI1+cuzgsVl+sEeChu1fm59chA==
X-Received: by 2002:ad4:56e8:: with SMTP id cr8mr6203119qvb.53.1626380070078;
        Thu, 15 Jul 2021 13:14:30 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, peterx@redhat.com
Subject: [PATCH v5 02/26] shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Thu, 15 Jul 2021 16:13:58 -0400
Message-Id: <20210715201422.211004-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, pass wp_copy into shmem_mfill_atomic_pte() through the stack.
Then apply the UFFD_WP bit properly when the UFFDIO_COPY on shmem is with
UFFDIO_COPY_MODE_WP, then wp_copy lands mfill_atomic_install_pte() which is
newly introduced very recently.

We need to make sure shmem_mfill_atomic_pte() will always set the dirty bit in
pte even if UFFDIO_COPY_MODE_WP is set.  After the rework of minor fault series
on shmem we need to slightly touch up the logic there, since uffd-wp needs to
be applied even if writable==false previously (e.g., for shmem private mapping).

Note: we must do pte_wrprotect() if !writable in mfill_atomic_install_pte(), as
mk_pte() could return a writable pte (e.g., when VM_SHARED on a shmem file).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/shmem_fs.h |  4 ++--
 mm/shmem.c               |  4 ++--
 mm/userfaultfd.c         | 23 +++++++++++++++--------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 8e775ce517bb..ba6ea8c4d534 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -128,11 +128,11 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  bool zeropage,
+				  bool zeropage, bool wp_copy,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
-			       src_addr, zeropage, pagep)       ({ BUG(); 0; })
+			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index dc9f95b5fb34..9608200f8a64 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2368,7 +2368,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage,
+			   bool zeropage, bool wp_copy,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2439,7 +2439,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       page, true, false);
+				       page, true, wp_copy);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b30a3724c701..2a9c9e6eb876 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -70,14 +70,22 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
-	if (page_in_cache && !vm_shared)
+	/* Don't write if uffd-wp wr-protected */
+	if (wp_copy) {
+		_dst_pte = pte_mkuffd_wp(_dst_pte);
 		writable = false;
-	if (writable) {
-		if (wp_copy)
-			_dst_pte = pte_mkuffd_wp(_dst_pte);
-		else
-			_dst_pte = pte_mkwrite(_dst_pte);
 	}
+	/* Don't write if page cache privately mapped */
+	if (page_in_cache && !vm_shared)
+		writable = false;
+	if (writable)
+		_dst_pte = pte_mkwrite(_dst_pte);
+	else
+		/*
+		 * We need this to make sure write bit removed; as mk_pte()
+		 * could return a pte with write bit set.
+		 */
+		_dst_pte = pte_wrprotect(_dst_pte);
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 
@@ -467,11 +475,10 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					     dst_addr, src_addr,
 					     mode != MCOPY_ATOMIC_NORMAL,
-					     page);
+					     wp_copy, page);
 	}
 
 	return err;
-- 
2.31.1

