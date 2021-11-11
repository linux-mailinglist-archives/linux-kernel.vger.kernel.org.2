Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F329744DAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhKKQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhKKQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:58:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B216C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:55:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 133so5662116wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYreyu4P5RFhpC3XSdSNPe0ZZcJBqdfBhkHv9IijHgU=;
        b=fYYunghZIE3mZNrhl+t5/Ioa4b31A4VzWXsQn04yaV/TpAHs8eAFNRIwJVpQPFZuZx
         +rPlP1asg+1fEasT7PokFeKin/4a/qwZgXRA6rswj+gq157nMpT+8PHZb/clYNGgDeEl
         f+Xhw3xSkz7CstvzEYRZf8BzvKVRagI92ACBvzVLMKrNBXJyQDsW0HQPcxb/H/hx7GZq
         BP09cmFbZVd+/Rreoq8dHsB/C7YI3ASAz0g8gVvy9/ncN4tJEMfy3jj6oKHAU6gOAkkZ
         5LUyuNuTjtDyAtQq/A5UYDkMEz4obfkkLyhtU9k5krG+C/kFyZyTzg0909RQVZ3mWntS
         7/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYreyu4P5RFhpC3XSdSNPe0ZZcJBqdfBhkHv9IijHgU=;
        b=AnZmcAH8THNlU5IhDnoRPwYVoyKqxVKAiFrbTc6lT+ldUzzoFcErBRkCvnQHEbl8ne
         ZAlcEDVf6psvcIhzvCiz1T0ZVO0YEbsX1iU3wjRVi+AGAC3evoo4ZnnlcNGp/2RnxwkG
         E3zoJvtx1t3MD3CRroN+D37KVljZAWvEDUAbMEu3KnIxv3xyXzcefCKyLqyO1m7af6Mi
         Ai9jm+ziv7/KyfMv3Nt9mNa2Sz/Q2qpClCMJ0uJFqgOD4ospx7aTuY7eX9y0ZmvCoHhH
         SJIIp4zHHxgoqNJ7uP9P7gX+I7puGgI124jrFIdSkwb2wfExpAPwrZZIltVTVLUSmmdU
         datg==
X-Gm-Message-State: AOAM530weGJ2Gm1seqBWwkRLxmGrVj3LQF7Zluyqt/JVSJtFztjU4AmL
        DiqXvpUEI+gZU5GVCLTAwMa05um/sgqF5AgjEw4JlQ==
X-Google-Smtp-Source: ABdhPJw3bZXwG1/3fSsNmd/SOg2fTKOAeHM/xWqM2xURAtOioNwuinB17GVz1gUdTPBcfPtCnb4GP0gDjpheiuCfOEg=
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr9685613wmq.48.1636649728694;
 Thu, 11 Nov 2021 08:55:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
 <CAHifhD4KbLQTA1=vVCeftKybSjU1tHGk7OZn4PN55eXUu-yKog@mail.gmail.com> <CAHp75Vfc85XnVmnJ0ytm_XCGSoqFfiMQ3jxXCudsyo5XW6brTQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfc85XnVmnJ0ytm_XCGSoqFfiMQ3jxXCudsyo5XW6brTQ@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 17:55:17 +0100
Message-ID: <CAHifhD42G+7BQHBwS=ZFzcv9On0TFNFLV+HARjWENUAmX-8WaQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 11. Nov. 2021 um 17:45 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
> On Thu, Nov 11, 2021 at 6:07 PM Hans-Gert Dahmen
> <hans-gert.dahmen@immu.ne> wrote:
> > Am Do., 11. Nov. 2021 um 16:31 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > > On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
> > > <hans-gert.dahmen@immu.ne> wrote:
> > > > Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> > > > <andy.shevchenko@gmail.com>:
> > > > > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > > >
> > > > > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> > > > > > >
> > > > > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > > > > What about bare metal configurations where the bootloader provides
> > > > > > > services to the OS?
> > > > > >
> > > > > > No it is always the case. I suggest you go read your own Intel specs
> > > > > > and datasheets
> > > > >
> > > > > Point me out, please, chapters in SDM (I never really read it in full,
> > > > > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > > > > 1Mb physical address space that the CPU runs at first.
> > > >
> > > > So you do not know what you are talking about, am I correct?
> > >
> > > Let me comment on this provocative question later, after some other
> > > comments first.
> > >
> > > > Starting
> > > > from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> > > > are referring to is the 8086 reset vector and that was like 40 years
> > > > ago.
> > >
> > > True. The idea is the same, It has a reset vector standard for x86
> > > (which doesn't explicitly tell what is there). So, nothing new or
> > > different here.
> > >
> > > > Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> > > > Instruction Executed", paragraph two. Just watch out for the hex
> > > > number train starting with FFFFF... then you will find it. This is
> > > > what requires the memory range to be mapped. Modern Intel CPUs require
> > > > larger portions, because of the ACM loading and XuCode and whatnot.
> > >
> > > Thanks. Have you read 9.7 and 9.8, btw?
> > > Where does it tell anything about memory to be mapped to a certain
> > > address, except the last up to 16 bytes?
> > >
> >
> > It doesn't, except that the FIT, ACM, BootGuard, XuCode stuff rely on
> > their binaries to be there, this just sets the upper address limit of
> > the window.
>
> Why is it needed? I mean the listed blobs are not mandatory to get
> system boot. Is this correct?

That doesn't matter for this case.

>
> > > > Please refer to the email [1] from me linked below where I reference
> > > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > > hard-wired. Note that the range cannot be turned off and will read
> > > > back 0xFF's if the PCH registers are configured to not be backed by
> > > > the actual SPI flash contents.
> > >
> > > And as I said it does not cover _all_ x86 designs (usual != all) .
> > > Have you heard about Intel MID line of SoCs? Do you know that they
> >
> > No and a quick search didn't turn up anything. Can you point me to
> > resources about those SoCs? Also my module is targeting x86_64, that
> > is only a subset of x86 designs.
>
> They are x86_32 and x86_64, so in the category you listed.
>
> Unfortunately there is indeed not much publicly available information,
> but I can tell you that from a design perspective you may consider
> them PCH-less.

Okay fine. Now you come around the corner with undocumented Intel
devices and make your first semi-valid point. Why did it take you so
long? Why did you seemingly just try to derail the discussion before?
Is the documentation non-existent or just NDA?
May I remind you that from a CPU view it doesn't matter if the PCH or
some other thing attached to the CPU's bus provides the mapping.

So if that is your concern, then the solution would be to probe if we
see a PCH or FCH?


>
> > > have no SPI NOR and the firmware is located on eMMC? Do you know that
> > > they can run Linux?
> >
> > It doesn't matter where the firmware is coming from, as long as it is
> > _mapped_.
>
> It's not. That address space is full of devices, the same memory can't
> be used for ROM and devices at the same time (I won't go to the weird
> concept of different read and write paths, and it's not applicable
> here anyway).
>
> > And something has to be mapped there, even if it is just a
> > loader that gets eMMC going.
>
> (Semi-)wrong. Yes, _something_ is there (with the holes), but it's
> _not_ a firmware memory.
>
> You may google for iomem output on that kind of device.
>
> For your convenience (an excerpt):
>
>   fee00000-fee00fff : Local APIC
>    fee00000-fee00fff : Reserved
>  ff000000-ffffffff : Reserved
>    ff008000-ff008fff : 0000:00:0c.0
>      ff008000-ff008fff : 0000:00:0c.0
>    ff009000-ff009fff : 0000:00:13.0
>      ff009000-ff009fff : intel_scu_ipc
>
> > > So, maybe it's you who do not know what you are talking about, am I correct?
> > >
> > > > [1] https://lkml.org/lkml/2021/6/24/379
>
> --
> With Best Regards,
> Andy Shevchenko
