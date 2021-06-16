Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED403A8F51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFPDXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhFPDXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76404613DC;
        Wed, 16 Jun 2021 03:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813679;
        bh=FjSVK+oLKWCgQcLVc/yxw6eKOykcdskBrRZdDTQATJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNxV4V7z+Nf+3L/lZMKFuV3SJ66ggCJ+cspPEUtfvkee+klF0IxtUDpq9DSwO40te
         Y/+8Op9Fj4sCWiK65uZ5EZUH8vS1Ha4lEzTXSwI28v2CGFytvqvS37LLikVoN0cVG8
         6jMich5fC5pKUGbDFMObsHD8RbVXsawbyksBNUDe2evE4KHmZh18FEckNI+KTuQEUp
         PWpa6XDbLpI7L05XpEjB5MM7gd//a/KYKlt2yWknMaftgoVrL2FGbzOCMguQqyJVD5
         vN6uvOJUdkIa7BI3bE944plKIQ3YtdbreMjZpSiKDnYa1JLRGqwKU4HVbz8WVVuMfY
         WVLB2KuFIkidw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6/8] powerpc/membarrier: Remove special barrier on mm switch
Date:   Tue, 15 Jun 2021 20:21:11 -0700
Message-Id: <d9034f951329830b766feb08099c15b714e08e8f.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc did the following on some, but not all, paths through
switch_mm_irqs_off():

       /*
        * Only need the full barrier when switching between processes.
        * Barrier when switching from kernel to userspace is not
        * required here, given that it is implied by mmdrop(). Barrier
        * when switching from userspace to kernel is not needed after
        * store to rq->curr.
        */
       if (likely(!(atomic_read(&next->membarrier_state) &
                    (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
                     MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
               return;

This is puzzling: if !prev, then one might expect that we are switching
from kernel to user, not user to kernel, which is inconsistent with the
comment.  But this is all nonsense, because the one and only caller would
never have prev == NULL and would, in fact, OOPS if prev == NULL.

In any event, this code is unnecessary, since the new generic
membarrier_finish_switch_mm() provides the same barrier without arch help.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/powerpc/include/asm/membarrier.h | 27 ---------------------------
 arch/powerpc/mm/mmu_context.c         |  2 --
 2 files changed, 29 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/membarrier.h

diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
deleted file mode 100644
index 6e20bb5c74ea..000000000000
--- a/arch/powerpc/include/asm/membarrier.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _ASM_POWERPC_MEMBARRIER_H
-#define _ASM_POWERPC_MEMBARRIER_H
-
-static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
-					     struct mm_struct *next,
-					     struct task_struct *tsk)
-{
-	/*
-	 * Only need the full barrier when switching between processes.
-	 * Barrier when switching from kernel to userspace is not
-	 * required here, given that it is implied by mmdrop(). Barrier
-	 * when switching from userspace to kernel is not needed after
-	 * store to rq->curr.
-	 */
-	if (likely(!(atomic_read(&next->membarrier_state) &
-		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
-		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
-		return;
-
-	/*
-	 * The membarrier system call requires a full memory barrier
-	 * after storing to rq->curr, before going back to user-space.
-	 */
-	smp_mb();
-}
-
-#endif /* _ASM_POWERPC_MEMBARRIER_H */
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index a857af401738..8daa95b3162b 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -85,8 +85,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	if (new_on_cpu)
 		radix_kvm_prefetch_workaround(next);
-	else
-		membarrier_arch_switch_mm(prev, next, tsk);
 
 	/*
 	 * The actual HW switching method differs between the various
-- 
2.31.1

