Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3750C44D9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhKKQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhKKQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:08:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69EBC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:05:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso2370541wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pm7n/4dnc2MbJNtR6nV+0gvIHCB7NPnJxlVJbDiXAyM=;
        b=dzfWJrH3allKPA4G1tMFLRZrIapX53LToHlnTRpc75HNMJRLOFpey6A+359sRZM5xY
         BlTFXrd4Lk0Z560BEvmOyGwKzr7PcpEsdF2DqVKSIO7bbzdy/VqnBjQUvYqpcN7xO2f8
         Cfq5pdADlGMoE4vKdAes2immvLK2mrPiQINrUS9WI9Q+leKKCPGmP3nlREU2zVunfDx6
         7f9aP+syfqRWP0AEk0666QSVEMXlRiGSXGFSDBSNVmW63FxQ9sLZVA+n235ZhwheG9n2
         w7Oze809rEstfz2wxYUbOfjV1EDeDlrtYrXO2ooAyWhzFII8NyzUKE3uPEeXHzhGg/mF
         VX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pm7n/4dnc2MbJNtR6nV+0gvIHCB7NPnJxlVJbDiXAyM=;
        b=wp+2y9hUHAts7OGRM/ulv9/frWx+ZUIuSef5/4/NCOOn9A8IASpIDjjUI7WtxlPs41
         JP9a6xjsCgZgOk4Ktq0HlMknMxZ8rVinlmPGP+prWoevluNsWpvk7OnJf8RWGDk6XZ31
         PBQ2wuFIJFJOYgl1oI7BcDyxvv2I+0ERKLoIuFh21dzwbZu5AfzYRDn7ALGBs0/etAVW
         grwwz+hi4K7IGFju68kGGgcF3wWDW6jpxu3i9249FSV/DS/J19aFt10AXGyPsswpb1xO
         UGXQFSaodw/LY/7NlXVDuTJCVg6Ya9RGSNEGNb4PfJ43Oh0bHesppu6QDVDXgNO1VOAo
         FyIQ==
X-Gm-Message-State: AOAM533jSAUfsJC+9mT7pz2wmVnYm9YCKjlXapXPaC3YlfrQENOEslC3
        /2VHBQwA+RhPl2kCH1bnMC9WStHkqbI54+NOSyEBoQ==
X-Google-Smtp-Source: ABdhPJzsWEhNQD7R1s97GYV0Jz4SS2WLD6yVai7hOc1rY5Y3oMLG3v+0YbevaDrB4LpizTUcTEcfjNIbWoQw2LQLIYY=
X-Received: by 2002:a1c:790d:: with SMTP id l13mr27229558wme.101.1636646719280;
 Thu, 11 Nov 2021 08:05:19 -0800 (PST)
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
 <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com> <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
In-Reply-To: <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 17:05:07 +0100
Message-ID: <CAHifhD6ekUjsHaR9j9XrsSMwEjJtEE3Dtz=xW8E7ctVwUVPedQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

Am Do., 11. Nov. 2021 um 16:50 Uhr schrieb Andy Shevchenko

<andy.shevchenko@gmail.com>:
>
> On Thu, Nov 11, 2021 at 5:43 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 11 Nov 2021 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
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
> > > > Please refer to the email [1] from me linked below where I reference
> > > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > > hard-wired. Note that the range cannot be turned off and will read
> > > > back 0xFF's if the PCH registers are configured to not be backed by
> > > > the actual SPI flash contents.
> > >
> > > And as I said it does not cover _all_ x86 designs (usual != all) .
> > > Have you heard about Intel MID line of SoCs? Do you know that they
> > > have no SPI NOR and the firmware is located on eMMC? Do you know that
> > > they can run Linux?
> > >
> > > So, maybe it's you who do not know what you are talking about, am I correct?
> > >
> > > > [1] https://lkml.org/lkml/2021/6/24/379
> >
> > Thanks for looping me in (I think ...)
>
> Thank you for chiming in!
>
> > The thing I don't like about exposing the entire SPI NOR region to
> > user space is that we can never take it back, given the 'never break
> > user space' rule. So once we ship this, the cat is out of the bag, and
> > somebody (which != the contributors of this code) will have to
> > maintain this forever.
> >
> > Also, you quoted several different use cases, all of which are
> > currently served by exposing a chunk of PA space, and letting the user
> > do the interpretation. This is not how it usually works: we tend to
> > prefer targeted and maintainable interfaces. That woudl mean that,
> > e.g., fwupd can invoke some kind of syscall to get at the version
> > numbers it is after, and the logic that finds those numbers is in the
> > kernel and not in user space.
>
> I was thinking about SHA256 hashes or so (as they tell about
> binaries). In any case the interface for this seems to be in the
> kernel.
>
> It is also possible to do the other way around, i.e. piping binary to
> the kernel and wait for the answer if it is the same or not or...
>
> > For the pen testing use case, things are likely a bit different, so I
> > realize this is not universally applicable, but just exposing the PA
> > space directly is not the solution IMO.
>

All of this doesn't really sound like it is more maintainable. It
requires the base use case, being able to read the BIOS/UEFI binary
plus more code and a more complicated interface. So if you do this,
there's more cats out of the bag.
Also please be aware that not everything is UEFI and you would
probably need to support things like CoreBoot as well.

>
> --
> With Best Regards,
> Andy Shevchenko
