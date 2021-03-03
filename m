Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9132BE48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385422AbhCCRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbhCCNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:37:28 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7DAC061756;
        Wed,  3 Mar 2021 05:35:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id k2so21349243ili.4;
        Wed, 03 Mar 2021 05:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mV7nRo9kv0WrCbk6EB35RPWl6ztHgF0++Sk3e0IPNlQ=;
        b=S3WIXSMd0vYgP8x2TKmJaUpzTZXqu0MLdDnHWr4/YHOuEXK3Zuvqu5I0GowTo4oqcq
         rkKfMWGUPEOHqWa8tyzdksOwPjTSV5YEtQ/fii3MkU4fUV6YkTgIerwnnJqz7eax0s7F
         Tqv8VVMWseQIV/s5lhS0fwd4JqLvs2QB//j+KM83pQZcTnA7fgs09a0xVRmx4qkWoZps
         qckI6WkMBI9xnO4I8gIeWBl5mU4DB859imOARDnAPRKbCc/152L6EDGxoEvf0vBnPy3F
         c7/W4VmachPy3DONPG5gY02GYMvSzkeoYafOceGRjUOoOIZwA2vC7j6BNwlwhZUYx5z+
         v8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mV7nRo9kv0WrCbk6EB35RPWl6ztHgF0++Sk3e0IPNlQ=;
        b=AnmhNU6J/1rRIQkMxH50v1VGFb/JE7Uvx21lxyaL7jgAUQlUEe9LeprYQ+T/hSSUMv
         dVt/QQo/7shwrJF/QT4rBfZhnm+mx0XDcxMOHfD1jk1dbJSIqdiT4R4DdKPZQN985rQf
         4GQbKRSKDa3wDIuiyxj+mxFkDxI7PeixIU33t9jJ6vZwL1boLsxDDaS7CScO0bO6Jeet
         tvaTa07LDbz86v7Xf1bb3xP4DOWrpvhvqg68hu/SoT5MQ9cSC8+bywJen5jJtjOPfBm7
         0pr7vUpdqdGhFmlMRFB2xq6KmK77G/jcjGGMEkO1v6LQRSuPaDVU8v0qRy2QoePUCxuL
         kJtg==
X-Gm-Message-State: AOAM530SUQliJjeV7EDT1iwnkCddDWTvOvn/ZxfhgGjDlkdrWw/5RP2V
        3uzq9nswZpv3ERZJNvNAU17W+D+anhqzQNVWX48=
X-Google-Smtp-Source: ABdhPJyTyl/1Qw3XzoM1h1OdLOMXAzxSz+3zavg+xqvdVIZzQseXECYY8QdrHxUKbCcOkNZMBUjpd5cndWv+4sfjTn8=
X-Received: by 2002:a05:6e02:194e:: with SMTP id x14mr22584922ilu.218.1614778559248;
 Wed, 03 Mar 2021 05:35:59 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-2-git-send-email-dillon.minfei@gmail.com> <5284d390-c03a-4035-df5a-10d6cd60e47b@arm.com>
In-Reply-To: <5284d390-c03a-4035-df5a-10d6cd60e47b@arm.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 3 Mar 2021 21:35:23 +0800
Message-ID: <CAL9mu0KUhctbBzmem1ZSgEwf5CebivHOSUr9Q7VTyzib8pW=Cw@mail.gmail.com>
Subject: Re: [PATCH 1/8] ARM: ARMv7-M: Fix register restore corrupt after svc call
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Thanks for the review.

On Wed, Mar 3, 2021 at 5:52 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> On 3/3/21 8:05 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > For some case, kernel not boot by u-boot(single thread),
> > but by rtos , as most rtos use pendsv to do context switch.
>
>
> Hmm, does it mean that it starts kernel from process context?
   Yes, kernel might be started from process context, since u-boot not
switch context, so kernel always startup under msp.
>
> I'd assume that it is not only kernel who expects MSP. So, what
> if RTOS you mentioned want to boot other RTOS (even itself)? What
> if you have no access to the source code for those RTOS(es) to
> patch MSP/PSP switch?

My case is a little complicated.
stm32h7 only have 128Kbytes internal flash, can't store u-boot.bin (>200K),
so, set a bootloader (rt-thread rtos) to internal flash, load
linux/u-boot from serial port via ymodem
store to qspi flash(8Mbytes), then jump to u-boot.

qspi flash layout:
0 - 512K:    u-boot
512K- 8M : kernel(xip)

load process : rt-thread -> u-boot -> linux

before add psp/msp check after svc call, register restore corrupt.
add a printhex8 around svc call, found the sp stack is 0x24040000c0ffcff8
it should be 0xc0ffcdf8c0ffcff8. 0x24040000 is the sp stack address
assigned by u-boot
i've no idea how it's become to u-boot's sp.

I have the rtos code, and will try to fix it on the rtos side.

Can you give more explanation about why linux relies on MSP ? thanks

>
> I'd very much prefer to keep stack switching logic outside kernel,
> say, in some shim which RTOS/bootloader can maintain.
>
> Cheers
> Vladimir
>
> >
> > So, we need add an lr check after svc call, to find out should
> > use psp or msp. else register restore after svc call might be
> > corrupted.
> >
> > Fixes: b70cd406d7fe ("ARM: 8671/1: V7M: Preserve registers across switch from Thread to Handler mode")
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >  arch/arm/mm/proc-v7m.S | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> > index 84459c1d31b8..c93d2757312d 100644
> > --- a/arch/arm/mm/proc-v7m.S
> > +++ b/arch/arm/mm/proc-v7m.S
> > @@ -137,7 +137,10 @@ __v7m_setup_cont:
> >  1:   cpsid   i
> >       /* Calculate exc_ret */
> >       orr     r10, lr, #EXC_RET_THREADMODE_PROCESSSTACK
> > -     ldmia   sp, {r0-r3, r12}
> > +     tst     lr, #EXC_RET_STACK_MASK
> > +     mrsne   r4, psp
> > +     moveq   r4, sp
> > +     ldmia   r4!, {r0-r3, r12}
> >       str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
> >       mov     lr, r6                  @ restore LR
> >
> >
>
