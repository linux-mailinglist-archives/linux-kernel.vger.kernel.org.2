Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42ECE44D9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhKKQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhKKQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:10:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30224C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:07:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so10601725wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIkJoHo49nDB7d1kNVJcqRJr0HpVKkGDJ4epEGRcchQ=;
        b=67Lrk1tLsWVtEjr2Q11WYluG4LUvxRHHehh9KUiY8bUlDNUBcWcwf2lZwc03cX1FSR
         tOotfcpHZXrs5mzlhsQcOq47Y3ovQ+KY2PbkSCF3vdYp8lODvVcqRlh/i6VLK8edRpxF
         YUF6lTd7ef8RNBWZ9ziZJSj/N7g1gyNt/qkvlTDOBvdQaWjaah0QHi1Bir+eQd5qr+am
         Y4i0B/kCIk/+3YpAk1MUVyyn+UjKSfICaZ4ErIQQLKZ1pKwRg974FHFf/HECgFgPo4WZ
         QabHYObOjWF+bsMZPQCcDkg2aQ3ClKoEE2OiiXWEqkf8TeZ8YnxuZB6i0AJmnFXnFkWw
         CvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIkJoHo49nDB7d1kNVJcqRJr0HpVKkGDJ4epEGRcchQ=;
        b=JOcySX5ZFgrhR9SLYBRXqkbsMADpFY6P+Rf0vlbCFe4Z/UK8fdvunwAQvsaoTfiBae
         qDz8aUph2MYQGdFqOOh6I5HwoXr3GfKH+FqGWdujj9ABvcgAxyodkwPb6ao2bNYmoBME
         zmsgPuwqU5ZhN1bfHITfGe6rOv93ploVjAJ6swcZ/A3c4a6uSLPldY6ce0IQ8jp/QxxK
         kk/XjSW0pFrCQ4MZto13LZEh7z9Td65008OgPwtlCBoxpDPxCFWI8e/ZT2VpifAt5ZsW
         m+CeGjvqS7slCTgsHLjZdkCAW+nMTL5VeZQu2G2A51oz8CSFu4HJJVBE2FVST1zsNXb7
         2fHA==
X-Gm-Message-State: AOAM532MnpLM3EmpZdXc44QT4fTGUhInS3sOGI4GT6nyJMTjRdUUfzlC
        Jn1+Tz+QC3qsqGkMKg3+uxxCm9GY6ReiMfCTfmVA/1Met/G3isq6
X-Google-Smtp-Source: ABdhPJxeFAt+bFa2IjwBgy1mqrAdkL2HaPzN4eJux2ID2pL419IbRKkQt1WDH2/QiIQ4vPTgMacFZUA1k9E8mH25q/I=
X-Received: by 2002:a5d:464c:: with SMTP id j12mr10055416wrs.150.1636646876725;
 Thu, 11 Nov 2021 08:07:56 -0800 (PST)
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
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 17:07:44 +0100
Message-ID: <CAHifhD4KbLQTA1=vVCeftKybSjU1tHGk7OZn4PN55eXUu-yKog@mail.gmail.com>
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

Am Do., 11. Nov. 2021 um 16:31 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
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

It doesn't, except that the FIT, ACM, BootGuard, XuCode stuff rely on
their binaries to be there, this just sets the upper address limit of
the window.

> > Please refer to the email [1] from me linked below where I reference
> > all PCH datasheets of the x64 era to prove that 16MB are mapped
> > hard-wired. Note that the range cannot be turned off and will read
> > back 0xFF's if the PCH registers are configured to not be backed by
> > the actual SPI flash contents.
>
> And as I said it does not cover _all_ x86 designs (usual != all) .
> Have you heard about Intel MID line of SoCs? Do you know that they

No and a quick search didn't turn up anything. Can you point me to
resources about those SoCs? Also my module is targeting x86_64, that
is only a subset of x86 designs.

> have no SPI NOR and the firmware is located on eMMC? Do you know that
> they can run Linux?

It doesn't matter where the firmware is coming from, as long as it is
_mapped_. And something has to be mapped there, even if it is just a
loader that gets eMMC going.

>
> So, maybe it's you who do not know what you are talking about, am I correct?
>
> > [1] https://lkml.org/lkml/2021/6/24/379
>
> --
> With Best Regards,
> Andy Shevchenko
