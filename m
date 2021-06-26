Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2482A3B4EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFZNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:13:42 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:41295 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhFZNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:13:22 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jun 2021 09:13:21 EDT
Received: from iva5-13ec62da2ad0.qloud-c.yandex.net (iva5-13ec62da2ad0.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:9304:0:640:13ec:62da])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 0C9F154C25FD;
        Sat, 26 Jun 2021 16:04:20 +0300 (MSK)
Received: from iva4-b3ebd202b141.qloud-c.yandex.net (iva4-b3ebd202b141.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:b3eb:d202])
        by iva5-13ec62da2ad0.qloud-c.yandex.net (mxback/Yandex) with ESMTP id GoXmMUUp7c-4JH8EDmO;
        Sat, 26 Jun 2021 16:04:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1624712660;
        bh=LM79m81DpAtl1zB1mc0ucWWKK88Tloubj1x39POUguE=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=cVv4ObwtQxs1yw9fMZrk9sKRJ5x5PGfd+FPaUMmkusNq06ZylC46nhgp/irXDlE2F
         PpUjr+Yq25HD+2d7HUzBJFO5opVU1vYiNQxwZX4nnTCoOJEv8BxRtVb3u4gh0lbsRp
         o1KnzXT2YJ/KCXsNSONgCXJyvlPqpdmrMy/cFz+s=
Authentication-Results: iva5-13ec62da2ad0.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by iva4-b3ebd202b141.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id CqoEVweReG-4H3m6Nun;
        Sat, 26 Jun 2021 16:04:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Marcos Del Sol Vives <marcos@orca.pet>
To:     x86@kernel.org
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86: add NOPL and CMOV emulation
Date:   Sat, 26 Jun 2021 15:03:14 +0200
Message-Id: <20210626130313.1283485-1-marcos@orca.pet>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOPL and CMOV are a set of instructions that were introduced to the
x86 architecture with the i686 ISA in 1995, first implemented in the
Intel Pentium Pro and Pentium II processors.

While virtually all desktop and server systems are modern enough to
support these instructions, in the embedded market things are a little
bit different: DM&P is still manufacturing their i586-only Vortex86
SoCs, and many embedded devices still in use are stuck on legacy SoCs
that either are i586-only (AMD Elan, AMD Geode GX1) or implement i686
but lack the NOPL instructions (Transmeta devices, AMD Geode LX).

This is a problem because most modern Linux distributions, such as
Debian and all its derivatives, have started compiling targeting i686,
leaving old embedded devices using binary distributions without an
easy upgrade path.

This ultimately results in most of these embedded devices running
years old, insecure and obsolete installations, and this itself can be
seen on the DM&P's own supported OS page where the newest supported
desktop Linux distro is Ubuntu 18.04, already three years old.

The emulation of these instructions thus allow upgrading to newer
distributions just by replacing the kernel, keeping all precompiled
binaries intact.

The way this emulation is implemented is fairly simple: it uses the
illegal instruction handler to trap these unsupported instructions,
and evaluates them in software.

Thus a kernel compiled with this feature can be still used on a
machine that fully supports the i686 ISA with no performance penalty
at all.

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 arch/x86/Kconfig              |  20 ++++
 arch/x86/include/asm/soft86.h |  24 +++++
 arch/x86/kernel/Makefile      |   1 +
 arch/x86/kernel/soft86.c      | 193 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c       |   5 +
 5 files changed, 243 insertions(+)
 create mode 100644 arch/x86/include/asm/soft86.h
 create mode 100644 arch/x86/kernel/soft86.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..631884bbf8a3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1749,6 +1749,26 @@ config MATH_EMULATION
 	  If you are not sure, say Y; apart from resulting in a 66 KB bigger
 	  kernel, it won't hurt.
 
+config X86_INSN_EMU
+	bool "Instruction emulation"
+	help
+	  Linux can be compiled to emulate some instructions transparently to
+	  an application, allowing older processors to run modern software
+	  without recompilation, albeit with a significant performance hit.
+
+	  Currently supported instructions are:
+	   - CMOVxx (conditional moves).
+	   - NOPL (long NOPs).
+
+	  Emulating these two instructions allow i686 binaries to run
+	  unmodified on devices that only support i586 (Intel Pentium 1,
+	  AMD Geode GX1, Cyrix III, Vortex86SX/MX/DX, WinChips), or are i686
+	  but miss some of the instructions (Transmeta Crusoe/Efficeon,
+	  AMD Geode LX)
+
+	  This emulation is only used if the processor is unable execute said
+	  instructions, and will not be used if supported natively.
+
 config MTRR
 	def_bool y
 	prompt "MTRR (Memory Type Range Register) support" if EXPERT
diff --git a/arch/x86/include/asm/soft86.h b/arch/x86/include/asm/soft86.h
new file mode 100644
index 000000000000..67b9e084a0a1
--- /dev/null
+++ b/arch/x86/include/asm/soft86.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_X86_SOFT86_H
+#define _ASM_X86_SOFT86_H
+
+/*
+ * Software execution of x86 opcodes
+ *
+ * Copyright (C) 2021, Marcos Del Sol Vives <marcos@orca.pet>
+ */
+
+#include <linux/types.h>
+#include <asm/ptrace.h>
+
+#ifdef CONFIG_X86_INSN_EMU
+bool soft86_execute(struct pt_regs *regs);
+#else
+static inline bool soft86_execute(struct pt_regs *regs)
+{
+	return false;
+}
+#endif
+
+#endif /* _ASM_X86_SOFT86_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0f66682ac02a..d538f4f5641c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
+obj-$(CONFIG_X86_INSN_EMU)		+= soft86.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/arch/x86/kernel/soft86.c b/arch/x86/kernel/soft86.c
new file mode 100644
index 000000000000..98d9e08599ff
--- /dev/null
+++ b/arch/x86/kernel/soft86.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Software execution of x86 opcodes
+ *
+ * Copyright (c) 2021, Marcos Del Sol Vives <marcos@orca.pet>
+ */
+
+#include <linux/uaccess.h>
+
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
+#include <asm/soft86.h>
+
+static bool cmov_check_condition(struct insn *insn, struct pt_regs *regs)
+{
+	bool result, invert;
+	int condition, flags;
+
+	/*
+	 * Bits 3-1 of the second opcode byte specify the condition.
+	 *
+	 * Bit 0 of the second opcode byte is a flag - if set, the result must
+	 * be inverted.
+	 */
+	condition = (insn->opcode.bytes[1] >> 1) & 0x7;
+	invert = insn->opcode.bytes[1] & 1;
+
+	flags = regs->flags;
+	switch (condition) {
+	case 0:
+		/*
+		 * 0F 40 CMOVO
+		 * 0F 41 CMOVNO
+		 */
+		result = flags & X86_EFLAGS_OF;
+		break;
+
+	case 1:
+		/*
+		 * 0F 42 CMOVC/CMOVNAE
+		 * 0F 43 CMOVNC/CMOVNB
+		 */
+		result = flags & X86_EFLAGS_CF;
+		break;
+
+	case 2:
+		/*
+		 * 0F 44 CMOVE/CMOVZ
+		 * 0F 45 CMOVNE/CMOVNZ
+		 */
+		result = flags & X86_EFLAGS_ZF;
+		break;
+
+	case 3:
+		/*
+		 * 0F 46 CMOVNA/CMOVBE
+		 * 0F 47 CMOVA/CMOVNBE
+		 */
+		result = (flags & X86_EFLAGS_CF) ||
+			 (flags & X86_EFLAGS_ZF);
+		break;
+
+	case 4:
+		/*
+		 * 0F 48 CMOVS
+		 * 0F 49 CMOVNS
+		 */
+		result = flags & X86_EFLAGS_SF;
+		break;
+
+	case 5:
+		/*
+		 * 0F 4A CMOVP
+		 * 0F 4B CMOVNP
+		 */
+		result = flags & X86_EFLAGS_PF;
+		break;
+
+	case 6:
+		/*
+		 * 0F 4C CMOVL/CMOVNGE
+		 * 0F 4D CMOVNL/CMOVGE
+		 */
+		result = !!(flags & X86_EFLAGS_SF) !=
+			 !!(flags & X86_EFLAGS_OF);
+		break;
+
+	case 7:
+		/*
+		 * 0F 4E CMOVLE/CMOVNG
+		 * 0F 4F CMOVNLE/CMOVG
+		 */
+		result = (flags & X86_EFLAGS_ZF) ||
+			 !!(flags & X86_EFLAGS_SF) !=
+			 !!(flags & X86_EFLAGS_OF);
+		break;
+	}
+
+	if (invert)
+		result = !result;
+
+	return result;
+}
+
+static bool cmov_do_move(struct insn *insn, struct pt_regs *regs)
+{
+	int reg_off, rm_off;
+	void __user *src;
+	unsigned char *reg_bytes;
+
+	reg_bytes = (unsigned char *)regs;
+
+	/* Destination, from the REG part of the ModRM */
+	reg_off = insn_get_modrm_reg_off(insn, regs);
+	if (reg_off < 0)
+		return false;
+
+	/* Register to register move */
+	if (X86_MODRM_MOD(insn->modrm.value) == 3) {
+		rm_off = insn_get_modrm_rm_off(insn, regs);
+		if (rm_off < 0)
+			return false;
+
+		memcpy(reg_bytes + reg_off, reg_bytes + rm_off,
+		       insn->addr_bytes);
+	} else {
+		/* Source from the RM part of the ModRM */
+		src = insn_get_addr_ref(insn, regs);
+		if (src == (void __user *)-1L)
+			return false;
+
+		if (copy_from_user(reg_bytes + reg_off, src,
+				   insn->addr_bytes) != 0)
+			return false;
+	}
+
+	return true;
+}
+
+static bool cmov_execute(struct insn *insn, struct pt_regs *regs)
+{
+	/* CMOV is only supported for 16 and 32-bit registers */
+	if (insn->addr_bytes != 2 && insn->addr_bytes != 4)
+		return false;
+
+	/* If condition is met, execute the move */
+	if (cmov_check_condition(insn, regs)) {
+		/* Return false if the operands were invalid */
+		if (!cmov_do_move(insn, regs))
+			return false;
+	}
+
+	return true;
+}
+
+bool soft86_execute(struct pt_regs *regs)
+{
+	int nr_copied;
+	unsigned char buf[MAX_INSN_SIZE];
+	struct insn insn;
+	bool ret;
+
+	/* Read from userspace */
+	nr_copied = insn_fetch_from_user(regs, buf);
+	if (!nr_copied)
+		return false;
+
+	/* Attempt to decode it */
+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
+		return false;
+
+	/* 0x0F is the two byte opcode escape */
+	if (insn.opcode.bytes[0] != 0x0F)
+		return false;
+
+	switch (insn.opcode.bytes[1]) {
+	case 0x1F:
+		/* NOPL, so do nothing */
+		ret = true;
+		break;
+
+	case 0x40 ... 0x4F:
+		/* CMOVxx */
+		ret = cmov_execute(&insn, regs);
+		break;
+	}
+
+	/* Increment the instruction pointer if succeeded */
+	if (ret)
+		regs->ip += insn.length;
+
+	return ret;
+}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a80806..a61d4d1d1bf1 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -58,6 +58,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/soft86.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
@@ -215,6 +216,10 @@ void handle_invalid_op(struct pt_regs *regs)
 static inline void handle_invalid_op(struct pt_regs *regs)
 #endif
 {
+	/* Attempt instruction emulation */
+	if (user_mode(regs) && soft86_execute(regs))
+		return;
+
 	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
-- 
2.25.1

