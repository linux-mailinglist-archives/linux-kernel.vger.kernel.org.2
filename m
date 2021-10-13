Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C980842CC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJMVMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhJMVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:12:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nOoPk2cAolMDPwIBVs+JEzAUAlzUwXEINvXNt3/AeBY=; b=o6wHonNXZ0IwplN4hFRx8wgu7C
        95VW/N5iaODhWGDM3F4QB6eAt/P2zrl/dbBjluG7zcsg627yv6eXN80rPHp/9tRuctLXI+mTNEJi+
        jSxfqxJiqEOs5f3fTi6wDT76yYqoXB5Fnf48boellZaKRxDK+RRMDH+oQu/5KpNkUyzW8QY/4R+A9
        J8ICkcwVIXRSsmJNayAp0l0YjZI82SICJDwPrwAeb9ZM0UP9Mq65b87GsjriG/cpPovW1hF5IoMVq
        GS9/RpDMfSdZJd+r2D8Vjcq2OQCQUfriNUPMF3Dmsp2XPm4mSNn7UowJ51fFLBAcoFKdl0D13ua04
        FQ/WaVzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1malUI-007o2g-0z; Wed, 13 Oct 2021 21:08:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2138F30030B;
        Wed, 13 Oct 2021 23:08:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A93E2D2782EA; Wed, 13 Oct 2021 23:08:34 +0200 (CEST)
Date:   Wed, 13 Oct 2021 23:08:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH 5/9] x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
Message-ID: <YWdK0nOWsj+At8IJ@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.119101107@infradead.org>
 <CAKwvOd=4s70S9irWGV94u2AoyQyo67XZ9tU12cdhf=6879gA+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=4s70S9irWGV94u2AoyQyo67XZ9tU12cdhf=6879gA+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:11:45PM -0700, Nick Desaulniers wrote:

> > +       /*
> > +        * Convert:
> > +        *
> > +        *   Jcc.d32 __x86_indirect_thunk_\reg
> > +        *
> > +        * into:
> > +        *
> > +        *   Jncc.d8 1f
> > +        *   jmp *%\reg
> > +        *   nop
> > +        * 1:
> > +        */
> > +       if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
> > +               cc = insn->opcode.bytes[1] & 0xf;
> > +               cc ^= 1; /* invert condition */
> > +
> > +               bytes[i++] = 0x70 + cc; /* Jcc.d8 */
> > +               bytes[i++] = insn->length - 2;
> 
> Isn't `insn->length - 2` always 4 (in this case)? We could avoid
> computing that at runtime I suspect if we just hardcoded it.

Yeah, but I found this to be more expressive. The purpose is getting to
the next instruction.

Also, if clang ever does instruction stuffing to hit alignment targets
without extra nops (ISTR reading about such passes) this logic still
works.

That is, I think you can prefix this with REX.W just to make a longer
instruction.

> Either way, I've looked at the disassembly enough that this LGTM.
> Thanks for the patch.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!
