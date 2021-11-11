Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7244D98A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhKKPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbhKKPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:53:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4CC061205;
        Thu, 11 Nov 2021 07:50:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c8so25538095ede.13;
        Thu, 11 Nov 2021 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M1Wz6NU/8H3Jq07UkfYR+o0iAJjTaXNhdrl+jV6eKs=;
        b=NUfbBY5Dg6VfgA7uhvyVuR4yoVn/iQUhzBa22R6IKkMJQu6fHB7T+8+8bABdGQQT3G
         UzrPI1hOrHEJXqxJwgBKrBJ2s5GFAV/r461jAYHAVnwzcATGALlMmutP5bLw31I0sTZ7
         tXJX90fNIl/S/2/fWi7dGA1VRXm6Udc0HwUwrLMmj1ocFxLqhBRP4ZXqK2F18lFytx9k
         OKRPc6epdxYbpD5SOiGBre//WCrVghlH4GvtWrUdbwlvMPtcoLo5KZOiABWASgnntu7P
         aXg4znQt4/yi/KrxTQqua0aEqOnJJoxqmy1i9sTcnLV2WKUnhdIsErk3sE07i15VMUBc
         JSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M1Wz6NU/8H3Jq07UkfYR+o0iAJjTaXNhdrl+jV6eKs=;
        b=1BshgoAS5d5Hknj2rkftWqQ7nosS9HAVKmkaNIUga/aWsNFELkIOPejC9MTdyLdl/e
         M1x6o97ingtlHH05Y4Xj/GwLkLvOhWpw8xUcRFgMoHr7z7CfXtId3xnWbiSj6onuxn9U
         uV4OBUfg2aPLrpbG3J2IogRh7sctRBzaXUn3Rgu0Lb6vuMep+8nhmxFuljn8VWdG4YER
         fraakkrPGhrNjrmWIxdhYoU6Iuf/i6x93u09MhUUTGOyyz41PeDRnQt0Q7oM0Kpmjwat
         D/PTQrdnMD11kMyAebwvft9DrTV9cz8YG5sDpeI3r8Rf2awqWBsYRek7K8TSVHdWmc4z
         DzYw==
X-Gm-Message-State: AOAM531NLjeiednjrcrni/4JDmfxf3YaLj/oq3xy4l5x0cw0cGFd57fa
        Tn7jswegcFN0FMoPLesKr0OK+FOT46zabq28oPY=
X-Google-Smtp-Source: ABdhPJxxgrQNoP2jnPDycoc5a769RJ1GueCrKscUbDQ+NWzt23+QTGAoJJwhsL3c0tZfm+uMfogmzaHj0d3Ezfs3EX0=
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr11039835edy.107.1636645810343;
 Thu, 11 Nov 2021 07:50:10 -0800 (PST)
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
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com> <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
In-Reply-To: <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 17:49:26 +0200
Message-ID: <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Richard Hughes <hughsient@gmail.com>,
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

On Thu, Nov 11, 2021 at 5:43 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 11 Nov 2021 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
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
> > > Please refer to the email [1] from me linked below where I reference
> > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > hard-wired. Note that the range cannot be turned off and will read
> > > back 0xFF's if the PCH registers are configured to not be backed by
> > > the actual SPI flash contents.
> >
> > And as I said it does not cover _all_ x86 designs (usual != all) .
> > Have you heard about Intel MID line of SoCs? Do you know that they
> > have no SPI NOR and the firmware is located on eMMC? Do you know that
> > they can run Linux?
> >
> > So, maybe it's you who do not know what you are talking about, am I correct?
> >
> > > [1] https://lkml.org/lkml/2021/6/24/379
>
> Thanks for looping me in (I think ...)

Thank you for chiming in!

> The thing I don't like about exposing the entire SPI NOR region to
> user space is that we can never take it back, given the 'never break
> user space' rule. So once we ship this, the cat is out of the bag, and
> somebody (which != the contributors of this code) will have to
> maintain this forever.
>
> Also, you quoted several different use cases, all of which are
> currently served by exposing a chunk of PA space, and letting the user
> do the interpretation. This is not how it usually works: we tend to
> prefer targeted and maintainable interfaces. That woudl mean that,
> e.g., fwupd can invoke some kind of syscall to get at the version
> numbers it is after, and the logic that finds those numbers is in the
> kernel and not in user space.

I was thinking about SHA256 hashes or so (as they tell about
binaries). In any case the interface for this seems to be in the
kernel.

It is also possible to do the other way around, i.e. piping binary to
the kernel and wait for the answer if it is the same or not or...

> For the pen testing use case, things are likely a bit different, so I
> realize this is not universally applicable, but just exposing the PA
> space directly is not the solution IMO.


-- 
With Best Regards,
Andy Shevchenko
