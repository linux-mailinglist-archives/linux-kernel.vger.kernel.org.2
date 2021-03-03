Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CBC32C064
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579547AbhCCSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:31:30 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhCCQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:37:31 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFsER-1l06p23mdb-00HOqA; Wed, 03 Mar 2021 17:34:04 +0100
Received: by mail-oi1-f176.google.com with SMTP id w65so3032822oie.7;
        Wed, 03 Mar 2021 08:34:03 -0800 (PST)
X-Gm-Message-State: AOAM5314Sx8487NK/n9yRrWNmacwveFqQUtkxyYrYUJ8Lbi5UQIB/0vI
        XnVy1L8dtGB2a+/Bi6VaBGQ0QOCqrkqPg4jUb4s=
X-Google-Smtp-Source: ABdhPJwaSEK/bqsQlLPth69eLwqovRhmDglrylbmEpMLoRv5EMSpQ8Is+AJSnKyJ7UGpR2ViS3wzOt8Luk0BNHaMLFk=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr4097772oib.67.1614789242550;
 Wed, 03 Mar 2021 08:34:02 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com> <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com> <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
 <YD+mkse29UwwYbFB@kroah.com> <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
In-Reply-To: <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 17:33:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com>
Message-ID: <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EwSemcTjirI6TZGXsPNMXKcyjSFtGPPG+qLAxPqyJ7fXNzV2Dn0
 Qdhcfs6lF+vO603XmWSS8vhM0H4S1X5Lk2zolyl7tnIyexzzkileYB5OuXiRI0zYLkPig7C
 GPhKkAKMB3w25tnwxXrntYYn/z2aEAae0QPy79JZm6aHepCsg7simQ4r9zr7Ds4mDJxRTEY
 n6y6ox24KL+csyEJ5OlSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bIM74AHIcLs=:aRzEpBNtQBNZxOR+rkP45D
 yI5gxQ7zd1AgHtaP1PUqurXrJv/x8sxpCTiEl6jID1Wya6gnjzntWTPHTIN0xGpYszumErhcn
 3+D+FsCrqEffw9ZaRnFIwKbpVkotFnzpiN6J+72kYUQ/TpTMBsWMlGEFfAfT8mPKYllYIr6Q0
 DLcE2Aa0kkuMC2vHFSLHLyHgP79OK/UGv93mgJ6tOkrD5mwUQQTFOSqYDQ334komNUb3x7w8m
 PqKy9hpxKIDWz8uY3+2qOu+CLD0nzldyng9k/XrZIi84kDLp5Sjs5OQ/ZdYEuox9P9KVvvuM3
 MDCk4sziva+wXLg9uHe3M1tHGw1n2aBzfnH5HnwYS8kVwXTr4kbcNRWLzPjAElTUIWqsiJhCe
 kyUS4evyiRfXGHeqEinuYIVbRHhGDWicm0XpN1EzK0lqWoMrCgvWQoUlJPreoOQJBmcAIPAZn
 zQ/tt4OFiz3AkmhBFu9yk5zHoChmEMfcfVyNAX0iBpKNvZa9UzrlB25yzQ9krLy6kIY8FIQan
 g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 4:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 03/03/2021 16:09, Greg Kroah-Hartman wrote:
> > On Wed, Mar 03, 2021 at 06:56:38AM -0800, Guenter Roeck wrote:
> >> On 3/3/21 6:05 AM, Greg Kroah-Hartman wrote:
> >> [ ... ]
> >>>> Anyway, that's the convention or consensus so far for entire SoC. If we
> >>>> want to change it - sure, but let's make it for everyone, not for just
> >>>> this one USB driver.
> >>>
> >>> Great, let's change it for everyone, I don't see a need for ARCH_*
> >>> symbols except for people who want to make it simpler for their one
> >>> board type.  And for that, use a defconfig.
> >>>
> >>
> >> I don't think that will work in practice. Many ARCH_ symbols for various
> >> architectures contradict with each other. Almost all watchdog drivers
> >> only _build_ for specific platforms/architectures.
> >
> > Great, that's horrible to hear, so much for a "generic arm64 kernel
> > binary" which I _thought_ was the goal.
> >
> > ugh, you would have thought we would have learned our lesson with
> > arm32...

I have no idea what you are talking about here. arm64 kernels have
always been generic, but you still need drivers for each piece of
hardware, we unfortunately can't stop SoC vendors from reinventing
the wheel with each new platform and then having to add yet another
driver for each subsystems.

> I think Guenter here refers to drivers which actually came from arm32
> and were not cleaned up to be build without machine-specific bits
> (arch/arm/mach-xxx).
>
> Most or all of the new code is made buildable outside of
> machine/ARCH_xxx (so COMPILE_TEST).

There are very few 32-bit arm platforms left that are mutually exclusive,
they are largely the ones that have not seen much maintenance in the
last ten years but still have users. Generally drivers for those platforms
don't have any remaining compile-time dependencies though.

Looking at watchdog drivers that can not coexist with others, I see:

- 21285_WATCHDOG (ARMv4 CATS from 1998)
- 977_WATCHDOG (ARMv4 netwinder from 1998)
- IXP4XX_WATCHDOG (Intel/ARMv5 network chip from  2002)
- IOP_WATCHDOG (Intel/ARMv5 storage chip from 2002)
- SA1100_WATCHDOG (Intel/ARMv4 mobile chip from 1998)
- EP93XX_WATCHDOG (Cirrus Logic ARMv4 embedded chip from 2003)
- SC520_WDT (AMD ELAN x86 chip from 2001)
- M54xx_WATCHDOG   (m68k coldfire from early 2000s)
- ATH79_WDT (mips)
- RC32434_WDT (mips)
- INDYDOG (mips)
- WDT_MTX1 (mips)
- SIBYTE_WDOG (mips)
- AR7_WDT (mips)
- TXX9_WDT (mips)
- OCTEON_WDT (mips)
- LANTIQ_WDT (mips)
- LOONGSON1_WDT (mips)
- MT7621_WDT (mips)
- PIC32_WDT (mips)
- PIC32_DMT (mips)

          Arnd
