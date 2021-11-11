Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EE344DCB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhKKUxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhKKUxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:53:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF8C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:50:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso5318908wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWHPHXa4AwQGjzRVxE2FTFVY/HyV7zY/By1UX+UtDAI=;
        b=fhH0UeAVGJ5/elMJ7ssV9AOuBBJGG0XTtnAEm2811l+J7eHZYLP3xzpKyoLOV4FdiA
         E8Vq7H8OBw5OPyYksJkTeCPixvMcl5eurqotpr6vQbEdFOGmrBVHz18KtYlT/bDppysD
         MeQX4TBadmC6igyTEXzaTuLiCThkWaEvdeO02WsUx4cXevSSn4IYwvZaEBy7zkq8bZPq
         308P7WA+Lzw6Obe4UupOCvtjF4rSlkVbceVZUsxJ7LX88DQcMz43Y/nTr55/93gt42Vr
         TixHtlCu6eHcGKGhi0sd9z1TzUEaZ6s5/EwCkURdHif8wiBuP5z83NzfB7wSUx5n1JQN
         5TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWHPHXa4AwQGjzRVxE2FTFVY/HyV7zY/By1UX+UtDAI=;
        b=VuMIaA5brRzEZfZ+NycOah+luwInM1Bs/1IbLij9WehzSGsej178X1GTeE7R+TQDdk
         FCn5RncoxokccAzFuE0wF0sNC9uLb3/lsjhQO758R/PXA+GBx94CJ4YZyHr8CSdOYfMZ
         kYQCM5UBPAjdaO+Y2O3lfJyfw8gIbosUt5H96Si4VoQ7YLNQI/xIGVE2duD60eCQAPjZ
         SS7zWSVH5IIZ0FGlFRlowsahPS9REYB76X/WYAUbi0Q9SAFK5EAPOoxhGOhLp74BejW9
         usrNym1lGc/9udJon28oQzw+062n1DRkGIm7v1u7ivAVb8L7Gnhoe3kOHAdRFSolF7KY
         2GRw==
X-Gm-Message-State: AOAM5333Zv/M12TcicfnN7b1uKzSqXYTQL1h14iGwqvQkfvh3RzB3rGu
        OgNy7sBNY0xty/oG3V4liWnkFNJ6AVlktzkE8LxlQg==
X-Google-Smtp-Source: ABdhPJz8Ae7Xm3h8MamBDbyTwH6dZhSv0Mly4rxf6xyF7CYmPTPM7TpoaXjTMiiVisG20znovwvuDaWulFQqUufp15I=
X-Received: by 2002:a1c:790d:: with SMTP id l13mr29254453wme.101.1636663842424;
 Thu, 11 Nov 2021 12:50:42 -0800 (PST)
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
 <CAHp75Vcn6023eNCmRupRDLVHQrmGgAJ56TPEjHpDoQrwNgC8Hg@mail.gmail.com>
 <CAHifhD7bc46ro39JVg3P_M2TRW9BJmcxMCSnMVNOc0DoNN8fHg@mail.gmail.com> <CAMj1kXFeHhA2CgBgiO5d39+0C42rsd1C=kZVS32z0j4WEx-vZQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFeHhA2CgBgiO5d39+0C42rsd1C=kZVS32z0j4WEx-vZQ@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 21:50:30 +0100
Message-ID: <CAHifhD6DK5jTRrXjsnjjG96egsiC-C1FOHAXhdM7S1kfpuAfiw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Ard Biesheuvel <ardb@kernel.org>
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

Am Do., 11. Nov. 2021 um 20:14 Uhr schrieb Ard Biesheuvel <ardb@kernel.org>:
>
> On Thu, 11 Nov 2021 at 19:15, Hans-Gert Dahmen <hans-gert.dahmen@immu.ne> wrote:
> >
> > Am Do., 11. Nov. 2021 um 18:49 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > >
> > > On Thu, Nov 11, 2021 at 6:55 PM Hans-Gert Dahmen
> > > <hans-gert.dahmen@immu.ne> wrote:
> > > > Am Do., 11. Nov. 2021 um 17:45 Uhr schrieb Andy Shevchenko
> > > > <andy.shevchenko@gmail.com>:
> > > > > On Thu, Nov 11, 2021 at 6:07 PM Hans-Gert Dahmen
> > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > Am Do., 11. Nov. 2021 um 16:31 Uhr schrieb Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
> > > > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > > > Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> > > > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > > > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > > > > > > > > <hans-gert.dahmen@immu.ne> wrote:
> > > > > > > > > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > > > > > > > > <andy.shevchenko@gmail.com>:
> > > > > > > > > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > > > > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > > > > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> > >
> > > (1)
> > >
> > > > > > > > > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > > > > > > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > > > > > > > > What about bare metal configurations where the bootloader provides
> > > > > > > > > > > services to the OS?
> > > > > > > > > >
> > > > > > > > > > No it is always the case. I suggest you go read your own Intel specs
> > > > > > > > > > and datasheets
> > >
> > > (2)
> > >
> > > > > > > > > Point me out, please, chapters in SDM (I never really read it in full,
> > > > > > > > > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > > > > > > > > 1Mb physical address space that the CPU runs at first.
> > > > > > > >
> > > > > > > > So you do not know what you are talking about, am I correct?
> > > > > > >
> > > > > > > Let me comment on this provocative question later, after some other
> > > > > > > comments first.
> > > > > > >
> > > > > > > > Starting
> > > > > > > > from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> > > > > > > > are referring to is the 8086 reset vector and that was like 40 years
> > > > > > > > ago.
> > > > > > >
> > > > > > > True. The idea is the same, It has a reset vector standard for x86
> > > > > > > (which doesn't explicitly tell what is there). So, nothing new or
> > > > > > > different here.
> > > > > > >
> > > > > > > > Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> > > > > > > > Instruction Executed", paragraph two. Just watch out for the hex
> > > > > > > > number train starting with FFFFF... then you will find it. This is
> > > > > > > > what requires the memory range to be mapped. Modern Intel CPUs require
> > > > > > > > larger portions, because of the ACM loading and XuCode and whatnot.
> > > > > > >
> > > > > > > Thanks. Have you read 9.7 and 9.8, btw?
> > > > > > > Where does it tell anything about memory to be mapped to a certain
> > > > > > > address, except the last up to 16 bytes?
> > > > > >
> > > > > > It doesn't, except that the FIT, ACM, BootGuard, XuCode stuff rely on
> > > > > > their binaries to be there, this just sets the upper address limit of
> > > > > > the window.
> > > > >
> > > > > Why is it needed? I mean the listed blobs are not mandatory to get
> > > > > system boot. Is this correct?
> > > >
> > > > That doesn't matter for this case.
> > >
> > > Then why did you mention them?
> > >
> > > > > > > > Please refer to the email [1] from me linked below where I reference
> > > > > > > > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > > > > > > > hard-wired. Note that the range cannot be turned off and will read
> > > > > > > > back 0xFF's if the PCH registers are configured to not be backed by
> > > > > > > > the actual SPI flash contents.
> > > > > > >
> > > > > > > And as I said it does not cover _all_ x86 designs (usual != all) .
> > > > > > > Have you heard about Intel MID line of SoCs? Do you know that they
> > > > > >
> > > > > > No and a quick search didn't turn up anything. Can you point me to
> > > > > > resources about those SoCs? Also my module is targeting x86_64, that
> > > > > > is only a subset of x86 designs.
> > > > >
> > > > > They are x86_32 and x86_64, so in the category you listed.
> > > > >
> > > > > Unfortunately there is indeed not much publicly available information,
> > > > > but I can tell you that from a design perspective you may consider
> > > > > them PCH-less.
> > > >
> > > > Okay fine. Now you come around the corner with undocumented Intel
> > > > devices and make your first semi-valid point.
> > >
> > > Huh?!
> > > You simply have the wrong assumption (see (1) and (2) above) and
> > > _this_ is my point. And it seems you still can't admit that. Be brave!
> > >
> >
> > I thought my last email was admitting that, but, if you insist, I
> > hereby explicitly admit, that, now, after some 40 emails, you have
> > brought forward a valid point that proves my assumption wrong. If this
> > is what makes you happy, then I can also certify my defeat on paper
> > and send it to you so you can hang it as a trophy on your wall. The
> > notion of being brave or not has no value for me here, I am purely
> > interested in the technical details. I never said that my solution was
> > brilliant, and, all I wanted, was, as you already know: to retain
> > functionality used by userspace tools on locked-down systems. Please,
> > next time, be of good character and don't play games like this. Just
> > directly bring forward the evidence to challenge an assumption.
> >
> > > > Why did it take you so
> > > > long?
> > >
> > > Same question to you.
> > >
> > > >  Why did you seemingly just try to derail the discussion before?
> > >
> > > See just above. I don't like when people are blind with their
> > > brilliant solutions.
> >
> > Again, now, if you have the feeling that someone is blind, please
> > don't fool them around just to make them painfully aware of their
> > blind spot. IMO the more human solution is not to react with anger,
> > like you did, but with constructivism.
> >
>
> Can we cut the drama please?
>
> Greg has already pointed out that you cannot blindly expose this
> without tying it to a property exposed by the hardware. Andy has
> pointed out that your assumption that any x86_64 based platform
> exposes this region does not hold.
>
> So maybe it is time for some 'constructivism' on your part, and simply
> go and implement what the reviewers suggested, rather than keep this
> pointless discussion going?

It is in my best interest to not keep this discussion going and I
already asked a couple of times what hardware I could bind to on
tuesday. If there had been any constructive suggestion as to what I
could implement, I would already have done it. Andy only now pointed
out specifics about what could be the problem. Before that, the
reasons why my patch isn't welcome changed seemingly just to argue
against it and I was accused of trying to sneak something into the
kernel. Do you think I like to waste my and everyone's time like this?
Anyway, I am really tired of this and I nearly have wasted all my
holiday for this discussion, so I don't have any time and energy left
to finally implement the proper solution during this merge window.

Hans-Gert
