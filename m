Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0A3D7928
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhG0O5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhG0O5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:57:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:57:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so2539400wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqFt2vhRpfIbTS1mg258ar/twtBzCyQEowAQHE3Yv28=;
        b=l7IZyi1LWdaDgWFaG0L+XzhR0wJ+YbJY7JZRQGhZ+nLJtE5XOQwN2N0qnsOWGi+5D4
         A4bPs6OH6KvuRAST3gJiFO2Sz/GklYvT6C9VQDvNnHwSSAnYC+jXPd4gkmlk1143SBmT
         z9IwO2ei0v8fCGc4/GMwwo//QgnZNjp6STzUxCMBhlMt7lqpzFhGnEBAFqWwvami4vzE
         /zy4dsp+ZbOj/6oN5idjEqqbWclOKGP6iIBEy29WZHo028MNJ+fz+O+ABPwGGWAAbkKt
         FQ5iwaixKgKzM81tnM/ReKqXEDdqH3s9EJH7lo/XsPYntF1xZzHeWqMJSWXcQRz/pyb/
         uajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqFt2vhRpfIbTS1mg258ar/twtBzCyQEowAQHE3Yv28=;
        b=YV+wlYg870Qgf+O6zGe6R2zbulWLSHIIQOWIgvaRq2t4R3ezGnruODoNe3a6Y2sNUt
         nVGwKd770e0kGmNFjrBVp3c1BLBHqGhB5Ame+/eooJcgkA6THQZZ/dC89itcWAFIaaQn
         eSTDalfpYH5j45PCEcdeUEpTWdMdXecMfagvTYL7x/KWb6mxUWIEwwpRUIRk+BgVwlvN
         7rPlvi2VHY/BW2UpT20g/u+jdV/NXoJjKNqEYu5JmNJsh5hdGf9EUktKqB8Zq+5SKtIC
         yx5F7SY60TPcj5AA5q+tFFNvfDaKkXp3pPhOXfRaVvQWeW/O3Kn+1iGEd6XdTDcGDzAt
         RM3g==
X-Gm-Message-State: AOAM532It2+GckYFzf26kYPVTklafuEixOyA3HNrKE7u/5DqJNO/jdIO
        dY5PZ6CYQpidXpwX3RCXrHnpebUZ95PBWOoJkiaGNw==
X-Google-Smtp-Source: ABdhPJy0527DySdaF0QbUTfkqaBmAxcSlt5xV1Y2DkQ5SSVi6UK7yG/P08m2+gfUVNs9muUkIzsQFP6U+AQhCi03FTM=
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr22405964wmg.3.1627397838046;
 Tue, 27 Jul 2021 07:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210723094422.2150313-1-jens.wiklander@linaro.org>
 <20210723094422.2150313-2-jens.wiklander@linaro.org> <87zgud1giz.wl-maz@kernel.org>
 <CAHUa44EhP5NCH6S27+Af8ePxAup9nJnrwGr_nMRUFumXOTh7uQ@mail.gmail.com> <87eebkdumr.wl-maz@kernel.org>
In-Reply-To: <87eebkdumr.wl-maz@kernel.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 27 Jul 2021 16:57:07 +0200
Message-ID: <CAHUa44HCEr_HKU0Fz10HPZYMowXVkx5JtnXMVTXd29wAv-dTCg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] docs: staging/tee.rst: add a section on OP-TEE notifications
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:32 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 27 Jul 2021 08:46:39 +0100,
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > On Fri, Jul 23, 2021 at 12:16 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Fri, 23 Jul 2021 10:44:17 +0100,
> > > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Adds a section on notifications used by OP-TEE, synchronous and
> > > > asynchronous.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  Documentation/staging/tee.rst | 27 +++++++++++++++++++++++++++
> > > >  1 file changed, 27 insertions(+)
> > > >
> > > > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> > > > index 4d4b5f889603..37bdd097336f 100644
> > > > --- a/Documentation/staging/tee.rst
> > > > +++ b/Documentation/staging/tee.rst
> > > > @@ -184,6 +184,33 @@ order to support device enumeration. In other words, OP-TEE driver invokes this
> > > >  application to retrieve a list of Trusted Applications which can be registered
> > > >  as devices on the TEE bus.
> > > >
> > > > +OP-TEE notifications
> > > > +--------------------
> > > > +
> > > > +There are two kinds of notifications that secure world can use to make
> > > > +normal world aware of some event.
> > > > +
> > > > +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> > > > +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> > > > +2. Asynchronous notifications delivered with a combination of a non-secure
> > > > +   interrupt and a fast call from the non-secure interrupt handler.
> > > > +
> > > > +Synchronous notifications are limited by depending on RPC for delivery,
> > > > +this is only usable when secure world is entered with a yielding call via
> > > > +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> > > > +world interrupt handlers.
> > > > +
> > > > +An asynchronous notification is delivered via a non-secure interrupt to an
> > > > +interrupt handler registered in the OP-TEE driver. The actual notification
> > > > +value are retrieved with the fast call ``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``.
> > > > +
> > > > +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> > > > +special meaning. When this value is received it means that normal world is
> > > > +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> > > > +call is done from the thread assisting the interrupt handler. This is a
> > > > +building block for OP-TEE OS in secure world to implement the top half and
> > > > +bottom half style of device drivers.
> > > > +
> > >
> > > What I find missing here is a description of the trigger for this
> > > interrupt, and how it influences the way the kernel drivers interacts
> > > with the secure side:
> > >
> > > - if it is edge triggered, this is 'fire and forget'. The interrupt
> > >   will be consumed by the kernel handler, and whether it eventually
> > >   calls into the secure side has no impact on the interrupt flow.
> > >
> > > - if it is level triggered, then the interrupt may be asserted until
> > >   the kernel calls into the secure side, which may then drop the line
> > >   level if no other requests are pending.
> > >
> > > These are evidently two very different flows, and you need to pick a
> > > side. Note that not all interrupt controllers support both signalling
> > > modes, so you are likely to leave something behind. Or you can try and
> > > support both flows, but that may make the driver slightly more
> > > complex.
> > >
> > > Either way, this needs specifying, here and in the DT binding.
> >
> > In the example I'm using a level triggered interrupt which is
> > triggered by writing to GICD_ISPENDR by secure world. Reading of
> > GICC_IAR should clear the interrupt,the GICv2 reference manual is
> > quite clear on that.
>
> No, it merely activates it. You can't transition an interrupt from
> pending to inactive (unless you clear it using GICD_ICPENDR). If you
> have spotted something else in the GICv2 architecture manual, please
> say so and I'll get it fixed 15 years after the facts. The fact that
> GICC_IAR consumes a pending bit introduced by a write to ISPENDR is an
> implementation detail, see below.

I was looking at figure 4-10 "Logic of the pending status of a
level-sensitive interrupt".

>
> It is also a flawed approach, as this behaviour is IMPDEF on GICv3
> (see 4.5 "Shared Peripheral Interrupts" in the GICv3 arch spec). Given
> that GICv2 is pretty much a dead horse (TFFT!), I can't see this approach
> being successful in the long run.

OK, thanks.

>
> > So, if I understand it correctly, it will for
> > this purpose work in the same way as an edge triggered interrupt. If
> > this wouldn't be the case in some configuration and the interrupt must
> > be cleared by some other action that would be a job for the receiver
> > of OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, that is, a secure world problem.
> > The normal world flow should be the same.
>
> You are assuming that the secure side will use GICD_ISPENDR, and
> that's a leap of faith.

Not in this case with upstream OP-TEE. If we need to signal in a
different way we can do that instead.
What happens downstream we have no control over, but that's perhaps
not so different from the kernel.

> An implementation should use, say, a GPIO to
> drive the interrupt line and give it proper level semantics.

I'm not so keen on that since we often don't touch GPIO at all in
OP-TEE and this would then mean more platform specific code. We may
even need to synchronize some hardware access with the normal world
and then we'd be back at square one again.

>
> > Now that we describe the interrupt configuration in device tree it
> > must use something that mirrors the secure world expectations. I don't
> > see a point in restricting what's allowed as long it doesn't need code
> > changes in the kernel too. Does this make any sense?
>
> And that's the crucial point: what *are* the expectations of the
> secure side?

That should be up to the OP-TEE port of that particular platform to
decide and advise which device tree configuration to use.

> You seem to assume edge semantics, but that's unclear at
> best.

Fair enough, edge semantics solves the problem here.

>
> > If I just expand a bit above explaining that the interrupt handler
> > must call OPTEE_SMC_GET_ASYNC_NOTIF_VALUE as part of clearing the
> > interrupt even if it might be cleared anyway in some configurations.
> > Would that make it more clear, good enough even :-) ?
>
> This is an interrupt, please document it in terms of interrupt
> signalling.

In this file, Documentation/staging/tee.rst ? A pointer to a good
example of what you're expecting would be much appreciated.
There's also the file drivers/tee/optee/optee_smc.h, this is where the
ABI to OP-TEE is defined.

>
> - If it is level, the handler has to call into secure to observe the
>   level dropping. If the driver can observe the level being low before
>   calling into secure, it is perfectly allowed to consider the
>   interrupt being spurious and not perform the call. If you don't have
>   a device actively driving the line, this doesn't work.

Spurious calls to OPTEE_SMC_GET_ASYNC_NOTIF_VALUE are harmless, but it
will of course save a few cycles if they can be avoided.

>
> - It is edge, the handler can do anything it likes, including ignoring
>   the request after consuming the interrupt, or call into secure from
>   a kernel thread with interrupts enabled.

Yes, that's a bit more relaxed. Now I'm doing that part in the upper
half handler. I don't suppose it matters much, not much time is spent
there. The advantage is that it will work with a level triggered
interrupt too, if it would ever come to that. Provided that
OPTEE_SMC_GET_ASYNC_NOTIF_VALUE does what's needed to clear the
interrupt in secure world, but that should be mandated in such
configurations.

>
> At the end of the day, only you can decide which of these two flows
> are appropriate. If you don't want to mandate actual HW driving the
> line, edge triggered is your only option.

I agree that in the GIC case we should use edge triggered interrupts.
But It's not clear to me why this must be nailed down in any other
case instead of being left open to configuration.

The configuration that is best for the platform should be used, but
this is still a platform specific detail [1]. If device tree can give
us the flexibility to use level triggered interrupts with some other
interrupt controller and the kernel code already is capable of working
with that, what's the harm in leaving that open?

Thanks for your patience, I'm still trying to understand the parameters.

Cheers,
Jens
[1] The OP-TEE firmware is always built per platform with platform
specific configuration. With FF-A that may change, but then we'll also
base these notifications on FF-A instead of playing directly with
interrupts.
