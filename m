Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87CF4349AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhJTLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhJTLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3738C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ak40Xd4ZmHeQMvWeIvej+mnGHnjjInsl3RcmtLpo0Os=; b=ZoyEgnWP/J6sXP4BAloOWCvOyP
        i0oGeElSkJ/E8ssEyzwoli6MIfGuggj+x4UgXjK7RmtP79n0maAzhL3056xkJbo4xZA97AMWuVXBO
        D2YYfZb534+Ec4VSRb3P9Gc8LHv8L8SGZh2z1fqgPfwPxS378cm9amtmwZanf6vWeh6vjZckqmLuY
        n5AnMqJekYBmjC5Js932Y2HYMp2/Y+CiACVtIAdroohzNo80V/L620+48Hj/rSlxt62Cb7qwRvRSy
        YG63qFA7ROVK6AAlxtSpeTY67xTAxGvNdyH+lGXkQhVsUE7B9qusM7LhdDnldv96XIjPtn7IEIygR
        qzmLX8Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00CR1E-Jh; Wed, 20 Oct 2021 11:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38D0E301995;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 27FC7201BB3C8; Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Message-ID: <20211020105843.345016338@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current BPF codegen doesn't respect X86_FEATURE_RETPOLINE* flags and
unconditionally emits a thunk call, this is sub-optimal and doesn't
match the regular, compiler generated, code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   59 -----------------------------
 arch/x86/net/bpf_jit_comp.c          |   71 ++++++++++++++++++++---------------
 arch/x86/net/bpf_jit_comp32.c        |   22 ++++++++--
 3 files changed, 59 insertions(+), 93 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -303,63 +303,4 @@ static inline void mds_idle_clear_cpu_bu
 
 #endif /* __ASSEMBLY__ */
 
-/*
- * Below is used in the eBPF JIT compiler and emits the byte sequence
- * for the following assembly:
- *
- * With retpolines configured:
- *
- *    callq do_rop
- *  spec_trap:
- *    pause
- *    lfence
- *    jmp spec_trap
- *  do_rop:
- *    mov %rcx,(%rsp) for x86_64
- *    mov %edx,(%esp) for x86_32
- *    retq
- *
- * Without retpolines configured:
- *
- *    jmp *%rcx for x86_64
- *    jmp *%edx for x86_32
- */
-#ifdef CONFIG_RETPOLINE
-# ifdef CONFIG_X86_64
-#  define RETPOLINE_RCX_BPF_JIT_SIZE	17
-#  define RETPOLINE_RCX_BPF_JIT()				\
-do {								\
-	EMIT1_off32(0xE8, 7);	 /* callq do_rop */		\
-	/* spec_trap: */					\
-	EMIT2(0xF3, 0x90);       /* pause */			\
-	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
-	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
-	/* do_rop: */						\
-	EMIT4(0x48, 0x89, 0x0C, 0x24); /* mov %rcx,(%rsp) */	\
-	EMIT1(0xC3);             /* retq */			\
-} while (0)
-# else /* !CONFIG_X86_64 */
-#  define RETPOLINE_EDX_BPF_JIT()				\
-do {								\
-	EMIT1_off32(0xE8, 7);	 /* call do_rop */		\
-	/* spec_trap: */					\
-	EMIT2(0xF3, 0x90);       /* pause */			\
-	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
-	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
-	/* do_rop: */						\
-	EMIT3(0x89, 0x14, 0x24); /* mov %edx,(%esp) */		\
-	EMIT1(0xC3);             /* ret */			\
-} while (0)
-# endif
-#else /* !CONFIG_RETPOLINE */
-# ifdef CONFIG_X86_64
-#  define RETPOLINE_RCX_BPF_JIT_SIZE	2
-#  define RETPOLINE_RCX_BPF_JIT()				\
-	EMIT2(0xFF, 0xE1);       /* jmp *%rcx */
-# else /* !CONFIG_X86_64 */
-#  define RETPOLINE_EDX_BPF_JIT()				\
-	EMIT2(0xFF, 0xE2)        /* jmp *%edx */
-# endif
-#endif
-
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -396,6 +396,37 @@ static int get_pop_bytes(bool *callee_re
 	return bytes;
 }
 
+#define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
+
+#ifdef CONFIG_RETPOLINE
+#define INDIRECT_SIZE (2 + 3*cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+#else
+#define INDIRECT_SIZE (2)
+#endif
+
+static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+{
+	u8 *prog = *pprog;
+
+#ifdef CONFIG_RETPOLINE
+	static void * const reg_thunk[] = {
+#define GEN(reg) __x86_indirect_thunk_ ## reg,
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+	};
+
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		EMIT_LFENCE();
+		EMIT2(0xFF, 0xE0 + reg);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		emit_jump(&prog, reg_thunk[reg], ip);
+	} else
+#endif
+	EMIT2(0xFF, 0xE0 + reg);
+
+	*pprog = prog;
+}
+
 /*
  * Generate the following code:
  *
@@ -411,10 +442,10 @@ static int get_pop_bytes(bool *callee_re
  * out:
  */
 static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth)
+					u32 stack_depth, u8 *ip)
 {
 	int tcc_off = -4 - round_up(stack_depth, 8);
-	u8 *prog = *pprog;
+	u8 *prog = *pprog, *start = *pprog;
 	int pop_bytes = 0;
 	int off1 = 42;
 	int off2 = 31;
@@ -448,7 +479,7 @@ static void emit_bpf_tail_call_indirect(
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 (off1 + RETPOLINE_RCX_BPF_JIT_SIZE) /* Number of bytes to jump */
+#define OFFSET1 (off1 + INDIRECT_SIZE) /* Number of bytes to jump */
 	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
 
 	/*
@@ -457,7 +488,7 @@ static void emit_bpf_tail_call_indirect(
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 (off2 + RETPOLINE_RCX_BPF_JIT_SIZE)
+#define OFFSET2 (off2 + INDIRECT_SIZE)
 	EMIT2(X86_JA, OFFSET2);                   /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
@@ -471,7 +502,7 @@ static void emit_bpf_tail_call_indirect(
 	 *	goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
-#define OFFSET3 (off3 + RETPOLINE_RCX_BPF_JIT_SIZE)
+#define OFFSET3 (off3 + INDIRECT_SIZE)
 	EMIT2(X86_JE, OFFSET3);                   /* je out */
 
 	*pprog = prog;
@@ -493,7 +524,7 @@ static void emit_bpf_tail_call_indirect(
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	RETPOLINE_RCX_BPF_JIT();
+	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
 
 	/* out: */
 	*pprog = prog;
@@ -1220,8 +1251,7 @@ static int do_jit(struct bpf_prog *bpf_p
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
 			if (boot_cpu_has(X86_FEATURE_XMM2))
-				/* Emit 'lfence' */
-				EMIT3(0x0F, 0xAE, 0xE8);
+				EMIT_LFENCE();
 			break;
 
 			/* ST: *(u8*)(dst_reg + off) = imm */
@@ -1411,7 +1441,8 @@ st:			if (is_imm8(insn->off))
 			else
 				emit_bpf_tail_call_indirect(&prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth);
+							    bpf_prog->aux->stack_depth,
+							    image + addrs[i - 1]);
 			break;
 
 			/* cond jump */
@@ -2117,24 +2148,6 @@ int arch_prepare_bpf_trampoline(struct b
 	return ret;
 }
 
-static int emit_fallback_jump(u8 **pprog)
-{
-	u8 *prog = *pprog;
-	int err = 0;
-
-#ifdef CONFIG_RETPOLINE
-	/* Note that this assumes the the compiler uses external
-	 * thunks for indirect calls. Both clang and GCC use the same
-	 * naming convention for external thunks.
-	 */
-	err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
-#else
-	EMIT2(0xFF, 0xE2);	/* jmp rdx */
-#endif
-	*pprog = prog;
-	return err;
-}
-
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 {
 	u8 *jg_reloc, *prog = *pprog;
@@ -2156,9 +2169,7 @@ static int emit_bpf_dispatcher(u8 **ppro
 		if (err)
 			return err;
 
-		err = emit_fallback_jump(&prog);	/* jmp thunk/indirect */
-		if (err)
-			return err;
+		emit_indirect_jump(&prog, 2 /* rdx */, prog);
 
 		*pprog = prog;
 		return 0;
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -15,6 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-prototypes.h>
 #include <linux/bpf.h>
 
 /*
@@ -1267,6 +1268,19 @@ static void emit_epilogue(u8 **pprog, u3
 	*pprog = prog;
 }
 
+static void emit_jmp_edx(u8 **pprog, u8 *ip)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+#ifdef CONFIG_RETPOLINE
+	EMIT1_off32(0xE9, (u8 *)__x86_indirect_thunk_edx - (ip + 5));
+#else
+	EMIT2(0xFF, 0xE2);
+#endif
+	*pprog = prog;
+}
+
 /*
  * Generate the following code:
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
@@ -1280,9 +1294,9 @@ static void emit_epilogue(u8 **pprog, u3
  *   goto *(prog->bpf_func + prologue_size);
  * out:
  */
-static void emit_bpf_tail_call(u8 **pprog)
+static void emit_bpf_tail_call(u8 **pprog, u8 *ip)
 {
-	u8 *prog = *pprog;
+	u8 *prog = *pprog, *start = *pprog;
 	int cnt = 0;
 	const u8 *r1 = bpf2ia32[BPF_REG_1];
 	const u8 *r2 = bpf2ia32[BPF_REG_2];
@@ -1362,7 +1376,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 * eax == ctx (1st arg)
 	 * edx == prog->bpf_func + prologue_size
 	 */
-	RETPOLINE_EDX_BPF_JIT();
+	emit_jmp_edx(&prog, ip + (prog - start));
 
 	if (jmp_label1 == -1)
 		jmp_label1 = cnt;
@@ -2122,7 +2136,7 @@ static int do_jit(struct bpf_prog *bpf_p
 			break;
 		}
 		case BPF_JMP | BPF_TAIL_CALL:
-			emit_bpf_tail_call(&prog);
+			emit_bpf_tail_call(&prog, image + addrs[i - 1]);
 			break;
 
 		/* cond jump */


