Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC042D66C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJNJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:52:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D92C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C5nkd01YLTlf7v89BaQCa2Vx27CtYGym5ql5OHtCf9E=; b=L+Hh+/Pkw+yWZryYkDXLimrEwJ
        EUeCh1j4sbu1Pf0zM5gWWF+gBr7LT3ySXqHYHUDdOva8+LBmDc3qDMFMRFra5eVEB8ej2x9asa/bJ
        x+0a8RyksElKfDV1OLMZBcKYW7vlLIQJEFtU1Qsf4RrIE0HxdAuQMFic2iyxZboYbo2yUiRjy/2tb
        d/KTdLDkSLDQ+QR0G1R+Rife4gl+D9Dhz8XKy/ibTSoNRXpy1SSIJU22PGrMLET8Pm3d1rDG1uvZ3
        JPJ9FIrTLkfJg0uDtx9T5+gVsgOXADoLZqNL/z376AoLarbUQQjCwlXD3iVCouG58AQMR75WX0nu7
        vYiBBINw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maxM2-008EWc-Pc; Thu, 14 Oct 2021 09:49:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC1CA3001C0;
        Thu, 14 Oct 2021 11:48:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3FD82D6E98E3; Thu, 14 Oct 2021 11:48:50 +0200 (CEST)
Date:   Thu, 14 Oct 2021 11:48:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 9/9] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YWf9Aje1F06vD5O6@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.706163435@infradead.org>
 <20211013210605.bz6l7o5xzik5ckga@treble>
 <YWdVq8UWpvMwnzht@hirez.programming.kicks-ass.net>
 <YWf8Yy2e9n+/veEe@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWf8Yy2e9n+/veEe@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:46:11AM +0200, Peter Zijlstra wrote:
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -396,6 +396,37 @@ static int get_pop_bytes(bool *callee_re
>  	return bytes;
>  }
>  
> +#define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
> +
> +#ifdef CONFIG_RETPOLINE
> +#define INDIRECT_SIZE (5)

Bah, that should be:

#define INDIRECT_SIZE	(2 + 3*cpu_feature_enabled(X86_FEATURE_RETPOLINE))

> +#else
> +#define INDIRECT_SIZE (2)
> +#endif
> +
> +static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> +{
> +	static const void *reg_thunk[] = {
> +#undef GEN
> +#define GEN(reg) __x86_indirect_thunk_ ## reg,
> +#include <asm/GEN-for-each-reg.h>
> +	};
> +
> +	u8 *prog = *pprog;
> +
> +#ifdef CONFIG_RETPOLINE
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
> +		EMIT_LFENCE();
> +		EMIT2(0xFF, 0xE0 + reg);
> +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> +		emit_jump(&prog, reg_thunk[reg], ip);
> +	} else
> +#endif
> +	EMIT2(0xFF, 0xE0 + reg);
> +
> +	*pprog = prog;
> +}
