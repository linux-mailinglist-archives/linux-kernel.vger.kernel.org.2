Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2361432C2E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhCCX74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:56 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:51931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376952AbhCCTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:43:51 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1My2pz-1lzclI09iJ-00zZYU; Wed, 03 Mar 2021 20:40:27 +0100
Received: by mail-oi1-f174.google.com with SMTP id f3so27268160oiw.13;
        Wed, 03 Mar 2021 11:40:26 -0800 (PST)
X-Gm-Message-State: AOAM533s2niafG6HZGnI5/zGikXBUPvNqOQxyU95D1HPpD0/9681G+Fh
        tB8187U1tQBCliz+Bx2U2N09rG4rFlG2XQOUcwg=
X-Google-Smtp-Source: ABdhPJzn3Q499PVsI9fue4JXopGo7Jot+WRlXZuMu9dMyxd/+iuVPnM+k2Lyu54W16vUNKI5PzbS2+wPDBpoflHkL00=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr343594oib.11.1614800425710;
 Wed, 03 Mar 2021 11:40:25 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com> <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com> <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
 <YD+mkse29UwwYbFB@kroah.com> <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
 <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com> <YD+8q/hSWNKQS1tE@kroah.com>
In-Reply-To: <YD+8q/hSWNKQS1tE@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 20:40:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_u-FdPKNtAZdZHKY2EAk+qhg1GQHV4dsnuGV4+LawgQ@mail.gmail.com>
Message-ID: <CAK8P3a3_u-FdPKNtAZdZHKY2EAk+qhg1GQHV4dsnuGV4+LawgQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:irQ9Y8hDCfeUHTK7SbkRdDLoBO8Uq+AB9S6IUXcUUPd29CetD8n
 DDOk2fRuSsSPNQkTl/PhpY0nZcEDftn9TQRcVDd8gYnMKT9XlCC/lligLZ0PjhyKpgHn0MI
 FglGW5oaJjCXdwZFNYNmfmYU2A0rwMotWxh+3NgmD48EpIljOz2Cj5J0CQ3ZStYKiVDHxPn
 u7h1amwEaDsLvsnsZ/Z5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YaQBB56KKM8=:7xYZZ8e5QttoWoYrmiquhT
 d2YUfXZj+iRbSfEUhgsq76sbNWYYi3k4ZWRTYzBaZo6BrWAkmTdci06tZNwV78wbgub4gQj78
 pXIIOrqTQRfJyWcjZ8+UigqPrcmQJDCUwvkcEO2IO7CqUqe4PihAzyFADFPq/CXFrkX85ZIYt
 Ku8LAzKP0KoCH4eI40CPWHsKqDVcGnfzK9Dm7LIiFL0YRtIX2tRi8cBNEUtfy5jxQOd/mSxWt
 ePvE1JUTKmihsa1UkTNyD19sdhj5ETCQfCaE9Q4cqp6xzYP/nVk2Y2OTm9mJw1qrlRMwLqoVd
 WBds5+bTBRJNERQs915+zWVRGhG7pT0zR9taG3z9NPZLh5MYHCAnlA1kctcYEn21n9icmQdIv
 vvYBj0ggNWWOV1CA0ugcchLJE5T7y+iAvzssvahV/l/ygwv8Cmt4+pShif6ZC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 5:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Mar 03, 2021 at 05:33:46PM +0100, Arnd Bergmann wrote:
> > > > On Wed, Mar 03, 2021 at 06:56:38AM -0800, Guenter Roeck wrote:
> > > >
> > > >> I don't think that will work in practice. Many ARCH_ symbols for various
> > > >> architectures contradict with each other. Almost all watchdog drivers
> > > >> only _build_ for specific platforms/architectures.
>
> That's fine, drivers are easy, but when I see comments like "ARCH_
> symbols contradict" that means that we can not make a generic kernel
> image.  Otherwise there's no contradiction :)

I think the key part of Guenter's sentence above was 'for various
architectures', which does not include arm64 or modern arm32 (armv6
or higher). On arm64 specifically, there is no platform specific code at
all that is not "just a driver".

32-bit ARM was in that category, and is mostly converted now to allow
combining arbitrary platforms within each of the three sets of slightly
incompatible CPUs (armv4/v4t/v5 vs armv6/v6k/v7/v7ve/v8 vs nommu
armv7-m).

powerpc did this first, but still has at least five groups of incompatible
CPU cores (8xx, 6xx, 4xx, e500 and everything 64-bit) with one or
more platforms in each.

mips is mostly incompatible between platforms, though there has been
some progress in the past few years to make some of the common ones
coexist.

m68k can have all mmu-based platforms (mac, atari, amiga, ...) coexist,
but the nommu platforms are all mutually exclusive. This is probably
not a problem because they are also highly resource constrained.

> And "new drivers" are almost always not really "new" as everyone uses
> much the same IP blocks.  As proof of this patch where the DWC3 IP block
> is being used by multiple SoC vendors.  To handle that, you split out
> the SoC-specific portions into sub-drivers, so that you can build a
> single image of the driver that works on multiple platforms.  Nothing
> new, we've been doing this for years, it's just that out-of-mainline SoC
> trees that think they can touch "core IP block code" break this all the
> time, which is what I am pushing back on.

In those cases where more than one or two platforms share an identical
driver, I agree we should just remove those dependencies. Across
subsystems, I think those are a small minority, but they are more common
in certain areas (usb, pci, networking) than others (clk, pinctrl, gpio).

I did find it very helpful to have the dependencies when I removed a
number of ARM platforms for linux-5.12 that had no remaining users ,
and I could just remove all the drivers along with those platforms.

I found one networking driver in that set that was a generic licensed
IP block that was probably shared by other platforms, but none of
those had upstream Linux support, so I removed it as well.

     Arnd
