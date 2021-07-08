Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D0D3BFABE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGHM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhGHM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:59:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 05:56:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so5554060lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYm3a5mpN+BoPmshn8mkxlHRFzX2Yya2PMbcQCv1mHs=;
        b=gD+ZhmQ9k9IhL01vh29PeeOyQHbwZAJ7CxUJIHaRkAMGpwX26vg4ShpVPaLuWJFeiS
         sVdSVzf9ENoKqC004pRnWi56RKvv0l3vqLVVgJpVGKhJIQyir91SO+zDH/V7Y2Hqs02N
         G4gmT93mYm0Ig0fLH8kIiqpsmKtvAA3EvdN80g9d2iJ0J+UbdwyhdfpvSJT//sEBTsfD
         j4veMOZIB22f0EMrQsxl5EA9m1A5kZSDflMQ9RUejgtpq/l8fNvVM4w9knYWKJ0B+XO9
         yc9oN/KXAvbmH8kTdcP8rIkPXhshoXcBrRAZzg/xCXOkw7esxRCnV9o/Qjhl1+jRJJEK
         WXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYm3a5mpN+BoPmshn8mkxlHRFzX2Yya2PMbcQCv1mHs=;
        b=fUwtSk2RGbHraF0jvSgY3PcBgtbD8qle17sQ7CD2rB6KWt9QVFDYIZa4o6MxDAT6vc
         z4iZKdrjPt1LVZ9GxzggRXJB3aGBcmBUiBU+aNJ1+iMrd9HtMna6LxaD8/H6Gv6wkStT
         hq9BJXofDlr8F3MbZipbN+0m6D2v0FSLBMV1XpNDdmSlwms/XuZaYAnSYuy04Z3xlrvq
         F7D4/G7J1x4WI3t3utLj1+Q7j2IhVekn70Q0OUeujg07XklgnEl5j6iz6OW+dwywTrpB
         o+EnjMpKbVgyCXuI7iddMESF1GmR+0kA6tq8mqWNqtIQ/y8CYauulxDeQq8NYaLncV0j
         78mg==
X-Gm-Message-State: AOAM533n9ODjmT7cyNyK5Toc7hgGpnVwQiXIJudn6iwub5BSjPP7i6e+
        kVhroNdJbuTKRjCH1OwpfEFbrReQ36Mpqzzf4CT/Mg==
X-Google-Smtp-Source: ABdhPJw9DOy/URmj+h9svmUyUGN7AhupCJ+fGCqHmeddr2Wk0Q5fOwXmrqiOw7uJLlAJ++O21J2H2CglW/qjdLYv9Lc=
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr4407179lfb.396.1625749001582;
 Thu, 08 Jul 2021 05:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
 <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>
 <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>
 <CAFA6WYMSAM2MDOXnhjuZFov3BtF8-nihZRUpR8ciUWsL4_nCWA@mail.gmail.com>
 <87czrv91b2.wl-maz@kernel.org> <CAFA6WYPVA5yP3trumfz=_oXzxKtfobQXRzDwZ1og8UXwaA1rkQ@mail.gmail.com>
 <87a6mz8vaj.wl-maz@kernel.org> <CAFA6WYMsjxYBw_0xzWMtHf=LtXzG+D113WSFuHCR7KhC1RuWYg@mail.gmail.com>
 <20210707175123.xdotr3lsy3e32plm@bogus>
In-Reply-To: <20210707175123.xdotr3lsy3e32plm@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 8 Jul 2021 18:26:30 +0530
Message-ID: <CAFA6WYNF_GkRiqn+H5UO6O4ZEkZ16xO=JkV6LOvgvvaVqwFtxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Wed, 7 Jul 2021 at 23:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Sumit,
>
> I was holding off you reply as I didn't have all the background on this.
> Achin did mention that this is preparatory work for FFA notifications.
> I did mention to him that this is more than that, it is custom extension
> to address what FF-A notification is trying to in standard way.
>
> I share same opinion as Marc Z.
>
> On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> > On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> > >
> > > I don't care about OP-TEE. If you are proposing a contract between S
> > > and NS, it has to be TEE and OS independent. That's how the
> > > architecture works.
> > >
> >
> > Agree, here we are not proposing a common contract among the S and NS
> > world that every TEE (based on Arm TrustZone) will use to communicate
> > with REE (Linux in our case) but rather an OP-TEE specific
> > notifications feature that is built on top of OP-TEE specific ABIs.
> >
> > And I can see your arguments coming from an FFA perspective but there
> > are platforms like the ones based on Armv7 which don't support FFA
> > ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> > comes into picture?
> >
>
> I can understand that but won't those platforms add the support both in
> the kernel(current series) and secure world to address notifications.

Agree.

> While you could argue that it is small extension to what is already present
> but I prefer they support FF-A is they need such a support instead of adding
> custom mechanisms. It is hard to maintain and each vendor will deviate
> from this custom mechanism and soon we will have bunch of them to handle.
>

I haven't had a deep dive into FF-A spec, maybe you can clarify on the
following queries regarding Armv7 compatibility:
- As you may be aware, secure monitor implementation on Armv7 is
tightly coupled to trusted OS (part of the same code base), so would
you like each trusted OS vendor to implement a common FF-A interface?
- IIRC, FF-A spec has the notion of multiple secure partitions, are
those supported on Armv7? If yes then how?

> > > > >
> > > > > In general, cross world SGIs are a really bad idea. Yes, some people
> > > > > like them. I still think they are misguided, and I don't intend to
> > > > > provide a generic request interface for this.
> > > >
> > > > Okay, as I mentioned above having it specific to OP-TEE driver
> > > > requesting secure world donated SGI would work for you?
> > >
> > > No. I want a proper architecture between secure and non-secure that
> > > explain how messages are conveyed between the two world, how
> > > signalling is done, how CPU PM is handled, how targeting is
> > > negotiated. And at the end of the day, this is starting to look a lot
> > > like FFA.
> >
> > AFAIK when FFA comes in picture than OP-TEE will use the standard
> > interface provided by FFA ABIs but if FFA isn't supported by a
> > particular platform (eg. based on Armv7) then we need to rely on TEE
> > specific ABI like what OP-TEE currently provides:
> >
>
> Who are asking for this ? Can we ask them to migrate to FF-A if this
> (new) notification support is needed on their platforms ? It is help to
> know the requesters so that they can be included in FF-A spec discussions.
>

I would let Jens answer that.

> > > that. You'll even get to keep the pieces once it breaks. But if you
> > > are going to invent a new universal way of signalling things across
> > > world, you'd better start specifying things the right way, taking into
> > > considerations systems where the interrupt controller doesn't allow
> > > cross-world signalling.
> >
> > As I mentioned above, this patch-set adds an OP-TEE specific
> > notifications feature. AFAIK, the interrupt controllers supported by
> > OP-TEE (GICv2, GICv3 etc.) don't restrict cross-world signaling.
> >
> > So given the explanation above, if you still think requesting an SGI
> > as an IRQ by drivers isn't allowed then I am fine with the approach
> > that Jens has already implemented in this patch-set to use platform
> > specific SPI.
> >
>
> And I assume these platforms in question have SPI to spare and way to
> trigger it from secure world ?
>

Yeah, that is the requirement on the platform if we rely on SPI (Qemu
test example [1]) which wouldn't be the case if we use secure world
donated SGI.

BTW, is this notification mechanism discussed in the case of FF-A? If
yes, can you throw some light on that?

[1] https://github.com/jenswi-linaro/optee_os/commit/9007f8184deb9b7995da8d590779cb3ba2783394

-Sumit

> --
> Regards,
> Sudeep
