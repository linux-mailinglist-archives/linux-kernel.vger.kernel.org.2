Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE683FBEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhH3WCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:02:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhH3WCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:02:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630360896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nmaQ9EYP/RanOcLyCAKUVbgRCdBpSu5eePr9qPV/r/Q=;
        b=N5/OS1oP5Svn4voy7opArs0XjL1bUuHxvTnlbIbX2T5UjcrgTJ9w6s8tM7+Ow7Qh36l6zt
        oE5Fst5Cv7GFxbffdk4Wtlb63c6iqcaRO8aI2SfFUX9Ek7idrpQ2v+MWqnG9Jjuh+HYUmL
        bThR0+yLh9+JeoGYJeVnOTEW0EItn6Z9BWRUpoy6ZmXXlDXD16Ugd5HhjVmlZG8hk0khS7
        ecRitnK9oz/GBpN96GqfXXCgQ5EHuY829jSB9mdJXH+QRiTeqAh7zrK+sxpn++aQpiny6B
        DAmQROfqq+SgrgJabQzlqp5VckPyVF0Xe0N79y7jhckyTAqsTd0DVh47YjeqrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630360896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nmaQ9EYP/RanOcLyCAKUVbgRCdBpSu5eePr9qPV/r/Q=;
        b=Y5MLms6tTE9Dd1U41LWFW9aMtzgoYj6puIht9IkGsxxBEOS2+O8dUQEBoqHHdi1bx1h1Lc
        JG0AZKs4qakw41Ag==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
Date:   Tue, 31 Aug 2021 00:01:35 +0200
Message-ID: <87r1eafv7k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 14:26, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 2:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Incidentally, why do we bother with negation in those?  Why not have
>> user_insn(), XSTATE_OP() and kernel_insn_err() return 0 or trap
>> number...

Correct.

> I really wish we didn't have that odd _ASM_EXTABLE_FAULT/
> ex_handler_fault() special case at all.
>
> It's *very* confusing, and it actually seems to be mis-used. It looks
> like the "copy_mc_fragile" code uses it by mistake, and doesn't
> actually want that "modify %%rax" behavior of that exception handler
> AT ALL.
>
> If I read that code correctly, it almost by mistake doesn't actually
> care, and will overwrite %%rax with the right result, but it doesn't
> look like the "fault code in %eax" was ever *intentional*. There's no
> mention of it.
>
> Maybe I'm misreading that code, but I look at it and just go "Whaa?"

Ooops. I never looked at that usage site. It indeed does not make use of
that information. The original __mcsafe_copy() made use of it, but that
got removed/replaced long ago.

The other user is SGX which actually uses the trap number in EAX for
failure analysis.

> The code in user_insn() clearly *does* use that fault number (and, as
> you say, inverts it for some reason), but I wonder how much it really
> cares? Could we get rid of it, and just set a fixed error code?
>
> I only checked one user, but that one didn't actually care which fault
> it was, it only cared about fault-vs-no-fault.

The usage sites of user_insn() and XSTATE_OP() need to distinguish:

   - success
   - fail due to #PF (which can be tried to handle)
   - fail due to some other exception (#GP, #MC)

I found that _ASM_EXTABLE_FAULT() mechanism pretty conveniant for this
and the negation was just me being lazy after I discovered that
X86_TRAP_PF == EFAULT. It turned out not to be a brilliant idea, but at
the time it looked great...

So yes, the negation does not matter, but the ability to check whether
the fail was caused by #PF or not matters.

Thanks,

        tglx
