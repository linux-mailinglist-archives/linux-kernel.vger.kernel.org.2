Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8444DAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhKKQsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhKKQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:48:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F2C0613F5;
        Thu, 11 Nov 2021 08:45:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so26603846edz.2;
        Thu, 11 Nov 2021 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7NxryXErjXtkrtdjeJl2OkLP7Fwd8D1Ac4yme0xpGQ=;
        b=TXzXvJntdUq1otyeLiWQQz1xbD3C6bknEk53APVTv1dGvccxr3/O8hJRWEmM8q22mA
         ugPSVetDIQ9Ci+i5pfRRMlCp+1bwBGRGdWfZLvzUZ5ZQAjY7hOOogjpI5etzsA+hN8ZM
         Nz1uaucW3DBCe3k4sCGaBQx9Y3e94iZ212dCtTIRue6LedtSyVPY3HBiuW20OWQe4qsq
         uXCNvDsSZQhf1iM7pvhLjyUFu/aJx5VggCeexUSmrMmHZ7fMnzbmUiwHZZhPXAKRQT/1
         97Lk+/443fUpLanduElQPFS+Ka4n7772e/vFExdm1zeYIVgpM1P8+3pQ5D5xmlBGvB46
         zqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7NxryXErjXtkrtdjeJl2OkLP7Fwd8D1Ac4yme0xpGQ=;
        b=uJ3ilwp1bigx/hwGz7+9h/RxlzdpGxJBc4Vo+P3O0Vd7KSTrJJronw3jf1+0XfxTP4
         GlHXJp6KM5VLhBYGEH6VBs0D7svHJt9Ql5aHUUkm9DsbFrSbNdrPiBetZIiHPIQSdH9g
         GPKi20m6gwtk8z9y7Nf+OpBD5n3fgQStmwlJobmx9+m/Emjyj2U9PrzerEQPdEHSURJW
         a0Ib4BhzNXWBNu8958tOYE8czAqZv6s39SEPoFmaFwDhr9/suVssjHLPiD0MrANOkpom
         lIfNXdnqnnxR8ChNg2snTUj90wU3cM8A+O3q5RzqJtRsDlbfGkq0dqbdvzmT91mICzC9
         6UDw==
X-Gm-Message-State: AOAM530a3bEcINvQxicgWyYK/Uap5rLSRuOjyxUpW/aZuZJGxkHauFFi
        wFGVgqtyIUqLUQnodLXUGT0RS8p3oW5UOMALoig=
X-Google-Smtp-Source: ABdhPJwy83UujwqCbhFtQEDkTPXfMQEi2mcXedjgv4a3KHMqQWTQdxZxGfPia4GU9ivaP3diFl56L5qWBluJyimK2nw=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr10760234ejd.425.1636649110429;
 Thu, 11 Nov 2021 08:45:10 -0800 (PST)
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
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com> <CAHifhD4KbLQTA1=vVCeftKybSjU1tHGk7OZn4PN55eXUu-yKog@mail.gmail.com>
In-Reply-To: <CAHifhD4KbLQTA1=vVCeftKybSjU1tHGk7OZn4PN55eXUu-yKog@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 18:44:25 +0200
Message-ID: <CAHp75Vfc85XnVmnJ0ytm_XCGSoqFfiMQ3jxXCudsyo5XW6brTQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
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

On Thu, Nov 11, 2021 at 6:07 PM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
> Am Do., 11. Nov. 2021 um 16:31 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> > On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > > Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com>:
> > > > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > >
> > > > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> > > > > >
> > > > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > > > What about bare metal configurations where the bootloader provides
> > > > > > services to the OS?
> > > > >
> > > > > No it is always the case. I suggest you go read your own Intel specs
> > > > > and datasheets
> > > >
> > > > Point me out, please, chapters in SDM (I never really read it in full,
> > > > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > > > 1Mb physical address space that the CPU runs at first.
> > >
> > > So you do not know what you are talking about, am I correct?
> >
> > Let me comment on this provocative question later, after some other
> > comments first.
> >
> > > Starting
> > > from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> > > are referring to is the 8086 reset vector and that was like 40 years
> > > ago.
> >
> > True. The idea is the same, It has a reset vector standard for x86
> > (which doesn't explicitly tell what is there). So, nothing new or
> > different here.
> >
> > > Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> > > Instruction Executed", paragraph two. Just watch out for the hex
> > > number train starting with FFFFF... then you will find it. This is
> > > what requires the memory range to be mapped. Modern Intel CPUs require
> > > larger portions, because of the ACM loading and XuCode and whatnot.
> >
> > Thanks. Have you read 9.7 and 9.8, btw?
> > Where does it tell anything about memory to be mapped to a certain
> > address, except the last up to 16 bytes?
> >
>
> It doesn't, except that the FIT, ACM, BootGuard, XuCode stuff rely on
> their binaries to be there, this just sets the upper address limit of
> the window.

Why is it needed? I mean the listed blobs are not mandatory to get
system boot. Is this correct?

> > > Please refer to the email [1] from me linked below where I reference
> > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > hard-wired. Note that the range cannot be turned off and will read
> > > back 0xFF's if the PCH registers are configured to not be backed by
> > > the actual SPI flash contents.
> >
> > And as I said it does not cover _all_ x86 designs (usual != all) .
> > Have you heard about Intel MID line of SoCs? Do you know that they
>
> No and a quick search didn't turn up anything. Can you point me to
> resources about those SoCs? Also my module is targeting x86_64, that
> is only a subset of x86 designs.

They are x86_32 and x86_64, so in the category you listed.

Unfortunately there is indeed not much publicly available information,
but I can tell you that from a design perspective you may consider
them PCH-less.

> > have no SPI NOR and the firmware is located on eMMC? Do you know that
> > they can run Linux?
>
> It doesn't matter where the firmware is coming from, as long as it is
> _mapped_.

It's not. That address space is full of devices, the same memory can't
be used for ROM and devices at the same time (I won't go to the weird
concept of different read and write paths, and it's not applicable
here anyway).

> And something has to be mapped there, even if it is just a
> loader that gets eMMC going.

(Semi-)wrong. Yes, _something_ is there (with the holes), but it's
_not_ a firmware memory.

You may google for iomem output on that kind of device.

For your convenience (an excerpt):

  fee00000-fee00fff : Local APIC
   fee00000-fee00fff : Reserved
 ff000000-ffffffff : Reserved
   ff008000-ff008fff : 0000:00:0c.0
     ff008000-ff008fff : 0000:00:0c.0
   ff009000-ff009fff : 0000:00:13.0
     ff009000-ff009fff : intel_scu_ipc

> > So, maybe it's you who do not know what you are talking about, am I correct?
> >
> > > [1] https://lkml.org/lkml/2021/6/24/379

-- 
With Best Regards,
Andy Shevchenko
