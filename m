Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAF42DC94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhJNPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhJNO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:59:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F5C06176F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uV6FqAySkq0fw+LoaMC3+vLHeLtfLChMwIjSAQi2V7k=; b=GsJDRyhNDvmciem0gz45aUYSgY
        6m/m3RXrMqaCv4TSd3HkrdgvqbraRJGIKOaqsNRJp6/BRrLD2Iv4EvvgwsBF9KnX43tjdYneLRyWL
        zvMhbxnBWO4/lQJ33pyMRVyDlLiLElozudMGMG/U6Gbh7lANVFp6I4n0ZVp2/13Rta/9LX5IoFtGW
        w73NUtm+jWhIVgeCfsrlu6sOwjjMJJTxWIbOukzg/FF842fkn6wYz+RBot0zatgpV/lIrqWGFQjuB
        MoKOjIJP/o8/623pjA+gzXTAgcoHMmlfiREtSDW5EW/+d4geUAxJMtKQjLMyLMvFmTb7leEF06xS2
        lFdOwa6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb29W-009qsw-0i; Thu, 14 Oct 2021 14:56:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EF3930030B;
        Thu, 14 Oct 2021 16:56:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F38DA2CF42A2D; Thu, 14 Oct 2021 16:56:11 +0200 (CEST)
Date:   Thu, 14 Oct 2021 16:56:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: [RFC] crypto/sm4: Fix objtool/libelf warning
Message-ID: <YWhFC6AMutE+a1oK@hirez.programming.kicks-ass.net>
References: <20211007202204.GT174703@worktop.programming.kicks-ass.net>
 <8e35ba6d-f876-4726-a8e7-a0d80b0186f2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e35ba6d-f876-4726-a8e7-a0d80b0186f2@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 06:29:55PM +0800, Tianjia Zhang wrote:
> Hi Peter,
> 
> On 10/8/21 4:22 AM, Peter Zijlstra wrote:
> > Hi,
> > 
> > objtool is yielding the obscure libelf warning:
> > 
> >    vmlinux.o: warning: objtool: elf_update: invalid section entry size
> > 
> > Which I tracked down to section:
> > 
> >    [3023] .rodata.cst164    PROGBITS        0000000000000000 1ab501e0 000154 a4  AM  0   0 16
> > 
> > Which has a section size of 0x154 (340) and an entry size of 0xa4 (164).
> > An obvious mis-match.
> > 
> >  From there, git-grep quickly yields:
> > 
> >    arch/x86/crypto/sm4-aesni-avx-asm_64.S:.section .rodata.cst164, "aM", @progbits, 164
> >    arch/x86/crypto/sm4-aesni-avx2-asm_64.S:.section        .rodata.cst164, "aM", @progbits, 164
> > 
> > So those files create this .rodata section with an explicit entry size,
> > but then don't respect it themselves. Removing the entry size makes the
> > warning go away, but I can't tell if that's right or not, given there is
> > zero clue as to why that entry size was specified to begin with.
> > 
> > Please explain...
> > 
> > ---
> > diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> > index 18d2f5199194..d089cccf4db7 100644
> > --- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> > +++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> > @@ -78,7 +78,7 @@
> >   	vpxor tmp0, x, x;
> > -.section	.rodata.cst164, "aM", @progbits, 164
> > +.section	.rodata.cst164, "aM", @progbits
> >   .align 16
> >   /*
> > diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
> > index d2ffd7f76ee2..a0f7541c2246 100644
> > --- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
> > +++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
> > @@ -93,7 +93,7 @@
> >   	vpxor tmp0, x, x;
> > -.section	.rodata.cst164, "aM", @progbits, 164
> > +.section	.rodata.cst164, "aM", @progbits
> >   .align 16
> >   /*
> > 
> 
> Thanks for pointing it out, We have also reproduced this error. If the M
> flag is specified, the entry_size argument is required. 

Correct.

> We also need to
> consider the clang compiler. This requires a more thorough method to fix it.
> I will post another patch later.

If the purpose is to share the whole section, such that there is only a
single copy of those tables between the two sm4 implementations, then
you need to set the entry size to the total size of the section.

Otoh, almost every entry (with exception of the very last one) seems to
be 16 bytes, so you might just get away with setting the entry size to
16.

Given this is only a very small data table, why the need to share? Any
one machine will only use a single one of these implementations at any
one time.
