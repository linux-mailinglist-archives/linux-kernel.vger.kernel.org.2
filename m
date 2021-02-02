Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14D30CD21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhBBUca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhBBUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:31:50 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C21C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 12:31:34 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id y34so14979909pgk.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 12:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jdyGh3Cr13aO6mxXsMzHUjoD5A4fbl/u70z2sgUvPf0=;
        b=Lx7QlDEAghdeRr3SPOTNVhhWEjvAeuC22rYEIbrnDs/W+rluV1hKL9pt0J5PkDt3QJ
         IxpgiDxcD0FCwGsCAGYFzbvc/R4cb/FBOQBeKErKOgcNdE/P9Ex9kSqh/RGOY+rVRgoJ
         GzIxMvLtzderd7hFWeBTijeBBcJzWMtku554B0ZtvyI+LweZZQjlrhK7dX7ysWkUKRj9
         ZkqyOxjt2fXnhq0wnkpsXiQkEdQmCZcSK+ho1Os89jQKok3uyYI8rgtW6iUaypxWa/lW
         GDgIHZ1MY+I2kDlde/wGonjrsCpOosUTwHVzBEKGI317ge0Ec4/qDFQHlm8WuOcti6c0
         ZLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jdyGh3Cr13aO6mxXsMzHUjoD5A4fbl/u70z2sgUvPf0=;
        b=WKoC1Zy5zWgo0bRyD6NNuOr47sctymSqjmAqy0iUvneBTpuJYkw3SagftyODxlJJmw
         bfI8vcvv2TRWEq4VDSMuCseHnRC7ifMGQSnm/f1rEfCRWk3swzYcyWECt8MITZxdU3rC
         wG7FfKmXQwDOAzamec+OwQZXJ68uhEVxbhmwbMM6Wx/3GSfkpy+XMAUEC/6w2aLX4cT9
         0S3zJo6jKPipt8t62hFNd39vu5RBfK7fG0O5wu7XF9KXKI3DuWS3tkFHHrSkf12DRG2r
         SwBkDi49zw5K4elTcrd9PCa2YGbcoa6bd/UkI/FHoOB7EINrZwMh/Q1aouLeHfnM+r9y
         lGug==
X-Gm-Message-State: AOAM531/48tCsQLq7IaLyNCIu1BRm0/hrqGDoqzlkN0MoKokSey3C618
        fmNFyYVHj8ZGBkKgv3XKlRnUuZMncPOTSF4uUM7p
X-Google-Smtp-Source: ABdhPJz/45+MtodomO1H1HLrYkrMbcNcdRpiO0romIzCbIwp4zP8F6N6r+fyux+W7ilB1fwkljmhQcXvPoeihdoTPa3y
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:81fb:f6a4:3e9d:5e8c])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:7408:b029:e1:63d0:75e5 with
 SMTP id g8-20020a1709027408b02900e163d075e5mr10479761pll.20.1612297893814;
 Tue, 02 Feb 2021 12:31:33 -0800 (PST)
Date:   Tue,  2 Feb 2021 12:31:27 -0800
Message-Id: <20210202203127.3596707-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] userfaultfd: hugetlbfs: only compile UFFD helpers if config enabled
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For background, mm/userfaultfd.c provides a general mcopy_atomic
implementation. But some types of memory (e.g., hugetlb and shmem) need
a slightly different implementation, so they provide their own helpers
for this. In other words, userfaultfd is the only caller of this
function.

This patch achieves two things:

1. Don't spend time compiling code which will end up never being
referenced anyway (a small build time optimization).

2. In future patches (e.g. [1]), we plan to extend the signature of
these helpers with UFFD-specific state (e.g., enums or structs defined
conditionally in userfaultfd_k.h). Once this happens, this patch will be
needed to avoid build errors (or, we'd need to define more UFFD-only
stuff unconditionally, which seems messier to me).

Peter Xu suggested this be sent as a standalone patch, in the mailing
list discussion for [1].

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=424091

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 4 ++++
 mm/hugetlb.c            | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..749701b5c153 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -134,11 +134,13 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+#ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				struct page **pagep);
+#endif
 int hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
@@ -308,6 +310,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	BUG();
 }
 
+#ifdef CONFIG_USERFAULTFD
 static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						pte_t *dst_pte,
 						struct vm_area_struct *dst_vma,
@@ -318,6 +321,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	BUG();
 	return 0;
 }
+#endif
 
 static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 					unsigned long sz)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18f6ee317900..821bfa9c0c80 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4615,6 +4615,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4745,6 +4746,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif
 
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
-- 
2.30.0.365.g02bc693789-goog

