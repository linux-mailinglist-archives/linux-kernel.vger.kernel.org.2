Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1370E34CE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhC2K7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhC2K7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:59:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A09C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:59:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so4210229plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rs4sxhIzTtx/zF2Svpj68x4K4PKdIJdNkL7SpT6Ivs=;
        b=M7zcqYs/Gzqpp+6MMHvXly3Zq/rM6OKwF5FdniupYwWafJc4/RAP6a2EbBFyO8Zec8
         5KqhmS+mEqutR5E+SgKHSW5dBxe+bGW4PQ7IrSW/BrN+H7t9X6O4pmdKf6pn5wCLMcn1
         wM+xgDZVH6+r9J2Fl3p+hIEfGcvoyDz20E8WLBcvXfa6JBoI0XdQBuC4k5YjDrB4SK+t
         8qRo0w+tTSQJiX9ws9f+/1zbiPTU+jMMpj3o6QarsOUHBD19WRDGyVFJQluOo2hHOcKP
         ewYpiY+xeMvyx3gncrPwp9mHzUsW45Xmv4lDkJPAS9SxoVAsy+F4Simj7x6336vDDy92
         fqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rs4sxhIzTtx/zF2Svpj68x4K4PKdIJdNkL7SpT6Ivs=;
        b=BUsN3QW3ghBCQAsQAAoUa0caZt/QpA9mR74rBYNGsgTbdvoJVa5TEwwE2DmefaD15e
         RMeKNzuTLDaQmZ/TXtv+2z70hxy0hZ+BMNbKaNqJBkKM8cLpn9qDbeIuYUWgwjvWBHVa
         dEH5w9oOXVdFSJtLcGDL/YA42y4K4FKxstHopSQMu0fiPVJgXiF/w0hblGtt46+N+MMj
         J1BFQGQCfCm+F+jguQ8zHQCydBhq/DqU1dlCsZ4zvUxTtKIQRZS+/Hu41NywkMF1ltcv
         ns8zh3OtjLntJkV8uNHHBvQqE996rv10OHKJuV5F4uWNowPX3uPBEWadoVfO0SQdGrNC
         o93w==
X-Gm-Message-State: AOAM5311KOn8srGYi4oPGFGo70G92V2Aq6UXx+1seu5jGC+qUAnBVcLa
        z5aFDCdZgtXB+o/DJ9Y8UpzYia833c56TLa24Lk=
X-Google-Smtp-Source: ABdhPJz2gw0TRSdced4QtFsmv1RCnPq8zBL1wZgDXzL75HUVNI4tRdoNZBcekqeCklJ+STO/YnbVtdRitRtVvDOSIi4=
X-Received: by 2002:a17:902:7883:b029:e7:32bd:6b97 with SMTP id
 q3-20020a1709027883b02900e732bd6b97mr15703209pll.0.1617015572028; Mon, 29 Mar
 2021 03:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210327203218.119372-1-mat.jonczyk@o2.pl> <20210327211322.121708-1-mat.jonczyk@o2.pl>
 <20210327232551.GA20783@1wt.eu> <87lfa8cchf.ffs@nanos.tec.linutronix.de>
 <20210328061837.GA22710@1wt.eu> <CAHp75Ve_Yhs3ib5yk=d-+bhb4vHpx-j6D4jGGBKuD2k1qv38Vg@mail.gmail.com>
 <20210328215807.GA26428@1wt.eu>
In-Reply-To: <20210328215807.GA26428@1wt.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 13:59:15 +0300
Message-ID: <CAHp75VfHeDd-Q_N=+CFg_yiesibkk_f20PH7jHMhp=4er+uOEQ@mail.gmail.com>
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mateusz Jonczyk <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 12:58 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Sun, Mar 28, 2021 at 11:14:05PM +0300, Andy Shevchenko wrote:
> > On Sunday, March 28, 2021, Willy Tarreau <w@1wt.eu> wrote:
> >
> > > Hi Thomas,
> > >
> > > On Sun, Mar 28, 2021 at 03:07:24AM +0200, Thomas Gleixner wrote:
> > > > On Sun, Mar 28 2021 at 00:25, Willy Tarreau wrote:
> > > > > On Sat, Mar 27, 2021 at 10:13:22PM +0100, Mateusz Jonczyk wrote:
> > > > > FWIW I tested on my ASUS 1025C which runs on an Atom N2600 forced to
> > > > > 32-bit. I had already tried in the past but wanted to give it a try
> > > > > again in case I'd have missed anything. Sadly it didn't work, I'm
> > > > > still getting the "requires an x86-64 CPU" message.
> > > > >
> > > > > Given these machines were really cheap, I've always suspected that they
> > > > > employ cheaper, low-grade CPUs, possibly having been subject to reduced
> > > > > tests where x86_64-specific parts were not even verified and might be
> > > > > defective. This may explain why they forcefully disable long mode
> > > there,
> > > > > but that's just speculation.
> > > >
> > > > There are some of these '32bit only' CPUs out there in the wild which
> > > > actually support long mode. Some of them even do not have the long mode
> > > > CPUID bit fused out.
> > >
> > > Yes, I'm aware of this as well. We might even have talked to the same
> > > "victim" :-)
> > >
> > > > But whether it works is a different story:
> > > >
> > > >   - If the CPUID bit is on, then the chance is high, but it runs out of
> > > >     spec (guarantee wise)
> > > >
> > > >   - If it's off is still might work by some definition of work as they
> > > >     might have fused off more or there are actual defects in some 64bit
> > > >     only area which are irrelevant when in 32bit mode.
> > > >
> > > > Even if it could work perfectly fine, the BIOS/SMM/ucode can prevent
> > > > switching to long mode.
> > > >
> > > > It's a lost cause.
> > >
> > > I agree. While I bought this netbook to have a 64-bit CPU and was extremely
> > > disappointed,
> >
> >
> > Where did you get an idea that it had 64-bit SoC from?
>
> It's an N2600, and I bought this laptop because N2600 supports 64-bit
> (and do have another mini-itx motherboard at work with the same CPU
> on it working pretty well in 64-bit):
>
>    https://ark.intel.com/content/www/us/en/ark/products/58916/intel-atom-processor-n2600-1m-cache-1-6-ghz.html

Wow, TIL. :-)

> > Atom Based 64-bit ones are Bay Trail, Cherry Trail, Tangier (Merrifield),
> > Anniedale (Moorefield) and all based on Skylake family (Apollo Lake,
> > Broxton, Gemini Lake, ...).
>
> Well, to be honest, I've never been able to remind (nor sort) all these
> totally crazy names. The day someone gives me a mnemotechnic hint to
> remind them and their ordering, that will make me reconsider them. For
> now they're all "something lake", and I find it particularly difficult
> to map them to SKUs.

It took me a few years to be on trend with those names, that's how
Wikipedia [1] helps.

[1]: https://en.wikipedia.org/wiki/List_of_Intel_Atom_microprocessors

-- 
With Best Regards,
Andy Shevchenko
