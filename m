Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D935C96C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbhDLPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:08:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237526AbhDLPIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:08:46 -0400
Received: from zn.tnic (p200300ec2f052100b992cfc3eab27929.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2100:b992:cfc3:eab2:7929])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F7B51EC0249;
        Mon, 12 Apr 2021 17:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618240105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MerdwYZHv9X7XzBa8kEPrV7U0nq5j/1focuz0dTDD9Q=;
        b=cx1Swk17PXnXih63cbor4U4n3xX+AHAM+rNWd3fRiakUGd0nO4mAeoiIjYrvBmANJXs3me
        tybcoA1fRJNXe2VA8Kb3z94eQIyr6SIIIZj2nzVO0FsVeap4Du5kKvlH1mu0xKzvmC1Jc/
        ttqvfipF5QjY16i/XCc5PHnOKH/j45s=
Date:   Mon, 12 Apr 2021 17:08:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210412150824.GF24283@zn.tnic>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
 <20210412143139.GE24283@zn.tnic>
 <878s5nk1pk.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878s5nk1pk.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:38:15PM +0200, Florian Weimer wrote:
> Yes, that's why we have the XGETBV handshake.  I was imprecise.  It's
> CPUID + XGETBV of course.  Or even AT_HWCAP2 (for FSGSBASE).

Ok, that sounds better. So looking at glibc sources, I see something
like this:

init_cpu_features
|-> update_usable
 |-> CPU_FEATURE_SET_USABLE (cpu_features, XGETBV_ECX_1);

so I'm guessing this happens when the library gets loaded per process,
right?

Which means, once the detection has taken place and the library has
gotten XCR0, it is going to use it and won't re-ask the kernel or so?

I.e., I'm trying to imagine how a per-process thing would work at all.
If at all.

And this sounds especially "fun":

> Code that installs a signal handler often does not have control on
> which thread an asynchronous signal is delivered, or which code it
> interrupts.

In my simplistic approach I'm thinking about something along the lines
of:

Library: hey kernel, can you handle AVX512?
Kernel: yes
Library: ok, I will use that in the signal handler

And since kernel has said yes, kernel is going to take care of handling
AVX512 state and library can assume that.

All those old processes which cannot be recompiled, for them I guess the
kernel should have to say no.

Dunno how much sense that makes...

> > And the CPUID-faulting thing would solve stuff like that because then
> > the kernel can *actually* get involved into answering something where it
> > has a say in, too.
> 
> But why wouldn't we use a syscall or an entry in the auxiliary vector
> for that?  Why fault a potentially performance-critical instruction?

Oh sure, CPUID faulting was just an example. I think the intent is to
have this important aspect of userspace asking the kernel first what
kind of features it can handle and then do accordingly.

IOW, legacy stuff can work unchanged and new libraries and kernels can
support fancier features and bigger buffers.

Methinks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
