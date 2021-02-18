Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60931F2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBRXNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:13:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhBRXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613689931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JoTh9i7nRqiPgisTFKHvYqnz+XigsyDbcSAEKf2YS0=;
        b=aR1vSIpO1HpBTgFbxT5uthEyuRpy3S7MTlH/XXw+NEgKmvopsy18Uw8xd97XisKQD51y6V
        WypeXvTU/1o0se7pr7Em5CjKLnPWTpro/CN6ZpCdPF/MkxzjCf/cClbI6gOc2SXxyHbpi7
        J3BXjGrFAggBqvdSRS8AZcVHveQx98c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-w3SI-0wGPGW0lPDlnysaXg-1; Thu, 18 Feb 2021 18:12:09 -0500
X-MC-Unique: w3SI-0wGPGW0lPDlnysaXg-1
Received: by mail-qt1-f197.google.com with SMTP id k28so2148277qtu.17
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4JoTh9i7nRqiPgisTFKHvYqnz+XigsyDbcSAEKf2YS0=;
        b=fFqbsCMBDs/3jsBpyNxmwwPO3b0EiETCd3m1nylW0UR1u0ByCfOJXdpcVl2fwm0kU5
         eaU5KMBhUFEqdh431AvhAGzu/81GGjb4gUQng43o1ypnQYRgClnIm6vl5OJTmj9DGEbc
         YZY4uyvTEuqAtrZ0cW3T3Ie9IQxGdFf4Fek329oLn0Mp6Y4hJDaXYLy5fQhLIsvvfssE
         H/wXLlWOe9DwfZrKFNF4EoU83yjd0yMQjLCQfbEEMOUGycFNoJobN9yYUWYrIpXPKxir
         Ce8eKvILBmFvpRNW+OqvEmfwbgLMRvI8S51EFapY90K4D/5BOqHKntOdwLICBCbYQHkx
         Tx/Q==
X-Gm-Message-State: AOAM532nQSkBXkCPM5xiFSOKezgYp5me8VnIJtEYHtGZwz12EWtwTVyb
        f3kxu1T6zl950XRFxfqw0NRVyARXQlHpmOu6f9aHeJbxgZxALSb3kEwo3Cc8RkwCh5AyHJTUkcf
        TJc5GqXt4elAlBVBNTQltxN3DDntOmqnWi/CHqEhzlSGqqiwq8pBbUnb+tEsujcZYakfAxm/oAw
        ==
X-Received: by 2002:a37:6f01:: with SMTP id k1mr6789286qkc.252.1613689929036;
        Thu, 18 Feb 2021 15:12:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwH7uSnFwdtsTX7ZkSOcixigLZ7WrmzlE0H3TVrR6Bzrcir+R3XPF4G+Uufy0zQJHFnDKl59g==
X-Received: by 2002:a37:6f01:: with SMTP id k1mr6789252qkc.252.1613689928723;
        Thu, 18 Feb 2021 15:12:08 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id b7sm5057179qkj.115.2021.02.18.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 15:12:08 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 4/4] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
Date:   Thu, 18 Feb 2021 18:12:06 -0500
Message-Id: <20210218231206.15524-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210218230633.15028-1-peterx@redhat.com>
References: <20210218230633.15028-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
userfaultfd-wp is always based on pgtable entries, so they cannot be shared.

Walk the hugetlb range and unshare all such mappings if there is, right before
UFFDIO_REGISTER will succeed and return to userspace.

This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
is completely disabled for userfaultfd-wp registered range.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c        |  4 ++++
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 894cc28142e7..e259318fcae1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/mm.h>
+#include <linux/mmu_notifier.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3b4104021dd3..6437483ad01b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -188,6 +188,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -369,6 +370,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 	return 0;
 }
 
+static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f53a0b852ed8..fc62932c31cb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5653,6 +5653,57 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	}
 }
 
+/*
+ * This function will unconditionally remove all the shared pmd pgtable entries
+ * within the specific vma for a hugetlbfs memory range.
+ */
+void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long address, start, end;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	start = ALIGN(vma->vm_start, PUD_SIZE);
+	end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
+
+	if (start >= end)
+		return;
+
+	/*
+	 * No need to call adjust_range_if_pmd_sharing_possible(), because
+	 * we have already done the PUD_SIZE alignment.
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	for (address = start; address < end; address += PUD_SIZE) {
+		unsigned long tmp = address;
+
+		ptep = huge_pte_offset(mm, address, sz);
+		if (!ptep)
+			continue;
+		ptl = huge_pte_lock(h, mm, ptep);
+		/* We don't want 'address' to be changed */
+		huge_pmd_unshare(mm, vma, &tmp, ptep);
+		spin_unlock(ptl);
+	}
+	flush_hugetlb_tlb_range(vma, start, end);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/vm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+}
+
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
-- 
2.26.2

