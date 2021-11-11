Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA76544D954
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhKKPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKPqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:46:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E992161179;
        Thu, 11 Nov 2021 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636645407;
        bh=s0P27p9klu2udk+yecyDLl8Dr/l7vMczMSfj2muJPsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rKbNegGavffz/Uv+exArc133KjBnCAPl3fJ606L8erP3w/VRFj+07gJcCPc0h7PR4
         aMiOefl28ZOUjAdcJKlgxnVrqVFrmIirTit4WCvSENvhHcsdht6aXZlwqe2cLxccNj
         05GHPQb8Dq+YuLo3BFZVKfm7u3dkQrX92joAGH4ZLcogsaQ24SKFVsehXTPc7T4L7r
         S1AMRMPhO/WVvCeNkgili+oMPU7FCActTvJZwgAkz4nNUuNSiyE9eR9uxTdO4/OnCl
         e8ekZWlUI8mesi1vX4uSrSJ+mMrr8EBrKuv35RUgeRzYZolzSWQksM+s5yQqN87kA4
         eBf4aiKsatRQw==
Received: by mail-oi1-f181.google.com with SMTP id m6so12323241oim.2;
        Thu, 11 Nov 2021 07:43:27 -0800 (PST)
X-Gm-Message-State: AOAM530AGRI4U0n7SQJixnlAQZ/r/sqxqkwzvPofYQ9K4rOMvluVeb46
        GdEvuZH632xwor+bmzjVQ/uFw8fO9S+8wK2VOQA=
X-Google-Smtp-Source: ABdhPJxUeL7Ec33BBif4e5ac+GDzauD0T2LW+0yWVxtHjxIu4HtqgXqjNRlBbhOkzaStg+NY7T7HKP6ehob8/gxsMTs=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr6938143oib.33.1636645407245;
 Thu, 11 Nov 2021 07:43:27 -0800 (PST)
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
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com> <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
In-Reply-To: <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Nov 2021 16:43:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
Message-ID: <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Thu, 11 Nov 2021 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
> <hans-gert.dahmen@immu.ne> wrote:
> > Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > > <hans-gert.dahmen@immu.ne> wrote:
> > > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > > <andy.shevchenko@gmail.com>:
> > > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> > > > >
> > > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > > What about bare metal configurations where the bootloader provides
> > > > > services to the OS?
> > > >
> > > > No it is always the case. I suggest you go read your own Intel specs
> > > > and datasheets
> > >
> > > Point me out, please, chapters in SDM (I never really read it in full,
> > > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > > 1Mb physical address space that the CPU runs at first.
> >
> > So you do not know what you are talking about, am I correct?
>
> Let me comment on this provocative question later, after some other
> comments first.
>
> > Starting
> > from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> > are referring to is the 8086 reset vector and that was like 40 years
> > ago.
>
> True. The idea is the same, It has a reset vector standard for x86
> (which doesn't explicitly tell what is there). So, nothing new or
> different here.
>
> > Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> > Instruction Executed", paragraph two. Just watch out for the hex
> > number train starting with FFFFF... then you will find it. This is
> > what requires the memory range to be mapped. Modern Intel CPUs require
> > larger portions, because of the ACM loading and XuCode and whatnot.
>
> Thanks. Have you read 9.7 and 9.8, btw?
> Where does it tell anything about memory to be mapped to a certain
> address, except the last up to 16 bytes?
>
> > Please refer to the email [1] from me linked below where I reference
> > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > hard-wired. Note that the range cannot be turned off and will read
> > back 0xFF's if the PCH registers are configured to not be backed by
> > the actual SPI flash contents.
>
> And as I said it does not cover _all_ x86 designs (usual != all) .
> Have you heard about Intel MID line of SoCs? Do you know that they
> have no SPI NOR and the firmware is located on eMMC? Do you know that
> they can run Linux?
>
> So, maybe it's you who do not know what you are talking about, am I correct?
>
> > [1] https://lkml.org/lkml/2021/6/24/379
>

Thanks for looping me in (I think ...)

The thing I don't like about exposing the entire SPI NOR region to
user space is that we can never take it back, given the 'never break
user space' rule. So once we ship this, the cat is out of the bag, and
somebody (which != the contributors of this code) will have to
maintain this forever.

Also, you quoted several different use cases, all of which are
currently served by exposing a chunk of PA space, and letting the user
do the interpretation. This is not how it usually works: we tend to
prefer targeted and maintainable interfaces. That woudl mean that,
e.g., fwupd can invoke some kind of syscall to get at the version
numbers it is after, and the logic that finds those numbers is in the
kernel and not in user space.

For the pen testing use case, things are likely a bit different, so I
realize this is not universally applicable, but just exposing the PA
space directly is not the solution IMO.
