Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02E44DC00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhKKTRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhKKTRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:17:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97C6761269;
        Thu, 11 Nov 2021 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636658088;
        bh=fLq87UbMLm9X6eW2rQdFoIKXAz4h2P6ghyXFhpUb+Zo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uiN1T+nKgpu3G3V1bNu0KoXFt/c3ZKOARv5VYcGWq0XbMcjAute2Soc2EDBXOyjRH
         JSyBMEfHZf6KUuVrQQ9PFaKt8oobQ5ZHqFJ3vsVFp2yocqjsdI8uRWqGcNIU/M1eOj
         2SIO/PjpWdQPhwO3WI2kae6NjNIERNW6RE2lzi6JHSOD9DW6Q2pOt9QRHAFGhImkj5
         XP8KrX5hLY1q88DhQ8xCEmtw3wc/x4jhvwqjkYzXmLC2FXU+3W6JUtOLKnUhmMxnyk
         4cbS+HMWQCykqK3xxMy1IcqOYkAgU5UivjKvhqkP3kzSgKktNkI5ckyaTn682p4vT+
         dFi2Xni+OSZ8w==
Received: by mail-oi1-f171.google.com with SMTP id o83so13340260oif.4;
        Thu, 11 Nov 2021 11:14:48 -0800 (PST)
X-Gm-Message-State: AOAM532Yc5h1bYVAi3nO1kkaWpEpz5Bb4cUJ4cNsQscnCugwt5zOsvYg
        DCJDlthmkvr+clN/3OSGV5EtbMVGMSg0h82FtdE=
X-Google-Smtp-Source: ABdhPJz2WvXAOmi6gF0GFDDVpw6ZT9hWI+Bx859nG1W+CZYMdLudyfxgodmghTkUA1HMwr1ctAsZNLMLQFv8Mp4U/UU=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr8121280oib.33.1636658087851;
 Thu, 11 Nov 2021 11:14:47 -0800 (PST)
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
 <CAHp75Vfc85XnVmnJ0ytm_XCGSoqFfiMQ3jxXCudsyo5XW6brTQ@mail.gmail.com>
 <CAHifhD42G+7BQHBwS=ZFzcv9On0TFNFLV+HARjWENUAmX-8WaQ@mail.gmail.com>
 <CAHp75Vcn6023eNCmRupRDLVHQrmGgAJ56TPEjHpDoQrwNgC8Hg@mail.gmail.com> <CAHifhD7bc46ro39JVg3P_M2TRW9BJmcxMCSnMVNOc0DoNN8fHg@mail.gmail.com>
In-Reply-To: <CAHifhD7bc46ro39JVg3P_M2TRW9BJmcxMCSnMVNOc0DoNN8fHg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Nov 2021 20:14:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFeHhA2CgBgiO5d39+0C42rsd1C=kZVS32z0j4WEx-vZQ@mail.gmail.com>
Message-ID: <CAMj1kXFeHhA2CgBgiO5d39+0C42rsd1C=kZVS32z0j4WEx-vZQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Thu, 11 Nov 2021 at 19:15, Hans-Gert Dahmen <hans-gert.dahmen@immu.ne> wrote:
>
> Am Do., 11. Nov. 2021 um 18:49 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> >
> > On Thu, Nov 11, 2021 at 6:55 PM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > > Am Do., 11. Nov. 2021 um 17:45 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > > On Thu, Nov 11, 2021 at 6:07 PM Hans-Gert Dahmen
> > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > Am Do., 11. Nov. 2021 um 16:31 Uhr schrieb Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com>:
> > > > > > On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
> > > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > > Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > > > > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > > > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > > > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > > > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > > > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> >
> > (1)
> >
> > > > > > > > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > > > > > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > > > > > > > What about bare metal configurations where the bootloader provides
> > > > > > > > > > services to the OS?
> > > > > > > > >
> > > > > > > > > No it is always the case. I suggest you go read your own Intel specs
> > > > > > > > > and datasheets
> >
> > (2)
> >
> > > > > > > > Point me out, please, chapters in SDM (I never really read it in full,
> > > > > > > > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > > > > > > > 1Mb physical address space that the CPU runs at first.
> > > > > > >
> > > > > > > So you do not know what you are talking about, am I correct?
> > > > > >
> > > > > > Let me comment on this provocative question later, after some other
> > > > > > comments first.
> > > > > >
> > > > > > > Starting
> > > > > > > from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> > > > > > > are referring to is the 8086 reset vector and that was like 40 years
> > > > > > > ago.
> > > > > >
> > > > > > True. The idea is the same, It has a reset vector standard for x86
> > > > > > (which doesn't explicitly tell what is there). So, nothing new or
> > > > > > different here.
> > > > > >
> > > > > > > Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> > > > > > > Instruction Executed", paragraph two. Just watch out for the hex
> > > > > > > number train starting with FFFFF... then you will find it. This is
> > > > > > > what requires the memory range to be mapped. Modern Intel CPUs require
> > > > > > > larger portions, because of the ACM loading and XuCode and whatnot.
> > > > > >
> > > > > > Thanks. Have you read 9.7 and 9.8, btw?
> > > > > > Where does it tell anything about memory to be mapped to a certain
> > > > > > address, except the last up to 16 bytes?
> > > > >
> > > > > It doesn't, except that the FIT, ACM, BootGuard, XuCode stuff rely on
> > > > > their binaries to be there, this just sets the upper address limit of
> > > > > the window.
> > > >
> > > > Why is it needed? I mean the listed blobs are not mandatory to get
> > > > system boot. Is this correct?
> > >
> > > That doesn't matter for this case.
> >
> > Then why did you mention them?
> >
> > > > > > > Please refer to the email [1] from me linked below where I reference
> > > > > > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > > > > > hard-wired. Note that the range cannot be turned off and will read
> > > > > > > back 0xFF's if the PCH registers are configured to not be backed by
> > > > > > > the actual SPI flash contents.
> > > > > >
> > > > > > And as I said it does not cover _all_ x86 designs (usual != all) .
> > > > > > Have you heard about Intel MID line of SoCs? Do you know that they
> > > > >
> > > > > No and a quick search didn't turn up anything. Can you point me to
> > > > > resources about those SoCs? Also my module is targeting x86_64, that
> > > > > is only a subset of x86 designs.
> > > >
> > > > They are x86_32 and x86_64, so in the category you listed.
> > > >
> > > > Unfortunately there is indeed not much publicly available information,
> > > > but I can tell you that from a design perspective you may consider
> > > > them PCH-less.
> > >
> > > Okay fine. Now you come around the corner with undocumented Intel
> > > devices and make your first semi-valid point.
> >
> > Huh?!
> > You simply have the wrong assumption (see (1) and (2) above) and
> > _this_ is my point. And it seems you still can't admit that. Be brave!
> >
>
> I thought my last email was admitting that, but, if you insist, I
> hereby explicitly admit, that, now, after some 40 emails, you have
> brought forward a valid point that proves my assumption wrong. If this
> is what makes you happy, then I can also certify my defeat on paper
> and send it to you so you can hang it as a trophy on your wall. The
> notion of being brave or not has no value for me here, I am purely
> interested in the technical details. I never said that my solution was
> brilliant, and, all I wanted, was, as you already know: to retain
> functionality used by userspace tools on locked-down systems. Please,
> next time, be of good character and don't play games like this. Just
> directly bring forward the evidence to challenge an assumption.
>
> > > Why did it take you so
> > > long?
> >
> > Same question to you.
> >
> > >  Why did you seemingly just try to derail the discussion before?
> >
> > See just above. I don't like when people are blind with their
> > brilliant solutions.
>
> Again, now, if you have the feeling that someone is blind, please
> don't fool them around just to make them painfully aware of their
> blind spot. IMO the more human solution is not to react with anger,
> like you did, but with constructivism.
>

Can we cut the drama please?

Greg has already pointed out that you cannot blindly expose this
without tying it to a property exposed by the hardware. Andy has
pointed out that your assumption that any x86_64 based platform
exposes this region does not hold.

So maybe it is time for some 'constructivism' on your part, and simply
go and implement what the reviewers suggested, rather than keep this
pointless discussion going?
