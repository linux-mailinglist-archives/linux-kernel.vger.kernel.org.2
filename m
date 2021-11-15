Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38E44FF96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhKOIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhKOH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubfx2uHai2Y0k1b/BYqRnZVepmNNtt1cqqHxspLPNNE=;
        b=UPywxh7W19DhseIZIj+xcPOkYgexNhpsH2OUNSQJbPii/cVb0cusHYglyuCFNA4S0mBQYA
        1DWPlAU6RAGfsRs5ivT1sZAw0Hq47nqYvKQGKB6sb8aQiR344J2f5g5AefCZKZx2lWsG0O
        mGvfI7DuJXgernaRGKlJwWyqbU0K21w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-NpKKNQvnNXuq1eNsbL2ypw-1; Mon, 15 Nov 2021 02:56:17 -0500
X-MC-Unique: NpKKNQvnNXuq1eNsbL2ypw-1
Received: by mail-pj1-f71.google.com with SMTP id jx2-20020a17090b46c200b001a62e9db321so8612934pjb.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubfx2uHai2Y0k1b/BYqRnZVepmNNtt1cqqHxspLPNNE=;
        b=F1je25uwPk3bL5+FwF3krZXzQy8Jab3P7T9heEfNhC9l9iCaxlYefnqXIG2H3bpoOo
         qNWLdoVGpdGeBeZYNA5z9aG1lJIqNm9FLDRouYAOODpZFyYpXhM4B2U+42clKbpWQIOg
         HDHVi8Zzldeig3HxNZxsq8NjmFyOWKGzi7jt7mxh4OhtxcVXYEnLCki4wvOQBIMHISbY
         GAKsTmrZgCvEfUJTIJYyOXj4Nxxoc9Q94q/O0q5GkXOWCiBd9VsmC25acLkarRSpBZWU
         y/wuY368iWYF2VvqBSVS4M32pQRzEVYcqMk2WO8boM9t9ITa+0i2HYmrInOs4Z5IX6lo
         6F3g==
X-Gm-Message-State: AOAM532BbYQJ25eZC6ebdX8sSyKL6/yKUGCX1bioPyAzgLANu417mIA5
        klKwD1vLN3gYyooB6NiFE7gDM7tV7qptXyPQCbQtY07vlg+MNa8dXeMwo8kpvJ/p58aUDxvwQ3B
        QCsvuPxI+sv9lAkpajqcGLKcX
X-Received: by 2002:a17:902:b615:b0:143:bbf0:aad0 with SMTP id b21-20020a170902b61500b00143bbf0aad0mr16671612pls.12.1636962976147;
        Sun, 14 Nov 2021 23:56:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwavIcr/CimjYOEqw/YJdq6Mqfcy+56LKYHxJhlNMkBwmXshfu7Q/OZQlTY3k8NhCo5kJhghQ==
X-Received: by 2002:a17:902:b615:b0:143:bbf0:aad0 with SMTP id b21-20020a170902b61500b00143bbf0aad0mr16671588pls.12.1636962975927;
        Sun, 14 Nov 2021 23:56:15 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:56:15 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v6 05/23] mm/shmem: Take care of UFFDIO_COPY_MODE_WP
Date:   Mon, 15 Nov 2021 15:55:04 +0800
Message-Id: <20211115075522.73795-6-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass wp_copy into shmem_mfill_atomic_pte() through the stack, then apply the
UFFD_WP bit properly when the UFFDIO_COPY on shmem is with UFFDIO_COPY_MODE_WP.
wp_copy lands mfill_atomic_install_pte() finally.

Note: we must do pte_wrprotect() if !writable in mfill_atomic_install_pte(), as
mk_pte() could return a writable pte (e.g., when VM_SHARED on a shmem file).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/shmem_fs.h |  4 ++--
 mm/shmem.c               |  4 ++--
 mm/userfaultfd.c         | 30 +++++++++++++++++++++---------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 166158b6e917..0ee0f437b14f 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -145,11 +145,11 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
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
index dc038ce78700..167a46e6a1ff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2344,7 +2344,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage,
+			   bool zeropage, bool wp_copy,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2415,7 +2415,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       page, true, false);
+				       page, true, wp_copy);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ac6f036298cd..95e5a9ba3196 100644
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
 
@@ -92,7 +100,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	}
 
 	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
+	/*
+	 * We allow to overwrite a pte marker: consider when both MISSING|WP
+	 * registered, we firstly wr-protect a none pte which has no page cache
+	 * page backing it, then access the page.
+	 */
+	if (!pte_none_mostly(*dst_pte))
 		goto out_unlock;
 
 	if (page_in_cache)
@@ -467,11 +480,10 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
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
2.32.0

