Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AEE3CF4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbhGTGGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbhGTGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:05:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE88C0613E1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:46:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d12so24728130wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6u28mRni0Cw47J0u2SXQYWYKsgAtL/6Mpg3s/eEUc94=;
        b=dwCxrpfI0MjLGWlnVBbScEpe6jcNStpztoWFiqh2qNaJ2ZM2mhtG+OQS2jEWjaUr5X
         ITRIAQDof81SzgMuYxeuEw58Ax7SJELveVJKnEEiIy2mW+/AqJwin/bCy2U8vMA0lTpf
         8IOVxm5Oxd+ZscW+5G5440FrYCpo3symiMEIIvhFtVrNzGRTFovHP7gNRKIgGRXDreCH
         gxoIwEts1w1mL3U/Cn6ms42SuDrGsVW7NyxOYocZRLAQwRftVRYXblBooGwvXwN3Yd+E
         kOyOlcVB9imxpIXyitYPJU+62GuXqflhcSKC0WxK1h3f/iM543h8FJ5PCvDRD651IuMH
         k28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6u28mRni0Cw47J0u2SXQYWYKsgAtL/6Mpg3s/eEUc94=;
        b=e21hPSGSgPY9WMOWlae4QK0IZlYwiN7fmo99HsCH27WCv744QL48N5JafNBHLWP17P
         RnUdzTYghFykTMx1JQIYfH4sa+S1/1ROAW36FfUUJuckdJYGoZ35L5pyko3xebKqielS
         FulJH3NbErsDc81Tf/Ea0gkuDGLUnrhhtcBIP8JhDB4N+3eBFrQgDz8jjH0xwNYfniIX
         mzRdgacfwO/VTZnFtQrsg71AIrDQ3ZlbfjeKEDJL0RTcy/vgNMIMGzqGVbw9oOLV+pKa
         0LXMZvswNBLVandgck++MQipK/fS5I2kfAQmBr65W6wXfTf9+2VH6IQTRhJDcae/FQG7
         4/XQ==
X-Gm-Message-State: AOAM530eaVNO/xZO/WqXc/Si47IC7JXvGEjmMYBJHdue7e4zeDXJPi2x
        KsfCdiwrSxgG5fh0Yd3Ct0KlnNN86IUCIF4mVPfIlg==
X-Google-Smtp-Source: ABdhPJwPiAPlC93OgR4lOuh8FuuiBLj7GUwKqoSbM86RZH460ccjkPoNQuk7YEaMcKSISOg8HGKDTZ0TcH3X2Jn0Lco=
X-Received: by 2002:a05:6000:178a:: with SMTP id e10mr34140578wrg.141.1626763570276;
 Mon, 19 Jul 2021 23:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <PAXPR10MB4687E737261282B78600272DFD189@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <20210713111143.g6ztdakegs6ck25s@bogus>
In-Reply-To: <20210713111143.g6ztdakegs6ck25s@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 20 Jul 2021 08:45:59 +0200
Message-ID: <CAHUa44G2xLn9td88H-n9E3yJ6JUnyGL4vZNj0rwisu2ArngYAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Etienne CARRIERE <etienne.carriere@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 1:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jul 09, 2021 at 08:05:57AM +0000, Etienne CARRIERE wrote:
> > Hello Sudeep and all,
> >
> > On Wed, 7 Jul 2021 at 19:52, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Hi Sumit,
> > >
> > > I was holding off you reply as I didn't have all the background on this.
> > > Achin did mention that this is preparatory work for FFA notifications.
> > > I did mention to him that this is more than that, it is custom extension
> > > to address what FF-A notification is trying to in standard way.

Are you suggesting that we should use a hybrid implementation with
FF-A for notifications and keep the rest as is for armv7-a?

> > >
> > > I share same opinion as Marc Z.

From what I've read in this thread this has mainly been about using
SGI notification and not whether asynchronous notification from OP-TEE
on non-FF-A systems is good or bad. I assume Sumit was asking about
SGI to find out why that wasn't used. This patch set uses SPI.

> > >
> > > On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> > > > On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > [...]
> > >
> > > > >
> > > > > I don't care about OP-TEE. If you are proposing a contract between S
> > > > > and NS, it has to be TEE and OS independent. That's how the
> > > > > architecture works.
> > > > >
> > > >
> > > > Agree, here we are not proposing a common contract among the S and NS
> > > > world that every TEE (based on Arm TrustZone) will use to communicate
> > > > with REE (Linux in our case) but rather an OP-TEE specific
> > > > notifications feature that is built on top of OP-TEE specific ABIs.
> > > >
> > > > And I can see your arguments coming from an FFA perspective but there
> > > > are platforms like the ones based on Armv7 which don't support FFA
> > > > ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> > > > comes into picture?
> > > >
> > >
> > > I can understand that but won't those platforms add the support both in
> > > the kernel(current series) and secure world to address notifications.
> > > While you could argue that it is small extension to what is already present
> > > but I prefer they support FF-A is they need such a support instead of adding
> > > custom mechanisms. It is hard to maintain and each vendor will deviate
> > > from this custom mechanism and soon we will have bunch of them to handle.

Regarding deviation, are we still talking about the OP-TEE driver? So
far I haven't seen any vendor extensions at all in that driver.

> >
> > There exist armv7-a platforms that expect OP-TEE notification support and
> > will not move the FF-A, like the stm32mp15. This platform won't move to FF-A
> > mainly due to the memory cost of the added SPM layer and the device physical
> > constraints.
>
> Fair enough on the use-case and the analysis for not being able to use FF-A.
> As you may already know it doesn't simply this problem. This has been
> discussed for years and FF-A was assumed to be the solution when FF-A
> spec work started.
>
> > We have a usecase for OP-TEE notification. We're working on the integration
> > of an SCMI server in OP-TEE. SCMI notification is a feature needed is this
> > scope and it requires OP-TEE async notification means as those proposed
> > here.
> >
>
> I am aware of this use-case, I understand. But I can only share rants
> which I know doesn't help much.
>
> > This OP-TEE async notif also brings a lot of value in OP-TEE as it allows a
> > OP-TEE secure thread (i.e. executing a trusted application service) to
> > gently wait on a secure interrupt (as a slow bus transaction completion or
> > many other usecase) with the CPU relaxed. This support is provided by the
> > proposed series. I believe existing device should be able to leverage this
> > OP-TEE feature without needing their OP-TEE to move to the new FF-A
> > interface.
> >
>
> While I agree these are nice to have in OPTEE, the timing is just odd.
>
> We are trying hard to push FF-A as standard solution to address all such
> issues that couldn't be solved with OPTEE + DT, now we are back to address
> the same in parallel to FF-A.

It's not exactly the same since the primary target here is armv7-a
where introducing FF-A isn't an obvious choice in all cases. For
OP-TEE armv7-a is special in the way that all secure world processing
is handled by OP-TEE. The internal secure monitor already takes care
of what's implemented in TF-A at EL3 for armv8-a.

This isn't meant to compete with FF-A, it's to make sure that the
OP-TEE armv7-a user base isn't left behind. This doesn't rule out FF-A
support for armv7-a for those prepared to take that step.

Cheers,
Jens
