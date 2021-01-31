Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE130995D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhAaATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhAaAQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:58 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70DC061794
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id j12so9055377pfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8uSPE/HXC6aHbVUxVpHG/d195EuTH7J5Gm24sXeUII=;
        b=PwdIMepAzUWPJ56ktZqfTNN8uHV1c1HOobe4OORa4XxJPl9z4jD2tKvqxvoz0NN8Q7
         vyLxvXY0eIDxnVZd66ZzKxalFo2pJE4Nj5hazn3Y1/ageaD2NuE9vFR0+KUNpYXZDmeq
         HUolGqpL0IJ8uww1/JcIOqWNR0896AbtuxsneTHFJm4E5OQ4HsdJ3pCEoxppW+6sQng9
         gfJsDusUVhQ/bLlx6/0ttYoqj6WhBqI+LVBu1dBxrdfJZWgd/SbsJ6xlHnyqblqTMkjl
         bDFUXr8WllrSt+rdAR4J+fExRJPMaSbNwUeleG1XK+k6LHuMJzUxR10VFVXkN/Rp39YY
         ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8uSPE/HXC6aHbVUxVpHG/d195EuTH7J5Gm24sXeUII=;
        b=gYjZF+MSbVnBXjOHvHJT4Es10AD04g4d3/PTo5p/xlZvYOBDqTaYXdf2M7RHn2Ogij
         1z3FcDW4ZKKsc3S1SmZ+6FY2oTJnQMncSW6NWNIgdEING6/vwgX3ZrYR6YmrjHW/2fNp
         hFovSEpxIuRb/Y1j0PfzhR2fqkdW3zjV8YEMNtj2wGUdvAIcpUiDgxdNSwWx+fGmDLtv
         fjDCn5QdJ0dUoVQKI7PD2XgYo4Y7GDMaQn5NyVJb8ugLo0TtbAaF79x0NBdSBJY+pswL
         xL8JqoUQfN7/dMjdqNiknL3yqgs+2WfPaw59piv6YMRNSk+NW6nwoGHVGpLeqqgSLyNT
         hBYA==
X-Gm-Message-State: AOAM530DYv37XfFe3qY65n2UXOK8aYqxB3eAWWFcoPc1cZzylKiKY4G1
        L593cjnLf8JJO8KNaGUcJMQ=
X-Google-Smtp-Source: ABdhPJxKdj8NOHZ5TdgXQQbvYo0DHw/nVRQlVpun7jqBLlHK6Vdma/V1nIaCJETf5QG8NYedmgWadQ==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr10935466pgk.186.1612052180090;
        Sat, 30 Jan 2021 16:16:20 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:19 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC 12/20] mm/tlb: save the VMA that is flushed during tlb_start_vma()
Date:   Sat, 30 Jan 2021 16:11:24 -0800
Message-Id: <20210131001132.3368247-13-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Certain architectures need information about the vma that is about to be
flushed. Currently, an artificial vma is constructed using the original
vma infromation. Instead of saving the flags, record the vma during
tlb_start_vma() and use this vma when calling flush_tlb_range().

Record the vma unconditionally as it would be needed for per-VMA
deferred TLB flush tracking and the overhead of tracking it
unconditionally should be negligible.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 include/asm-generic/tlb.h | 56 +++++++++++++--------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b97136b7010b..041be2ef4426 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -252,6 +252,13 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 struct mmu_gather {
 	struct mm_struct	*mm;
 
+	/*
+	 * The current vma. This information is changing upon tlb_start_vma()
+	 * and is therefore only valid between tlb_start_vma() and tlb_end_vma()
+	 * calls.
+	 */
+	struct vm_area_struct   *vma;
+
 #ifdef CONFIG_MMU_GATHER_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
@@ -283,12 +290,6 @@ struct mmu_gather {
 	unsigned int		cleared_puds : 1;
 	unsigned int		cleared_p4ds : 1;
 
-	/*
-	 * tracks VM_EXEC | VM_HUGETLB in tlb_start_vma
-	 */
-	unsigned int		vma_exec : 1;
-	unsigned int		vma_huge : 1;
-
 	unsigned int		batch_count;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
@@ -352,10 +353,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		flush_tlb_mm(tlb->mm);
 }
 
-static inline void
-tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
-
-#define tlb_end_vma tlb_end_vma
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 
 #else /* CONFIG_MMU_GATHER_NO_RANGE */
@@ -364,7 +361,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 
 /*
  * When an architecture does not provide its own tlb_flush() implementation
- * but does have a reasonably efficient flush_vma_range() implementation
+ * but does have a reasonably efficient flush_tlb_range() implementation
  * use that.
  */
 static inline void tlb_flush(struct mmu_gather *tlb)
@@ -372,38 +369,20 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	if (tlb->fullmm || tlb->need_flush_all) {
 		flush_tlb_mm(tlb->mm);
 	} else if (tlb->end) {
-		struct vm_area_struct vma = {
-			.vm_mm = tlb->mm,
-			.vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
-				    (tlb->vma_huge ? VM_HUGETLB : 0),
-		};
-
-		flush_tlb_range(&vma, tlb->start, tlb->end);
+		VM_BUG_ON(!tlb->vma);
+		flush_tlb_range(tlb->vma, tlb->start, tlb->end);
 	}
 }
 
 static inline void
-tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
+tlb_update_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	/*
-	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
-	 * mips-4k) flush only large pages.
-	 *
-	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
-	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
-	 * range.
-	 *
-	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
-	 * these values the batch is empty.
-	 */
-	tlb->vma_huge = is_vm_hugetlb_page(vma);
-	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
+	tlb->vma = vma;
 }
-
 #else
 
 static inline void
-tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+tlb_update_vma(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 
 #endif
 
@@ -487,17 +466,17 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
 	if (tlb->fullmm)
 		return;
 
-	tlb_update_vma_flags(tlb, vma);
+	tlb_update_vma(tlb, vma);
 	flush_cache_range(vma, vma->vm_start, vma->vm_end);
 }
 
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm)
-		return;
+		goto out;
 
 	if (IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING))
-		return;
+		goto out;
 
 	/*
 	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
@@ -506,6 +485,9 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	 * this.
 	 */
 	tlb_flush_mmu_tlbonly(tlb);
+out:
+	/* Reset the VMA as a precaution. */
+	tlb_update_vma(tlb, NULL);
 }
 
 #ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
-- 
2.25.1

