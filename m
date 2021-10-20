Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C090E4349CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJTLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhJTLMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:12:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zt/OzRjbS+FMMBY/5pb3m8NJ0VtDCrV9eTFjp4dDyAQ=; b=AdgQAwhb5MaE2kO5RcRB2VCemz
        ejEi6ga3aBKM/pIu3IlUxZTiFfvEiqiEtI/oD2kBHQhc/KZTmxL3zZJ/ShcA/KsYR5VZKabuWTLdh
        xgTGnQ/OdXmITl5RBTt7VPX7kjCL6x2ELJB3g+gXuwvtrZxCCEs03fWqP69ToGUnZFDqbgWVGOesC
        6Am3aZEdEq+3e83sUPhguIKA9LlQ+cuI3no19NuuMjBmuyU0VllVWM6OuJlePTieGgJQm1CrPS3Oa
        XxgDFt2Xg0M1wZUKU2yl7pw0lV/DDTZlXjvAqJrnLgFsk8UnJDtoQTdIyWDocz081QfjjpT5alOr6
        QXJtjTxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9Tj-00Aw5l-PJ; Wed, 20 Oct 2021 11:09:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68244300221;
        Wed, 20 Oct 2021 13:09:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BDFB201BB3D5; Wed, 20 Oct 2021 13:09:51 +0200 (CEST)
Date:   Wed, 20 Oct 2021 13:09:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020105843.345016338@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:56PM +0200, Peter Zijlstra wrote:
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

> +#ifdef CONFIG_RETPOLINE
> +#define INDIRECT_SIZE (2 + 3*cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> +#else
> +#define INDIRECT_SIZE (2)
> +#endif

> @@ -411,10 +442,10 @@ static int get_pop_bytes(bool *callee_re
>   * out:
>   */
>  static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
> -					u32 stack_depth)
> +					u32 stack_depth, u8 *ip)
>  {
>  	int tcc_off = -4 - round_up(stack_depth, 8);
> -	u8 *prog = *pprog;
> +	u8 *prog = *pprog, *start = *pprog;
>  	int pop_bytes = 0;
>  	int off1 = 42;
>  	int off2 = 31;
> @@ -448,7 +479,7 @@ static void emit_bpf_tail_call_indirect(
>  	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
>  	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
>  	      offsetof(struct bpf_array, map.max_entries));
> -#define OFFSET1 (off1 + RETPOLINE_RCX_BPF_JIT_SIZE) /* Number of bytes to jump */
> +#define OFFSET1 (off1 + INDIRECT_SIZE) /* Number of bytes to jump */
>  	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
>  
>  	/*
> @@ -457,7 +488,7 @@ static void emit_bpf_tail_call_indirect(
>  	 */
>  	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
>  	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
> -#define OFFSET2 (off2 + RETPOLINE_RCX_BPF_JIT_SIZE)
> +#define OFFSET2 (off2 + INDIRECT_SIZE)
>  	EMIT2(X86_JA, OFFSET2);                   /* ja out */
>  	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
>  	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
> @@ -471,7 +502,7 @@ static void emit_bpf_tail_call_indirect(
>  	 *	goto out;
>  	 */
>  	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
> -#define OFFSET3 (off3 + RETPOLINE_RCX_BPF_JIT_SIZE)
> +#define OFFSET3 (off3 + INDIRECT_SIZE)
>  	EMIT2(X86_JE, OFFSET3);                   /* je out */
>  
>  	*pprog = prog;
> @@ -493,7 +524,7 @@ static void emit_bpf_tail_call_indirect(
>  	 * rdi == ctx (1st arg)
>  	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
>  	 */
> -	RETPOLINE_RCX_BPF_JIT();
> +	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
>  
>  	/* out: */
>  	*pprog = prog;

Alexei; could the above not be further improved with something like the
below?

Despite several hours trying and Song helping, I can't seem to run
anything bpf, that stuff is cursed. So I've no idea if the below
actually works, but it seems reasonable.

---

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -398,12 +398,6 @@ static int get_pop_bytes(bool *callee_re
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
-#ifdef CONFIG_RETPOLINE
-#define INDIRECT_SIZE (2 + 3*cpu_feature_enabled(X86_FEATURE_RETPOLINE))
-#else
-#define INDIRECT_SIZE (2)
-#endif
-
 static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 {
 	u8 *prog = *pprog;
@@ -446,25 +440,8 @@ static void emit_bpf_tail_call_indirect(
 {
 	int tcc_off = -4 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
-	int pop_bytes = 0;
-	int off1 = 42;
-	int off2 = 31;
-	int off3 = 9;
-
-	/* count the additional bytes used for popping callee regs from stack
-	 * that need to be taken into account for each of the offsets that
-	 * are used for bailing out of the tail call
-	 */
-	pop_bytes = get_pop_bytes(callee_regs_used);
-	off1 += pop_bytes;
-	off2 += pop_bytes;
-	off3 += pop_bytes;
-
-	if (stack_depth) {
-		off1 += 7;
-		off2 += 7;
-		off3 += 7;
-	}
+	static int out_label = -1;
+	int offset;
 
 	/*
 	 * rdi - pointer to ctx
@@ -479,8 +456,9 @@ static void emit_bpf_tail_call_indirect(
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 (off1 + INDIRECT_SIZE) /* Number of bytes to jump */
-	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
+
+	offset = out_label - (prog - start) + 2;
+	EMIT2(X86_JBE, offset);                  /* jbe out */
 
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -488,8 +466,9 @@ static void emit_bpf_tail_call_indirect(
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 (off2 + INDIRECT_SIZE)
-	EMIT2(X86_JA, OFFSET2);                   /* ja out */
+
+	offset = out_label - (prog - start) + 2;
+	EMIT2(X86_JA, offset);                   /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
 
@@ -502,8 +481,9 @@ static void emit_bpf_tail_call_indirect(
 	 *	goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
-#define OFFSET3 (off3 + INDIRECT_SIZE)
-	EMIT2(X86_JE, OFFSET3);                   /* je out */
+
+	offset = out_label - (prog - start) + 2;
+	EMIT2(X86_JE, offset);                   /* je out */
 
 	*pprog = prog;
 	pop_callee_regs(pprog, callee_regs_used);
@@ -527,6 +507,8 @@ static void emit_bpf_tail_call_indirect(
 	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
 
 	/* out: */
+	out_label = (prog - start);
+
 	*pprog = prog;
 }
 
