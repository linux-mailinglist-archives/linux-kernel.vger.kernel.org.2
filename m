Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BE942CD24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJMV5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhJMV5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:57:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE6C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TAQPbKdTK+XYzzbBsKuM4PTBNyN7lbgkmAhmeIQrqj4=; b=m3A45t3czX7FZVgI4mk/dxamYd
        9Lzol0m0NMAp8m2SmOETD2F+6eFaYLevuvQKVfzwYzyjERZFJo6xZXS5LBX1zWc2Pxb4UCcIM16ah
        tMChxDzE+7wtnxu6WOEoHJnaxFppiriQH4U7auD0F4mz2O1daJqYhibq0721eafqEY+cJtJ5WObV7
        1v7vVU+bprJKUI/tTYX7d8Nb9TDA14HPxNWIqW+qx9ccV1uzqVKnFaG44n/5ySXULp1ylegezThrG
        +pkTVmBlP4C8ClkJwYTkn1BQevvCaJOIrivBzOf3z/skTFKFqhFchGIvT0ZUi4lYfIVKSXwwx8off
        XGM2K99Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mamD6-009gDu-3A; Wed, 13 Oct 2021 21:54:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A426300252;
        Wed, 13 Oct 2021 23:54:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A89C212B3C68; Wed, 13 Oct 2021 23:54:51 +0200 (CEST)
Date:   Wed, 13 Oct 2021 23:54:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 9/9] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YWdVq8UWpvMwnzht@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.706163435@infradead.org>
 <20211013210605.bz6l7o5xzik5ckga@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013210605.bz6l7o5xzik5ckga@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:06:05PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 02:22:26PM +0200, Peter Zijlstra wrote:
> > Current BPF codegen doesn't respect X86_FEATURE_RETPOLINE* flags and
> > unconditionally emits a thunk call, this is sub-optimal and doesn't
> > match the regular, compiler generated, code.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c |   18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2123,14 +2123,18 @@ static int emit_fallback_jump(u8 **pprog
> >  	int err = 0;
> >  
> >  #ifdef CONFIG_RETPOLINE
> > -	/* Note that this assumes the the compiler uses external
> > -	 * thunks for indirect calls. Both clang and GCC use the same
> > -	 * naming convention for external thunks.
> > -	 */
> > -	err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
> > -#else
> > -	EMIT2(0xFF, 0xE2);	/* jmp rdx */
> > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> > +		if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
> > +			/* The AMD retpoline can be easily emitted inline. */
> > +			EMIT3(0x0F, 0xAE, 0xE8);	/* lfence */
> > +			EMIT2(0xFF, 0xE2);		/* jmp rdx */
> > +		} else {
> > +			/* Call the retpoline thunk */
> > +			err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
> > +		}
> > +	} else
> >  #endif
> > +	EMIT2(0xFF, 0xE2);	/* jmp rdx */
> 
> But the rest of eBPF JIT just emits retpolines unconditionally
> regardless of feature, for example see RETPOLINE_RCX_BPF_JIT().  So I'm
> thinking this should probably be consistent with that (or that with
> this).

Argh, I grepped for __x86_indirect_thunk, and missed they're writing
retpolines themselves. Bah.

Yes, that needs cleaning up. I'll go prod at that tomorrow.
