Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25CF44D755
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhKKNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhKKNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:39:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84090C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:36:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so9855005wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzCDiDkndP/GKiTl3ZEmRMT9MYSu0rjfM7w2AMw4pPA=;
        b=P0fRuCQN6EBfBT6XLSo/7G56qjZcEUiY+4Lk3atEr+xmA6BuvRCkYBMKhC86SqliT4
         ZSLCiKGHues/znyvjK6WkE34qSyPM3kzq5/KdYfTJAikIB2zVAT/1CfBpCgDVpKvhOLe
         Rhw+3oxiiZF9SMV1M/cP4LrcXrh1n+fEdXgrchlDQRJDKG5jYu/vJtTbMizEx0qjkU6d
         M63VoERgIBkFuQuZr6fBKBx4mxkjyrchhZjmmS/uBfk/Ofgo/b29/Ff9A+OUBVwJOMwR
         baBiTV39qhAk4j5O1NmgEh7DFzrmqH55voiURasb7sDFJ65rEmHLbpAfUNQQw9llYdNN
         Yv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzCDiDkndP/GKiTl3ZEmRMT9MYSu0rjfM7w2AMw4pPA=;
        b=ikFqhl8fRJvHjk1EcvJchzzGKm11p/i8j90FiCGWl2mzatAc5U52LrAjI8QlhlFiM0
         Ifu47IsPEfhuro3MPAVUwXtvvqN4VWMe7IFCAPtqFmRa2gcNLdKBI7W0Hx+xBBVCqZpG
         vT9ZT31UlIrg+2TxBg2TnC41RP7pQVma6QNULLxhz/AFsmBNknC/+uqnWn5eZgu7zQaJ
         uSCXvRtCeI61SHykJm8USYjT0AlJgNE2uEcVWNZF0PiKRi4gXYQL20Lc+KMW3dqUp0kO
         UxJs71dTRLBqqykWBWfeEJ3o62iMAkdtnx+SQSm2IAROm9y4HX+7CP5IOG6bplr4GD7X
         CDcQ==
X-Gm-Message-State: AOAM533ZTqVzxpm6P0eo9ZJGhjddGkGWyQbnAuJq61ZEyK96H+rkecIi
        kEMV9DdaI9BDNqrnfTT4cq/utv46JDqdFDLPr0h8Q1L3q6sEhw==
X-Google-Smtp-Source: ABdhPJze/m1HpnZv8jnQMYbSum+bxfNuwGgAN1K3EwV0ar4PyxpBqdDavff3srOKuX2Tsb4C9WLF8IdQd3JC+AmMK1s=
X-Received: by 2002:adf:eece:: with SMTP id a14mr8906694wrp.333.1636637787099;
 Thu, 11 Nov 2021 05:36:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <YY0UCHtf8SAvGHTY@lahna> <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
 <YY0b01g+z3lkO4w2@lahna>
In-Reply-To: <YY0b01g+z3lkO4w2@lahna>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 14:36:15 +0100
Message-ID: <CAHifhD51y5jX6bGJdFr7s46oJPwHNNOjq9haNOZ8U4ryOkyMbw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

Am Do., 11. Nov. 2021 um 14:34 Uhr schrieb Mika Westerberg
<mika.westerberg@linux.intel.com>:
>
> On Thu, Nov 11, 2021 at 01:22:25PM +0000, Richard Hughes wrote:
> > On Thu, 11 Nov 2021 at 13:01, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > I'm not sure I understand why the platform security needs to be turned off?
> >
> > Sorry to be unclear, I meant we had to turn off Secure Boot (and thus
> > also kernel lockdown) so that we could use /dev/mem to verify that
> > OEMs have set up the IFD, BLE, BIOSWP etc correctly. You'd be
> > surprised just how many vendors don't read the specifications
> > correctly and get this wrong. We also need port IO to use the
> > intel-spi driver so we can parse the BIOS contents from userspace,
> > which you can't obviously do when SB is turned off. The eSPI
> > controller is hidden on some hardware now, and we need to play games
> > to make it visible again.
>
> Okay, thanks for explaining.
>
> > > I think exposing /dev/mem opens another can of worms that we want to
> > > avoid.
> >
> > Ohh it's not all of /dev/mem, it's just the 16MB BIOS region that has
> > to be mapped at that address for the hardware to boot.
>
> I see.
>
> > > Don't we already expose some of the EFI stuff under /sys/firmware?
> >
> > Yes, some information, but not the file volumes themselves. I don't
> > think the kernel wants to be in the game of supporting every nested
> > container and compression format that EFI supports. It's also the
> > wrong layer to expose platform attributes like BLE, but that's an
> > orthogonal thing to the patch Hans-Gert is proposing.
> >
> > > I just don't want to
> > > spend yet another Christmas holiday trying to fix angry peoples laptops :(
> >
> > Completely understood, I don't think any of us want that.
> >
> > > Having said that the hardware sequencer used in the recent CPUs should
> > > be much safer in that sense.
> >
> > FWIW, I'd be fine if we had RO access for HWSEQ flash access only. If
> > I understood correctly that's what Mauro proposed (with a patch) and
> > instead was told that it was being rewritten as a mtd driver
> > completion time unknown.
>
> I think Mauro proposed something different, basically exposing RO parts
> of the driver only.
>
> The intel-spi driver is being moved from MTD to SPI because the MTD
> SPI-NOR maintainers (not me) said that it needs to be done before we can
> add any new feature to the driver. That includes also Mauro's patch.
>
> I have v4 of the conversion patch series done already but since it is a
> middle of the merge window I'm holding it until v5.16-rc1 is released
> (next sunday). I can CC you too and I suppose Hans and Mauro (who else,

I'd be delighted.

> let me know). Once the MTD maintainers are happy we can progress adding
> features what fwupd needs there too (and the features we, Intel, want to
> add there).

Hans-Gert
