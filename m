Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB2A38E792
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhEXNal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232885AbhEXNaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:30:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE242613D8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621862936;
        bh=kE3gL04mJXooRokA4ix7dxU3jLeoiVUafEG0fZx7vHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NQ3WzbkRAn9UuCZKhROWIQPfT1nwpD9Cu88enoHNBH3hb8UUehCYTe8SEtFV9uPhs
         6k57XqyXFre7flPO6y3zEkurge0irsOibCOCZFBP7JfNDT7GQtXQPU2EcE3XZvVgtv
         W+cFPhMveM9FVyeV+qO160rXvdoowOD5Mtobgox7yuv2An69bxdac001On5B1XdsGx
         TrlqZuzhLiMcbsBahi0KIP7xDOGOLAaWOfyIy4Fl7pg3Q5BtputE/5wD0CykdY5UoY
         iGWB7eXuEmImgLkrVyO5hyDDoVV644HHiM6qfpZeGBF953JrcEeBFY5h7P8XUWDPiC
         UhZMLAgNyU7CQ==
Received: by mail-ed1-f52.google.com with SMTP id b17so31990348ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:28:55 -0700 (PDT)
X-Gm-Message-State: AOAM530qFHTLCvD4f/IQWl2PpxECPCE506+x7mlsPVlZfUGgMH1ruakT
        L2On/UJkO0WazHt7dGDbAfWR593nW7TB/rHTbw==
X-Google-Smtp-Source: ABdhPJyJrzJLfKdJqW+81Y1zhbTP0tEmlqFEEnHebE+4meQuLlpmSOtERQCj8KnZMV9t40jkzyX31w52FqR4rQ1zbjo=
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr25590910edu.165.1621862934229;
 Mon, 24 May 2021 06:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-31-maz@kernel.org>
 <CAL_Jsq+nu8PmONzx2AfysRWuhJDV9Xn3O5rCOfEZL0KoC12_qw@mail.gmail.com> <87tumswmqc.wl-maz@kernel.org>
In-Reply-To: <87tumswmqc.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 May 2021 08:28:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWLLRmusfvAweahA=ZKxOChRWAVUKehShpvn60kScsrw@mail.gmail.com>
Message-ID: <CAL_JsqLWLLRmusfvAweahA=ZKxOChRWAVUKehShpvn60kScsrw@mail.gmail.com>
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

On Mon, May 24, 2021 at 3:38 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 20 May 2021 18:47:06 +0100,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, May 20, 2021 at 11:57 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Wherever possible, replace constructs that match either
> > > generic_handle_irq(irq_find_mapping()) or
> > > generic_handle_irq(irq_linear_revmap()) to a single call to
> > > generic_handle_domain_irq().
> > >
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pci-dra7xx.c        | 14 +++++---------
> > >  drivers/pci/controller/dwc/pci-keystone.c      |  5 ++---
> > >  .../pci/controller/dwc/pcie-designware-host.c  |  9 ++++-----
> > >  drivers/pci/controller/dwc/pcie-uniphier.c     |  6 ++----
> > >  .../controller/mobiveil/pcie-mobiveil-host.c   | 15 ++++++---------
> > >  drivers/pci/controller/pci-aardvark.c          |  5 ++---
> > >  drivers/pci/controller/pci-ftpci100.c          |  2 +-
> > >  drivers/pci/controller/pci-tegra.c             |  8 +++-----
> > >  drivers/pci/controller/pci-xgene-msi.c         |  9 +++------
> > >  drivers/pci/controller/pcie-altera-msi.c       | 10 ++++------
> > >  drivers/pci/controller/pcie-altera.c           | 10 ++++------
> > >  drivers/pci/controller/pcie-brcmstb.c          |  9 ++++-----
> > >  drivers/pci/controller/pcie-iproc-msi.c        |  4 +---
> > >  drivers/pci/controller/pcie-mediatek-gen3.c    | 13 ++++---------
> > >  drivers/pci/controller/pcie-mediatek.c         | 12 ++++--------
> > >  drivers/pci/controller/pcie-microchip-host.c   | 18 +++++++-----------
> > >  drivers/pci/controller/pcie-rcar-host.c        |  8 +++-----
> > >  drivers/pci/controller/pcie-rockchip-host.c    |  8 +++-----
> > >  drivers/pci/controller/pcie-xilinx-cpm.c       |  4 ++--
> > >  drivers/pci/controller/pcie-xilinx-nwl.c       | 13 +++----------
> > >  drivers/pci/controller/pcie-xilinx.c           |  9 ++++-----
> > >  21 files changed, 71 insertions(+), 120 deletions(-)
> >
> >
> > > diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> > > index 1c34c897a7e2..cf3832b905e8 100644
> > > --- a/drivers/pci/controller/pci-xgene-msi.c
> > > +++ b/drivers/pci/controller/pci-xgene-msi.c
> > > @@ -291,8 +291,7 @@ static void xgene_msi_isr(struct irq_desc *desc)
> > >         struct irq_chip *chip = irq_desc_get_chip(desc);
> > >         struct xgene_msi_group *msi_groups;
> > >         struct xgene_msi *xgene_msi;
> > > -       unsigned int virq;
> > > -       int msir_index, msir_val, hw_irq;
> > > +       int msir_index, msir_val, hw_irq, ret;
> > >         u32 intr_index, grp_select, msi_grp;
> > >
> > >         chained_irq_enter(chip, desc);
> > > @@ -330,10 +329,8 @@ static void xgene_msi_isr(struct irq_desc *desc)
> > >                          * CPU0
> > >                          */
> > >                         hw_irq = hwirq_to_canonical_hwirq(hw_irq);
> > > -                       virq = irq_find_mapping(xgene_msi->inner_domain, hw_irq);
> > > -                       WARN_ON(!virq);
> > > -                       if (virq != 0)
> > > -                               generic_handle_irq(virq);
> > > +                       ret = generic_handle_domain_irq(xgene_msi->inner_domain, hw_irq);
> > > +                       WARN_ON(ret);
> >
> > There's various error prints in some of the handlers. I think they
> > should be moved to the core. I can't imagine handling the irq is ever
> > optional.
>
> Printing stuff like this is a sure recipe for disaster, and there is
> no way I'm moving such crap into core code.

Then why maintain such crap code? I'm fine with just removing. I just
think we should have some consistency.

> If the interrupt handling
> fails (most likely because there is no mapping for this interrupt), it
> is the driver's responsibility to handle the error (either disabling
> the input or the output of the secondary irqchip). There isn't much
> the core code can do about it.

I would imagine the errors here would be the 'this should never
happen' kind. Maybe a race with tearing down the domain. Seems to me
the core code should be warning when the calling code has made
mistakes.

Rob
