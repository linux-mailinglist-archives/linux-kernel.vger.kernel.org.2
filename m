Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22073C93AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhGNWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhGNWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlGOfsM9rm2m+cZAonb5FrW/IEnwBmumPPW7EcnV+EI=;
        b=OJJ41utvYgpnvnfjVk5Yf77xKm5DwHBU4AkjmZNEiA4idVTFFj+20osMtF3oK4IA+Dy5+H
        /2um2VZYxJgmMYBhxTtfbgrVSnVab71WrSKnEkS7CYVowu/CBZTbL4ORYJjYD0ZkUlVXTz
        AZkzKGMJ7cHu/pqOAZKn9DGjf/IJsv0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-zQe63hNGNEmEPD00kHIP0A-1; Wed, 14 Jul 2021 18:21:25 -0400
X-MC-Unique: zQe63hNGNEmEPD00kHIP0A-1
Received: by mail-qk1-f197.google.com with SMTP id r190-20020a375dc70000b02903acea04c19fso2312161qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlGOfsM9rm2m+cZAonb5FrW/IEnwBmumPPW7EcnV+EI=;
        b=CPbDvrGueGr7NRw/bhbndmQuKGl+e9RlN/4e1eEFjZKFoh1SZbeMd/EeKlfWMehgrI
         3YvpOrexmfiFGI1KGH6KIRpxaVZLGZ+GK7bExAWm4Hp3+2SJTXqiKu+RSzUXhWPhRCMw
         eWGzp1QAodkInXHLGqwYsGidmJRbzgbis4GbEnrNhWuLdVTSm0biVOvIb8Z7u3x2p6pq
         a76FsS9oHF/7aE4MJOo4svTBIqiNxg9o4wfJBAy0y5JkC3U84mWzJa6Bn7OMgyGKKCSN
         X6fc/qjQYhoqwJH114FF7PHw2B/2ylulcrL0zR6Q8EKgB7KeUuxf2E2FTj3UmYvBrazj
         iWUQ==
X-Gm-Message-State: AOAM530nQ808OOPAUI7tityJ9x2aZX9LkfwNVcMZZMf5e4bYxi5XgeIe
        VwbdmJZggQcINpB2cYa61fb7rBn2MYKanjYjW4rl12jxHY3ZIv3UU4Hl2NKkp11Cl9ykSLPTwRN
        PC4sl7P0p189KrikWt1ptlA12vcTzY63LlrTQqm5JEYbr6RQuNq0NxObJTQWqWKb2/4uYZWFMcQ
        ==
X-Received: by 2002:ae9:e644:: with SMTP id x4mr208214qkl.105.1626301284786;
        Wed, 14 Jul 2021 15:21:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZMIEbENGHhL6vjrq7lZny3uTxO1l6RhCF7LFn65Ziwb4pSrVyPurhPBGMM/glELOuwBDj8w==
X-Received: by 2002:ae9:e644:: with SMTP id x4mr208178qkl.105.1626301284518;
        Wed, 14 Jul 2021 15:21:24 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b25sm1625854qka.123.2021.07.14.15.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:21:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 02/26] shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Wed, 14 Jul 2021 18:20:53 -0400
Message-Id: <20210714222117.47648-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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

