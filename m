Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412E140880D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhIMJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236022AbhIMJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:21:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 907286108C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631524838;
        bh=tfo4VT9tevF5EcHGadDEEin7sfPHUCanQbDTfYb3Vf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cBxOc+qtt5DHPfsNN6ZhPycytvYHxXsn2o5RkLGEUsXrdLnmmJpT6kVmMBHxgB/I4
         1voj1iU6JNM3dD6y4DZOArD5lGfgSDFyB4y7TKGCUTSpuYWubBlTU/z1aQZ5MDcgM9
         mRuUf8IZoYDXTiBr8Sf7F76Zi9jFaUeE0+SkimSsIIvlxDRY0iBZkkOc8mPWL/7aPL
         v8hqWeKjamlmw9UgIM9mDFBJua00iunE4sROQwi3489CTcciTBmKImX9itgauGK+A2
         pxi0pmkIlBLumDKyeDV4zqhXpwe3v1K1OCZVC980O/HE42lrNkrMVj5UX4FWteq6oO
         btDIMw74sFHrA==
Received: by mail-lj1-f173.google.com with SMTP id i28so16033115ljm.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:20:38 -0700 (PDT)
X-Gm-Message-State: AOAM531H1GyvhVMCtrui4EaayafqHEqfKjZa8AJUC/oI4TXsg/YNYDL2
        vSXa7SFbTW0HGVUyyjKnx6k6kbBbvgP8+/oP2Io=
X-Google-Smtp-Source: ABdhPJwUQ2Vxc3mqOt2ji6UfpEtOyKYZA5k/71ajUtuybnmHl+zIXrXWmr+nwOV4WhG4DmX+3bhYyf6UnmBUpzr76Wk=
X-Received: by 2002:a2e:a4d1:: with SMTP id p17mr9437403ljm.82.1631524836885;
 Mon, 13 Sep 2021 02:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
In-Reply-To: <20210913084520.kkbsupogkzv226x3@gilmour>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 13 Sep 2021 17:20:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
Message-ID: <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
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

On Mon, Sep 13, 2021 at 4:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> > From: Liu Shaohua <liush@allwinnertech.com>
> >
> > Add Allwinner kconfig option which selects SoC specific and common
> > drivers that is required for this SoC.
> >
> > Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> > interconnect issues for dma synchronization, so we set the default
> > value when SOC_SUNXI selected.
> >
> > Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Wei Fu <wefu@redhat.com>
> > Cc: Anup Patel <anup.patel@wdc.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Drew Fustini <drew@beagleboard.org>
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Wei Wu <lazyparser@gmail.com>
> > ---
> >  arch/riscv/Kconfig.socs      | 15 +++++++++++++++
> >  arch/riscv/configs/defconfig |  1 +
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 30676ebb16eb..8721c000ef23 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif
> >
> > +config SOC_SUNXI
> > +     bool "Allwinner SoCs"
> > +     depends on MMU
> > +     select DWMAC_GENERIC
> > +     select ERRATA_THEAD
> > +     select RISCV_DMA_NONCOHERENT
> > +     select RISCV_ERRATA_ALTERNATIVE
> > +     select SERIAL_8250
> > +     select SERIAL_8250_CONSOLE
> > +     select SERIAL_8250_DW
> > +     select SIFIVE_PLIC
> > +     select STMMAC_ETH
> > +     help
> > +       This enables support for Allwinner SoC platforms like the D1.
> > +
>
> I'm not sure we should select the drivers there. We could very well
> imagine a board without UART, or even more so without ethernet.
We just want people could bring D1 up easier, 8250 is the basic component.


>
> These options should be in the defconfig.
>
> Maxime



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
