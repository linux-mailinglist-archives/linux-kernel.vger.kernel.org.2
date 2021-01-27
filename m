Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5369F306852
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhA0Xzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhA0Xz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:55:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC12A64DD8;
        Wed, 27 Jan 2021 23:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611791662;
        bh=IyZMRWubT8lewmjSA1zCALq266sCXPZZNFPDHqaC0PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWUS5LgFUC38pCI71/9L1l4fG+UqwNtejoeFafHg6Opxuj5zux3Zgvil3KNvoR+Qu
         FB12Xm/6QISjiHzzIR4nKYnZ68pvnOmA1Sq8/MqXgHBYPXETKcT/W3JuPhxwXu/LVT
         IxJ99r3cqYRABvaq4e6Iw4dkFi9/g12w05brbvmKeJPLZXj+23q5g0YvZcS1NuR2Z1
         GEM1cMlQaPT08Bw5Cxd284FOJvNuTEuFDWiuknSjYygZ7elJde7dDBNsrXV/zi169+
         sODYHg9f8HyO7y8LXdpy53eMPY3mt16Z92yPrIcQM5qPFBVkMwMUxNOItBEUuyj4dA
         zIOyfGDsTEjIA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 6/6] x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables
Date:   Wed, 27 Jan 2021 23:53:47 +0000
Message-Id: <20210127235347.1402-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210127235347.1402-1-will@kernel.org>
References: <20210127235347.1402-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_ldt_pgtables() uses the MMU gather API for batching TLB flushes
over the call to free_pgd_range(). However, tlb_gather_mmu() expects
to operate on user addresses and so passing LDT_{BASE,END}_ADDR will
confuse the range setting logic in __tlb_adjust_range(), causing the
gather to identify a range starting at TASK_SIZE. Such a large range
will be converted into a 'fullmm' flush by the low-level invalidation
code, so change the caller to invoke tlb_gather_mmu_fullmm() directly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/x86/kernel/ldt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 7ad9834e0d95..aa15132228da 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -398,7 +398,13 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	tlb_gather_mmu(&tlb, mm);
+	/*
+	 * Although free_pgd_range() is intended for freeing user
+	 * page-tables, it also works out for kernel mappings on x86.
+	 * We use tlb_gather_mmu_fullmm() to avoid confusing the
+	 * range-tracking logic in __tlb_adjust_range().
+	 */
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	free_pgd_range(&tlb, start, end, start, end);
 	tlb_finish_mmu(&tlb);
 #endif
-- 
2.30.0.365.g02bc693789-goog

