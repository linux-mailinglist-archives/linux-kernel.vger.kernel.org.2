Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DE43960E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhJYMXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhJYMXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:23:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FE0661027;
        Mon, 25 Oct 2021 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635164473;
        bh=/Dm6/oy8rlrhMB6xfSQ6xIxUqIS5IdKJW0ZUMxGErEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGT5nWbkZNMtUpscQnOL+DoDZuOHNg2OuWpbq5B9GvngdoJifDVbARWmHvDOch328
         jM301mqPqCMY8H7LZii7ruxNtb9S0+5hNNOmU5EAVi1qBx4LrS2my3r4tzBV1TeYJ1
         78XsGxylyKrrbKBAEhsF7xa6q7ieBlalnw8/PHF9oxCbUdVZQHUVyNwY4iWPAjtfZW
         ztH0nbuKjCiZTXNoSv9q9llkTEajqoH4iXpqm8IMNe43GcEkqwUoFnmFxmq3P66DHE
         +n4wRvDFalzHCwRrPdGTBS/riv4ZM+CPKdZOF/YOpOBQ/dK0fpMLfyrFw4rYZJuwBk
         KVWHsqVpxxTBQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Frederic Weisbecker <frederic@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/4] arm64: implement support for static call trampolines
Date:   Mon, 25 Oct 2021 14:21:00 +0200
Message-Id: <20211025122102.46089-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025122102.46089-1-frederic@kernel.org>
References: <20211025122102.46089-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Implement arm64 support for the 'unoptimized' static call variety, which
routes all calls through a single trampoline that is patched to perform a
tail call to the selected function.

It is expected that the direct branch instruction will be able to cover
the common case. However, given that static call targets may be located
in modules loaded out of direct branching range, we need a fallback path
that loads the address into R16 and uses a branch-to-register (BR)
instruction to perform an indirect call.

Unlike on x86, there is no pressing need on arm64 to avoid indirect
calls at all cost, but hiding it from the compiler as is done here does
have some benefits:
- the literal is located in .text, which gives us the same robustness
  advantage that code patching does;
- no performance hit on CFI enabled Clang builds that decorate compiler
  emitted indirect calls with branch target validity checks.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/static_call.h | 25 ++++++++++++++
 arch/arm64/kernel/patching.c         | 51 ++++++++++++++++++++++++++--
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 4 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/static_call.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d13677f4731d..34b175b1e247 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,6 +192,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_STATIC_CALL
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select MMU_GATHER_RCU_TABLE_FREE
diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
new file mode 100644
index 000000000000..4871374d584b
--- /dev/null
+++ b/arch/arm64/include/asm/static_call.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insn)			    \
+	asm("	.pushsection	.static_call.text, \"ax\"		\n" \
+	    "	.align		4					\n" \
+	    "	.globl		" STATIC_CALL_TRAMP_STR(name) "		\n" \
+	    "0:	.quad	0x0						\n" \
+	    STATIC_CALL_TRAMP_STR(name) ":				\n" \
+	    "	hint 	34	/* BTI C */				\n" \
+		insn "							\n" \
+	    "	ldr	x16, 0b						\n" \
+	    "	cbz	x16, 1f						\n" \
+	    "	br	x16						\n" \
+	    "1:	ret							\n" \
+	    "	.popsection						\n")
+
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "b " #func)
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret")
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 771f543464e0..f98127d92e1f 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -66,7 +66,7 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 	return ret;
 }
 
-static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
+static int __kprobes __aarch64_insn_write(void *addr, void *insn, int size)
 {
 	void *waddr = addr;
 	unsigned long flags = 0;
@@ -75,7 +75,7 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 	raw_spin_lock_irqsave(&patch_lock, flags);
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
-	ret = copy_to_kernel_nofault(waddr, &insn, AARCH64_INSN_SIZE);
+	ret = copy_to_kernel_nofault(waddr, insn, size);
 
 	patch_unmap(FIX_TEXT_POKE0);
 	raw_spin_unlock_irqrestore(&patch_lock, flags);
@@ -85,7 +85,52 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 
 int __kprobes aarch64_insn_write(void *addr, u32 insn)
 {
-	return __aarch64_insn_write(addr, cpu_to_le32(insn));
+	__le32 i = cpu_to_le32(insn);
+
+	return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
+{
+	/*
+	 * -0x8	<literal>
+	 *  0x0	bti c		<--- trampoline entry point
+	 *  0x4	<branch or nop>
+	 *  0x8	ldr x16, <literal>
+	 *  0xc	cbz x16, 20
+	 * 0x10	br x16
+	 * 0x14	ret
+	 */
+	struct {
+		u64	literal;
+		__le32	insn[2];
+	} insns;
+	u32 insn;
+	int ret;
+
+	insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_BTIC);
+	insns.literal = (u64)func;
+	insns.insn[0] = cpu_to_le32(insn);
+
+	if (!func) {
+		insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
+						   AARCH64_INSN_BRANCH_RETURN);
+	} else {
+		insn = aarch64_insn_gen_branch_imm((u64)tramp + 4, (u64)func,
+						   AARCH64_INSN_BRANCH_NOLINK);
+
+		/*
+		 * Use a NOP if the branch target is out of range, and rely on
+		 * the indirect call instead.
+		 */
+		if (insn == AARCH64_BREAK_FAULT)
+			insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
+	}
+	insns.insn[1] = cpu_to_le32(insn);
+
+	ret = __aarch64_insn_write(tramp - 8, &insns, sizeof(insns));
+	if (!WARN_ON(ret))
+		caches_clean_inval_pou((u64)tramp - 8, sizeof(insns));
 }
 
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f6b1a88245db..ceb35c35192c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -161,6 +161,7 @@ SECTIONS
 			IDMAP_TEXT
 			HIBERNATE_TEXT
 			TRAMP_TEXT
+			STATIC_CALL_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
-- 
2.25.1

