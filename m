Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73A4397F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhJYN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJYN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:59:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ef8hkZsa4H89XkZHxMxY82mpR5AmSwHB7IihVr9CwYA=; b=ajOzZ25lvF2c81Z8/YIRkhHs4/
        QICwxDhWj+DXkMLCiHZcdZ2avCd2m65CFrGdTQCyLSUv80qWdtW7KeXIO59YbBqaBtb8m7Pg++O4t
        yFCYsyvrod6gJz2+qqssX4eTNF/0zCVpKvLAaVO+fKIM1Ld2dpdjHzbTPHtDoCwEwE1HyPC5ItWx8
        2n1pFQqoKbYUemFaRSQWFVZmI6pct+az732AfcK++J3fp32/SZioQh9sa6r/twe//IjF15UNi8YRe
        4btIIFINmTvt7WVbw5vUEJ95Y2Q1/cirwILjCk60XYF9SVfO/PeIkiewVaJ7JRPI9fFOGHfapdhDz
        tjxyCpZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf0TF-00C9hj-68; Mon, 25 Oct 2021 13:57:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBD5B3002AE;
        Mon, 25 Oct 2021 15:56:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3B1A2C3E69E1; Mon, 25 Oct 2021 15:56:59 +0200 (CEST)
Date:   Mon, 25 Oct 2021 15:56:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025122102.46089-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 02:21:00PM +0200, Frederic Weisbecker wrote:

> +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insn)			    \
> +	asm("	.pushsection	.static_call.text, \"ax\"		\n" \
> +	    "	.align		4					\n" \
> +	    "	.globl		" STATIC_CALL_TRAMP_STR(name) "		\n" \
> +	    "0:	.quad	0x0						\n" \
> +	    STATIC_CALL_TRAMP_STR(name) ":				\n" \
> +	    "	hint 	34	/* BTI C */				\n" \
> +		insn "							\n" \
> +	    "	ldr	x16, 0b						\n" \
> +	    "	cbz	x16, 1f						\n" \
> +	    "	br	x16						\n" \
> +	    "1:	ret							\n" \
> +	    "	.popsection						\n")

> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> +{
> +	/*
> +	 * -0x8	<literal>
> +	 *  0x0	bti c		<--- trampoline entry point
> +	 *  0x4	<branch or nop>
> +	 *  0x8	ldr x16, <literal>
> +	 *  0xc	cbz x16, 20
> +	 * 0x10	br x16
> +	 * 0x14	ret
> +	 */
> +	struct {
> +		u64	literal;
> +		__le32	insn[2];
> +	} insns;
> +	u32 insn;
> +	int ret;
> +
> +	insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_BTIC);
> +	insns.literal = (u64)func;
> +	insns.insn[0] = cpu_to_le32(insn);
> +
> +	if (!func) {
> +		insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
> +						   AARCH64_INSN_BRANCH_RETURN);
> +	} else {
> +		insn = aarch64_insn_gen_branch_imm((u64)tramp + 4, (u64)func,
> +						   AARCH64_INSN_BRANCH_NOLINK);
> +
> +		/*
> +		 * Use a NOP if the branch target is out of range, and rely on
> +		 * the indirect call instead.
> +		 */
> +		if (insn == AARCH64_BREAK_FAULT)
> +			insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
> +	}
> +	insns.insn[1] = cpu_to_le32(insn);
> +
> +	ret = __aarch64_insn_write(tramp - 8, &insns, sizeof(insns));

OK, that's pretty magical...

So you're writing the literal and the two instructions with 2 u64
stores. Relying on alignment to guarantee both are in a single page and
that copy_to_kernel_nofault() selects u64 writes.

By unconditionally writing the literal, you avoid there ever being an
stale value, which in turn avoids there being a race where you switch
from 'J @func' relative addressing to 'NOP; do-literal-thing' and cross
CPU execution gets the ordering inverted.

Ooohh, but what if you go from !func to NOP.

assuming:

	.literal = 0
	BTI C
	RET

Then

	CPU0			CPU1

	[S] literal = func	[I] NOP
	[S] insn[1] = NOP	[L] x16 = literal (NULL)
				b x16
				*BANG*

Is that possible? (total lack of memory ordering etc..)

On IRC you just alluded to the fact that this relies on it all being in
a single cacheline (i-fetch windows don't need to be cacheline sized,
but provided they're at least 16 bytes, this should still work given the
alignment).

But is I$ and D$ coherent? One load is through I-fetch, the other is a
regular D-fetch.

However, Will has previously expressed reluctance to rely on such
things.

> +	if (!WARN_ON(ret))
> +		caches_clean_inval_pou((u64)tramp - 8, sizeof(insns));
>  }
