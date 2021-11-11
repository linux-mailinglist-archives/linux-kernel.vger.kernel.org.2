Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D0644D7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhKKN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:57:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877BC061766;
        Thu, 11 Nov 2021 05:55:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so24558992edz.2;
        Thu, 11 Nov 2021 05:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkAHHRELUR3r+2lukxo30sI9DzwFgcJtRiHk6YyjBfE=;
        b=nLlKfMMvzCLKY9hkrrxdIg+ATY/2fzIXErWKdMKOmbvypXaeA4UeZNQ19OCo2Zwwr1
         zd8/YcAfB2ZIAPPykQd6Nv21RYMfVgglKgiPsd1GbafCoesPtfF8Wjwtfp+3Ma+9FT80
         H+62xiUTd3T4Me6xC0QoMA8LR4t6rL8F5l425JvnhOlKpK68C8gupyHyTmdc5JRQ5vgX
         ism8uomf8kvHjZlbTB1VYYlPsQszDiMT3gnsVOmOGVT7gUIeo19kUExaTrG5rej26j3v
         4NtbxF3lBZy4/0TqBQ2Ct3155lSDhFhy+sExk6JYUevqGSP0kq9DwOzubBybKvKZO/0S
         Brfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkAHHRELUR3r+2lukxo30sI9DzwFgcJtRiHk6YyjBfE=;
        b=gFWw6qDqiypgGQnIzbf4WjTiPcMZ6n/layeD9rCzgguxjS7b4QxPVg6N5tyKLGVlJQ
         RnrhMb327wh+eOQririOsyLkYZTON0+KAy/Zp+TS+In/3g5vGo3+rdMq3Cl59PyhuKFW
         FdCHIlu1mrQix7IzOKO5cLJnn3Uprl7Q3soNICsQW2oyRmUoAmQBWIMR8rqjdZA0X42C
         9rxkY89nOJbQWF/+qSchv7rvtUrJmmSoS+9hwBiL2tPix+kcW/yRSYxh+iT7nblb2tpc
         WDT7zoJz51rvaSoLBuuGGTi3iSBX56QXxo6uUKZRJ/fEVIH8qHvPeY+Ig4tVjADcxejJ
         AY6g==
X-Gm-Message-State: AOAM532ald+/6YTHSUW412+3HBnrVEIvo3Txs+WWS7mBmCccMdgVIdbP
        FUFTLEzkNGv/kmdBERhiHburPqiAQCWSCh8emcE=
X-Google-Smtp-Source: ABdhPJzIGR0yr2K/uYmW72GvEIHnQ6+Ni56Znw65lXQD9xptQmRMY6gNhUaJPd9WkD0ddddvNs+w9QPIr9ySKoRFgyk=
X-Received: by 2002:a05:6402:c89:: with SMTP id cm9mr1443651edb.283.1636638906260;
 Thu, 11 Nov 2021 05:55:06 -0800 (PST)
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
 <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com> <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
In-Reply-To: <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 15:54:22 +0200
Message-ID: <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
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

On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
>
> Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> >
> > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> >
> > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> >
> > Well, it's _usual_ case, but in general the assumption is simply
> > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > What about bare metal configurations where the bootloader provides
> > services to the OS?
>
> No it is always the case. I suggest you go read your own Intel specs
> and datasheets

Point me out, please, chapters in SDM (I never really read it in full,
it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
1Mb physical address space that the CPU runs at first.

> before spreading further FUD. I have experienced u-root
> and coreboot developers sitting right next to me in my office and they
> were among the ones suggesting my patch. This is just laughable,
> please stop it Andy.

Yeah, zillion people can't ever make a mistake... I see.

-- 
With Best Regards,
Andy Shevchenko
