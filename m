Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CBD40280E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbhIGLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:53:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbhIGLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:53:23 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2NqA-1mO8PJ1t9C-003rmF; Tue, 07 Sep 2021 13:52:15 +0200
Received: by mail-wr1-f46.google.com with SMTP id g16so1983281wrb.3;
        Tue, 07 Sep 2021 04:52:15 -0700 (PDT)
X-Gm-Message-State: AOAM532LUkYv7lBmQjzNQW+8zj+T5ExLo8DD0H7EM7GyWuDeCftxkuls
        5hT8crcV09cgqMgaY1LPmO0ZUhfgk1PID0u8aio=
X-Google-Smtp-Source: ABdhPJw/CYZi2S4HK/KvHhz3qkFmdKwYpEfDmVzUvGY+xJcU8hH8BcH/rcHW5a8nZJHRmYJfVGa0Hgs7p6ap52yheJg=
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr18160699wrv.71.1631015535089;
 Tue, 07 Sep 2021 04:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210907102722.47543-1-bert@biot.com> <20210907102722.47543-5-bert@biot.com>
 <CAFr9PXmCKPfdHnHU7=ALh=j2SDf71ibd8kEnLTK6aPN1vmQVdg@mail.gmail.com>
In-Reply-To: <CAFr9PXmCKPfdHnHU7=ALh=j2SDf71ibd8kEnLTK6aPN1vmQVdg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Sep 2021 13:51:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a21N8khjyV-f=p28ZogoakhLTrkoPBd6PeXrigba=7-TQ@mail.gmail.com>
Message-ID: <CAK8P3a21N8khjyV-f=p28ZogoakhLTrkoPBd6PeXrigba=7-TQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: Add basic support for Airoha EN7523 SoC
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Bert Vermeulen <bert@biot.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <john@phrozen.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:e/9cqD10FOuA8njfmLytMKlOmgTRaXvcL7pZn7FgjLEe1TiH20t
 HQgo29dmlSC3ddreWXcYG+suwQ2gaGJPx6fI0wLtzKLnNfRyvEQFGvhpefPEFMYbgz3XB7D
 OvC596bzPcfAInHVPL5JnKIdx4+syBJwutAKaWSk/FZgEEk+pGMSVcEf5/z/0d6G6y0F0c6
 boo/Dcd128EYRxsNBnwuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d20yJRJ9TNw=:OVBrHhY5gtukVVg3Xtd/m0
 8u4R++63dqxiRfrhGmw9e4KOw+Da1VJcXhE81xXL2nK8CA7imI83yLc1r2C/EpoRfx01QIcHe
 ahbwnKSD7t5kZzYXcME/9EH3EooRP/sfglVBUYl49zeMQ6sD0z6QzI4IrdfRnQvBgasUOzpvZ
 ZUG7NXZgorGfoSsx9iQsNcO2TEKa+P1jlc7O/cFD/Yl9syPt3cCyv/4jzs2ahKVfMgjeOcwEZ
 v0OFoKooGf05KSP0QPlU9ZE1AP4WwwTpHrY6hkT52+oBfRdCRa9p0scUm8tS5Y/nSSm+Dqs/W
 H9NHDcPZbYnxkLg2DJNwD2dWg064P+IrnOP2OE1NfsbnXR9Ur86UEZLzZYDkGANcrnaFKE8DS
 ICBDnjX2n1taoxxKFu71KCgnLSyrigfDthuZj2L24f0ZdtG1s+Cy/sq1Pc35pMuQMMNXtlMcZ
 YvXtlep/GTD+7nBHpVohTp3GeZs4AQSsI2/inFexWGouY1Ulb4fvKC5mFtG/6PsTcYOgO+4+n
 ZZmiABN1dyAM1aCeOyNAU5ZvtiJCEKG8FB8Og38nKb6DL4zvT8Po/w3gReD2wVmZp9pZPnJNl
 JvDEUXcq3S8inLp3/3qCGfKn2Q0eTh0+ZLu/CBAhLyr0GWaRIBpYJ8YGviD/aymoyWQXmvcr8
 LsfwV2498J5GOF6i+qOxIUQme59j8wLDEY6/jaCXnzw4Ew8sFIXgrAXzUXG7nK53w6cspAOJZ
 84KezZYvOTbJj1hw80eXp1yqR3OjcVtW8N1e+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 12:48 PM Daniel Palmer <daniel@0x0f.com> wrote:
> On Tue, 7 Sept 2021 at 19:30, Bert Vermeulen <bert@biot.com> wrote:
> >
> > From: John Crispin <john@phrozen.org>
> >
> > EN7523 is an armv7 based silicon used inside broadband access type devices
> > such as xPON and xDSL. It shares various silicon blocks with MediaTek
> > silicon such as the MT7622.
>
> This is a Cortex A53 isn't it? So it's ARMv8. I thought the issue is
> that it's actually a 64bit system but you only have a 32bit
> bootloader, firmware etc?
>
> Off-topic but related:  Another MediaTek spin off, SigmaStar, seems to
> have done exactly the same thing. Cortex A53 chip running as a 32bit
> system to avoid having to fix their software. I'm interested to see if
> this makes it into arm or arm64. :)

Maybe it's best to just add them to both at the same time? The boot
loader situation might take a bit to work out, but in theory this should
be fixable.

You can generally include .dtsi files from one in the other, as you can
see from e.g. arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts.

For new files, I think I would prefer having the .dts files in arm64 and
including them from arch/arm/ rather than the other way round, but
others may come up with a good reason to keep doing the reverse.
This would help encourage the thought that running a 64-bit
kernel is the better setup, rather than propagate the 32-bit kernel
nonsense on 64-bit machines.

       Arnd
