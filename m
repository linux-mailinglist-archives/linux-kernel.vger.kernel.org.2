Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C438942C491
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhJMPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:14:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28042C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rrv5JZn1uLPYidbThlkuK/7xoe7HZCMyhAzWQgfjz1c=; b=Mnu0SSiCXmIgDP94Mi2O/A3dNm
        NKCPXU+y0EbZQFaeQGbos6zteTNVz9VMow0keOHMeNZljVgRCeSzvknLjfYMhc35YCb034VDoLAhv
        lM5iP3HzK0ThQ69Pb6hmR3+BaAtmxcOEDspzRwryNTMMoesw8ON1lFJ2zMh9SA07n4hkcboe2NG1a
        ZiEdw1Z3JfcWjN9JN7wB11ebGq2vyFCDapdtns+uFqNVqidxKuv1fmR509vXNNJG7wMLGb42Bb8M5
        bPR1scsyxtUuFC+rERwqbVYAEaFe62bymxqxL+uEck3R8ljXx7zAe9Fo+XNOKu03QZa0T905TOHH8
        pCSutb6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mafvS-009d7o-3k; Wed, 13 Oct 2021 15:12:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5612730026A;
        Wed, 13 Oct 2021 17:12:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43586207EF0DE; Wed, 13 Oct 2021 17:12:13 +0200 (CEST)
Date:   Wed, 13 Oct 2021 17:12:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWb3TdmyPK7GwBP4@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <98fdd068-d1c3-1f8c-18b7-13c3909ed9ca@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fdd068-d1c3-1f8c-18b7-13c3909ed9ca@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:38:27PM +0100, Andrew Cooper wrote:
> On 13/10/2021 13:22, Peter Zijlstra wrote:
> > +/*
> > + * Rewrite the compiler generated retpoline thunk calls.
> > + *
> > + * For spectre_v2=off (!X86_FEATURE_RETPOLINE), rewrite them into immediate
> > + * indirect instructions, avoiding the extra indirection.
> > + *
> > + * For example, convert:
> > + *
> > + *   CALL __x86_indirect_thunk_\reg
> > + *
> > + * into:
> > + *
> > + *   CALL *%\reg
> > + *
> > + */
> > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > +{
> > +	void (*target)(void);
> > +	int reg, i = 0;
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > +		return -1;
> > +
> > +	target = addr + insn->length + insn->immediate.value;
> > +	reg = (target - &__x86_indirect_thunk_rax) /
> > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> 
> This is equal measures beautiful and terrifying.

Thanks! :-)

> Something around here really wants to BUG_ON(reg == 4), because
> literally nothing good can come from selecting %rsp.

Ack, I had to add rsp to get the offsets right, but indeed, if anything
ever selects that we're in trouble.

> Also, it might be a good idea (previous patch perhaps) to have some
> linker assertions to confirm that the symbols are laid out safely to do
> this calculation.

I was hoping that since all this is in .S it would be immune from crazy
things like a compiler and do as told. But I suppose carzy stuff like
LTO (or worse BOLT) can totaly wreck this still (then BOLT won't care
about linker script assertions either).

I'll see if I can come up with something.
