Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA03FD91F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbhIAMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:01:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhIAMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:01:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630497638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ec6i1ImQPN/gGXkxwwOBw07led3jlYRO29psKqExgSE=;
        b=bX0kysSkASE+VEfRldzdBNQKDHqqxG3gdulfljZ4vn028eUOcaIK1MlWCsD9j7V3eSAbbT
        GFgolGGTTmmaaZqrLZGHio2inBrhGH86Nwt9NdU5vFDOjF0Kp6d30LtNhyNFrdQNzRXT7Z
        3ABsQT/D4kn1oUVJS9FfLErkwvtAwhjjiX1jzrnCSNSZ0RYuidffrHXbNQs6Qvuatcgcz8
        CbUMtTOERv1oQIsqiO0IzLIiDs9A35vCvRq7qkVE+Ij/PxZCMK2RKTjYRKEJeagZ3CV/ec
        PQj7uUnowqwT0joXGejfvIk52euPMnJYkV3vVG2MykEBeV+w9Vi1Ea6vEIoa6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630497638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ec6i1ImQPN/gGXkxwwOBw07led3jlYRO29psKqExgSE=;
        b=lqzIAUwbsrBu89Qg0alzVOhCGiHYSjq2X4dyOF9IsC8HuIGvLdO1l7PRiW6TL6QQNj67K3
        20FEYEal9jPsyVBQ==
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
Date:   Wed, 01 Sep 2021 14:00:38 +0200
Message-ID: <87r1e8cxp5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 14:26, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 2:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Incidentally, why do we bother with negation in those?  Why not have
>> user_insn(), XSTATE_OP() and kernel_insn_err() return 0 or trap number...
>
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

It took me a while to figure out why this is actually using that
specific fault handler. And yes, I had a major "Whaa?" moment as well.

ASM_EXTABLE_FAULT() was introduced with commit

  548acf19234d ("x86/mm: Expand the exception table logic to allow new handling options")

blessed by a guy named Torvalds :)

commit 92b0729c34ca ("x86/mm, x86/mce: Add memcpy_mcsafe()") made use of
this and it actually did not use the trap number either:

+       .section .fixup, "ax"
+       /* Return false for any failure */
+.L_memcpy_mcsafe_fail:
+       mov     $1, %rax
+       ret

commit b2f9d678e28c ("x86/mce: Check for faults tagged in
EXTABLE_CLASS_FAULT exception table entries") made use of this in MCE to
allow in kernel recovery. The only thing it uses is checking the
exception handler type.

Bah. I'll fix that up to make that less obscure.

The remaining two use cases (SGX and FPU) make use of the stored trap
number.

Thanks,

        tglx
