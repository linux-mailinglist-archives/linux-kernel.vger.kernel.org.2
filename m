Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0400138B56D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhETRsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhETRsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C142613D1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621532839;
        bh=v6c692HpaiUNYLBW8NHQxpu5a4y3zsvrULjJ+1d4CSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vJJ+CFa6mcYGibOcKcKkmiumbYkSWLrRDzT12/QCPD7n7/EN4Ju/qYfcwnxC2kzzK
         nsNECseUSy9Tp4b4fTFHbH5E9naUtsOn6VrfbfAU/GkN7DvvFCSnUBCna7zzKt+luY
         lYF8RgpOZJhf8Y861gKVJxhOzFV+X2P1Q0HEYL/fFBubZXCrwf3btzqCSM4yG5bXF4
         ObbzRj1Ige6BYv2LNGpBtbrImdkBs0Lhzof2KymWTKHb+jSWisvoHOYt6rnKr5xxkb
         vFThECuc+kQT9Am6M5sS1cidHTqTThsfw7HT2j30tfj+C5VwVhSF6vlq1WKsmIIUWw
         EEZnT6Jsg8SPw==
Received: by mail-ed1-f44.google.com with SMTP id s6so20350450edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:47:19 -0700 (PDT)
X-Gm-Message-State: AOAM5322bcU867zq0VcBabUPAIEt4E4IOo6g3ae3HMMwlTpuUR8PUTr1
        zXvevc8Hful/OzEwhRqrrp7VdkN0o/588tkjEg==
X-Google-Smtp-Source: ABdhPJxPOecSm7Lse7H/+a0GuLAtwROgxrajM++9UFLVwD1e2pkoRhWaLvZGj6HsYR5yXp76zqg+ptVJVg/RuNJ/27s=
X-Received: by 2002:a05:6402:3513:: with SMTP id b19mr4788912edd.137.1621532838075;
 Thu, 20 May 2021 10:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-31-maz@kernel.org>
In-Reply-To: <20210520163751.27325-31-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 May 2021 12:47:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nu8PmONzx2AfysRWuhJDV9Xn3O5rCOfEZL0KoC12_qw@mail.gmail.com>
Message-ID: <CAL_Jsq+nu8PmONzx2AfysRWuhJDV9Xn3O5rCOfEZL0KoC12_qw@mail.gmail.com>
Subject: Re: [PATCH 30/39] PCI: Bulk conversion to generic_handle_domain_irq()
To:     Marc Zyngier <maz@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:57 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Wherever possible, replace constructs that match either
> generic_handle_irq(irq_find_mapping()) or
> generic_handle_irq(irq_linear_revmap()) to a single call to
> generic_handle_domain_irq().
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c        | 14 +++++---------
>  drivers/pci/controller/dwc/pci-keystone.c      |  5 ++---
>  .../pci/controller/dwc/pcie-designware-host.c  |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-uniphier.c     |  6 ++----
>  .../controller/mobiveil/pcie-mobiveil-host.c   | 15 ++++++---------
>  drivers/pci/controller/pci-aardvark.c          |  5 ++---
>  drivers/pci/controller/pci-ftpci100.c          |  2 +-
>  drivers/pci/controller/pci-tegra.c             |  8 +++-----
>  drivers/pci/controller/pci-xgene-msi.c         |  9 +++------
>  drivers/pci/controller/pcie-altera-msi.c       | 10 ++++------
>  drivers/pci/controller/pcie-altera.c           | 10 ++++------
>  drivers/pci/controller/pcie-brcmstb.c          |  9 ++++-----
>  drivers/pci/controller/pcie-iproc-msi.c        |  4 +---
>  drivers/pci/controller/pcie-mediatek-gen3.c    | 13 ++++---------
>  drivers/pci/controller/pcie-mediatek.c         | 12 ++++--------
>  drivers/pci/controller/pcie-microchip-host.c   | 18 +++++++-----------
>  drivers/pci/controller/pcie-rcar-host.c        |  8 +++-----
>  drivers/pci/controller/pcie-rockchip-host.c    |  8 +++-----
>  drivers/pci/controller/pcie-xilinx-cpm.c       |  4 ++--
>  drivers/pci/controller/pcie-xilinx-nwl.c       | 13 +++----------
>  drivers/pci/controller/pcie-xilinx.c           |  9 ++++-----
>  21 files changed, 71 insertions(+), 120 deletions(-)


> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index 1c34c897a7e2..cf3832b905e8 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -291,8 +291,7 @@ static void xgene_msi_isr(struct irq_desc *desc)
>         struct irq_chip *chip = irq_desc_get_chip(desc);
>         struct xgene_msi_group *msi_groups;
>         struct xgene_msi *xgene_msi;
> -       unsigned int virq;
> -       int msir_index, msir_val, hw_irq;
> +       int msir_index, msir_val, hw_irq, ret;
>         u32 intr_index, grp_select, msi_grp;
>
>         chained_irq_enter(chip, desc);
> @@ -330,10 +329,8 @@ static void xgene_msi_isr(struct irq_desc *desc)
>                          * CPU0
>                          */
>                         hw_irq = hwirq_to_canonical_hwirq(hw_irq);
> -                       virq = irq_find_mapping(xgene_msi->inner_domain, hw_irq);
> -                       WARN_ON(!virq);
> -                       if (virq != 0)
> -                               generic_handle_irq(virq);
> +                       ret = generic_handle_domain_irq(xgene_msi->inner_domain, hw_irq);
> +                       WARN_ON(ret);

There's various error prints in some of the handlers. I think they
should be moved to the core. I can't imagine handling the irq is ever
optional.

Rob
