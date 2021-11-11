Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84F44D87C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhKKOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:45:55 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF4C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:43:05 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id ay21so12264229uab.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVKvqqv9OAm/4zmBtmBL3IsJoqgkQce/EVyhK7rg1us=;
        b=bla6vHHxGVyyUZ9MxqW+MUZPy1SocRWyskkzZrnZPH5hjIGr+I/VhDk49eozz2ztwW
         xXIpxN8dQ4bOw0eEpumBMhOcpUWlb89tmXuOPIINmoJh94gLAE2mTSTMozVmnIvQk/PG
         i+FV2jDxe+vcPSt6+/ctg5Yfvhw6aJMHPhfwdbkwyLLiAenVBvzbJhm7jeoBY+x69OnC
         mqTIONq+9EBn5eMRoIDNsRTaouZx0VTgosWpWvOlGxjA32nbCq4C5R+LP2yLfkSzwTff
         VWX3Ec3IW7tCtCwNjEwZgyjX7T9o3H7u1/tGGyRROYsM9Q5dIJ+EQrCGq2fJqnbCkCTG
         YZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVKvqqv9OAm/4zmBtmBL3IsJoqgkQce/EVyhK7rg1us=;
        b=zg1JcesMUIMiOWWbn0ik5aRXAQ5/07Iml4sDDeb1N3pSbMwSDuqg0rTOqMZnRa3Byd
         E38j5qye+Kd+AHj34mMWy2C+E7jPbq8oVrUo2QmDaJOKPrKBmZZUiXm614WCnQ97+/aT
         TXXiAzRPszYciMSYHxYedym6vZFflyTpuh3MQ75RT6pROCeOoWTeCJAvHlVoSsLXJSu/
         O5AFh4EyM6hOo8vFjsKX7QgbzxpuVBexKFR/MAWh7wGi+JhlneMWcC0yjEz/6zTWivC8
         OxP+ZrjBL4FkIkkY0NDCZuti4SU2/+x5oqPDMYbsA5RhPHJDUgAfT2VeJpzb7U/X5kHh
         +rIA==
X-Gm-Message-State: AOAM530w5bGf5oiAPcDWfzz4X+WDzMTq1iTJULjQKlNzc9uMkV9ycTAo
        gXucG1w2VFzUO7XGnMrLZ1jCIFrsDIxIW+OOjymEng==
X-Google-Smtp-Source: ABdhPJx026hYrlBBFK38Gt7vmuxM1v3n7oS6F6N1E+0n8usO0gslLNmM/UQ1Fhu0CrOnFNB+d2++LP9zPcKR1efnSZc=
X-Received: by 2002:ab0:3359:: with SMTP id h25mr10912445uap.59.1636641783486;
 Thu, 11 Nov 2021 06:43:03 -0800 (PST)
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
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Thu, 11 Nov 2021 11:42:52 -0300
Message-ID: <CAArk9MOxZaK2WqsuPR4GbgdxSnUBqgO1KZ8OT=+siksYq+2PxQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
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

On Thu, Nov 11, 2021 at 10:34 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
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

My patch was intended to move the read functionality of the spi chip
to be able to compile the driver with just that and then remove the
dangerous tag. So we can use that functionality to read the flash, I'm
missing what is different from the things being discussed here sorry.

> The intel-spi driver is being moved from MTD to SPI because the MTD
> SPI-NOR maintainers (not me) said that it needs to be done before we can
> add any new feature to the driver. That includes also Mauro's patch.
>
> I have v4 of the conversion patch series done already but since it is a
> middle of the merge window I'm holding it until v5.16-rc1 is released
> (next sunday). I can CC you too and I suppose Hans and Mauro (who else,
> let me know). Once the MTD maintainers are happy we can progress adding
> features what fwupd needs there too (and the features we, Intel, want to
> add there).
