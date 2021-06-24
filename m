Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8C3B2BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhFXJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4FC061766
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aoz8GqgWyLrn/eCm1STfWs7bb1T5oXDPWfrj4n03Lmo=; b=K9eVgzCMWbTDRJErG5WRi7IOU7
        5GuL5MVWu++aqn9Qx8UHV1ihiATfrD3o1k8w78gW8W+fnxL7F1e6grifk3eh+4IJKuchK16J7CsPf
        uWzJKR+JrP9rgV0kIINK7jb+1vWRFaCRlK342Q6OFwgjjTFZQjVLOYuwXRbMSUcfULBT5jB7Si9RE
        lroSXS2S0ChIT6YSXc5ea6a0l6HBCCebPxw2Ax7kCiaVAFspX/jJFEXqccfFnqZVJ839MVAL20TSx
        efu5aLEHBfH/F5nxsoWmLUzJWd0x+kD4HW2rAq8CflOxdnSTdEkOCcO8wheDNkeOOyOCZ11q0OEfG
        vt9EDA6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4K-00GQP8-1p; Thu, 24 Jun 2021 09:54:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADE183005F4;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 44DFD2BC1D0C5; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095149.057262522@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 23/24] x86/xen: Rework the xen_{cpu,irq,mmu}_ops[] arrays
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow objtool to make sense of all the various paravirt
functions, it needs to either parse whole pv_ops[] tables, or observe
individual assignments in the form:

  bf87:       48 c7 05 00 00 00 00 00 00 00 00        movq   $0x0,0x0(%rip)
    bf92 <xen_init_spinlocks+0x5f>
    bf8a: R_X86_64_PC32     pv_ops+0x268

As is, xen_cpu_ops[] is at offset +0 in pv_ops[] and could thus be
parsed as a 'normal' pv_ops[] table, however xen_irq_ops[] and
xen_mmu_ops[] are not.

Worse, both the latter two are compiled into the individual assignment
for by current GCC, but that's not something one can rely on.

Therefore, convert all three into full pv_ops[] tables. This has the
benefit of not needing to teach objtool about the offsets and
resulting in more conservative code-gen.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/xen/enlighten_pv.c |   66 ++++++++++++++++---------------
 arch/x86/xen/irq.c          |   17 ++++----
 arch/x86/xen/mmu_pv.c       |   92 ++++++++++++++++++++++----------------------
 3 files changed, 91 insertions(+), 84 deletions(-)

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1051,52 +1051,54 @@ static const struct pv_info xen_info __i
 	.name = "Xen",
 };
 
-static const struct pv_cpu_ops xen_cpu_ops __initconst = {
-	.cpuid = xen_cpuid,
+static const typeof(pv_ops) xen_cpu_ops __initconst = {
+	.cpu = {
+		.cpuid = xen_cpuid,
 
-	.set_debugreg = xen_set_debugreg,
-	.get_debugreg = xen_get_debugreg,
+		.set_debugreg = xen_set_debugreg,
+		.get_debugreg = xen_get_debugreg,
 
-	.read_cr0 = xen_read_cr0,
-	.write_cr0 = xen_write_cr0,
+		.read_cr0 = xen_read_cr0,
+		.write_cr0 = xen_write_cr0,
 
-	.write_cr4 = xen_write_cr4,
+		.write_cr4 = xen_write_cr4,
 
-	.wbinvd = native_wbinvd,
+		.wbinvd = native_wbinvd,
 
-	.read_msr = xen_read_msr,
-	.write_msr = xen_write_msr,
+		.read_msr = xen_read_msr,
+		.write_msr = xen_write_msr,
 
-	.read_msr_safe = xen_read_msr_safe,
-	.write_msr_safe = xen_write_msr_safe,
+		.read_msr_safe = xen_read_msr_safe,
+		.write_msr_safe = xen_write_msr_safe,
 
-	.read_pmc = xen_read_pmc,
+		.read_pmc = xen_read_pmc,
 
-	.load_tr_desc = paravirt_nop,
-	.set_ldt = xen_set_ldt,
-	.load_gdt = xen_load_gdt,
-	.load_idt = xen_load_idt,
-	.load_tls = xen_load_tls,
-	.load_gs_index = xen_load_gs_index,
+		.load_tr_desc = paravirt_nop,
+		.set_ldt = xen_set_ldt,
+		.load_gdt = xen_load_gdt,
+		.load_idt = xen_load_idt,
+		.load_tls = xen_load_tls,
+		.load_gs_index = xen_load_gs_index,
 
-	.alloc_ldt = xen_alloc_ldt,
-	.free_ldt = xen_free_ldt,
+		.alloc_ldt = xen_alloc_ldt,
+		.free_ldt = xen_free_ldt,
 
-	.store_tr = xen_store_tr,
+		.store_tr = xen_store_tr,
 
-	.write_ldt_entry = xen_write_ldt_entry,
-	.write_gdt_entry = xen_write_gdt_entry,
-	.write_idt_entry = xen_write_idt_entry,
-	.load_sp0 = xen_load_sp0,
+		.write_ldt_entry = xen_write_ldt_entry,
+		.write_gdt_entry = xen_write_gdt_entry,
+		.write_idt_entry = xen_write_idt_entry,
+		.load_sp0 = xen_load_sp0,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
-	.invalidate_io_bitmap = xen_invalidate_io_bitmap,
-	.update_io_bitmap = xen_update_io_bitmap,
+		.invalidate_io_bitmap = xen_invalidate_io_bitmap,
+		.update_io_bitmap = xen_update_io_bitmap,
 #endif
-	.io_delay = xen_io_delay,
+		.io_delay = xen_io_delay,
 
-	.start_context_switch = paravirt_start_context_switch,
-	.end_context_switch = xen_end_context_switch,
+		.start_context_switch = paravirt_start_context_switch,
+		.end_context_switch = xen_end_context_switch,
+	},
 };
 
 static void xen_restart(char *msg)
@@ -1232,7 +1234,7 @@ asmlinkage __visible void __init xen_sta
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	pv_ops.cpu = xen_cpu_ops;
+	pv_ops.cpu = xen_cpu_ops.cpu;
 	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -94,17 +94,20 @@ static void xen_halt(void)
 		xen_safe_halt();
 }
 
-static const struct pv_irq_ops xen_irq_ops __initconst = {
-	.save_fl = PV_CALLEE_SAVE(xen_save_fl),
-	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
-	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
+static const typeof(pv_ops) xen_irq_ops __initconst = {
+	.irq = {
 
-	.safe_halt = xen_safe_halt,
-	.halt = xen_halt,
+		.save_fl = PV_CALLEE_SAVE(xen_save_fl),
+		.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
+		.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
+
+		.safe_halt = xen_safe_halt,
+		.halt = xen_halt,
+	},
 };
 
 void __init xen_init_irq_ops(void)
 {
-	pv_ops.irq = xen_irq_ops;
+	pv_ops.irq = xen_irq_ops.irq;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2076,67 +2076,69 @@ static void xen_leave_lazy_mmu(void)
 	preempt_enable();
 }
 
-static const struct pv_mmu_ops xen_mmu_ops __initconst = {
-	.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
-	.write_cr2 = xen_write_cr2,
+static const typeof(pv_ops) xen_mmu_ops __initconst = {
+	.mmu = {
+		.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
+		.write_cr2 = xen_write_cr2,
 
-	.read_cr3 = xen_read_cr3,
-	.write_cr3 = xen_write_cr3_init,
+		.read_cr3 = xen_read_cr3,
+		.write_cr3 = xen_write_cr3_init,
 
-	.flush_tlb_user = xen_flush_tlb,
-	.flush_tlb_kernel = xen_flush_tlb,
-	.flush_tlb_one_user = xen_flush_tlb_one_user,
-	.flush_tlb_multi = xen_flush_tlb_multi,
-	.tlb_remove_table = tlb_remove_table,
+		.flush_tlb_user = xen_flush_tlb,
+		.flush_tlb_kernel = xen_flush_tlb,
+		.flush_tlb_one_user = xen_flush_tlb_one_user,
+		.flush_tlb_multi = xen_flush_tlb_multi,
+		.tlb_remove_table = tlb_remove_table,
 
-	.pgd_alloc = xen_pgd_alloc,
-	.pgd_free = xen_pgd_free,
+		.pgd_alloc = xen_pgd_alloc,
+		.pgd_free = xen_pgd_free,
 
-	.alloc_pte = xen_alloc_pte_init,
-	.release_pte = xen_release_pte_init,
-	.alloc_pmd = xen_alloc_pmd_init,
-	.release_pmd = xen_release_pmd_init,
+		.alloc_pte = xen_alloc_pte_init,
+		.release_pte = xen_release_pte_init,
+		.alloc_pmd = xen_alloc_pmd_init,
+		.release_pmd = xen_release_pmd_init,
 
-	.set_pte = xen_set_pte_init,
-	.set_pmd = xen_set_pmd_hyper,
+		.set_pte = xen_set_pte_init,
+		.set_pmd = xen_set_pmd_hyper,
 
-	.ptep_modify_prot_start = __ptep_modify_prot_start,
-	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+		.ptep_modify_prot_start = __ptep_modify_prot_start,
+		.ptep_modify_prot_commit = __ptep_modify_prot_commit,
 
-	.pte_val = PV_CALLEE_SAVE(xen_pte_val),
-	.pgd_val = PV_CALLEE_SAVE(xen_pgd_val),
+		.pte_val = PV_CALLEE_SAVE(xen_pte_val),
+		.pgd_val = PV_CALLEE_SAVE(xen_pgd_val),
 
-	.make_pte = PV_CALLEE_SAVE(xen_make_pte_init),
-	.make_pgd = PV_CALLEE_SAVE(xen_make_pgd),
+		.make_pte = PV_CALLEE_SAVE(xen_make_pte_init),
+		.make_pgd = PV_CALLEE_SAVE(xen_make_pgd),
 
-	.set_pud = xen_set_pud_hyper,
+		.set_pud = xen_set_pud_hyper,
 
-	.make_pmd = PV_CALLEE_SAVE(xen_make_pmd),
-	.pmd_val = PV_CALLEE_SAVE(xen_pmd_val),
+		.make_pmd = PV_CALLEE_SAVE(xen_make_pmd),
+		.pmd_val = PV_CALLEE_SAVE(xen_pmd_val),
 
-	.pud_val = PV_CALLEE_SAVE(xen_pud_val),
-	.make_pud = PV_CALLEE_SAVE(xen_make_pud),
-	.set_p4d = xen_set_p4d_hyper,
+		.pud_val = PV_CALLEE_SAVE(xen_pud_val),
+		.make_pud = PV_CALLEE_SAVE(xen_make_pud),
+		.set_p4d = xen_set_p4d_hyper,
 
-	.alloc_pud = xen_alloc_pmd_init,
-	.release_pud = xen_release_pmd_init,
+		.alloc_pud = xen_alloc_pmd_init,
+		.release_pud = xen_release_pmd_init,
 
 #if CONFIG_PGTABLE_LEVELS >= 5
-	.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
-	.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
+		.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
+		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
 #endif
 
-	.activate_mm = xen_activate_mm,
-	.dup_mmap = xen_dup_mmap,
-	.exit_mmap = xen_exit_mmap,
-
-	.lazy_mode = {
-		.enter = paravirt_enter_lazy_mmu,
-		.leave = xen_leave_lazy_mmu,
-		.flush = paravirt_flush_lazy_mmu,
-	},
+		.activate_mm = xen_activate_mm,
+		.dup_mmap = xen_dup_mmap,
+		.exit_mmap = xen_exit_mmap,
+
+		.lazy_mode = {
+			.enter = paravirt_enter_lazy_mmu,
+			.leave = xen_leave_lazy_mmu,
+			.flush = paravirt_flush_lazy_mmu,
+		},
 
-	.set_fixmap = xen_set_fixmap,
+		.set_fixmap = xen_set_fixmap,
+	},
 };
 
 void __init xen_init_mmu_ops(void)
@@ -2144,7 +2146,7 @@ void __init xen_init_mmu_ops(void)
 	x86_init.paging.pagetable_init = xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem = xen_after_bootmem;
 
-	pv_ops.mmu = xen_mmu_ops;
+	pv_ops.mmu = xen_mmu_ops.mmu;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }


