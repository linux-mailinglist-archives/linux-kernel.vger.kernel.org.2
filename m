Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA73FE2E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbhIATXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:23:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhIATXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:23:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630524128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBCmjcjTBTxx9ykVeYLmxMCZDSv/m8f9PnMVU7TibpQ=;
        b=Nvj2zeETXqNARgng5/lMDdduwqgC3Kj665AwcVrHmxaf9nz6a/O13GIC5bjKPtf/zhAvN9
        bfjXGtsAaxy9HhcvSiwAntKdvcFFLpJYB71ZE5wV40I9eW9t2en//EvdfAR5SiQLVqOBY5
        rjTzrkVD8aYMenDR/gwdU6b01NylKzTrpI2JMeXJYmmtY/YiORUuba4ft3j9yFmBORUVaL
        ZeRk4lO/ycsyVF/omKkTFQ+9EEQAMtMT1U8YHkKUgjGX2i10AHdWR7H0Q1vJcLNypZFHA/
        DEqnIh+kuLCJmGj0cYw0ABP6YTaScR+KpSCczRN2nRUA6PKQLC/rc4vzDxpx2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630524128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBCmjcjTBTxx9ykVeYLmxMCZDSv/m8f9PnMVU7TibpQ=;
        b=uNxfoTzZ+JReZDrZJRi9qsMPaJm7uvIAT2RbOlW0kOyNAfTPhCMwPKsj+kidrBdEG9468Q
        Kqk686QWuc/MFqCQ==
To:     Sean Christopherson <seanjc@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <YS+upEmTfpZub3s9@google.com>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <87r1e8cxp5.ffs@tglx> <87o89ccmyu.ffs@tglx> <YS+upEmTfpZub3s9@google.com>
Date:   Wed, 01 Sep 2021 21:22:07 +0200
Message-ID: <87ilzkcd9c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

On Wed, Sep 01 2021 at 16:47, Sean Christopherson wrote:
> On Wed, Sep 01, 2021, Thomas Gleixner wrote:
>> Though while for the FPU use case we really want to handle the #MC case,
>> it's not clear to me whether this is actually correct for SGX.
>> 
>> Jarkko, Sean, Dave?
>
> Are you asking about #MC specifically, or about SGX consuming the trap number in
> general?

#MC

> For #MC, it's probably a moot point because #MC on ENCLS is not recoverable for
> current hardware.  If #MC somehow occurs on ENCLS and doesn't kill the platform,
> "handling" the #MC in SGX is probably wrong.  Note, Tony is working on a series to
> support recoverable #MC on SGX stuff on future hardware[*], but I'm not sure that's
> relevant to this discussion.

Probably not.

> As for SGX consuming the trap number in general, it's correct.  For non-KVM usage,
> it's nice to have but not strictly necessary.  Any fault except #PF on ENCLS is
> guaranteed to be a kernel or hardware bug; SGX uses the trap number to WARN on a
> !#PF exception, e.g. on #GP or #UD.  Not having the trap number would mean losing
> those sanity checks, which have been useful in the past.
>
> For virtualizing SGX, KVM needs the trap number so that it can inject the correct
> exception into the guest, e.g. if the guest violates the ENCLS concurrency rules
> it should get a #GP, whereas a EPCM violation should #PF.

Yes, I understood that part, but I was confused about the #MC part.

Thanks for clarifying!

       tglx
