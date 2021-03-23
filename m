Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97807345424
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCWAts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhCWAtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+P1dWJGjbRulk7s1nJfmaHQsVvt1Wj4iX3MZXYNalzI=;
        b=hV6lLrpDVSGJT3fxb/NentO0ojUzPJiqXccWapBQ2SKgUjo2vEkTE3btZw1GNyRKlR45SO
        NTsvN36wT14fAK3m3hfmIDbaSB51NNAcf/vAPCyoTRIr27U9JAY9gqTex4mTxy8IeqEvEv
        vf7lIOH1g6XsegmNB62Ta2el69r5RVo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-Y64JoGlPNn-S-6qrj79U8Q-1; Mon, 22 Mar 2021 20:49:18 -0400
X-MC-Unique: Y64JoGlPNn-S-6qrj79U8Q-1
Received: by mail-qt1-f197.google.com with SMTP id m35so397195qtd.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+P1dWJGjbRulk7s1nJfmaHQsVvt1Wj4iX3MZXYNalzI=;
        b=Zd3PRnNNWAjs1VXJsz4c1PEX0ESVjR1eEOpn9lly8igvjrkGtjqkTNgRPM9bchEnsz
         LvphZKOALBCIqe4nlSfgAPFjtgffJmpovVDLWKQefJ9PaBW8qCEX0vZ97MtpG7YDXeIO
         psBtX2fid0aFUH6qi3jWJp3Rd/LXiFRYf1fZAyhZg3fk+3MEqwtTCgazxSBQwjDD6Uyl
         VhFgamY0o/72yl5xetbuWL5JIgxwtLU44vlfx8N5BdfA1WvvYukIc9JHX8LjJtz+1U+y
         TrmvQ62gS4w187EC+WSJDtkcjSLVsLUPj41VVgB0XkoO5ZBXxib7l/SvSWOlDSwE/Goa
         Gc5w==
X-Gm-Message-State: AOAM533v8Vj9Q8X1QCh8EOQLWOIEqbuk3ZDdvk2kOLnEiYxWiiFhnhsi
        mwuHlF/pVEQcG6bFySd+p1rmvyaHnQYB/47bdrhy7qeobRz76DU5Rrn4bs4jGStl02NDqSUIi/w
        Y73zymQ+u3cMhTIK8fH889R88EqeJ/nrB0nCu7bt/oiGduDPKBdzR5sroqyiKBfYh4uOTwa6hWA
        ==
X-Received: by 2002:a05:622a:1192:: with SMTP id m18mr2273155qtk.27.1616460557143;
        Mon, 22 Mar 2021 17:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqjFEqUS8mI2bN3hk02sEVq6e4Mt4cud7LDIj6h6LCxZV+FMUuvXeBvvd82VpC1CtDlxHBfA==
X-Received: by 2002:a05:622a:1192:: with SMTP id m18mr2273126qtk.27.1616460556811;
        Mon, 22 Mar 2021 17:49:16 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:16 -0700 (PDT)
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
Subject: [PATCH 01/23] shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
Date:   Mon, 22 Mar 2021 20:48:50 -0400
Message-Id: <20210323004912.35132-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
 mm/shmem.c               | 18 ++++++++++++++----
 mm/userfaultfd.c         |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index f0919c3722e7..dfd0369657d8 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -128,10 +128,11 @@ extern void shmem_uncharge(struct inode *inode, long pages);
 int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr, unsigned long src_addr,
-			   enum mcopy_atomic_mode mode, struct page **pagep);
+			   enum mcopy_atomic_mode mode, struct page **pagep,
+			   bool wp_copy);
 #else /* !CONFIG_SHMEM */
 #define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
-			       src_addr, mode, pagep)        ({ BUG(); 0; })
+			       src_addr, mode, pagep, wp_copy) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 5cfd2fb6e52b..e88aaabaeb27 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2364,7 +2364,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr, unsigned long src_addr,
-			   enum mcopy_atomic_mode mode, struct page **pagep)
+			   enum mcopy_atomic_mode mode, struct page **pagep,
+			   bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2438,9 +2439,18 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	}
 
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
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbb7c8d79a4d..0963e0d9ed20 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -448,7 +448,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-					     src_addr, mode, page);
+					     src_addr, mode, page, wp_copy);
 	}
 
 	return err;
-- 
2.26.2

