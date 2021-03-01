Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9C32805C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhCAOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236120AbhCAOJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:09:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 000EB601FE;
        Mon,  1 Mar 2021 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614607700;
        bh=HDi08UqTir8u55P4nkGUsEQelRebN/xp8kaTDUe6mIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jtj7uCwMoAON9QP92c4jjx9r1CLSqTK45yXhifhkfKYGnYQszBw+VzVR9q34+rdL8
         gj45NK1Rra9KaTWtzxARO1dRi8AKubckZcaUw2wDLpQ928AfC2gaLf2ULU4dosPz1w
         Db+S82Q7/Gxq8CA1gq3OsfinuADk2mzR6S0ip212v/n8uaeddPcmzbwlY93LFeUm5g
         YRMC+mcv7LQkJeh/gA2lOFw2/1e/ZFI+sHJK/iA1v25WJyR+FOhRXSPY/0Ay+Ii9Rn
         SWvyKd75cqb/czD3XeJDtOHYgn+9vecpzVv4kdbL/55+CXuc4B53q9omEqT8US9GkQ
         57HUTTkY4EeDA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 1/1] x86/kprobes: Use int3 instead of debug trap for single-step
Date:   Mon,  1 Mar 2021 23:08:15 +0900
Message-Id: <161460769556.430263.12936080446789384938.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161460768474.430263.18425867006584111900.stgit@devnote2>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use int3 instead of debug trap exception for single-stepping the
probed instructions. Some instructions which change the ip
registers or modify IF flags are emulated because those are not
able to be single-stepped by int3 or may allow the interrupt
while single-stepping.

This actually changes the kprobes behavior.

- kprobes can not probe following instructions; int3, iret,
  far jmp/call which get absolute address as immediate,
  indirect far jmp/call, indirect near jmp/call with addressing
  by memory (register-based indirect jmp/call are OK), and
  vmcall/vmlaunch/vmresume/vmxoff.

- If the kprobe post_handler doesn't set before registering,
  it may not be called in some case even if you set it afterwards.
  (IOW, kprobe booster is enabled at registration, user can not
   change it)

But both are rare issue, unsupported instructions will not be
used in the kernel (or rarely used), and post_handlers are
rarely used (I don't see it except for the test code).

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/kprobes.h |   21 +-
 arch/x86/kernel/kprobes/core.c |  515 ++++++++++++++++++++++++++--------------
 arch/x86/kernel/traps.c        |    3 
 3 files changed, 351 insertions(+), 188 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index d20a3d6be36e..bd7f5886a789 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -65,10 +65,22 @@ struct arch_specific_insn {
 	 * a post_handler).
 	 */
 	unsigned boostable:1;
-	unsigned if_modifier:1;
-	unsigned is_call:1;
-	unsigned is_pushf:1;
-	unsigned is_abs_ip:1;
+	unsigned char size;	/* The size of insn */
+	union {
+		unsigned char opcode;
+		struct {
+			unsigned char type;
+		} jcc;
+		struct {
+			unsigned char type;
+			unsigned char asize;
+		} loop;
+		struct {
+			unsigned char reg;
+		} indirect;
+	};
+	s32 rel32;	/* relative offset must be s32, s16, or s8 */
+	void (*emulate_op)(struct kprobe *p, struct pt_regs *regs);
 	/* Number of bytes of text poked */
 	int tp_len;
 };
@@ -107,7 +119,6 @@ extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 extern int kprobe_int3_handler(struct pt_regs *regs);
-extern int kprobe_debug_handler(struct pt_regs *regs);
 
 #else
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index be76568d57a5..30c34797933a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -177,6 +177,9 @@ int can_boost(struct insn *insn, void *addr)
 	case 0xf0:
 		/* clear and set flags are boostable */
 		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
+	case 0xff:
+		/* indirect jmp is boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
 		/* CS override prefix and call are not boostable */
 		return (opcode != 0x2e && opcode != 0x9a);
@@ -357,13 +360,14 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	return insn->length;
 }
 
-/* Prepare reljump right after instruction to boost */
-static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
-			  struct insn *insn)
+/* Prepare reljump or int3 right after instruction */
+static int prepare_singlestep(kprobe_opcode_t *buf, struct kprobe *p,
+			      struct insn *insn)
 {
 	int len = insn->length;
 
-	if (can_boost(insn, p->addr) &&
+	if (!IS_ENABLED(CONFIG_PREEMPTION) &&
+	    !p->post_handler && can_boost(insn, p->addr) &&
 	    MAX_INSN_SIZE - len >= JMP32_INSN_SIZE) {
 		/*
 		 * These instructions can be executed directly if it
@@ -374,7 +378,12 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 		len += JMP32_INSN_SIZE;
 		p->ainsn.boostable = 1;
 	} else {
-		p->ainsn.boostable = 0;
+		/* Otherwise, put an int3 for trapping singlestep */
+		if (MAX_INSN_SIZE - len < INT3_INSN_SIZE)
+			return -ENOSPC;
+
+		buf[len] = INT3_INSN_OPCODE;
+		len += INT3_INSN_SIZE;
 	}
 
 	return len;
@@ -411,42 +420,225 @@ void free_insn_page(void *page)
 	module_memfree(page);
 }
 
-static void set_resume_flags(struct kprobe *p, struct insn *insn)
+/* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
+
+static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
+{
+	switch (p->ainsn.opcode) {
+	case 0xfa:	/* cli */
+		regs->flags &= ~(X86_EFLAGS_IF);
+		break;
+	case 0xfb:	/* sti */
+		regs->flags |= X86_EFLAGS_IF;
+		break;
+	case 0x9c:	/* pushf */
+		int3_emulate_push(regs, regs->flags);
+		break;
+	case 0x9d:	/* popf */
+		regs->flags = int3_emulate_pop(regs);
+		break;
+	}
+	regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+}
+NOKPROBE_SYMBOL(kprobe_emulate_ifmodifiers);
+
+static void kprobe_emulate_ret(struct kprobe *p, struct pt_regs *regs)
+{
+	int3_emulate_ret(regs);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_ret);
+
+static void kprobe_emulate_call(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long func = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+
+	func += p->ainsn.rel32;
+	int3_emulate_call(regs, func);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_call);
+
+static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+
+	ip += p->ainsn.rel32;
+	int3_emulate_jmp(regs, ip);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jmp);
+
+static const unsigned long jcc_mask[6] = {
+	[0] = X86_EFLAGS_OF,
+	[1] = X86_EFLAGS_CF,
+	[2] = X86_EFLAGS_ZF,
+	[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
+	[4] = X86_EFLAGS_SF,
+	[5] = X86_EFLAGS_PF,
+};
+
+static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
+{
+	bool invert = p->ainsn.jcc.type & 1;
+	bool match;
+
+	if (p->ainsn.jcc.type < 0xc) {
+		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
+	} else {
+		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		if (p->ainsn.jcc.type >= 0xe)
+			match = match && (regs->flags & X86_EFLAGS_ZF);
+	}
+	if ((match && !invert) || (!match && invert))
+		kprobe_emulate_jmp(p, regs);
+	else
+		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jcc);
+
+static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
+{
+	bool match;
+
+	if (p->ainsn.loop.type != 3) {	/* LOOP* */
+		if (p->ainsn.loop.asize == 32)
+			match = ((*(u32 *)&regs->cx)--) != 0;
+#ifdef CONFIG_X86_64
+		else if (p->ainsn.loop.asize == 64)
+			match = ((*(u64 *)&regs->cx)--) != 0;
+#endif
+		else
+			match = ((*(u16 *)&regs->cx)--) != 0;
+	} else {			/* JCXZ */
+		if (p->ainsn.loop.asize == 32)
+			match = *(u32 *)(&regs->cx) == 0;
+#ifdef CONFIG_X86_64
+		else if (p->ainsn.loop.asize == 64)
+			match = *(u64 *)(&regs->cx) == 0;
+#endif
+		else
+			match = *(u16 *)(&regs->cx) == 0;
+	}
+
+	if (p->ainsn.loop.type == 0)	/* LOOPNE */
+		match = match && !(regs->flags & X86_EFLAGS_ZF);
+	else if (p->ainsn.loop.type == 1)	/* LOOPE */
+		match = match && (regs->flags & X86_EFLAGS_ZF);
+
+	if (match)
+		kprobe_emulate_jmp(p, regs);
+	else
+		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+}
+NOKPROBE_SYMBOL(kprobe_emulate_loop);
+
+static const int addrmode_regoffs[] = {
+	offsetof(struct pt_regs, ax),
+	offsetof(struct pt_regs, cx),
+	offsetof(struct pt_regs, dx),
+	offsetof(struct pt_regs, bx),
+	offsetof(struct pt_regs, sp),
+	offsetof(struct pt_regs, bp),
+	offsetof(struct pt_regs, si),
+	offsetof(struct pt_regs, di),
+#ifdef CONFIG_X86_64
+	offsetof(struct pt_regs, r8),
+	offsetof(struct pt_regs, r9),
+	offsetof(struct pt_regs, r10),
+	offsetof(struct pt_regs, r11),
+	offsetof(struct pt_regs, r12),
+	offsetof(struct pt_regs, r13),
+	offsetof(struct pt_regs, r14),
+	offsetof(struct pt_regs, r15),
+#endif
+};
+
+static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
+
+	int3_emulate_call(regs, regs_get_register(regs, offs));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
+
+static void kprobe_emulate_jmp_indirect(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
+
+	int3_emulate_jmp(regs, regs_get_register(regs, offs));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jmp_indirect);
+
+static int prepare_emulation(struct kprobe *p, struct insn *insn)
 {
 	insn_byte_t opcode = insn->opcode.bytes[0];
 
 	switch (opcode) {
 	case 0xfa:		/* cli */
 	case 0xfb:		/* sti */
+	case 0x9c:		/* pushfl */
 	case 0x9d:		/* popf/popfd */
-		/* Check whether the instruction modifies Interrupt Flag or not */
-		p->ainsn.if_modifier = 1;
-		break;
-	case 0x9c:	/* pushfl */
-		p->ainsn.is_pushf = 1;
+		/*
+		 * IF modifiers must be emulated since it will enable interrupt while
+		 * int3 single stepping.
+		 */
+		p->ainsn.emulate_op = kprobe_emulate_ifmodifiers;
+		p->ainsn.opcode = opcode;
 		break;
-	case 0xcf:	/* iret */
-		p->ainsn.if_modifier = 1;
-		fallthrough;
 	case 0xc2:	/* ret/lret */
 	case 0xc3:
 	case 0xca:
 	case 0xcb:
-	case 0xea:	/* jmp absolute -- ip is correct */
-		/* ip is already adjusted, no more changes required */
-		p->ainsn.is_abs_ip = 1;
-		/* Without resume jump, this is boostable */
-		p->ainsn.boostable = 1;
+		p->ainsn.emulate_op = kprobe_emulate_ret;
 		break;
-	case 0xe8:	/* call relative - Fix return addr */
-		p->ainsn.is_call = 1;
+	case 0x9a:	/* far call absolute -- segment is not supported */
+	case 0xea:	/* far jmp absolute -- segment is not supported */
+	case 0xcc:	/* int3 */
+	case 0xcf:	/* iret -- in-kernel IRET is not supported */
+		return -EOPNOTSUPP;
 		break;
-#ifdef CONFIG_X86_32
-	case 0x9a:	/* call absolute -- same as call absolute, indirect */
-		p->ainsn.is_call = 1;
-		p->ainsn.is_abs_ip = 1;
+	case 0xe8:	/* near call relative */
+		p->ainsn.emulate_op = kprobe_emulate_call;
+		if (insn->immediate.nbytes == 2)
+			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+		else
+			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		break;
+	case 0xeb:	/* short jump relative */
+	case 0xe9:	/* near jump relative */
+		p->ainsn.emulate_op = kprobe_emulate_jmp;
+		if (insn->immediate.nbytes == 1)
+			p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+		else if (insn->immediate.nbytes == 2)
+			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+		else
+			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		break;
+	case 0x0f:
+		opcode = insn->opcode.bytes[1];
+		if ((opcode & 0xf0) == 0x80) {
+			/* 2 bytes Conditional Jump */
+			p->ainsn.emulate_op = kprobe_emulate_jcc;
+			p->ainsn.jcc.type = opcode & 0xf;
+			if (insn->immediate.nbytes == 2)
+				p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+			else
+				p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		} else if (opcode == 0x01 &&
+			   X86_MODRM_REG(insn->modrm.bytes[0]) == 0 &&
+			   X86_MODRM_MOD(insn->modrm.bytes[0]) == 3) {
+			/* VM extensions - not supported */
+			return -EOPNOTSUPP;
+		}
+		break;
+	case 0xe0:	/* Loop NZ */
+	case 0xe1:	/* Loop */
+	case 0xe2:	/* Loop */
+	case 0xe3:	/* J*CXZ */
+		p->ainsn.emulate_op = kprobe_emulate_loop;
+		p->ainsn.loop.type = opcode & 0x3;
+		p->ainsn.loop.asize = insn->addr_bytes * 8;
+		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
 		break;
-#endif
 	case 0xff:
 		/*
 		 * Since the 0xff is an extended group opcode, the instruction
@@ -454,46 +646,62 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 		 */
 		opcode = insn->modrm.bytes[0];
 		if ((opcode & 0x30) == 0x10) {
-			/*
-			 * call absolute, indirect
-			 * Fix return addr; ip is correct.
-			 * But this is not boostable
-			 */
-			p->ainsn.is_call = 1;
-			p->ainsn.is_abs_ip = 1;
-			break;
+			if ((opcode & 0x8) == 0x8)
+				return -EOPNOTSUPP;	/* far call */
+			/* call absolute, indirect */
+			p->ainsn.emulate_op = kprobe_emulate_call_indirect;
 		} else if ((opcode & 0x30) == 0x20) {
-			/*
-			 * jmp near and far, absolute indirect
-			 * ip is correct.
-			 */
-			p->ainsn.is_abs_ip = 1;
-			/* Without resume jump, this is boostable */
-			p->ainsn.boostable = 1;
-		}
+			if ((opcode & 0x8) == 0x8)
+				return -EOPNOTSUPP;	/* far jmp */
+			/* jmp near absolute indirect */
+			p->ainsn.emulate_op = kprobe_emulate_jmp_indirect;
+		} else
+			break;
+
+		if (insn->addr_bytes != sizeof(unsigned long))
+			return -EOPNOTSUPP;	/* Don't support differnt size */
+		if (X86_MODRM_MOD(opcode) != 3)
+			return -EOPNOTSUPP;	/* TODO: support memory addressing */
+
+		p->ainsn.indirect.reg = X86_MODRM_RM(opcode);
+#ifdef CONFIG_X86_64
+		if (X86_REX_B(insn->rex_prefix.value))
+			p->ainsn.indirect.reg += 8;
+#endif
 		break;
+	default:
+		if ((opcode & 0xf0) == 0x70) {
+			/* 1 byte conditional jump */
+			p->ainsn.emulate_op = kprobe_emulate_jcc;
+			p->ainsn.jcc.type = opcode & 0xf;
+			p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		}
 	}
+	p->ainsn.size = insn->length;
+
+	return 0;
 }
 
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	int len;
+	int ret, len;
 
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	len = __copy_instruction(buf, p->addr, p->ainsn.insn, &insn);
 	if (!len)
 		return -EINVAL;
 
-	/*
-	 * __copy_instruction can modify the displacement of the instruction,
-	 * but it doesn't affect boostable check.
-	 */
-	len = prepare_boost(buf, p, &insn);
+	/* Analyze the opcode and setup emulate functions */
+	ret = prepare_emulation(p, &insn);
+	if (ret < 0)
+		return ret;
 
-	/* Analyze the opcode and set resume flags */
-	set_resume_flags(p, &insn);
+	/* Add int3 for single-step or booster jmp */
+	len = prepare_singlestep(buf, p, &insn);
+	if (len < 0)
+		return len;
 
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
@@ -586,29 +794,7 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 {
 	__this_cpu_write(current_kprobe, p);
 	kcb->kprobe_saved_flags = kcb->kprobe_old_flags
-		= (regs->flags & (X86_EFLAGS_TF | X86_EFLAGS_IF));
-	if (p->ainsn.if_modifier)
-		kcb->kprobe_saved_flags &= ~X86_EFLAGS_IF;
-}
-
-static nokprobe_inline void clear_btf(void)
-{
-	if (test_thread_flag(TIF_BLOCKSTEP)) {
-		unsigned long debugctl = get_debugctlmsr();
-
-		debugctl &= ~DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
-	}
-}
-
-static nokprobe_inline void restore_btf(void)
-{
-	if (test_thread_flag(TIF_BLOCKSTEP)) {
-		unsigned long debugctl = get_debugctlmsr();
-
-		debugctl |= DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
-	}
+		= (regs->flags & X86_EFLAGS_IF);
 }
 
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
@@ -623,6 +809,22 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
+static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
+			       struct kprobe_ctlblk *kcb)
+{
+	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
+	}
+
+	/* Restore back the original saved kprobes variables and continue. */
+	if (kcb->kprobe_status == KPROBE_REENTER)
+		restore_previous_kprobe(kcb);
+	else
+		reset_current_kprobe();
+}
+NOKPROBE_SYMBOL(kprobe_post_process);
+
 static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 			     struct kprobe_ctlblk *kcb, int reenter)
 {
@@ -630,7 +832,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		return;
 
 #if !defined(CONFIG_PREEMPTION)
-	if (p->ainsn.boostable && !p->post_handler) {
+	if (p->ainsn.boostable) {
 		/* Boost up -- we can execute copied instructions directly */
 		if (!reenter)
 			reset_current_kprobe();
@@ -649,18 +851,50 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		kcb->kprobe_status = KPROBE_REENTER;
 	} else
 		kcb->kprobe_status = KPROBE_HIT_SS;
-	/* Prepare real single stepping */
-	clear_btf();
-	regs->flags |= X86_EFLAGS_TF;
+
+	if (p->ainsn.emulate_op) {
+		p->ainsn.emulate_op(p, regs);
+		kprobe_post_process(p, regs, kcb);
+		return;
+	}
+
+	/* Disable interrupt, and set ip register on trampoline */
 	regs->flags &= ~X86_EFLAGS_IF;
-	/* single step inline if the instruction is an int3 */
-	if (p->opcode == INT3_INSN_OPCODE)
-		regs->ip = (unsigned long)p->addr;
-	else
-		regs->ip = (unsigned long)p->ainsn.insn;
+	regs->ip = (unsigned long)p->ainsn.insn;
 }
 NOKPROBE_SYMBOL(setup_singlestep);
 
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "int3"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn. We also doesn't use trap, but "int3" again
+ * right after the copied instruction.
+ * Different from the trap single-step, "int3" single-step can not
+ * handle the instruction which changes the ip register, e.g. jmp,
+ * call, conditional jmp, and the instructions which changes the IF
+ * flags because interrupt must be disabled around the single-stepping.
+ * Such instructions are software emulated, but others are single-stepped
+ * using "int3".
+ *
+ * When the 2nd "int3" handled, the regs->ip and regs->flags needs to
+ * be adjusted, so that we can resume execution on correct code.
+ */
+static void resume_singlestep(struct kprobe *p, struct pt_regs *regs,
+			      struct kprobe_ctlblk *kcb)
+{
+	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
+	unsigned long orig_ip = (unsigned long)p->addr;
+
+	/* Restore saved interrupt flag and ip register */
+	regs->flags |= kcb->kprobe_saved_flags;
+	/* Note that regs->ip is executed int3 so must be a step back */
+	regs->ip += (orig_ip - copy_ip) - INT3_INSN_SIZE;
+}
+NOKPROBE_SYMBOL(resume_singlestep);
+
 /*
  * We have reentered the kprobe_handler(), since another probe was hit while
  * within the handler. We save the original kprobes variables and just single
@@ -696,6 +930,12 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(reenter_kprobe);
 
+static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
+{
+	return (kcb->kprobe_status == KPROBE_HIT_SS ||
+		kcb->kprobe_status == KPROBE_REENTER);
+}
+
 /*
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled throughout this function.
@@ -740,7 +980,18 @@ int kprobe_int3_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			return 1;
 		}
-	} else if (*addr != INT3_INSN_OPCODE) {
+	} else if (kprobe_is_ss(kcb)) {
+		p = kprobe_running();
+		if ((unsigned long)p->ainsn.insn < regs->ip &&
+		    (unsigned long)p->ainsn.insn + MAX_INSN_SIZE > regs->ip) {
+			/* Most provably this is the second int3 for singlestep */
+			resume_singlestep(p, regs, kcb);
+			kprobe_post_process(p, regs, kcb);
+			return 1;
+		}
+	}
+
+	if (*addr != INT3_INSN_OPCODE) {
 		/*
 		 * The breakpoint instruction was removed right
 		 * after we hit it.  Another cpu has removed
@@ -813,91 +1064,6 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 
-/*
- * Called after single-stepping.  p->addr is the address of the
- * instruction whose first byte has been replaced by the "int 3"
- * instruction.  To avoid the SMP problems that can occur when we
- * temporarily put back the original opcode to single-step, we
- * single-stepped a copy of the instruction.  The address of this
- * copy is p->ainsn.insn.
- *
- * This function prepares to return from the post-single-step
- * interrupt.  We have to fix up the stack as follows:
- *
- * 0) Except in the case of absolute or indirect jump or call instructions,
- * the new ip is relative to the copied instruction.  We need to make
- * it relative to the original instruction.
- *
- * 1) If the single-stepped instruction was pushfl, then the TF and IF
- * flags are set in the just-pushed flags, and may need to be cleared.
- *
- * 2) If the single-stepped instruction was a call, the return address
- * that is atop the stack is the address following the copied instruction.
- * We need to make it the address following the original instruction.
- */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs,
-			     struct kprobe_ctlblk *kcb)
-{
-	unsigned long *tos = stack_addr(regs);
-	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
-	unsigned long orig_ip = (unsigned long)p->addr;
-
-	regs->flags &= ~X86_EFLAGS_TF;
-
-	/* Fixup the contents of top of stack */
-	if (p->ainsn.is_pushf) {
-		*tos &= ~(X86_EFLAGS_TF | X86_EFLAGS_IF);
-		*tos |= kcb->kprobe_old_flags;
-	} else if (p->ainsn.is_call) {
-		*tos = orig_ip + (*tos - copy_ip);
-	}
-
-	if (!p->ainsn.is_abs_ip)
-		regs->ip += orig_ip - copy_ip;
-
-	restore_btf();
-}
-NOKPROBE_SYMBOL(resume_execution);
-
-/*
- * Interrupts are disabled on entry as trap1 is an interrupt gate and they
- * remain disabled throughout this function.
- */
-int kprobe_debug_handler(struct pt_regs *regs)
-{
-	struct kprobe *cur = kprobe_running();
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (!cur)
-		return 0;
-
-	resume_execution(cur, regs, kcb);
-	regs->flags |= kcb->kprobe_saved_flags;
-
-	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		cur->post_handler(cur, regs, 0);
-	}
-
-	/* Restore back the original saved kprobes variables and continue. */
-	if (kcb->kprobe_status == KPROBE_REENTER) {
-		restore_previous_kprobe(kcb);
-		goto out;
-	}
-	reset_current_kprobe();
-out:
-	/*
-	 * if somebody else is singlestepping across a probe point, flags
-	 * will have TF set, in which case, continue the remaining processing
-	 * of do_debug, as if this is not a probe hit.
-	 */
-	if (regs->flags & X86_EFLAGS_TF)
-		return 0;
-
-	return 1;
-}
-NOKPROBE_SYMBOL(kprobe_debug_handler);
-
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
@@ -915,20 +1081,9 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * normal page fault.
 		 */
 		regs->ip = (unsigned long)cur->addr;
-		/*
-		 * Trap flag (TF) has been set here because this fault
-		 * happened where the single stepping will be done.
-		 * So clear it by resetting the current kprobe:
-		 */
-		regs->flags &= ~X86_EFLAGS_TF;
-		/*
-		 * Since the single step (trap) has been cancelled,
-		 * we need to restore BTF here.
-		 */
-		restore_btf();
 
 		/*
-		 * If the TF flag was set before the kprobe hit,
+		 * If the IF flag was set before the kprobe hit,
 		 * don't touch it:
 		 */
 		regs->flags |= kcb->kprobe_old_flags;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7f5aec758f0e..1235c85c8b3a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -890,9 +890,6 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
-	if (kprobe_debug_handler(regs))
-		goto out;
-
 	/*
 	 * The kernel doesn't use INT1
 	 */

