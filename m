Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4744FFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhKOIHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236817AbhKOIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2a8iiYw9cHHedU0g0ICbwjIFnh904x/uUid5qyax/0o=;
        b=AHk0Tm4xF4ne0omtOz0Iab+4UbU7D7+ieFqKOwAmt1149m+fzmjj3R6MOtCvDn25L3LdqL
        IhNXRF1hXH1oo6IgvBAiXs4TPIvievcev3o3CL9SLaJGjI3bSRAl3lZCN7wALESEEchlal
        9ciGEv5VguBK2p/n5Ne6jeuBvlmbxYQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324--a7bkPVVNaKDM5iGF3gNDQ-1; Mon, 15 Nov 2021 03:01:18 -0500
X-MC-Unique: -a7bkPVVNaKDM5iGF3gNDQ-1
Received: by mail-pj1-f72.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so8617225pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a8iiYw9cHHedU0g0ICbwjIFnh904x/uUid5qyax/0o=;
        b=fShXBlSyF6zCwYZFi3NF0mz5limBMtC+bSHGqbpvVohGdXeMFkBiGl4wUWnCeUzB9u
         x8ETf4HZs/B9p8xguujfnl205oVUC9fvFikJWd/eYihZ7WQ/X3n0+k1CMi/iSFSiWvOJ
         lf6gDWwh/qN8ERjwI/+yVSM+YrnjY7AZjpBtWiPJXRyI0+UrKj/IjZPOGwu4cXuHVAiK
         eKysIb+MPVwYPAFd44LfVlt2nN2Y1eFcEeeYWwwTsQnwmGT2pOkHZsYGKQpNwBNU5NlU
         5pzCJY/xidtkpcXUCg0pDq14+a3W/INWuRzME8oTW3DrnlaP+Bc6u3xCjiotJt7xIgdX
         RvnQ==
X-Gm-Message-State: AOAM53103Ftbx9h/m+xMKbUPmFF6q5CVUp/k0WQ6yi4T3EYU9EZC+bNl
        TT9v+8GcYNblVfdUg8b6PtqQqERNEsXpu/S8RP6abpfvzxv6xUG6YzhShull86IUzIx/BOpkDHg
        7fbb7fbranR669ehHIGCTaKjC
X-Received: by 2002:a17:90a:e7c4:: with SMTP id kb4mr62908411pjb.237.1636963277375;
        Mon, 15 Nov 2021 00:01:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMaGzKjVGqxW+/p2kNrUGh0+wmkSEQkrNVusG8+B8od3HYJT9hN/7CV3ovfOezj2dLkfDFdA==
X-Received: by 2002:a17:90a:e7c4:: with SMTP id kb4mr62908368pjb.237.1636963277100;
        Mon, 15 Nov 2021 00:01:17 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id ng9sm19694926pjb.4.2021.11.15.00.01.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:01:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 10/23] mm/shmem: Handle uffd-wp during fork()
Date:   Mon, 15 Nov 2021 16:01:03 +0800
Message-Id: <20211115080103.74640-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally we skip copy page when fork() for VM_SHARED shmem, but we can't skip
it anymore if uffd-wp is enabled on dst vma.  This should only happen when the
src uffd has UFFD_FEATURE_EVENT_FORK enabled on uffd-wp shmem vma, so that
VM_UFFD_WP will be propagated onto dst vma too, then we should copy the
pgtables with uffd-wp bit and pte markers, because these information will be
lost otherwise.

Since the condition checks will become even more complicated for deciding
"whether a vma needs to copy the pgtable during fork()", introduce a helper
vma_needs_copy() for it, so everything will be clearer.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fef6a91c5dfb..cc625c616645 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -859,6 +859,14 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (try_restore_exclusive_pte(src_pte, src_vma, addr))
 			return -EBUSY;
 		return -ENOENT;
+	} else if (is_pte_marker_entry(entry)) {
+		/*
+		 * We're copying the pgtable should only because dst_vma has
+		 * uffd-wp enabled, do sanity check.
+		 */
+		WARN_ON_ONCE(!userfaultfd_wp(dst_vma));
+		set_pte_at(dst_mm, addr, dst_pte, pte);
+		return 0;
 	}
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_swp_clear_uffd_wp(pte);
@@ -1227,6 +1235,38 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	return 0;
 }
 
+/*
+ * Return true if the vma needs to copy the pgtable during this fork().  Return
+ * false when we can speed up fork() by allowing lazy page faults later until
+ * when the child accesses the memory range.
+ */
+bool
+vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
+{
+	/*
+	 * Always copy pgtables when dst_vma has uffd-wp enabled even if it's
+	 * file-backed (e.g. shmem). Because when uffd-wp is enabled, pgtable
+	 * contains uffd-wp protection information, that's something we can't
+	 * retrieve from page cache, and skip copying will lose those info.
+	 */
+	if (userfaultfd_wp(dst_vma))
+		return true;
+
+	if (src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP))
+		return true;
+
+	if (src_vma->anon_vma)
+		return true;
+
+	/*
+	 * Don't copy ptes where a page fault will fill them correctly.  Fork
+	 * becomes much lighter when there are big shared or private readonly
+	 * mappings. The tradeoff is that copy_page_range is more efficient
+	 * than faulting.
+	 */
+	return false;
+}
+
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
@@ -1240,14 +1280,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	bool is_cow;
 	int ret;
 
-	/*
-	 * Don't copy ptes where a page fault will fill them correctly.
-	 * Fork becomes much lighter when there are big shared or private
-	 * readonly mappings. The tradeoff is that copy_page_range is more
-	 * efficient than faulting.
-	 */
-	if (!(src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
-	    !src_vma->anon_vma)
+	if (!vma_needs_copy(dst_vma, src_vma))
 		return 0;
 
 	if (is_vm_hugetlb_page(src_vma))
-- 
2.32.0

