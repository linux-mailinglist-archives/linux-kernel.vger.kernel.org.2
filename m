Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD23936FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhE0UVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235873AbhE0UVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9xr4bMl+zJeAQFvcMC4T+nTSZSbNTKgkWVTyL0bma8=;
        b=dmQkx+8fg7iKQ1IRRgAvKaLU8nT8Zp6V9G9K0y+if1lJr2XGjyUy+NeRmFWMB5e8T+X1O/
        W/CXvT2udtmo0o91/l1rlbgF4Y6AZikAybwX/GkKP++DSJ+3xYItIPqVFr8SLdo2pUtbnO
        VxBuXnceFuR1nUgKYUU5Lmi+naYIiSE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-h8Pl346uPrWjgVi_lMIZ7A-1; Thu, 27 May 2021 16:19:38 -0400
X-MC-Unique: h8Pl346uPrWjgVi_lMIZ7A-1
Received: by mail-qv1-f70.google.com with SMTP id h11-20020a0ceecb0000b0290211ed54e716so1020033qvs.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9xr4bMl+zJeAQFvcMC4T+nTSZSbNTKgkWVTyL0bma8=;
        b=i3nW0bSwiJafCp7Tm+6LAvItr+KVvhm7lNiYrj7dgg7bMFLaOgVVRSsUUdFopRAsws
         4MzGjPamsYNEeSSCN/hgnh2vtmF/iJZ6DkpNWHGb4Y62BQm0lMk3M+XWoIjYnqf43XKH
         jYzrDAAi7D43CYzVnmat3pXjFZvqqOFv31vnamEMqE03a8XCh3QjYFLZl3GsXUD2KWmS
         mb+Gihuu0ns7IcPFBMTW1/hBhxDHtJZM/LAf3sSD9IO+bnZr06FLyR8Tg+XPi7CKkOyA
         tCFnqHDrGTDWb2wTaxT74JlkLQgAKN4bbyGc3qpCWPmK0iVkb376NIeghApU7mIPUtIJ
         oa7Q==
X-Gm-Message-State: AOAM5330pqUYPg/rOwOC4F0/IW4Lk1o8zM/STvevecuKkJWKU9LYF2x4
        DMUuaXBcyLFr3mZbmHMmrURXyk7obxdvWayRm1XcZOy/xXYEk6XSPpfY5PWnQ5+eqY8NujqmD9s
        NyLnwho5puEYlzWpfFQk/Ma5eAUVP85SGFZcFK1G0jdEaS9YYcIj8B/tSMCg+Mhkkbvrln5Pfww
        ==
X-Received: by 2002:a05:6214:934:: with SMTP id dk20mr276639qvb.26.1622146777675;
        Thu, 27 May 2021 13:19:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx93jjVodboMgC/3iEgSR5YS6lBTH8CpTnxClpAjjIJe0S75YVhvKxzrlxBwhIfF9hncVRBmA==
X-Received: by 2002:a05:6214:934:: with SMTP id dk20mr276611qvb.26.1622146777383;
        Thu, 27 May 2021 13:19:37 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u14sm2089536qkp.80.2021.05.27.13.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:19:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 02/27] shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Thu, 27 May 2021 16:19:02 -0400
Message-Id: <20210527201927.29586-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index a69ea4d97fdd..0b6a8e871036 100644
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
index 4085a5cf4a13..5b648cbae37a 100644
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
index 462fa6e25e03..3636f5be6390 100644
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
 
@@ -515,11 +523,10 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
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

