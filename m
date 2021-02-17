Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5152D31DD68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhBQQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232759AbhBQQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftGXzlNwaFnDz8kDiuMs+kiPJ3W722AFkGJD2WRAqcY=;
        b=LqP+faHh5nIDV09DNgPGN/liJC2Yh3NN/dWlSsvcrHPvpH8JBSnEu7lfhlRCukMECEVeGL
        kp9J64Fd3U3UpGB9hDuBmwX0mKcBfDea2OjquChwLUlN4rljz50DC/6K1gyJnYuOUP1v7I
        ZxabVL2x30x+hjSo0DoZeLDW2YXHhVo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-EPq7RJ1qPFe2Yrmk9rtEQg-1; Wed, 17 Feb 2021 11:31:10 -0500
X-MC-Unique: EPq7RJ1qPFe2Yrmk9rtEQg-1
Received: by mail-qk1-f199.google.com with SMTP id 124so11089501qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftGXzlNwaFnDz8kDiuMs+kiPJ3W722AFkGJD2WRAqcY=;
        b=lY3vU5a/s5Yfcxi0e3h9y6PMnp+7mbkL7z7dOsG4Za1u9EER6Fc+Ix+rS78Xvhb8Tv
         UgiLtV/1A3zFd4tRq1MBwmV5hVhkoI7921Al6UsflagA0hjl2qkMq/yNi55D7ZActPz5
         297PSW5QVjLHO3F/gRAv+R2QyCtnSQ3TWD8bVOzFx9hHjw7H4cpG0lKlXlFRvJKfPYoq
         3c6x+XdxADsXVlAC6LcMb7AT0+Z4tl2W4eLyg5Xt/+yE6jp7dJq71WksftnxFvjhLdkH
         phT6O0YsAPc7POBScaR2IsQbTHHNjhiSr1rZzVfERF1hb9qjAuNOD434H/N3Q29LnNzL
         9Csw==
X-Gm-Message-State: AOAM530qSBWa8UyWv1JOpACb5U9a6m0pb5TQ+4jEQP0QPGMaNgxWrAzj
        V3JM3vHMroBe0zZUwU5eGlJytJrWmgp2dpDZ7ZN8SixymJTuM/rNtF2y5PYimSxMi8J41QuTyUl
        rT5rq6xcuXYDN4CmLvepu4C3mqJnh0uXhggV41boYBxEC1XfOrhONJ+Uo2Xwe2KUsLuszShFWKQ
        ==
X-Received: by 2002:a05:622a:54e:: with SMTP id m14mr101674qtx.128.1613579470093;
        Wed, 17 Feb 2021 08:31:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztC/d/cZ0fIo7SdGnxYzSnhkW+w3i5etEZbDCMiMqGgbvRAOf3wv7D+bDWPxCKQ3NiCG4Z/w==
X-Received: by 2002:a05:622a:54e:: with SMTP id m14mr101606qtx.128.1613579469720;
        Wed, 17 Feb 2021 08:31:09 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z37sm399902qth.87.2021.02.17.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:31:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 4/4] hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
Date:   Wed, 17 Feb 2021 11:31:02 -0500
Message-Id: <20210217163102.13436-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217163102.13436-1-peterx@redhat.com>
References: <20210217163102.13436-1-peterx@redhat.com>
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
 fs/userfaultfd.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 894cc28142e7..3fbdacc25ff4 100644
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
@@ -1190,6 +1191,59 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	}
 }
 
+/*
+ * This function will unconditionally remove all the shared pmd pgtable entries
+ * within the specific vma for a hugetlbfs memory range.
+ */
+static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HUGETLB_PAGE
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
+#endif
+}
+
 static void __wake_userfault(struct userfaultfd_ctx *ctx,
 			     struct userfaultfd_wake_range *range)
 {
@@ -1448,6 +1502,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-- 
2.26.2

