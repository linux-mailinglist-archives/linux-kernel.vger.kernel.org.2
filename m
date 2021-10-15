Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2842F984
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbhJORCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbhJORCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:02:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BAfNBN8URhyP72a4qvxS6wQ+QWtB4yuONqxLBe7hw1k=; b=eAm7eFoIm1yDIu5xxzP2xBHCLW
        3bVjgc8tdfS6UwzXnL6Ko0weNSQpuor+hVlyI3jEkpAtlWct98GnfhW0eN4DD+s7SSQQ5KeZJaJkw
        uHd9IJCatGPiCtDBvxE1tRCbpqR8UrJlP4dRIu1mXO4MjrpLe8dF/UbDvduUhDOD0TB5CZlWupDwA
        O3Z0ee3kHw/Dw1wU81ztGYr1r5lVY0ao/wvnwLtDForsrecLkeTvWTT3o0rJwf2qfzKAcXO+u07Ra
        zbvZHL0CXKh5HEtm/OMn2HQiv9YCGqiVNOqwFmh3Kp01y8bC9/vrm7MGQpY0iXCLP35RWPQUoh3I0
        qomBZIAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbQVX-0098xn-Rj; Fri, 15 Oct 2021 16:57:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 113609857C7; Fri, 15 Oct 2021 18:56:36 +0200 (CEST)
Date:   Fri, 15 Oct 2021 18:56:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211015165635.GH174703@worktop.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <YWmPCF+g+sF4+ieh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWmPCF+g+sF4+ieh@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:24:08PM +0200, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
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
> I guess you should compute those values once so that it doesn't have to
> do them for each function invocation. And it does them here when I look
> at the asm it generates.

Takes away the simplicity of the thing. It can't know these values at
compile time (due to external symbols etc..) although I suppose LTO
might be able to fix that.

Other than that, the above is the trivial form of reverse indexing an
array.

> > +
> > +	if (WARN_ON_ONCE(reg & ~0xf))
> > +		return -1;
> 
> Sanity-checking the alignment of those thunks?

Nah, the target address of the instruction; if that's not a retpoline
thunk (for whatever raisin) then the computation will not result in a
valid reg and we should bail.

> > +
> > +	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
> > +	if (i < 0)
> > +		return i;
> > +
> > +	for (; i < insn->length;)
> > +		bytes[i++] = BYTES_NOP1;
> 
> Why not:
> 
>         nop_len = insn->length - i;
>         if (nop_len) {
>                 memcpy(&bytes[i], x86_nops[nop_len], nop_len);
>                 i += nop_len;
>         }
> 
> and then you save yourself the optimize_nops() call because it'll take
> the right-sized NOP directly.

That's not immediately safe; if for some reason or other the original
instrucion is 15 bytes long, and we generated 2 bytes, then we need 13
nop bytes, the above will then do an out-of-bound array access (due to
the nops array only doing 8 byte nops at max).

I wanted this code to be simple and obvious.
