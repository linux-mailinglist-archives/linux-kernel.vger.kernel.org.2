Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFD40A5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhINFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhINFS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:18:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A44C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 22:17:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m9so18120829wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 22:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOM9/HSr10rms/kTZtRBXXYbkulobkA+KsRsDSab8hI=;
        b=NZuqZkPP5EOAbtuipffIoRtYtf54WNs8r1D2Xx2W41gn1DAyzOP6/UkFtAxcRakq41
         4+aYDoE1yZS7WHAXGhEMC0gNTwyNQhzRUF448U1kY4KLqcJinjwhuRl30+ODFXH9D0EB
         x6sQTY2r+pF7c7dfkVK74Xi7/C8lQchVYQkxW9EVEUmzc53tzrpl4TXuSTEkX2dqICun
         QLRXb0tTCV/ZncV9o4gG7tZlyRVRwlIDIiltmVLWm25HzX10CpGOc1VCyh+bECG6ZuYB
         5XjutcfXE0JBe1jFmOx+6vBB+21Iu9NHZZP10u/06TijTMOicEoxTPjYU6a9qqfqPTCa
         lBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOM9/HSr10rms/kTZtRBXXYbkulobkA+KsRsDSab8hI=;
        b=ts8E935zzKCYTJi9bn/6tHC69Me4T/UI1b8ojoV0SB2B7jhlGL2PD6objhxC1hBZ3d
         dauFKcyoqN3mPfgN7CGYnZM3QE5TTaBm2V7AW729HRUD4m/7veVrLHJ/4wLq4yniDXeH
         F3FR1Kag52jH0pZATEQGilUExSY6+BBoWFKGnhH01lZCa5btb79GESu6GxhKo2/uz2U/
         uBE7Fge3PdEsINiV/VN8ulV2TWuzZ/FFP+n1adq6XWrLaEmrhXrcoo2NN8i7JHA74+9Q
         5zGKJZeRWhq4IhlsZcISpvvvZ4tXLuGEGOVK+hYiXoeQvLII7LScoB8pNm4KtWfrK5eO
         ehSA==
X-Gm-Message-State: AOAM533x7jm4c5H7JzwCge5hKeWCAaexGLqW4J9mg6oO+h1bkW/0lLN3
        Skw2recHAYT+SIVwrp9kvWlG91ZLZpUAqMXnG5mj1Q==
X-Google-Smtp-Source: ABdhPJzawKvepU75qV+pfqmm+V/cgxGLAd3DIA/4Y2/3OJGzCcolG+JinnFs4EbCUGFridK2GGkBDc83By+52beV5iY=
X-Received: by 2002:adf:e387:: with SMTP id e7mr16835445wrm.199.1631596628583;
 Mon, 13 Sep 2021 22:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour> <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org> <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
 <357851d1-5311-6ee3-6998-b20f0d238100@infradead.org>
In-Reply-To: <357851d1-5311-6ee3-6998-b20f0d238100@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 14 Sep 2021 10:46:57 +0530
Message-ID: <CAAhSdy0EMdaB4nPGbi5yynUQ-c-JmSO+mn46JLSb6x--DpA-kg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:36 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/13/21 7:34 PM, Guo Ren wrote:
> > On Tue, Sep 14, 2021 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 9/13/21 2:20 AM, Guo Ren wrote:
> >>> On Mon, Sep 13, 2021 at 4:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> >>>>> From: Liu Shaohua <liush@allwinnertech.com>
> >>>>>
> >>>>> Add Allwinner kconfig option which selects SoC specific and common
> >>>>> drivers that is required for this SoC.
> >>>>>
> >>>>> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> >>>>> interconnect issues for dma synchronization, so we set the default
> >>>>> value when SOC_SUNXI selected.
> >>>>>
> >>>>> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> >>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>>>> Cc: Anup Patel <anup.patel@wdc.com>
> >>>>> Cc: Atish Patra <atish.patra@wdc.com>
> >>>>> Cc: Christoph Hellwig <hch@lst.de>
> >>>>> Cc: Chen-Yu Tsai <wens@csie.org>
> >>>>> Cc: Drew Fustini <drew@beagleboard.org>
> >>>>> Cc: Maxime Ripard <maxime@cerno.tech>
> >>>>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> >>>>> Cc: Wei Wu <lazyparser@gmail.com>
> >>>>> ---
> >>>>>    arch/riscv/Kconfig.socs      | 15 +++++++++++++++
> >>>>>    arch/riscv/configs/defconfig |  1 +
> >>>>>    2 files changed, 16 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> >>>>> index 30676ebb16eb..8721c000ef23 100644
> >>>>> --- a/arch/riscv/Kconfig.socs
> >>>>> +++ b/arch/riscv/Kconfig.socs
> >>>>> @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >>>>>
> >>>>>    endif
> >>>>>
> >>>>> +config SOC_SUNXI
> >>>>> +     bool "Allwinner SoCs"
> >>>>> +     depends on MMU
> >>>>> +     select DWMAC_GENERIC
> >>>>> +     select ERRATA_THEAD
> >>>>> +     select RISCV_DMA_NONCOHERENT
> >>>>> +     select RISCV_ERRATA_ALTERNATIVE
> >>>>> +     select SERIAL_8250
> >>>>> +     select SERIAL_8250_CONSOLE
> >>>>> +     select SERIAL_8250_DW
> >>>>> +     select SIFIVE_PLIC
> >>>>> +     select STMMAC_ETH
> >>>>> +     help
> >>>>> +       This enables support for Allwinner SoC platforms like the D1.
> >>>>> +
> >>>>
> >>>> I'm not sure we should select the drivers there. We could very well
> >>>> imagine a board without UART, or even more so without ethernet.
> >>> We just want people could bring D1 up easier, 8250 is the basic component.
> >>>
> >>>
> >>>>
> >>>> These options should be in the defconfig.
> >>
> >> Agreed, using a defconfig is the right way to do this.
> > Put 8250 related configs into arch/riscv/configs/defconfig?
> >
> >   @Palmer Dabbelt @Arnd Bergmann, How do you think about that?
> > (defconfig or Kconfig.soc)
> > My purpose is when people make the Image from riscv/defconfig, then
> > the Image could run on all platforms include D1.
>
> Hi,
>
> I certainly did not understand your purpose with the patch being
> able to build a kernel that would run on multiple platforms.
> Still, I would not expect to see one platform cause unnecessary
> drivers to be built for platforms that don't need them.
>
> Kconfig.socs in arch/riscv/ is a bit of an unusual Kconfig file
> IMO -- I suppose what you want to do fits into its style.
>
> AFAIK the suggestion to use a defconfig (at least my suggestion)
> was expecting to have a defconfig for each platform, but that
> would not give you a boot image that could run on all platforms.

AFAIK, having a separate defconfig for each platform is not going
to fly with distros (AFAIK). We can't expect dirstros to release
separate RISC-V kernel image for each platform. In fact, ARM64
kernel has just one defconfig whereas ARM32 kernel has
consolidated and minimized number of defconfigs.

The long term goal for Linux RISC-V is to support single kernel
image booting on multiple-platforms. Of course, users can always
strip down the kernel using their custom defconfigs.

Regards,
Anup

>
> Anyway, it's Palmer's choice.
>
> thanks.
> --
> ~Randy
>
