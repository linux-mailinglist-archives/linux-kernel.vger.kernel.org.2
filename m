Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C75D44DB46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhKKRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhKKRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:52:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B6CC061766;
        Thu, 11 Nov 2021 09:49:25 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so27274965edv.1;
        Thu, 11 Nov 2021 09:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLzEMa8I9EBwwLb6kskoi7uTi8gY91SHIHJaYVwyUHc=;
        b=EWmd1IHQk9Yn4b5LHwXZtrDksp7wnpjBUydoJfrp9MApGP9xgFrQMTCRA6uG101fRr
         ZIgX+PAF24IKMAB7vEwmkMXreh7JTZ2EIeYLmZMz2Xrs3Vc2Qp6gpsoes9HFOVnnru3L
         6DZYP0vI9LET7wx1TjBtKc2/4ODdP4UJkGDeCHnm38v1XE/2z9Pg5ZGJriMO7B9Gg4P/
         oiHFQCUCqf24/+RgrYBQJWd6NkucE0TkC1Xmdc7jg8gQ3DpQmAabvOzu3ocqMmx5GJ6i
         bE/q3gXX4HlkPNb6LHXsmxstT59jiHk5gfkXTb2/0/UAKudFIZjvMmc/ZGpnDVAG0269
         QfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLzEMa8I9EBwwLb6kskoi7uTi8gY91SHIHJaYVwyUHc=;
        b=JsCnlr5+b6zn4DR2VSEPgNV4ULOAibh2AGp1n8U3seQBYnqaFzv1GuWOIkf36ts58m
         H1+x0bbUfBQG8i0+piRbXjy6Ivm2N76l4pc3VcAs28gub5sodWoZPPWTBL09o0HZSKCt
         RMgi9WtZEbakcXbtSim3zUkq4LmxnB7yivWTHmVuy2oT1Wcs7RROGgzuJRJFcXMMQwcT
         7rsoeaD3FAUJRoGEkOiLviVtLhhP7QSb8b5CuKoByfzhT0UAC5nDNwg9FQuN71pD96Fq
         mKiJMyLIsm1GIWs4j0y6CtcjCX3opgPg9OYqXeP7ssvky1fQcpMeKGCYAT32xpD8Oor2
         trHA==
X-Gm-Message-State: AOAM532Fc9yabV4AuoNE9G0YIDhalT/wlmO/tPfRxyxWVR8+2ag9MZHX
        ZW+cW4DX4meTRwjvzYbcUOPnUmwv9olIwzwGTSQ=
X-Google-Smtp-Source: ABdhPJwgwHuGXOeQqfGiLHVL1PmeInz8MmcKICw+rujRoSzOCbkV/ljMG5fKXZHc+jy4GHW8Q+YhyzNALhJY92y/jgo=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr11113881ejc.356.1636652963723;
 Thu, 11 Nov 2021 09:49:23 -0800 (PST)
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
 <CAHifhD4KbLQTA1=vVCeftKybSjU1tHGk7OZn4PN55eXUu-yKog@mail.gmail.com>
 <CAHp75Vfc85XnVmnJ0ytm_XCGSoqFfiMQ3jxXCudsyo5XW6brTQ@mail.gmail.com> <CAHifhD42G+7BQHBwS=ZFzcv9On0TFNFLV+HARjWENUAmX-8WaQ@mail.gmail.com>
In-Reply-To: <CAHifhD42G+7BQHBwS=ZFzcv9On0TFNFLV+HARjWENUAmX-8WaQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 19:48:39 +0200
Message-ID: <CAHp75Vcn6023eNCmRupRDLVHQrmGgAJ56TPEjHpDoQrwNgC8Hg@mail.gmail.com>
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

On Thu, Nov 11, 2021 at 6:55 PM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
> Am Do., 11. Nov. 2021 um 17:45 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> > On Thu, Nov 11, 2021 at 6:07 PM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > > Am Do., 11. Nov. 2021 um 16:31 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > > On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
> > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com>:
> > > > > > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.

(1)

> > > > > > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > > > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > > > > > What about bare metal configurations where the bootloader provides
> > > > > > > > services to the OS?
> > > > > > >
> > > > > > > No it is always the case. I suggest you go read your own Intel specs
> > > > > > > and datasheets

(2)

> > > > > > Point me out, please, chapters in SDM (I never really read it in full,
> > > > > > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > > > > > 1Mb physical address space that the CPU runs at first.
> > > > >
> > > > > So you do not know what you are talking about, am I correct?
> > > >
> > > > Let me comment on this provocative question later, after some other
> > > > comments first.
> > > >
> > > > > Starting
> > > > > from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> > > > > are referring to is the 8086 reset vector and that was like 40 years
> > > > > ago.
> > > >
> > > > True. The idea is the same, It has a reset vector standard for x86
> > > > (which doesn't explicitly tell what is there). So, nothing new or
> > > > different here.
> > > >
> > > > > Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> > > > > Instruction Executed", paragraph two. Just watch out for the hex
> > > > > number train starting with FFFFF... then you will find it. This is
> > > > > what requires the memory range to be mapped. Modern Intel CPUs require
> > > > > larger portions, because of the ACM loading and XuCode and whatnot.
> > > >
> > > > Thanks. Have you read 9.7 and 9.8, btw?
> > > > Where does it tell anything about memory to be mapped to a certain
> > > > address, except the last up to 16 bytes?
> > >
> > > It doesn't, except that the FIT, ACM, BootGuard, XuCode stuff rely on
> > > their binaries to be there, this just sets the upper address limit of
> > > the window.
> >
> > Why is it needed? I mean the listed blobs are not mandatory to get
> > system boot. Is this correct?
>
> That doesn't matter for this case.

Then why did you mention them?

> > > > > Please refer to the email [1] from me linked below where I reference
> > > > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > > > hard-wired. Note that the range cannot be turned off and will read
> > > > > back 0xFF's if the PCH registers are configured to not be backed by
> > > > > the actual SPI flash contents.
> > > >
> > > > And as I said it does not cover _all_ x86 designs (usual != all) .
> > > > Have you heard about Intel MID line of SoCs? Do you know that they
> > >
> > > No and a quick search didn't turn up anything. Can you point me to
> > > resources about those SoCs? Also my module is targeting x86_64, that
> > > is only a subset of x86 designs.
> >
> > They are x86_32 and x86_64, so in the category you listed.
> >
> > Unfortunately there is indeed not much publicly available information,
> > but I can tell you that from a design perspective you may consider
> > them PCH-less.
>
> Okay fine. Now you come around the corner with undocumented Intel
> devices and make your first semi-valid point.

Huh?!
You simply have the wrong assumption (see (1) and (2) above) and
_this_ is my point. And it seems you still can't admit that. Be brave!

> Why did it take you so
> long?

Same question to you.

>  Why did you seemingly just try to derail the discussion before?

See just above. I don't like when people are blind with their
brilliant solutions.

> Is the documentation non-existent or just NDA?

Of course documentation exists. Otherwise it wouldn't be possible to
program or do something about the chips.

> May I remind you that from a CPU view it doesn't matter if the PCH or
> some other thing attached to the CPU's bus provides the mapping.

Exactly my (another) point!

> So if that is your concern, then the solution would be to probe if we
> see a PCH or FCH?

If you can do that...

Bottom line, the proposed solution can't be accepted because it
appeals to the false assumptions besides other technical issues which
have been pointed out by the others.

> > > > have no SPI NOR and the firmware is located on eMMC? Do you know that
> > > > they can run Linux?
> > >
> > > It doesn't matter where the firmware is coming from, as long as it is
> > > _mapped_.
> >
> > It's not. That address space is full of devices, the same memory can't
> > be used for ROM and devices at the same time (I won't go to the weird
> > concept of different read and write paths, and it's not applicable
> > here anyway).
> >
> > > And something has to be mapped there, even if it is just a
> > > loader that gets eMMC going.
> >
> > (Semi-)wrong. Yes, _something_ is there (with the holes), but it's
> > _not_ a firmware memory.
> >
> > You may google for iomem output on that kind of device.
> >
> > For your convenience (an excerpt):
> >
> >   fee00000-fee00fff : Local APIC
> >    fee00000-fee00fff : Reserved
> >  ff000000-ffffffff : Reserved
> >    ff008000-ff008fff : 0000:00:0c.0
> >      ff008000-ff008fff : 0000:00:0c.0
> >    ff009000-ff009fff : 0000:00:13.0
> >      ff009000-ff009fff : intel_scu_ipc
> >
> > > > So, maybe it's you who do not know what you are talking about, am I correct?
> > > >
> > > > > [1] https://lkml.org/lkml/2021/6/24/379
> >
> > --
> > With Best Regards,
> > Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
