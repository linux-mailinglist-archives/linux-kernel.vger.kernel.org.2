Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23250402A73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhIGONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:13:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhIGONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:13:14 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MF35K-1mCZCR01DE-00FTuz; Tue, 07 Sep 2021 16:12:07 +0200
Received: by mail-wm1-f43.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso1311956wmc.1;
        Tue, 07 Sep 2021 07:12:06 -0700 (PDT)
X-Gm-Message-State: AOAM530JWCr93icN2IhBHdwQKgz7XWsqAl+1uo2zbv6GVu6p45jv29pk
        zMfdKOVG1mRDL5akVUlvI9WT0WTj42OeNg3XCSU=
X-Google-Smtp-Source: ABdhPJy+/Gv1NvxJaewrWW3DJ0D+IuIPMTgII10oAN+FconpZJf6Lk7NuP3bbFLC4UZYNMUyEiJr3b4SvKAhlHYh1Z0=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr4232162wml.82.1631023926662;
 Tue, 07 Sep 2021 07:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210907102722.47543-1-bert@biot.com> <20210907102722.47543-5-bert@biot.com>
 <CAFr9PXmCKPfdHnHU7=ALh=j2SDf71ibd8kEnLTK6aPN1vmQVdg@mail.gmail.com>
 <CAK8P3a21N8khjyV-f=p28ZogoakhLTrkoPBd6PeXrigba=7-TQ@mail.gmail.com> <CAFr9PXn4JXGKSCDNeKMJDPgfezktyfBsTcq8GErt+ROuumDgrg@mail.gmail.com>
In-Reply-To: <CAFr9PXn4JXGKSCDNeKMJDPgfezktyfBsTcq8GErt+ROuumDgrg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Sep 2021 16:11:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0y0PhmOdMPnx10zG6s6RfiuC9Ju9s5SMnOk8oZ+cAFMw@mail.gmail.com>
Message-ID: <CAK8P3a0y0PhmOdMPnx10zG6s6RfiuC9Ju9s5SMnOk8oZ+cAFMw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: Add basic support for Airoha EN7523 SoC
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bert Vermeulen <bert@biot.com>,
        Russell King <linux@armlinux.org.uk>,
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
X-Provags-ID: V03:K1:jO/2X410NXuyfZklVpDuBSTUB2yoaPBjwT1b0bYPn86+rMMt1lE
 +pJChftr+A9+czyk4uBRZgzvrZ1QYsNR3wZSvBTd4z8Ge+tUZHzuqBoep//36TdsWEHq+0/
 NOqhvKpexbAE4688whEsbm3Zl8jummEThK//2/ev7oZXD1s6YHIdYmI2YLYhBhcAvmSCxSP
 OpsRpFeIuSCGqtr7t0tRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zh7rp9qVPIE=:ArHhEEsbb3ScolxJTgJL44
 QOq87fcH0UE27HTPIZvdnAPHc2zgeuSUUBJb1SjhOabyqYsKfO1lyC9jEhnhLUzaUqczEftHc
 xzDEuBaISNm4bteE+evSnrecXHaRLQTdaTxVmL4M9u+r1ruT5WmaZEeX6mnu/l6dTzUWBf9I0
 2qhsQxzAjIgGmJ08BhOWmLEWjmfMiNOUTc6Ls2gK1ed43fGjeUZrWj/2rI2uYuHpHHkL6VAVd
 Wx4Tqy3H5c7LlGlLGHrIogx2oHzXvvbA+luZNAW/Z18aSTWrndqxt9RJb3VznCweHKQHq+6q9
 iYRNTFBf7eKkGunBgD3hbX9wMZzyrkrpS8xB0jo8BROM79uLxsQM6OCXS3sDh+AD4GjLrNLAI
 jjFApt2E/CfvZmXosGwyVpsSxCwWYUAb0tC/OntW9chY76Qkn8acJymV4I5zq4nIzqWDv/Xza
 Jx9HwmnrGCFCzGtxi0pbbHLGC1Pn2UH1/2Vo5uPl3E4J/W2HUd3PI42xxLvMgmsOPFkMboJN1
 LeyXdD4qY+MkUiaMpO64bMqDaOs4x4GQoREjCS5XKIxS7VStm8Sjb/JojYdG2qyOdBCJY6Grx
 Q/535zI3uJh1NRg9FqRG5L3XXW+AquDOjGJYvUHYecaNtCATtvHTscYcIhvwru1BAGCZnIY0u
 DyM0vChpnn1TJ/OKVS43O34Itbe9O34LvOiL73bCd72Wn5R1/4/G+Ovel9sXtmbta2xb+Sedf
 xsgUkVzcMls+aAfL5d58IWRa/F+b7EOYRQPxiR3mhxHjdZlHg1/EiNxIDuheotVwYi/5AJBNb
 QFc2RyZRnzUTWIe+o6iSmHdJcKMKhbK9gdcBUzGRTkewxSOi9ArThmqcnfUN1m4Xsx83ZwrTT
 Nve9cMCWxUSg5FSMw5Sg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 2:27 PM Daniel Palmer <daniel@0x0f.com> wrote:
> On Tue, 7 Sept 2021 at 20:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Off-topic but related:  Another MediaTek spin off, SigmaStar, seems to
> > > have done exactly the same thing. Cortex A53 chip running as a 32bit
> > > system to avoid having to fix their software. I'm interested to see if
> > > this makes it into arm or arm64. :)
> >
> > Maybe it's best to just add them to both at the same time? The boot
> > loader situation might take a bit to work out, but in theory this should
> > be fixable.
>
> I wonder how fixable it would be..
>
> I haven't gotten a board with the chip in question (SSD268G) yet but
> from looking at some firmware binaries I can see that even u-boot is a
> 6 year old 32bit version.
> As far as I can tell there's no PSCI, ATF etc that I think would be
> expected for an arm64 machine.

If the source code is available, creating a minimal PSCI implementation
in u-boot should be possible, and it would make it work well for both
32-bit and 64-bit kernels. There is no need for ATF here.

> I think the broken memory controller is still there so somehow I'd
> need to get the heavy barrier to work in arm64. I haven't yet worked
> out if that's even possible.

I think I missed that part of the discussion, or I forgot about it already.
What is the issue you are referring to here?

       Arnd
