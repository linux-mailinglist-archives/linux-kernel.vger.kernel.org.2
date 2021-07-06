Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F393BD52D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbhGFMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbhGFMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:03:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6DC073C09
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 04:39:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z9so667600ljm.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KHENRVTFcr1DeeaRLU/2vG0asdcInU8xhn1ZnIiQEc=;
        b=IdGKMBytW7IOMBESz96dq6itTpIEDPBWGB5XRO+qSQ48yJT7yYAT9N8lqiHah9wnDY
         3K6D67UfDsx2P/ABipjl30TBctWMN4qhsTRC4E4sc1XIGn/04HiicXlk8UmLQM6W2Kpr
         7PNSQ5KyQpi5RAnSZMdMPgQeA0Twv6DZgMvu/nxu6Z15JYc+G6N/l9rt0dUMVRGcbsQG
         jIxb3yy8OJnKogUutBA72zbdZTq1n+5HnQrIFBIFQZDQYf/yl9D5hlL0E2RnfqraqVuD
         oc9p4c/bJt85uQ08MZVR9pynFPLB0W1DafWua6b73deN8YLYp9UoQQ19K9K219rSCjO/
         tXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KHENRVTFcr1DeeaRLU/2vG0asdcInU8xhn1ZnIiQEc=;
        b=iztVj1IKWA7+OUqIabgi4bayXjrbb3gWAPBnI9k4JcPwOnXWXshPt/HViP9vSD3REr
         jhctSABtOqPUfOWgGjYk3fi0vzs6q0WBH8/9wN153ib4fPDF1VyL1oJtDYnuPg1vcAyK
         McBIozyK+lMt6gYpLrN/f39sz6Hap/i5/NPlp3fpGmU3OpD/sgbjE4GuSD87wWYQTwOo
         zzK6+sGomasyk4sdXHPCFGQOb4h38/DXQxkR2g/5HQy4cHBqRfXUSGIPQYA1YnvZG9WA
         R5CxFApAtU/NuwGaf6PdhD1DnH9X2GSsWlB/caq1sIv7ihtFFW6PiuE3MZwtJJqR4us6
         nEMg==
X-Gm-Message-State: AOAM530mjaWSTkRURxzg0oeZYPyqUp8dAZvNLwbyH9DjY0KuhHyT/wyL
        a4xQGBe/h5X4J810ehadk5zMzbdLQvHqubD3VPkkyQ==
X-Google-Smtp-Source: ABdhPJyelO119SdIxeoLnTAOiAmiMNIuQe3vuufuwv/8ig2netrG+imXeZJWy7PwGkasy+bYcpaaE4SV5ck1PxhSv58=
X-Received: by 2002:a2e:bc13:: with SMTP id b19mr15061008ljf.480.1625571564690;
 Tue, 06 Jul 2021 04:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
 <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>
 <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>
 <CAFA6WYMSAM2MDOXnhjuZFov3BtF8-nihZRUpR8ciUWsL4_nCWA@mail.gmail.com> <87czrv91b2.wl-maz@kernel.org>
In-Reply-To: <87czrv91b2.wl-maz@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 6 Jul 2021 17:09:13 +0530
Message-ID: <CAFA6WYPVA5yP3trumfz=_oXzxKtfobQXRzDwZ1og8UXwaA1rkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
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

Hi Marc,

On Tue, 6 Jul 2021 at 16:06, Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 08:25:26 +0100,
> Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 17 Jun 2021 at 11:40, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi Jens,
> > > >
> > > > On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This adds support for asynchronous notifications from OP-TEE in secure
> > > > > world to the OP-TEE driver. This allows a design with a top half and bottom
> > > > > half type of driver where the top half runs in secure interrupt context and
> > > > > a notifications tells normal world to schedule a yielding call to do the
> > > > > bottom half processing.
> > > > >
> > > > > An interrupt is used to notify the driver that there are asynchronous
> > > > > notifications pending.
> > > > >
> > > >
> > > > It looks like a nice feature. I would like to get hands on with this.
> > > > Can I test this feature on Qemu?
> > >
> > > Absolutely, you can get this into the normal OP-TEE development repo setup with:
> > > repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
> > > repo sync
> > > Update optee_os with
> > > https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
> > > Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_notif_v2
> > > cd build
> > > make all -j...
> > > make run-only
> > >
> > > If you type anything at the secure console you'll notice how it
> > > changes behaviour once the Linux kernel has booted.
> > >
> >
> > Thanks for sharing instructions as I now got some time to test and
> > deep dive into this feature. It looks like a pretty useful feature to
> > realize interrupt support in the secure world in its true sense. This
> > feature works for me as per your instructions.
> >
> > I could recognise it's requirement from the time while I was playing
> > with secure timer interrupt support for OP-TEE RNG driver on
> > Developerbox. In that case I had to strip down the secure interrupt
> > handler to a minimum that would just collect entropy and dump into the
> > secure buffer. But with asynchronous notifications support, I could
> > add more functionality like entropy health tests in the bottom half
> > instead of doing those health tests while retrieving entropy from the
> > secure world.
> >
> > Given that, have you explored the possibility to leverage SGI rather
> > than a platform specific SPI for notifying the normal world? If it's
> > possible to leverage Architecture specific SGI for this purpose then I
>
> What does "Architecture specific SGI" mean?
>

Here I meant that SGI is specific to Arm architecture and doesn't
require to be specific to per platform like an SPI.

> > think this feature will come automatically enabled for every platform
> > without the need to reserve a platform specific SPI.
>
> That old chestnut again...

Okay, can you provide reference to earlier threads?

>
> - How do you discover that the secure side has graced you with a
>   Group-1 SGI (no, you can't use one of the first 8)? for both DT and
>   ACPI?

I think the secure world can be probed for that during the OP-TEE
driver probe. And I agree with you that the first 7 SGIs are already
pre-occupied and I guess you remember mine patch-set that tried to
leverage 8th SGI as pseudo NMI for kernel debug purposes.

So yes for this use-case, the secure world can reserve one of the
latter 8 SGIs (8 to 15) for cross world notification and I guess your
earlier work to make SGIs to be requested as normal IRQs should make
it easier to implement this as well.

>
> - How do you find which CPUs are targeted by this SGI? All? One? A
>   subset? What is the expected behaviour with CPU hotplug? How can the
>   NS side (Linux) can inform the secure side about the CPUs it wants
>   to use?

For the current OP-TEE use-case, I think targeting all CPUs would be
efficient. So wouldn't it be possible for the CPU which receives the
secure interrupt to raise that SGI to self that would in turn notify
the normal world (Linux) to create a thread for OP-TEE to do bottom
half processing?

>
> - Is there any case where you would instead need a level interrupt
>   (which a SGI cannot provide)?

I think SGI should be sufficient to suffice OP-TEE notifications use-case.

>
> In general, cross world SGIs are a really bad idea. Yes, some people
> like them. I still think they are misguided, and I don't intend to
> provide a generic request interface for this.

Okay, as I mentioned above having it specific to OP-TEE driver
requesting secure world donated SGI would work for you?

-Sumit

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
