Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7926A355030
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhDFJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:38:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45147 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhDFJi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:38:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FF2Wt2S70z9txTK;
        Tue,  6 Apr 2021 11:38:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HXMr9RCc-Y03; Tue,  6 Apr 2021 11:38:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FF2Wt1Zbnz9txTH;
        Tue,  6 Apr 2021 11:38:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31BF38B79D;
        Tue,  6 Apr 2021 11:38:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id u_xeBMAx6hgR; Tue,  6 Apr 2021 11:38:19 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B77748B796;
        Tue,  6 Apr 2021 11:38:18 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9465E6766B; Tue,  6 Apr 2021 09:38:18 +0000 (UTC)
Message-Id: <28730d147adeaa6c2d0c98d0aa9e17e9e4bd043a.1617701875.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e1723a06c5a26398ff03cb669ec99de2516045a9.1617701875.git.christophe.leroy@csgroup.eu>
References: <e1723a06c5a26398ff03cb669ec99de2516045a9.1617701875.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/2] powerpc: Enable OPTPROBES on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  6 Apr 2021 09:38:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For that, create a 32 bits version of patch_imm64_load_insns()
and create a patch_imm_load_insns() which calls
patch_imm32_load_insns() on PPC32 and patch_imm64_load_insns()
on PPC64.

Adapt optprobes_head.S for PPC32. Use PPC_LL/PPC_STL macros instead
of raw ld/std, opt out things linked to paca and use stmw/lmw to
save/restore registers.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                 |  2 +-
 arch/powerpc/kernel/optprobes.c      | 24 +++++++++++++--
 arch/powerpc/kernel/optprobes_head.S | 46 +++++++++++++++++++---------
 3 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c1344c05226c..49b538e54efb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -227,7 +227,7 @@ config PPC
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC64 && PPC_BOOK3S && SMP
-	select HAVE_OPTPROBES			if PPC64
+	select HAVE_OPTPROBES
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 58fdb9f66e0f..cdf87086fa33 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -141,11 +141,21 @@ void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
 	}
 }
 
+static void patch_imm32_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
+{
+	patch_instruction((struct ppc_inst *)addr,
+			  ppc_inst(PPC_RAW_LIS(reg, IMM_H(val))));
+	addr++;
+
+	patch_instruction((struct ppc_inst *)addr,
+			  ppc_inst(PPC_RAW_ORI(reg, reg, IMM_L(val))));
+}
+
 /*
  * Generate instructions to load provided immediate 64-bit value
  * to register 'reg' and patch these instructions at 'addr'.
  */
-static void patch_imm64_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
+static void patch_imm64_load_insns(unsigned long long val, int reg, kprobe_opcode_t *addr)
 {
 	/* lis reg,(op)@highest */
 	patch_instruction((struct ppc_inst *)addr,
@@ -177,6 +187,14 @@ static void patch_imm64_load_insns(unsigned long val, int reg, kprobe_opcode_t *
 				   ___PPC_RS(reg) | (val & 0xffff)));
 }
 
+static void patch_imm_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
+{
+	if (IS_ENABLED(CONFIG_PPC64))
+		patch_imm64_load_insns(val, reg, addr);
+	else
+		patch_imm32_load_insns(val, reg, addr);
+}
+
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 {
 	struct ppc_inst branch_op_callback, branch_emulate_step, temp;
@@ -230,7 +248,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	 * Fixup the template with instructions to:
 	 * 1. load the address of the actual probepoint
 	 */
-	patch_imm64_load_insns((unsigned long)op, 3, buff + TMPL_OP_IDX);
+	patch_imm_load_insns((unsigned long)op, 3, buff + TMPL_OP_IDX);
 
 	/*
 	 * 2. branch to optimized_callback() and emulate_step()
@@ -264,7 +282,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
 	temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
-	patch_imm64_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
+	patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index ff8ba4d3824d..49f31e554573 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -30,39 +30,47 @@ optinsn_slot:
 	.global optprobe_template_entry
 optprobe_template_entry:
 	/* Create an in-memory pt_regs */
-	stdu	r1,-INT_FRAME_SIZE(r1)
+	PPC_STLU	r1,-INT_FRAME_SIZE(r1)
 	SAVE_GPR(0,r1)
 	/* Save the previous SP into stack */
 	addi	r0,r1,INT_FRAME_SIZE
-	std	r0,GPR1(r1)
+	PPC_STL	r0,GPR1(r1)
+#ifdef CONFIG_PPC64
 	SAVE_10GPRS(2,r1)
 	SAVE_10GPRS(12,r1)
 	SAVE_10GPRS(22,r1)
+#else
+	stmw	r2, GPR2(r1)
+#endif
 	/* Save SPRS */
 	mfmsr	r5
-	std	r5,_MSR(r1)
+	PPC_STL	r5,_MSR(r1)
 	li	r5,0x700
-	std	r5,_TRAP(r1)
+	PPC_STL	r5,_TRAP(r1)
 	li	r5,0
-	std	r5,ORIG_GPR3(r1)
-	std	r5,RESULT(r1)
+	PPC_STL	r5,ORIG_GPR3(r1)
+	PPC_STL	r5,RESULT(r1)
 	mfctr	r5
-	std	r5,_CTR(r1)
+	PPC_STL	r5,_CTR(r1)
 	mflr	r5
-	std	r5,_LINK(r1)
+	PPC_STL	r5,_LINK(r1)
 	mfspr	r5,SPRN_XER
-	std	r5,_XER(r1)
+	PPC_STL	r5,_XER(r1)
 	mfcr	r5
-	std	r5,_CCR(r1)
+	PPC_STL	r5,_CCR(r1)
+#ifdef CONFIG_PPC64
 	lbz     r5,PACAIRQSOFTMASK(r13)
 	std     r5,SOFTE(r1)
+#endif
 
 	/*
 	 * We may get here from a module, so load the kernel TOC in r2.
 	 * The original TOC gets restored when pt_regs is restored
 	 * further below.
 	 */
+#ifdef CONFIG_PPC64
 	ld	r2,PACATOC(r13)
+#endif
 
 	.global optprobe_template_op_address
 optprobe_template_op_address:
@@ -72,9 +80,11 @@ optprobe_template_op_address:
 	 */
 	nop
 	nop
+#ifdef CONFIG_PPC64
 	nop
 	nop
 	nop
+#endif
 	/* 2. pt_regs pointer in r4 */
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 
@@ -94,9 +104,11 @@ optprobe_template_insn:
 	/* 2, Pass instruction to be emulated in r4 */
 	nop
 	nop
+#ifdef CONFIG_PPC64
 	nop
 	nop
 	nop
+#endif
 
 	.global optprobe_template_call_emulate
 optprobe_template_call_emulate:
@@ -107,20 +119,24 @@ optprobe_template_call_emulate:
 	 * All done.
 	 * Now, restore the registers...
 	 */
-	ld	r5,_MSR(r1)
+	PPC_LL	r5,_MSR(r1)
 	mtmsr	r5
-	ld	r5,_CTR(r1)
+	PPC_LL	r5,_CTR(r1)
 	mtctr	r5
-	ld	r5,_LINK(r1)
+	PPC_LL	r5,_LINK(r1)
 	mtlr	r5
-	ld	r5,_XER(r1)
+	PPC_LL	r5,_XER(r1)
 	mtxer	r5
-	ld	r5,_CCR(r1)
+	PPC_LL	r5,_CCR(r1)
 	mtcr	r5
 	REST_GPR(0,r1)
+#ifdef CONFIG_PPC64
 	REST_10GPRS(2,r1)
 	REST_10GPRS(12,r1)
 	REST_10GPRS(22,r1)
+#else
+	lmw	r2, GPR2(r1)
+#endif
 	/* Restore the previous SP */
 	addi	r1,r1,INT_FRAME_SIZE
 
-- 
2.25.0

