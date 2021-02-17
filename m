Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62731E0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhBQUsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234469AbhBQUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613594787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gY06+Wkmcfht3KanCaWtohAIi6SQMiBnqeZFMOnly8=;
        b=IPGF5zbAJrPvdh3l3kIuzupbuKA4K9ohI/IQ0KMbLrg7dIv7dhY3gCyhN/HdhIqS6BFEjF
        OKGVzieGQAeHerfnaMeN7v6Nj1tcjJbCXibnK/iqDj+BSliFzKVgTH0ltdOydS70D5nFOR
        g4/DG/6dybTOKKrU65QyKMs3/HiCgG4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Tm9bTvuyMIeVnU3XVuy6kQ-1; Wed, 17 Feb 2021 15:46:25 -0500
X-MC-Unique: Tm9bTvuyMIeVnU3XVuy6kQ-1
Received: by mail-qv1-f70.google.com with SMTP id d26so10776098qve.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gY06+Wkmcfht3KanCaWtohAIi6SQMiBnqeZFMOnly8=;
        b=NvkBacHli9rw7dwUMs7yKXxPj2Lg9o4avqiVYh38OyDZ2QBBWuk0GouR1v1TiBsFjs
         rYmaBQ6L0EteM4eizOzHXMlvrzemvZgKpi0xeCim0z9Nm+xZtriu5d9VdwAC+w02sY8D
         wvstD7tPhHODuWYKxiiTrEkYQGd3p8DeiwL/aGSz6d6kJFP6zYP/ywD69MhgTM+YdBy2
         vgaDboKQyq8ci8Ep9pTCzcVGHcIlZf0XMuscLR9fEIMLyVusES4ltLwys0W45IUxg+a4
         96ZFhADZ84bUvLwKIqj9RN7Sb9DjM44UwpnjbQNvrKF7boUaz+6fgM5xI0gPwvMUtf3T
         TH6w==
X-Gm-Message-State: AOAM5324lq/28BzetZF3DAPTyNwFlvzMbV2xhRx8qBMBw440N76dxvSV
        SEzRt8ldOtZCUlL6if+9nj9eagDpJhv9N+uq6FJ4gRVolajkMyPTEFGjP1ni8kFK3U5Z07x9IYo
        G8kwj7snPz1/v8k3oYiSdBBn7
X-Received: by 2002:aed:3366:: with SMTP id u93mr1036099qtd.255.1613594784968;
        Wed, 17 Feb 2021 12:46:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMbRLQXtnhXCNIMHW/s0UkO3hOcL2E4K5NIeBOPs0XHxCUYd5LV5uO57+v1rN/IHYI76Nexg==
X-Received: by 2002:aed:3366:: with SMTP id u93mr1036087qtd.255.1613594784778;
        Wed, 17 Feb 2021 12:46:24 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p25sm2354901qkh.79.2021.02.17.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:46:24 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/4] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
Date:   Wed, 17 Feb 2021 15:46:19 -0500
Message-Id: <20210217204619.54761-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217204619.54761-1-peterx@redhat.com>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
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
 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index 3b4104021dd3..97ecfd4c20b2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -188,6 +188,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f53a0b852ed8..83c006ea3ff9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5723,4 +5723,55 @@ void __init hugetlb_cma_check(void)
 	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
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
+	 * we're going to operate on the whole vma
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				vma->vm_start, vma->vm_end);
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
+	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/vm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+}
+
 #endif /* CONFIG_CMA */
-- 
2.26.2

