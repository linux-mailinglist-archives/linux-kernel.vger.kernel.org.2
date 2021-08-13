Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49BB3EADA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhHLXi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237956AbhHLXiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02C38610A4;
        Thu, 12 Aug 2021 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811478;
        bh=yKgAZpCv9bEnKnaHu5fqX12u7Ay6u1osj+T/lRSld68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGpgx3NY0Whw2BFWOk6BtzWzxx0jTpr4YQiu0JigeB8zNzkn4UxnpPpWXDeeOJt7R
         c/3LJUbGlThxuLdu8JFlWtustZcS9YG49Nqi+kpM7Uz3zyQfxcg21caTlQa9beQTX1
         oUjgy8PZQ3T3pOsyHusjhDr1BZIH5iw0BthWH/Uv1y961iQj0Vn8qNhNq2xMnQ+9Vm
         75p455RzRdsBWBeiFAY/XBpGxnZ1YK/rWJ6gnkd5/LJszkzAqiSZe2djDLSUyXgr+y
         56sdKqbtiBoSYPSjk07qo2bbwdhv9jbh6XXG1KpcMns5IjNoHNerHvNJa4KY2yY31F
         iUU6H2VWWk5KA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 02/19] ARC: mm: remove tlb paranoid code
Date:   Thu, 12 Aug 2021 16:37:36 -0700
Message-Id: <20210812233753.104217-3-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was used back in arc700 days when ASID allocator was fragile.
Not needed in last 5 years

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig           |  3 ---
 arch/arc/include/asm/mmu.h |  6 -----
 arch/arc/mm/tlb.c          | 40 ------------------------------
 arch/arc/mm/tlbex.S        | 50 --------------------------------------
 4 files changed, 99 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 0680b1de0fc3..59d5b2a179f6 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -537,9 +537,6 @@ config ARC_DW2_UNWIND
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame unwind information
 
-config ARC_DBG_TLB_PARANOIA
-	bool "Paranoia Checks in Low Level TLB Handlers"
-
 config ARC_DBG_JUMP_LABEL
 	bool "Paranoid checks in Static Keys (jump labels) code"
 	depends on JUMP_LABEL
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 4065335a7922..38a036508699 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -64,12 +64,6 @@ typedef struct {
 	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
 } mm_context_t;
 
-#ifdef CONFIG_ARC_DBG_TLB_PARANOIA
-void tlb_paranoid_check(unsigned int mm_asid, unsigned long address);
-#else
-#define tlb_paranoid_check(a, b)
-#endif
-
 void arc_mmu_init(void);
 extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
 void read_decode_mmu_bcr(void);
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 349fb7a75d1d..6079dfd129b9 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -400,7 +400,6 @@ void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
 	 *
 	 * Removing the assumption involves
 	 * -Using vma->mm->context{ASID,SASID}, as opposed to MMU reg.
-	 * -Fix the TLB paranoid debug code to not trigger false negatives.
 	 * -More importantly it makes this handler inconsistent with fast-path
 	 *  TLB Refill handler which always deals with "current"
 	 *
@@ -423,8 +422,6 @@ void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
 
 	local_irq_save(flags);
 
-	tlb_paranoid_check(asid_mm(vma->vm_mm, smp_processor_id()), vaddr);
-
 	vaddr &= PAGE_MASK;
 
 	/* update this PTE credentials */
@@ -818,40 +815,3 @@ void do_tlb_overlap_fault(unsigned long cause, unsigned long address,
 
 	local_irq_restore(flags);
 }
-
-/***********************************************************************
- * Diagnostic Routines
- *  -Called from Low Level TLB Handlers if things don;t look good
- **********************************************************************/
-
-#ifdef CONFIG_ARC_DBG_TLB_PARANOIA
-
-/*
- * Low Level ASM TLB handler calls this if it finds that HW and SW ASIDS
- * don't match
- */
-void print_asid_mismatch(int mm_asid, int mmu_asid, int is_fast_path)
-{
-	pr_emerg("ASID Mismatch in %s Path Handler: sw-pid=0x%x hw-pid=0x%x\n",
-	       is_fast_path ? "Fast" : "Slow", mm_asid, mmu_asid);
-
-	__asm__ __volatile__("flag 1");
-}
-
-void tlb_paranoid_check(unsigned int mm_asid, unsigned long addr)
-{
-	unsigned int mmu_asid;
-
-	mmu_asid = read_aux_reg(ARC_REG_PID) & 0xff;
-
-	/*
-	 * At the time of a TLB miss/installation
-	 *   - HW version needs to match SW version
-	 *   - SW needs to have a valid ASID
-	 */
-	if (addr < 0x70000000 &&
-	    ((mm_asid == MM_CTXT_NO_ASID) ||
-	      (mmu_asid != (mm_asid & MM_CTXT_ASID_MASK))))
-		print_asid_mismatch(mm_asid, mmu_asid, 0);
-}
-#endif
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index bcd2909c691f..0b4bb62fa0ab 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -93,11 +93,6 @@ ex_saved_reg1:
 	st_s  r1, [r0, 4]
 	st_s  r2, [r0, 8]
 	st_s  r3, [r0, 12]
-
-	; VERIFY if the ASID in MMU-PID Reg is same as
-	; one in Linux data structures
-
-	tlb_paranoid_check_asm
 .endm
 
 .macro TLBMISS_RESTORE_REGS
@@ -146,51 +141,6 @@ ex_saved_reg1:
 
 #endif
 
-;============================================================================
-;  Troubleshooting Stuff
-;============================================================================
-
-; Linux keeps ASID (Address Space ID) in task->active_mm->context.asid
-; When Creating TLB Entries, instead of doing 3 dependent loads from memory,
-; we use the MMU PID Reg to get current ASID.
-; In bizzare scenrios SW and HW ASID can get out-of-sync which is trouble.
-; So we try to detect this in TLB Mis shandler
-
-.macro tlb_paranoid_check_asm
-
-#ifdef CONFIG_ARC_DBG_TLB_PARANOIA
-
-	GET_CURR_TASK_ON_CPU  r3
-	ld r0, [r3, TASK_ACT_MM]
-	ld r0, [r0, MM_CTXT+MM_CTXT_ASID]
-	breq r0, 0, 55f	; Error if no ASID allocated
-
-	lr r1, [ARC_REG_PID]
-	and r1, r1, 0xFF
-
-	and r2, r0, 0xFF	; MMU PID bits only for comparison
-	breq r1, r2, 5f
-
-55:
-	; Error if H/w and S/w ASID don't match, but NOT if in kernel mode
-	lr  r2, [erstatus]
-	bbit0 r2, STATUS_U_BIT, 5f
-
-	; We sure are in troubled waters, Flag the error, but to do so
-	; need to switch to kernel mode stack to call error routine
-	GET_TSK_STACK_BASE   r3, sp
-
-	; Call printk to shoutout aloud
-	mov r2, 1
-	j print_asid_mismatch
-
-5:	; ASIDs match so proceed normally
-	nop
-
-#endif
-
-.endm
-
 ;============================================================================
 ;TLB Miss handling Code
 ;============================================================================
-- 
2.25.1

