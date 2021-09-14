Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89F640A394
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhINCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234374AbhINCg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:36:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5CD96117A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631586904;
        bh=bz7Rxj4OImLOV2F9ZMnEZ6ial2UhktF/5F1YEEEmV44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dVOoOD3fjFIeQljEiWffzK3e87epnINC96VyHIv56IevUZHt/riioVLoD19h6aEnC
         THvkD5VyX/VM/xzicH1O9bdy0NJXgCE6ZTb3ifEALrEO5Sxe+n0vW1pJDTAFEfwX+D
         zKQVoEKAQ3bNeHRRKCAxtFS9K46vLFNW+GPAIh+Y9MC0lUap9Ljdi5fpqDa3wsIghN
         +S6km0b+ebZ9sXZ8sAAMGr3d53tC8zJfUcjnT6oEAdXpptcIY+pQM1cK6+T4AinXMV
         1q3P+CfalDzJ8G1xrT6mfYwgCUzlgf6FAo8JbxHcIQFvJ9/0bbc/BbiLQ1ECn0C7ct
         s+DcYGZ06y+fA==
Received: by mail-lj1-f169.google.com with SMTP id j12so20859962ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:35:04 -0700 (PDT)
X-Gm-Message-State: AOAM532WwZZyVuL797Rw8vRoHNMf7bTr45EemHNvZ8yX0+D10eL9mIwF
        YTz9MphU6iazeeOAGaKHSvj25UNZYeph7obuaM8=
X-Google-Smtp-Source: ABdhPJxkZIIk5caw259v6Vh2lE0hi3eHP19JEjfp0Q1aBDBi5doS3d2wUWRWNx2sALY0CUr7hNPWej0rfeYlb9xhAfI=
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr13274351ljp.507.1631586903131;
 Mon, 13 Sep 2021 19:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour> <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org>
In-Reply-To: <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 14 Sep 2021 10:34:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
Message-ID: <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Maxime Ripard <maxime@cerno.tech>, Anup Patel <anup.patel@wdc.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/13/21 2:20 AM, Guo Ren wrote:
> > On Mon, Sep 13, 2021 at 4:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >>
> >> Hi,
> >>
> >> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> >>> From: Liu Shaohua <liush@allwinnertech.com>
> >>>
> >>> Add Allwinner kconfig option which selects SoC specific and common
> >>> drivers that is required for this SoC.
> >>>
> >>> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> >>> interconnect issues for dma synchronization, so we set the default
> >>> value when SOC_SUNXI selected.
> >>>
> >>> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>> Cc: Anup Patel <anup.patel@wdc.com>
> >>> Cc: Atish Patra <atish.patra@wdc.com>
> >>> Cc: Christoph Hellwig <hch@lst.de>
> >>> Cc: Chen-Yu Tsai <wens@csie.org>
> >>> Cc: Drew Fustini <drew@beagleboard.org>
> >>> Cc: Maxime Ripard <maxime@cerno.tech>
> >>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> >>> Cc: Wei Wu <lazyparser@gmail.com>
> >>> ---
> >>>   arch/riscv/Kconfig.socs      | 15 +++++++++++++++
> >>>   arch/riscv/configs/defconfig |  1 +
> >>>   2 files changed, 16 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> >>> index 30676ebb16eb..8721c000ef23 100644
> >>> --- a/arch/riscv/Kconfig.socs
> >>> +++ b/arch/riscv/Kconfig.socs
> >>> @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >>>
> >>>   endif
> >>>
> >>> +config SOC_SUNXI
> >>> +     bool "Allwinner SoCs"
> >>> +     depends on MMU
> >>> +     select DWMAC_GENERIC
> >>> +     select ERRATA_THEAD
> >>> +     select RISCV_DMA_NONCOHERENT
> >>> +     select RISCV_ERRATA_ALTERNATIVE
> >>> +     select SERIAL_8250
> >>> +     select SERIAL_8250_CONSOLE
> >>> +     select SERIAL_8250_DW
> >>> +     select SIFIVE_PLIC
> >>> +     select STMMAC_ETH
> >>> +     help
> >>> +       This enables support for Allwinner SoC platforms like the D1.
> >>> +
> >>
> >> I'm not sure we should select the drivers there. We could very well
> >> imagine a board without UART, or even more so without ethernet.
> > We just want people could bring D1 up easier, 8250 is the basic component.
> >
> >
> >>
> >> These options should be in the defconfig.
>
> Agreed, using a defconfig is the right way to do this.
Put 8250 related configs into arch/riscv/configs/defconfig?

 @Palmer Dabbelt @Arnd Bergmann, How do you think about that?
(defconfig or Kconfig.soc)
My purpose is when people make the Image from riscv/defconfig, then
the Image could run on all platforms include D1.

>
> --
> ~Randy
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
