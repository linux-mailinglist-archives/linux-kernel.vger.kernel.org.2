Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34C344D92D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhKKPd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:33:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93871C061766;
        Thu, 11 Nov 2021 07:31:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o8so25565114edc.3;
        Thu, 11 Nov 2021 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5nCrzgeg0S1QzoYZ4cedeygYrNZFLTg5qwsY/kUNL0=;
        b=Btdfer9wvUWAZbFdhRybOlLiijhDHpDvo16GyrKBUYp64NQQWGRH43go3cNBTLxFKD
         +Bn94QTtcmyH83kGxGdhYdALz1bLS4aYLeAzBoTIBHzLQKODro2fRfw1NrZE3Fbb2VG1
         /KKmyC5OTEiQaiRq0U6TWWEGeDGLgoLWWVHQWTpnmmvdJiTop8XXqpZzMaR4tG31uHJi
         TASSHk+mGeV8pdnfoV51YrgiI4IZJ+lynOoIMZDuUWo6SXRuuF+rmaFGmUJIM4UlYu19
         hBOmMQP5l+JaQ6iJjrXtdSaISVbuX0P3ssu38VZUvtzbk5Sn84Cl+t2qhJ1g0yhy53Qz
         VM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5nCrzgeg0S1QzoYZ4cedeygYrNZFLTg5qwsY/kUNL0=;
        b=8SZotGaVxDJ6o7mDlOd+Gka8XTTzSE29A/hrWUikha4texS51GxMCLWhKXSx99Of1e
         JIuIVlC92IF7zZAuZkagED1EJWqXd5kb73VffdLOIOGRHVkUHJs4lhNpXmeRfUBncMFC
         qK14369pBCN/qKwo5kDJlGZDuEZxhFDtv6rH0tqXmYdIfUuHPdv6kHdtAemBXgI8a5Ez
         Ec69rmCGog4udiqqfJ3JpESntg+axjQkMtSnu1hIiEvDh1Y1ohstpqTojkUZtlqN7ZS/
         v+PEF0aWeWz/Q0YqZdvffUEqBJyfgMGp0g7LYcSdsoEe6cOhbRbXMmEbmAKNUeEccPod
         KRXA==
X-Gm-Message-State: AOAM530OM+3paIYeRG31xwEXTIM08sV7tElcgh+ePFamSZ6yPdODK03q
        14aSQsMzGQ8b9JJ/m8utgxM7lMKJ08oJEeicKAw=
X-Google-Smtp-Source: ABdhPJxj/UBc4UfN5lKvQouhXTWDHuXIlwHlnKEN41ZSV3ygW3c3BuQGi9nM0tqaevBjchLkgQ68xb50V7bcEocq+5E=
X-Received: by 2002:a50:8741:: with SMTP id 1mr5560490edv.119.1636644663323;
 Thu, 11 Nov 2021 07:31:03 -0800 (PST)
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
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com> <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
In-Reply-To: <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 17:30:18 +0200
Message-ID: <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
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

On Thu, Nov 11, 2021 at 4:33 PM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
> Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> > On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> > > >
> > > > Well, it's _usual_ case, but in general the assumption is simply
> > > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > > What about bare metal configurations where the bootloader provides
> > > > services to the OS?
> > >
> > > No it is always the case. I suggest you go read your own Intel specs
> > > and datasheets
> >
> > Point me out, please, chapters in SDM (I never really read it in full,
> > it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> > 1Mb physical address space that the CPU runs at first.
>
> So you do not know what you are talking about, am I correct?

Let me comment on this provocative question later, after some other
comments first.

> Starting
> from 386 the first instruction is executed at 0xFFFFFFF0h. What you
> are referring to is the 8086 reset vector and that was like 40 years
> ago.

True. The idea is the same, It has a reset vector standard for x86
(which doesn't explicitly tell what is there). So, nothing new or
different here.

> Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
> Instruction Executed", paragraph two. Just watch out for the hex
> number train starting with FFFFF... then you will find it. This is
> what requires the memory range to be mapped. Modern Intel CPUs require
> larger portions, because of the ACM loading and XuCode and whatnot.

Thanks. Have you read 9.7 and 9.8, btw?
Where does it tell anything about memory to be mapped to a certain
address, except the last up to 16 bytes?

> Please refer to the email [1] from me linked below where I reference
> all PCH datasheets of the x64 era to prove that 16MB are mapped
> hard-wired. Note that the range cannot be turned off and will read
> back 0xFF's if the PCH registers are configured to not be backed by
> the actual SPI flash contents.

And as I said it does not cover _all_ x86 designs (usual != all) .
Have you heard about Intel MID line of SoCs? Do you know that they
have no SPI NOR and the firmware is located on eMMC? Do you know that
they can run Linux?

So, maybe it's you who do not know what you are talking about, am I correct?

> [1] https://lkml.org/lkml/2021/6/24/379

-- 
With Best Regards,
Andy Shevchenko
