Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93A140AAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhINJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:31:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhINJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:31:16 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M76jv-1mYbsI2Ym7-008esp for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021
 11:29:57 +0200
Received: by mail-wr1-f54.google.com with SMTP id m9so19130043wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:29:57 -0700 (PDT)
X-Gm-Message-State: AOAM531xF9rbtliP35x2O+l4JxPlg1K2gzr2nzFgtXgNNkncRCMViIjQ
        TnW6dlBHWrlNKlz3zchEFWLp8J81O0d3zxrup5E=
X-Google-Smtp-Source: ABdhPJypqsYHFxoUa29/jtw7Qz56PJNAFh3JFeGA9boJ1TXhrmxqwyJldyb+fdD4v1ob2++RiK7UL+91VPvYQXRh/IU=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr17068296wrv.369.1631611797238;
 Tue, 14 Sep 2021 02:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour> <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org> <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Sep 2021 11:29:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
Message-ID: <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Guo Ren <guoren@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xkQoB0YNte3eXNW3ZSE+AanhV7oV5Ki89yQ1+4GH6dM0myIicGq
 +EPj4QNWrq1jFDbuXyJ6HhfKPxmPEP/SDOwmsvFr4QRfg9d+ZeFCWd4BAmG22XjMq0d/3HS
 5oole/6axcpUjOY8t7ukr/fXNMHSq9hGvltKACRlABe0QoraXZ/VeB5g9QVRyIAC0X8c77P
 5z0KjStM5GLrKNhqauH3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dc1TpPUhvLs=:DPAVedJPHpu5i7b62PqdXy
 7XsU50PxJilWenJaqZ1To+7i+EGPURWdj5eaC91c1kvDDQoA1Eq0JQ2zHb78CBiP39FiKEKk/
 4TbetqT8wogusqk+8FX+6dPLmk1FB4kasCUPRSNeFER+0zIQEaSt3MV7LCa9UJE4jWmZzMtVb
 V8rCbR6J9KkcrKGlp+WbBrYYl6Hivg4fEFAG113b2Dk8iqYgpfxqODLCvFyMJN2+yHV0XIePU
 uA0gQCkpQqjWqDIuftxpcX7MG3fknO4D1qTbg4DHcFAXPKa87oCXaYZzpPe9RZJjZq5GmN16s
 DwXgK9CczrMFq/D1tV+orq4UQw/1I35WTehcKb2JOFi0M3eh3U7PKdPnLkawz8Ly2j9VbV/x8
 5Hgv3dQLP+tjEIeAcI5SJLCxjrKijEQhzMuqhaMU7zAI5QDpMWz91CZVZJzsndlTpDOquwHBO
 GRSCMVvvDzfHOfGDkMEH0J6pHNhPeaVV6LrNbfEYpzc9kN7+JTUswt4w57eohNyDxKna4KQld
 uoPeOiyIsgS0m1AzQL4MTbfNDMnPf3b3i7FDzjzB7/CcQs+YnxvKjfpXp62NpfbH8YXqZgIG5
 N+geAzk4PBNNfcy8vOONnT9UrnccJXjk+jcscmx3e4EbPcz9b83Ndfu3E6g84xBTXq4Jaf0Ot
 k3G//O2fkvTqww7X6QW7NzhYP8Qbkq7zhRkm2n+RTS46fyxt8c9HtS2XwwVy6/8x7WbOY/5y0
 OSCAY20ihTPOCatDu/iqWWCPaUQVOeWo+c5Jw1cQvLx583/D+KE2W4U9ZCp0n757XxEB7QVCY
 0aejCB/MNVFaXHyKVPNRykwon0irjVyaHrt2cz6QoNNO4FTM50fnaeSm2gbjhhQ8VnIqivvRG
 k5E2X4CHBGaRf6KRPnVQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 4:36 AM Guo Ren <guoren@kernel.org> wrote:
> On Tue, Sep 14, 2021 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 9/13/21 2:20 AM, Guo Ren wrote:
> > > On Mon, Sep 13, 2021 at 4:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > >> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> > >>> From: Liu Shaohua <liush@allwinnertech.com>
> > >>>
> > >>> Add Allwinner kconfig option which selects SoC specific and common
> > >>> drivers that is required for this SoC.
> > >>>
> > >>> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> > >>> interconnect issues for dma synchronization, so we set the default
> > >>> value when SOC_SUNXI selected.
> > >>>
> > >>>
> > >>> +config SOC_SUNXI
> > >>> +     bool "Allwinner SoCs"
> > >>> +     depends on MMU
> > >>> +     select DWMAC_GENERIC
> > >>> +     select ERRATA_THEAD
> > >>> +     select RISCV_DMA_NONCOHERENT
> > >>> +     select RISCV_ERRATA_ALTERNATIVE
> > >>> +     select SERIAL_8250
> > >>> +     select SERIAL_8250_CONSOLE
> > >>> +     select SERIAL_8250_DW
> > >>> +     select SIFIVE_PLIC
> > >>> +     select STMMAC_ETH
> > >>> +     help
> > >>> +       This enables support for Allwinner SoC platforms like the D1.
> > >>> +
> > >>
> > >> I'm not sure we should select the drivers there. We could very well
> > >> imagine a board without UART, or even more so without ethernet.
> > > We just want people could bring D1 up easier, 8250 is the basic component.
> > >
> > >
> > >>
> > >> These options should be in the defconfig.
> >
> > Agreed, using a defconfig is the right way to do this.
> Put 8250 related configs into arch/riscv/configs/defconfig?

I think that would be best, as well as the STMMAC_ETH and
DWMAC_GENERIC options.

If all RISC-V chips are required to have a 8250 compatible uart,
selecting it from CONFIG_RISCV would work as well, but for
consistency I'd give users the option to leave it out, just like
any other driver that is not required to have a useful system.

>  @Palmer Dabbelt @Arnd Bergmann, How do you think about that?
> (defconfig or Kconfig.soc)
> My purpose is when people make the Image from riscv/defconfig, then
> the Image could run on all platforms include D1.

I would try to keep the Kconfig.soc as short as possible. As a general
rule, only use 'select' to enable symbols that are otherwise not user
visible, such as the specific errata if you want to hide them. For individual
SoCs, I prefer not having separate Kconfig options, but instead have
those per driver. We have some SoC families that have part specific
options elsewhere, e.g. drivers/soc/renesas/Kconfig, but I'd only add
those if you can't avoid it. Having it in drivers/soc/ may be better for
sunxi than spreading them over arch/{arm,arm64,riscv}.

Some subsystem maintainers want drivers to be selected by the SoC
option, this is why you need the 'select SIFIVE_PLIC', but usually
the drivers are selectable with a 'depends on ARCH_SUNXI ||
COMPILE_TEST' and enabled in the defconfig.

If you want to get fancy, you can use something like:

config RESET_SUNXI
        bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
        default ARCH_SUNXI

This will make an option that
 - always enabled when the platform is built-in
 - user selectable when compile-testing for any other platform
 - always disabled otherwise

       Arnd
