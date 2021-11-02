Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6748F442EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhKBNPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKBNPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:15:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA655C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:13:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y4so5110022pfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fD0tIMAF7tWra31fh+AaRoWEJ08h/Unl1Zw9AjZB3ss=;
        b=CL2Wt79zVe4+wGaWsunf0CO3bjOsO0zcDu2E4DEGJakirt9rLZRiE6A2zWc0k/Plkt
         WKyGbn5swwa/CtPKzvToAkgFgZ/IrebRHgyaBMZ/r5klCcAgns2M49fliMdeCAt1H5Y3
         NHVnRQ1xK8Nf8H/2W1NvXZw5/O3TgWr9vVWwqJ8p8ppHeXiyPV4lFxoTDEQtVF4Fwe1Z
         mLmpE/07WGZz4OSt5I+r8RyY9DFZx4sbe5pPFST52EowSOp2rBKlxqEqA39B9rRB3vAw
         hq4gEw0XZesE9cqEWXyimY8c706um0py+LQ54Y+NghrlYjqqR+86pU2+TbR60yEUUGQb
         CidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fD0tIMAF7tWra31fh+AaRoWEJ08h/Unl1Zw9AjZB3ss=;
        b=6h8G7aPm6wQ9kZ73YVVh1/M9o7rrUTPsHJ1qNjA4crWI94BDXlHBg945bAJVeZuYuT
         42c9SQv9kLblG1xrKaF0qmznG9HJOBPuYQVqzLp8AyCyMbY42nVMaRJ6VpOAxaCaIYyw
         Y/1YCbcxugedTtc43hBJBU3VU+q5Qxhawhbcsze4A5NuX6vek2fu6GO0c8Mfy1v4hhTz
         7OD0gJIoLEm/DskAMyNZlI95oHjAdHL5PyBWrA9CaT+CjFlRwtK7s0sDhFn/rLKJnQ8J
         eBYG6Q5wagvuW4dhqje1JIPo3+uKFR4Sl025nTcLQ+EqAjhc93ss3yO5Fou717pbB+yj
         UQ/Q==
X-Gm-Message-State: AOAM5311lD4WMWmwc/CdII41VzVWMP0FHjLgMPFM9X1eUPpng3pVieeO
        p5I14NnCcNmY3J3rf+Eg88U=
X-Google-Smtp-Source: ABdhPJzNSFF2G4AqL8PnG1WqtUWei4AJml/Dewko2s5DUJzAKG6x8yB9qUw3ljjSpFVL2KaELy69FA==
X-Received: by 2002:a63:7341:: with SMTP id d1mr27157307pgn.294.1635858782172;
        Tue, 02 Nov 2021 06:13:02 -0700 (PDT)
Received: from bj04871pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k13sm20924750pfc.197.2021.11.02.06.12.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:13:01 -0700 (PDT)
From:   Janet Liu <jianhua.ljh@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        orson.zhai@unisoc.com
Subject: [PATCH v2 1/2] arm64: kprobes: implement optprobes
Date:   Tue,  2 Nov 2021 21:11:45 +0800
Message-Id: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janet Liu <janet.liu@unisoc.com>

Limitations:
  -only support 17(4096/240) kprobes
   240 is from optprobe_template_end - optprobe_template_entry
   4096 is from optinsn_slot reserve space size
  -only support steppable insn to be probed

This patch replaced the probed instruction with a 'b' instruction,
 unconditionally branch to a buffer. The buffer contains instructions
to create an pt_regs on stack, and then calls optimized_callback() which
call the pre_handle(). After the executing kprobe handler, run the
replaced instrunction, and branch to PC that probed instruction.

The range of 'b' instruction is +/-128MB, alloc page from buddy is
probable out of this +/-128MB range, so the buffer is allocated from
a reserved area. For simple, only 4K is reserved. Futher patch can make
optimization.

Signed-off-by: Janet Liu <janet.liu@unisoc.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v1 -> v2: fixed lkp robot reported issue
	  modify optinsn_slot reserve space 4096 to PAGE_SIZE
---
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/probes.h               |  23 ++
 arch/arm64/kernel/probes/Makefile             |   1 +
 arch/arm64/kernel/probes/base_regs.h          |  76 ++++++
 arch/arm64/kernel/probes/kprobes_trampoline.S |  55 +---
 arch/arm64/kernel/probes/opt.c                | 247 ++++++++++++++++++
 arch/arm64/kernel/probes/opt_head.S           |  40 +++
 7 files changed, 389 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm64/kernel/probes/base_regs.h
 create mode 100644 arch/arm64/kernel/probes/opt.c
 create mode 100644 arch/arm64/kernel/probes/opt_head.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fee914c716aa..339130712093 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -199,6 +199,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_OPTPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 006946745352..311488195fef 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -25,6 +25,29 @@ typedef u32 kprobe_opcode_t;
 struct arch_specific_insn {
 	struct arch_probe_insn api;
 };
+
+/* optinsn template addresses */
+extern __visible kprobe_opcode_t optinsn_slot;
+extern __visible kprobe_opcode_t optprobe_template_entry;
+extern __visible kprobe_opcode_t optprobe_template_val;
+extern __visible kprobe_opcode_t optprobe_template_call;
+extern __visible kprobe_opcode_t optprobe_template_end;
+extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn;
+extern __visible kprobe_opcode_t optprobe_template_restore_end;
+
+#define MAX_OPTIMIZED_LENGTH    4
+#define MAX_OPTINSN_SIZE                                \
+	((kprobe_opcode_t *)&optprobe_template_end -        \
+	(kprobe_opcode_t *)&optprobe_template_entry)
+
+
+struct arch_optimized_insn {
+	/* copy of the original instructions */
+	kprobe_opcode_t copied_insn[AARCH64_INSN_SIZE];
+	/* detour code buffer */
+	kprobe_opcode_t *insn;
+};
+
 #endif
 
 #endif
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
index 8e4be92e25b1..c77c92ac95fd 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
 				   kprobes_trampoline.o		\
 				   simulate-insn.o
+obj-$(CONFIG_OPTPROBES) 	+= opt.o opt_head.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
 				   simulate-insn.o
diff --git a/arch/arm64/kernel/probes/base_regs.h b/arch/arm64/kernel/probes/base_regs.h
new file mode 100644
index 000000000000..b0fc8bc83d40
--- /dev/null
+++ b/arch/arm64/kernel/probes/base_regs.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+//
+// Copyright (C) 2021, Unisoc Inc.
+// Author: Janet Liu <janet.liu@unisoc.com>
+
+#include <asm/asm-offsets.h>
+
+	.macro  save_all_base_regs
+
+	sub     sp, sp, #(PT_REGS_SIZE + 16)
+
+	stp x0, x1, [sp, #S_X0]
+	stp x2, x3, [sp, #S_X2]
+	stp x4, x5, [sp, #S_X4]
+	stp x6, x7, [sp, #S_X6]
+	stp x8, x9, [sp, #S_X8]
+	stp x10, x11, [sp, #S_X10]
+	stp x12, x13, [sp, #S_X12]
+	stp x14, x15, [sp, #S_X14]
+	stp x16, x17, [sp, #S_X16]
+	stp x18, x19, [sp, #S_X18]
+	stp x20, x21, [sp, #S_X20]
+	stp x22, x23, [sp, #S_X22]
+	stp x24, x25, [sp, #S_X24]
+	stp x26, x27, [sp, #S_X26]
+	stp x28, x29, [sp, #S_X28]
+	add x0, sp, #(PT_REGS_SIZE + 16)
+	stp lr, x0, [sp, #S_LR]
+
+	stp x29, x30, [sp, #PT_REGS_SIZE]
+	add x29, sp, #PT_REGS_SIZE
+	stp x29, x30, [sp, #S_STACKFRAME]
+	add x29, sp, #S_STACKFRAME
+
+	/*
+	 * Construct a useful saved PSTATE
+	 */
+	mrs x0, nzcv
+	mrs x1, daif
+	orr x0, x0, x1
+	mrs x1, CurrentEL
+	orr x0, x0, x1
+	mrs x1, SPSel
+	orr x0, x0, x1
+	stp xzr, x0, [sp, #S_PC]
+	.endm
+
+	.macro  restore_all_base_regs trampoline = 0
+	.if \trampoline == 0
+	ldr x0, [sp, #S_PSTATE]
+	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
+	msr nzcv, x0
+	.endif
+
+	ldp x0, x1, [sp, #S_X0]
+	ldp x2, x3, [sp, #S_X2]
+	ldp x4, x5, [sp, #S_X4]
+	ldp x6, x7, [sp, #S_X6]
+	ldp x8, x9, [sp, #S_X8]
+	ldp x10, x11, [sp, #S_X10]
+	ldp x12, x13, [sp, #S_X12]
+	ldp x14, x15, [sp, #S_X14]
+	ldp x16, x17, [sp, #S_X16]
+	ldp x18, x19, [sp, #S_X18]
+	ldp x20, x21, [sp, #S_X20]
+	ldp x22, x23, [sp, #S_X22]
+	ldp x24, x25, [sp, #S_X24]
+	ldp x26, x27, [sp, #S_X26]
+	ldp x28, x29, [sp, #S_X28]
+
+	.if \trampoline == 1
+	ldr lr, [sp, #S_LR]
+	.endif
+
+	add     sp, sp, #(PT_REGS_SIZE + 16)
+	.endm
diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/kernel/probes/kprobes_trampoline.S
index 288a84e253cc..cdc874f1176a 100644
--- a/arch/arm64/kernel/probes/kprobes_trampoline.S
+++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
@@ -6,63 +6,11 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
+#include "base_regs.h"
 
 	.text
 
-	.macro	save_all_base_regs
-	stp x0, x1, [sp, #S_X0]
-	stp x2, x3, [sp, #S_X2]
-	stp x4, x5, [sp, #S_X4]
-	stp x6, x7, [sp, #S_X6]
-	stp x8, x9, [sp, #S_X8]
-	stp x10, x11, [sp, #S_X10]
-	stp x12, x13, [sp, #S_X12]
-	stp x14, x15, [sp, #S_X14]
-	stp x16, x17, [sp, #S_X16]
-	stp x18, x19, [sp, #S_X18]
-	stp x20, x21, [sp, #S_X20]
-	stp x22, x23, [sp, #S_X22]
-	stp x24, x25, [sp, #S_X24]
-	stp x26, x27, [sp, #S_X26]
-	stp x28, x29, [sp, #S_X28]
-	add x0, sp, #PT_REGS_SIZE
-	stp lr, x0, [sp, #S_LR]
-	/*
-	 * Construct a useful saved PSTATE
-	 */
-	mrs x0, nzcv
-	mrs x1, daif
-	orr x0, x0, x1
-	mrs x1, CurrentEL
-	orr x0, x0, x1
-	mrs x1, SPSel
-	orr x0, x0, x1
-	stp xzr, x0, [sp, #S_PC]
-	.endm
-
-	.macro	restore_all_base_regs
-	ldr x0, [sp, #S_PSTATE]
-	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
-	msr nzcv, x0
-	ldp x0, x1, [sp, #S_X0]
-	ldp x2, x3, [sp, #S_X2]
-	ldp x4, x5, [sp, #S_X4]
-	ldp x6, x7, [sp, #S_X6]
-	ldp x8, x9, [sp, #S_X8]
-	ldp x10, x11, [sp, #S_X10]
-	ldp x12, x13, [sp, #S_X12]
-	ldp x14, x15, [sp, #S_X14]
-	ldp x16, x17, [sp, #S_X16]
-	ldp x18, x19, [sp, #S_X18]
-	ldp x20, x21, [sp, #S_X20]
-	ldp x22, x23, [sp, #S_X22]
-	ldp x24, x25, [sp, #S_X24]
-	ldp x26, x27, [sp, #S_X26]
-	ldp x28, x29, [sp, #S_X28]
-	.endm
-
 SYM_CODE_START(kretprobe_trampoline)
-	sub sp, sp, #PT_REGS_SIZE
 
 	save_all_base_regs
 
@@ -76,7 +24,6 @@ SYM_CODE_START(kretprobe_trampoline)
 
 	restore_all_base_regs
 
-	add sp, sp, #PT_REGS_SIZE
 	ret
 
 SYM_CODE_END(kretprobe_trampoline)
diff --git a/arch/arm64/kernel/probes/opt.c b/arch/arm64/kernel/probes/opt.c
new file mode 100644
index 000000000000..b1f8f0db56f7
--- /dev/null
+++ b/arch/arm64/kernel/probes/opt.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Kernel Probes Jump Optimization (Optprobes)
+//
+// Copyright (C) 2021, Unisoc Inc.
+// Author: Janet Liu <janet.liu@unisoc.com>
+#include <linux/kprobes.h>
+#include <linux/jump_label.h>
+#include <linux/slab.h>
+#include <asm/patching.h>
+#include <asm/ptrace.h>
+#include <asm/kprobes.h>
+#include <asm/cacheflush.h>
+#include <asm/insn.h>
+
+#define TMPL_VAL_IDX \
+	((kprobe_opcode_t *)&optprobe_template_val - (kprobe_opcode_t *)&optprobe_template_entry)
+#define TMPL_CALL_IDX \
+	((kprobe_opcode_t *)&optprobe_template_call - (kprobe_opcode_t *)&optprobe_template_entry)
+#define TMPL_END_IDX \
+	((kprobe_opcode_t *)&optprobe_template_end - (kprobe_opcode_t *)&optprobe_template_entry)
+#define TMPL_RESTORE_ORIGN_INSN \
+	((kprobe_opcode_t *)&optprobe_template_restore_orig_insn \
+	- (kprobe_opcode_t *)&optprobe_template_entry)
+#define TMPL_RESTORE_END \
+	((kprobe_opcode_t *)&optprobe_template_restore_end \
+	- (kprobe_opcode_t *)&optprobe_template_entry)
+
+
+static bool optinsn_page_in_use;
+
+void *alloc_optinsn_page(void)
+{
+	if (optinsn_page_in_use)
+		return NULL;
+	optinsn_page_in_use = true;
+	return &optinsn_slot;
+}
+
+void free_optinsn_page(void *page __maybe_unused)
+{
+	optinsn_page_in_use = false;
+}
+
+int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
+{
+	return optinsn->insn != NULL;
+}
+
+/*
+ * In ARM64 ISA, kprobe opt always replace one instruction (4 bytes
+ * aligned and 4 bytes long). It is impossible to encounter another
+ * kprobe in the address range. So always return 0.
+ */
+int arch_check_optimized_kprobe(struct optimized_kprobe *op)
+{
+	return 0;
+}
+
+/* only optimize steppable insn */
+static int can_optimize(struct kprobe *kp)
+{
+	if (!kp->ainsn.api.insn)
+		return 0;
+	return 1;
+}
+
+/* Free optimized instruction slot */
+static void
+__arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
+{
+	if (op->optinsn.insn) {
+		free_optinsn_slot(op->optinsn.insn, dirty);
+		op->optinsn.insn = NULL;
+	}
+}
+
+extern void kprobe_handler(struct pt_regs *regs);
+
+static void
+optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
+{
+	unsigned long flags;
+	struct kprobe_ctlblk *kcb;
+
+	if (kprobe_disabled(&op->kp))
+		return;
+
+	/* Save skipped registers */
+	regs->pc = (unsigned long)op->kp.addr;
+	regs->orig_x0 = ~0UL;
+	regs->stackframe[1] = (unsigned long)op->kp.addr + 4;
+
+	local_irq_save(flags);
+	kcb = get_kprobe_ctlblk();
+
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(&op->kp);
+	} else {
+		__this_cpu_write(current_kprobe, &op->kp);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		opt_pre_handler(&op->kp, regs);
+		__this_cpu_write(current_kprobe, NULL);
+	}
+
+	local_irq_restore(flags);
+}
+NOKPROBE_SYMBOL(optimized_callback)
+
+int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
+{
+	kprobe_opcode_t *code;
+	void **addrs;
+	long offset;
+	kprobe_opcode_t final_branch;
+	u32 insns[8];
+	int i;
+
+	if (!can_optimize(orig))
+		return -EILSEQ;
+
+	/* Allocate instruction slot */
+	code = get_optinsn_slot();
+	if (!code)
+		return -ENOMEM;
+
+	/* use a 'b' instruction to branch to optinsn.insn.
+	 * according armv8 manual, branch range is +/-128MB,
+	 * is encoded as "imm26" times 4.
+	 *   31  30      26
+	 *  +---+-----------+----------------+
+	 *  | 0 | 0 0 1 0 1 |      imm26     |
+	 *  +---+-----------+----------------+
+	 */
+	offset = (long)code - (long)orig->addr;
+
+	if (offset > 0x7ffffffL || offset < -0x8000000 || offset & 0x3) {
+
+		free_optinsn_slot(code, 0);
+		return -ERANGE;
+	}
+
+	addrs = kmalloc(MAX_OPTINSN_SIZE * sizeof(kprobe_opcode_t *), GFP_KERNEL);
+	for (i = 0; i < MAX_OPTINSN_SIZE; i++)
+		addrs[i] = &code[i];
+
+	/* Copy arch-dep-instance from template. */
+	aarch64_insn_patch_text(addrs,
+				(kprobe_opcode_t *)&optprobe_template_entry,
+				TMPL_RESTORE_ORIGN_INSN);
+
+	/* Set probe information */
+	*(unsigned long *)&insns[TMPL_VAL_IDX-TMPL_RESTORE_ORIGN_INSN] = (unsigned long)op;
+
+
+	/* Set probe function call */
+	*(unsigned long *)&insns[TMPL_CALL_IDX-TMPL_RESTORE_ORIGN_INSN] = (unsigned long)optimized_callback;
+
+	final_branch = aarch64_insn_gen_branch_imm((unsigned long)(&code[TMPL_RESTORE_END]),
+						   (unsigned long)(op->kp.addr) + 4,
+						   AARCH64_INSN_BRANCH_NOLINK);
+
+	/* The original probed instruction */
+	if (orig->ainsn.api.insn)
+		insns[0] = orig->opcode;
+	else
+		insns[0] = 0xd503201f; /*nop*/
+
+	/* Jump back to next instruction */
+	insns[1] = final_branch;
+
+	aarch64_insn_patch_text(addrs + TMPL_RESTORE_ORIGN_INSN,
+				insns,
+				TMPL_END_IDX - TMPL_RESTORE_ORIGN_INSN);
+
+	flush_icache_range((unsigned long)code, (unsigned long)(&code[TMPL_END_IDX]));
+
+	/* Set op->optinsn.insn means prepared. */
+	op->optinsn.insn = code;
+
+	kfree(addrs);
+
+	return 0;
+}
+
+void __kprobes arch_optimize_kprobes(struct list_head *oplist)
+{
+	struct optimized_kprobe *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		unsigned long insn;
+		void *addrs[] = {0};
+		u32 insns[] = {0};
+
+		WARN_ON(kprobe_disabled(&op->kp));
+
+		/*
+		 * Backup instructions which will be replaced
+		 * by jump address
+		 */
+		memcpy(op->optinsn.copied_insn, op->kp.addr,
+				AARCH64_INSN_SIZE);
+
+		insn = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
+						   (unsigned long)op->optinsn.insn,
+						   AARCH64_INSN_BRANCH_NOLINK);
+
+		insns[0] = insn;
+		addrs[0] = op->kp.addr;
+
+		aarch64_insn_patch_text(addrs, insns, 1);
+
+		list_del_init(&op->list);
+	}
+}
+
+void arch_unoptimize_kprobe(struct optimized_kprobe *op)
+{
+	arch_arm_kprobe(&op->kp);
+}
+
+/*
+ * Recover original instructions and breakpoints from relative jumps.
+ * Caller must call with locking kprobe_mutex.
+ */
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			    struct list_head *done_list)
+{
+	struct optimized_kprobe *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		arch_unoptimize_kprobe(op);
+		list_move(&op->list, done_list);
+	}
+}
+
+int arch_within_optimized_kprobe(struct optimized_kprobe *op,
+				unsigned long addr)
+{
+	return ((unsigned long)op->kp.addr <= addr &&
+		(unsigned long)op->kp.addr + AARCH64_INSN_SIZE > addr);
+}
+
+void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
+{
+	__arch_remove_optimized_kprobe(op, 1);
+}
diff --git a/arch/arm64/kernel/probes/opt_head.S b/arch/arm64/kernel/probes/opt_head.S
new file mode 100644
index 000000000000..d5886c2f7ec2
--- /dev/null
+++ b/arch/arm64/kernel/probes/opt_head.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright 2021 Unisoc Inc.
+ */
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+#include "base_regs.h"
+	.align 2
+	.global optinsn_slot
+	optinsn_slot:
+	.space  PAGE_SIZE
+	.global optprobe_template_entry
+	optprobe_template_entry:
+
+	save_all_base_regs
+
+	mov	x1, sp
+	ldr	x0, 1f
+	ldr	x2, 2f
+	blr	x2
+	nop
+
+	restore_all_base_regs 1
+
+	.global optprobe_template_restore_orig_insn
+	optprobe_template_restore_orig_insn:
+	nop
+	.global optprobe_template_restore_end
+	optprobe_template_restore_end:
+	nop
+	.align 3
+	.global optprobe_template_val
+	optprobe_template_val:
+1:	.space 8
+	.global optprobe_template_call
+	optprobe_template_call:
+2:	.space 8
+	.global optprobe_template_end
+	optprobe_template_end:
+

base-commit: 180eca540ae06246d594bdd8d8213426a259cc8c
-- 
2.25.1

