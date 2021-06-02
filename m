Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77E3983EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhFBIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFBIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:17:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yONE1d8i5hfR07uAKblTaH+2S9CKA1GaJ8pZJcWFjE0=; b=Zc1uEjIml6Ejdkjr/M1BqcdGZN
        EV/Z2d8fQZpsbXSOAKxkdSgrGhRmDvGCTs4LEjJf16w9bK619n952NTDIg/E/qnRSdZb8DG6diD7q
        cm5N22tzlkznHqZ62Rl02xvJpANkwY5mDgKatoiLR73vLz1Y7DbHTbJhha4SbmUTu367WQGMi7Hn2
        ea2OJvEONMLf40A+viN52ho8Q4q9Q3/Zek7Qixazjw9/zoOutJuQoPdSJ0NZD53yOi/7c+yaESOxu
        t0krxiBbGeV3h0kCTV37B59Cm9H7qf6Sw4McRw1lL5PGj5z0lh046SzkgS9W2vDRRKMcGminx6mCJ
        rt4wUFmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1loM1j-00AsT0-Hv; Wed, 02 Jun 2021 08:15:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E28A830019C;
        Wed,  2 Jun 2021 10:14:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C16782016D6C3; Wed,  2 Jun 2021 10:14:58 +0200 (CEST)
Date:   Wed, 2 Jun 2021 10:14:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Richard Narron <richard@aaazen.com>
Subject: Re: [PATCH] x86/alternative: Optimize single-byte NOPs at an
 arbitrary position
Message-ID: <YLc+AniWgFBdMbX6@hirez.programming.kicks-ass.net>
References: <20210601212125.17145-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601212125.17145-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:21:25PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Up until now the assumption was that an alternative patching site would
> have some instructions at the beginning and trailing single-byte NOPs
> (0x90) padding. Therefore, the patching machinery would go and optimize
> those single-byte NOPs into longer ones.
> 
> However, this assumption is broken on 32-bit when code like
> hv_do_hypercall() in hyperv_init() would use the ratpoline speculation
> killer CALL_NOSPEC. The 32-bit version of that macro would align certain
> insns to 16 bytes, leading to the compiler issuing a one or more
> single-byte NOPs, depending on the holes it needs to fill for alignment.

Who again insisted that wouldn't happen? :-)

> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 6974b5174495..7baf13b11952 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -182,42 +182,68 @@ recompute_jump(struct alt_instr *a, u8 *orig_insn, u8 *repl_insn, u8 *insn_buff)
>  		n_dspl, (unsigned long)orig_insn + n_dspl + repl_len);
>  }
>  
> +/*
> + * @instr: instruction byte stream
> + * @instrlen: length of the above
> + * @off: offset within @instr where the first NOP has been detected
> + */

That's almost a proper comment, might as well finish it

/*
 * optimize_nops_range() - Optimize a sequence of single byte NOPs (0x90)
 * @instr: instruction byte stream
 * @instrlen: length of the above
 * @off: offset within @instr where the first NOP has been detected
 *
 * Return: number of NOPs found (and replaced)
 */
> +static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
> +{
> +	unsigned long flags;
> +	int i = off, nnops;
> +
> +	while (i < instrlen) {
> +		if (instr[i] != 0x90)
> +			break;
> +
> +		i++;
> +	}

	for (; i < instrlen && instr[i] == 0x90; i++)
		;

perhaps? (possibly too dense, up to you)

> +
> +	nnops = i - off;
> +
> +	if (nnops <= 1)
> +		return nnops;

!nnops would be an error, no?

> +
> +	local_irq_save(flags);
> +	add_nops(instr + off, nnops);
> +	local_irq_restore(flags);
> +
> +	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ",
> +		   instr, off, i);
> +
> +	return nnops;
> +}
> +
> +

We really needs that extra line?

>  /*
>   * "noinline" to cause control flow change and thus invalidate I$ and
>   * cause refetch after modification.
>   */
>  static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
>  {
>  	struct insn insn;
> +	int i = 0;
>  
>  	/*
> +	 * Jump over the non-NOP insns and optimize single-byte NOPs into bigger
> +	 * ones.
>  	 */
>  	for (;;) {
>  		if (insn_decode_kernel(&insn, &instr[i]))
>  			return;
>  
> +		/*
> +		 * See if this and any potentially following NOPs can be
> +		 * optimized.
> +		 */
>  		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
> +			i += optimize_nops_range(instr, a->instrlen, i);
> +		else
> +			i += insn.length;
>  
> +		if (i >= a->instrlen)
>  			return;
>  	}
>  }

Anyway, irrespective of nits:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
