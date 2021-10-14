Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928E842D668
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJNJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJNJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:50:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC83C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VFsHmjtqeA7otVRvYxYoUhNnco8im9G7T9b/UENwDiU=; b=neVzISUhlgDOdylmOFjmS24nAD
        5tAhfdNbj/MV9jXJ154MaXabeecXM+8FIbzPipNoHFHnRJPl7rd5Fj+CvANmXuwwNFf8lWUxhgygD
        qhK+7YCRb644aQbFtI4r7cUJPdiowTlzEDdDc9PzimjLwQS6KKvKbkpMaKDUO7vyPqTEE88ksnH2G
        QsCyCqoKVGjo/FwIUx3u0Zq4baATQgYYfv50o0koJS+/rZewhTYGfjQVEWzFpc+zj/EfiSWOPkQQH
        ZTYEy8NLoAblDhbhwPZh0r39z7riwaMvZEVOjHXFgEWYggaTDKovSZcy5kQxKtOPVYG32RIvXBPHj
        WtpeYppg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maxJU-008ENj-07; Thu, 14 Oct 2021 09:46:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A21C23001C0;
        Thu, 14 Oct 2021 11:46:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EFE12D6E98E3; Thu, 14 Oct 2021 11:46:11 +0200 (CEST)
Date:   Thu, 14 Oct 2021 11:46:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 9/9] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YWf8Yy2e9n+/veEe@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.706163435@infradead.org>
 <20211013210605.bz6l7o5xzik5ckga@treble>
 <YWdVq8UWpvMwnzht@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWdVq8UWpvMwnzht@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:54:51PM +0200, Peter Zijlstra wrote:

> > But the rest of eBPF JIT just emits retpolines unconditionally
> > regardless of feature, for example see RETPOLINE_RCX_BPF_JIT().  So I'm
> > thinking this should probably be consistent with that (or that with
> > this).
> 
> Argh, I grepped for __x86_indirect_thunk, and missed they're writing
> retpolines themselves. Bah.
> 
> Yes, that needs cleaning up. I'll go prod at that tomorrow.

Bah, i've too much of a head-ache to make sense of that bpf jit code :-(

Alexei, emit_fallback_jump() uses emit_jump() and provides @prog as .ip
argument, but other sites do weird things like 'image + addrs[i]',
presumable because @prog points to an on-stack array instead of to the
actual text location.

Also @prog is confusingly sometimes a struct bpf_prog* and sometimes a
u8* which makes grepping really confusing.

I've ended up with the below.. which is known broken-crap for 32, but is
likely simlar for 64bit as well :-( Can you please have a look?

(random remarks:
  I *really* hate Intel syntax,
  64bit seems to lack IA32_reg equivalents,
  add_2reg(), add_1reg() are really daft names for something that
  generates a modrm byte.
)

---

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
+#define INDIRECT_SIZE (5)
+#else
+#define INDIRECT_SIZE (2)
+#endif
+
+static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+{
+	static const void *reg_thunk[] = {
+#undef GEN
+#define GEN(reg) __x86_indirect_thunk_ ## reg,
+#include <asm/GEN-for-each-reg.h>
+	};
+
+	u8 *prog = *pprog;
+
+#ifdef CONFIG_RETPOLINE
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
+	emit_indirect_jump(&prog, 1 /* rcx */, prog);
 
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
@@ -2117,24 +2147,6 @@ int arch_prepare_bpf_trampoline(struct b
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
@@ -2156,9 +2168,7 @@ static int emit_bpf_dispatcher(u8 **ppro
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
@@ -1362,6 +1362,11 @@ static void emit_bpf_tail_call(u8 **ppro
 	 * eax == ctx (1st arg)
 	 * edx == prog->bpf_func + prologue_size
 	 */
+#ifdef CONFIG_RETPOLINE
+	EMIT1_off32(0xE9, __x86_indirect_thunk_edx - (image + addrs[i] + 5));
+#else
+	EMIT2(0xFF, 0xE2);
+#endif
 	RETPOLINE_EDX_BPF_JIT();
 
 	if (jmp_label1 == -1)
