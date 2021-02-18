Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF731F1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRV5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:57:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhBRV53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613685362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/LGjoZ6J0eOt0Hag6QsOmNHN0ORlN3M/YMxrfz7rNU=;
        b=bdIw9pXWt5Aiyq9ELgKnt1B6c2ADbWLpT1u/QyScSgYZ4k79FxAXbUCkX+FtvHSishNwRE
        L3Bzlf/pcv6CI9weuzNxaW2uIfu8tPnE66O9yXkZwyrJg6s0CR3CFbx9LEDSGWJ6bqPW91
        enENiZMDxawoC3FNmH114QoeH0ZbIUc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-oGH7lzCIPxCznv_9kI-lAg-1; Thu, 18 Feb 2021 16:55:58 -0500
X-MC-Unique: oGH7lzCIPxCznv_9kI-lAg-1
Received: by mail-qt1-f197.google.com with SMTP id l63so2063759qtd.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/LGjoZ6J0eOt0Hag6QsOmNHN0ORlN3M/YMxrfz7rNU=;
        b=LjDr6+uAazdANtaBt0B7fBnRP99dsMbWQOZlL+bZkjkr1LPsn3WvyrtjssBy+p6Ugt
         Al6rvQJ8rc08cpvmx4VWPDLp+c1l/MZMU8E4K+ym9jXFdTy6sRUa5foM24mxrc0kIUGZ
         pfJe8Gy+x1ZRXQSGXEgQsQ0bEEVgpSFlxUJ8TjfuqQiI4VfyolXwYxijwxj7LJbh+V4m
         hr3mUuBkJFgtBEjV/Ex8GiupbO9OoKmAUS7XU5XDM4Veru4EBo4YAs3m87SoV+rSuBCo
         x4/flakCaH9WJX18E/pBNTkOEEOOD7kjeq9Ulkzikh5srHQnIjTVoDvaQpgGelLILrqj
         8qBA==
X-Gm-Message-State: AOAM531P0xIED5NG7mtBsToNWEH/14a/7E+zchDmjuQL76j+h+Ks53oc
        7NXPTQ6ywVs/S2XeDLFgLL/iB43K1eOLrBlVSDX1wsj5kD0DNs9YIIhCuTUoLyyHRcUAUqZ0vtW
        ms6yghg6VPcSd5GxSimdRzQkY0cAKB+SrBVsHnyvd3NVBmXdfJhMTIVQwTK6wvgQZbA2nQdMgIg
        ==
X-Received: by 2002:a37:a7c9:: with SMTP id q192mr6324218qke.299.1613685357564;
        Thu, 18 Feb 2021 13:55:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMD5UVVS1w5xPjiB2AW4UW0+MMcsCBMmGZDBmYRgcCKOQNuldvrR1qOQccnAuyoRN9xCcXbg==
X-Received: by 2002:a37:a7c9:: with SMTP id q192mr6324189qke.299.1613685357281;
        Thu, 18 Feb 2021 13:55:57 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id m5sm4956015qkf.55.2021.02.18.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 13:55:56 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 4/4] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
Date:   Thu, 18 Feb 2021 16:55:55 -0500
Message-Id: <20210218215555.10710-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210218215434.10203-1-peterx@redhat.com>
References: <20210218215434.10203-1-peterx@redhat.com>
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

