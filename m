Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5B40D352
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhIPGjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234452AbhIPGj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:39:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA2BC61242
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631774289;
        bh=cl8cjumjedhg/hUSA0E7lpIPUJaxO5tf0lxL5C33oeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgUjnx38MmVIaK92HRctfJAVwHEh20dg5OkdR7td5s+W9NK6TNe46MquG1/PN1tw7
         u6he9G97ZY8cC73oLXBZTyKKqoZ4cojFTxLd/IDdSEzAV/IDbqZivMAWW0Zn+NEj+v
         YjqS3b7/y9OphPsUlYJ1+3Ppl8c+JP45LYrvGseNnwxuIpBOnCMshgfVoUEqhLcam0
         +ItMqROIymcpy0z+nOFYJw4eCplTvJefAvEqYd28Lo/+18v3BXf+TpvoWP0zcz4jcs
         0G4dYyBG4nAHWrcXiPFdSfTXFItm6AmrMa5sEmNI+3//0Pp+kYIwOMrNdY4LECFkWw
         bXn17QteM+8Pw==
Received: by mail-lf1-f47.google.com with SMTP id h16so14288943lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:38:09 -0700 (PDT)
X-Gm-Message-State: AOAM530ZjWOpIG2d3Kpf0RFUg4TWklWgNtY5XsOphcTZz1GF4/kdrUQF
        PZ1j4u3/AvL2cHEyECy2r+2RkHviuDXwwoq1zOA=
X-Google-Smtp-Source: ABdhPJxK3o76pgI6LlHKF8AqVNm3vLxTy301SYbamsChBSxE7YdZQl31Jw9GlrhfVxqv5Fxj2+bDxLsoEsQlbuKxju4=
X-Received: by 2002:a05:6512:3f9f:: with SMTP id x31mr3075402lfa.233.1631774287843;
 Wed, 15 Sep 2021 23:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour> <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org> <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
 <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
In-Reply-To: <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 16 Sep 2021 14:37:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQn3WafM8O9km=bbXDpx-fsejt+t0twrKNSHSHsvaZqRw@mail.gmail.com>
Message-ID: <CAJF2gTQn3WafM8O9km=bbXDpx-fsejt+t0twrKNSHSHsvaZqRw@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
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

On Tue, Sep 14, 2021 at 5:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 14, 2021 at 4:36 AM Guo Ren <guoren@kernel.org> wrote:
> > On Tue, Sep 14, 2021 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 9/13/21 2:20 AM, Guo Ren wrote:
> > > > On Mon, Sep 13, 2021 at 4:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > >> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> > > >>> From: Liu Shaohua <liush@allwinnertech.com>
> > > >>>
> > > >>> Add Allwinner kconfig option which selects SoC specific and common
> > > >>> drivers that is required for this SoC.
> > > >>>
> > > >>> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> > > >>> interconnect issues for dma synchronization, so we set the default
> > > >>> value when SOC_SUNXI selected.
> > > >>>
> > > >>>
> > > >>> +config SOC_SUNXI
> > > >>> +     bool "Allwinner SoCs"
> > > >>> +     depends on MMU
> > > >>> +     select DWMAC_GENERIC
> > > >>> +     select ERRATA_THEAD
> > > >>> +     select RISCV_DMA_NONCOHERENT
> > > >>> +     select RISCV_ERRATA_ALTERNATIVE
> > > >>> +     select SERIAL_8250
> > > >>> +     select SERIAL_8250_CONSOLE
> > > >>> +     select SERIAL_8250_DW
> > > >>> +     select SIFIVE_PLIC
> > > >>> +     select STMMAC_ETH
> > > >>> +     help
> > > >>> +       This enables support for Allwinner SoC platforms like the D1.
> > > >>> +
> > > >>
> > > >> I'm not sure we should select the drivers there. We could very well
> > > >> imagine a board without UART, or even more so without ethernet.
> > > > We just want people could bring D1 up easier, 8250 is the basic component.
> > > >
> > > >
> > > >>
> > > >> These options should be in the defconfig.
> > >
> > > Agreed, using a defconfig is the right way to do this.
> > Put 8250 related configs into arch/riscv/configs/defconfig?
>
> I think that would be best, as well as the STMMAC_ETH and
> DWMAC_GENERIC options.
Okay, I would move STMMAC_ETH SERIAL_8250_DW SERIAL_8250_CONSOLE
SERIAL_8250 & SIFIVE_PLIC into defconfig in the next version of the
patch.

>
> If all RISC-V chips are required to have a 8250 compatible uart,
> selecting it from CONFIG_RISCV would work as well, but for
> consistency I'd give users the option to leave it out, just like
> any other driver that is not required to have a useful system.
>
> >  @Palmer Dabbelt @Arnd Bergmann, How do you think about that?
> > (defconfig or Kconfig.soc)
> > My purpose is when people make the Image from riscv/defconfig, then
> > the Image could run on all platforms include D1.
>
> I would try to keep the Kconfig.soc as short as possible. As a general
> rule, only use 'select' to enable symbols that are otherwise not user
> visible, such as the specific errata if you want to hide them. For individual
> SoCs, I prefer not having separate Kconfig options, but instead have
> those per driver. We have some SoC families that have part specific
> options elsewhere, e.g. drivers/soc/renesas/Kconfig, but I'd only add
> those if you can't avoid it. Having it in drivers/soc/ may be better for
> sunxi than spreading them over arch/{arm,arm64,riscv}.
>
> Some subsystem maintainers want drivers to be selected by the SoC
> option, this is why you need the 'select SIFIVE_PLIC', but usually
> the drivers are selectable with a 'depends on ARCH_SUNXI ||
> COMPILE_TEST' and enabled in the defconfig.
>
> If you want to get fancy, you can use something like:
>
> config RESET_SUNXI
>         bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>         default ARCH_SUNXI
>
> This will make an option that
>  - always enabled when the platform is built-in
>  - user selectable when compile-testing for any other platform
>  - always disabled otherwise
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
