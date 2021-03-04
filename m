Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85A32CC1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 06:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhCDFny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 00:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhCDFnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:43:47 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BF0C061574;
        Wed,  3 Mar 2021 21:43:07 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z13so28459477iox.8;
        Wed, 03 Mar 2021 21:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+Oav42c1HOCCRMgaozVb9Gm8OFZUHNfLbYCK2+bU1w=;
        b=XIG2QobFS1KqxGmKjapup5ZoCxXETYCmErSLolTk7Hcog7ZhSw8W3I6DBZqX3o6+RU
         vxgWHyb+lLuEi5kNWGS/SVduSgZfN9dZqTCXV2BP9pJMKqAX7rcvW9kuPA//Rs2zExy6
         4gb5urKkrKfJSoVjGaWLBO5ZAyEU7ouR4qzjCGMrxryDD+FkonY782t8A5RB4nLxts4N
         OSaXjl7K3fBWxulpbTOJ90Eb621pKfI2Njs6ZWgsf5S49szaZVvlKkkrjmhwn+3cp0Nd
         Y0Z8+uHX53CC6O8PgDRS6KedKX9i+70YOJQCJkHhjChjaFF/jV0V79glvc84PGTxtiRH
         LFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+Oav42c1HOCCRMgaozVb9Gm8OFZUHNfLbYCK2+bU1w=;
        b=n7D7ZMf97q1B1GKpTbt/75NmuUWYddlymLI4fwY5eT+Qawcs+L4VyNtHooj9nRA4EB
         m3mK8VJrvEyZ+ZrYvGX+Z+jDFVeqTSjD0tfry2JFvvuLejSEs9juTQz0+kSk49/MSlwi
         x8PF7UCirGjEAcoWy9AfIQKsgymxtzhtE+L1IFBLpkN4O5+UZutMv9b/rGrI59zfZqz9
         QWYiHQ4KT31zmCqxSDD7O0z28Z+R8yAyayOXR1u+8JXFQvw5qyQxxjsoBXRkehycl0VE
         BzqbkDbtBh63j8PW3H3HKUjYxFuntzqqGj45XYt8h0kIw9sMXHFqz1nQMplpKA8eI9A/
         wHgg==
X-Gm-Message-State: AOAM530tU4YTqPYA/IoVYgR4ihdIC6siM4c5SycihPKgBFU782MSKkE6
        eaFHn5/u+QRB3XgGAjyUuJwZgSvXI1d6DafMJfgCsnVNbmc=
X-Google-Smtp-Source: ABdhPJyOqaEjluM4fpjA/jSUFcjs5N4iiwvyANhz3BbXknSEZx5uEIr07uovuUygdxM372Ed1UJ4CcqqjBDtrX4KOGw=
X-Received: by 2002:a05:6638:e93:: with SMTP id p19mr2578361jas.10.1614836586605;
 Wed, 03 Mar 2021 21:43:06 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-2-git-send-email-dillon.minfei@gmail.com>
 <5284d390-c03a-4035-df5a-10d6cd60e47b@arm.com> <CAL9mu0KUhctbBzmem1ZSgEwf5CebivHOSUr9Q7VTyzib8pW=Cw@mail.gmail.com>
 <5efe3d44-8045-e376-003e-3ccbff54fb23@arm.com>
In-Reply-To: <5efe3d44-8045-e376-003e-3ccbff54fb23@arm.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 4 Mar 2021 13:42:30 +0800
Message-ID: <CAL9mu0JoHqo_wnpNN9ZqRnzzKjhOwEktZ5yPtO8-6WBh51g1BQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 10:19 PM Vladimir Murzin <vladimir.murzin@arm.com> w=
rote:
>
> On 3/3/21 1:35 PM, dillon min wrote:
> > Hi Vladimir,
> >
> > Thanks for the review.
> >
> > On Wed, Mar 3, 2021 at 5:52 PM Vladimir Murzin <vladimir.murzin@arm.com=
> wrote:
> >>
> >> On 3/3/21 8:05 AM, dillon.minfei@gmail.com wrote:
> >>> From: dillon min <dillon.minfei@gmail.com>
> >>>
> >>> For some case, kernel not boot by u-boot(single thread),
> >>> but by rtos , as most rtos use pendsv to do context switch.
> >>
> >>
> >> Hmm, does it mean that it starts kernel from process context?
> >    Yes, kernel might be started from process context, since u-boot not
> > switch context, so kernel always startup under msp.
> >>
> >> I'd assume that it is not only kernel who expects MSP. So, what
> >> if RTOS you mentioned want to boot other RTOS (even itself)? What
> >> if you have no access to the source code for those RTOS(es) to
> >> patch MSP/PSP switch?
> >
> > My case is a little complicated.
> > stm32h7 only have 128Kbytes internal flash, can't store u-boot.bin (>20=
0K),
> > so, set a bootloader (rt-thread rtos) to internal flash, load
> > linux/u-boot from serial port via ymodem
> > store to qspi flash(8Mbytes), then jump to u-boot.
> >
> > qspi flash layout:
> > 0 - 512K:    u-boot
> > 512K- 8M : kernel(xip)
> >
> > load process : rt-thread -> u-boot -> linux
> >
> > before add psp/msp check after svc call, register restore corrupt.
> > add a printhex8 around svc call, found the sp stack is 0x24040000c0ffcf=
f8
> > it should be 0xc0ffcdf8c0ffcff8. 0x24040000 is the sp stack address
> > assigned by u-boot
> > i've no idea how it's become to u-boot's sp.
> >
> > I have the rtos code, and will try to fix it on the rtos side.
>
> That would be great!
>
> >
> > Can you give more explanation about why linux relies on MSP ? thanks
>
> MSP is what set from boot, thus it is natural assumption that boot code
> would preserve that illusion.
>
> I'd guess that kernel is in line in such assumption across different
> (RT)OS capable to run on M-class cores (please, note that some variants
> might not have two stack pointers)
>
Okay=EF=BC=8C got it. after adding msp/psp switch code in RTOS, now the ker=
nel
can be loaded normally
without any modification.

So, just drop the changes in proc-v7m.S.

Thanks.
> Cheers
> Vladimir
>
> >
> >>
> >> I'd very much prefer to keep stack switching logic outside kernel,
> >> say, in some shim which RTOS/bootloader can maintain.
> >>
> >> Cheers
> >> Vladimir
> >>
> >>>
> >>> So, we need add an lr check after svc call, to find out should
> >>> use psp or msp. else register restore after svc call might be
> >>> corrupted.
> >>>
> >>> Fixes: b70cd406d7fe ("ARM: 8671/1: V7M: Preserve registers across swi=
tch from Thread to Handler mode")
> >>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> >>> ---
> >>>  arch/arm/mm/proc-v7m.S | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> >>> index 84459c1d31b8..c93d2757312d 100644
> >>> --- a/arch/arm/mm/proc-v7m.S
> >>> +++ b/arch/arm/mm/proc-v7m.S
> >>> @@ -137,7 +137,10 @@ __v7m_setup_cont:
> >>>  1:   cpsid   i
> >>>       /* Calculate exc_ret */
> >>>       orr     r10, lr, #EXC_RET_THREADMODE_PROCESSSTACK
> >>> -     ldmia   sp, {r0-r3, r12}
> >>> +     tst     lr, #EXC_RET_STACK_MASK
> >>> +     mrsne   r4, psp
> >>> +     moveq   r4, sp
> >>> +     ldmia   r4!, {r0-r3, r12}
> >>>       str     r5, [r12, #11 * 4]      @ restore the original SVC vect=
or entry
> >>>       mov     lr, r6                  @ restore LR
> >>>
> >>>
> >>
> >
>
