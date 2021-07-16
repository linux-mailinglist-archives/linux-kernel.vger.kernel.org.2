Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B73CB939
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbhGPPDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhGPPDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69C80613F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447613;
        bh=MvtPm16ciGdCL4jI4gviO9ECmXWAu9QPZUBdt/X/PNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FV8gMsxlSq8Ra6nVpGUzTfGsySQo4PxqM7FUGXrQZQRD3nuWte5jZvbR+fNZbV/Jc
         U8RdaCOHNj1zcNVfPRo05WAM3YjSIi7Xg69mI54T5fvbg4UcgV3aAiB4rx+MFo8mh0
         IUgSkMOcozt6mTmS/XTH/a+s+cGfM1Lh4XUgmN6XTdrjU2QLW2ASno+spVBemPiEDH
         /01aecQ/gVrA8ACzqWeiDFtoTgYFaJyIArp9dYwBIbz9D49lQKt80ZkLA3xmo06ibT
         UkArEfObC3N4PtjP/woHiPTmtV5LmgHD8vsXWh4wgccsLDEKGTLfL2DfR1zWudAwd8
         JII+LMCJFFuBg==
Received: by mail-ed1-f45.google.com with SMTP id dj21so13444644edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 08:00:13 -0700 (PDT)
X-Gm-Message-State: AOAM530PIPMIWUbNeW56R4fDys/xxrkwG+ZYnwEXKBhA8+OmBSINOauN
        h1tRBBj/wJR+ZSJUQkB4QLw38tRM3ua5pLbLqA==
X-Google-Smtp-Source: ABdhPJyMaQ4QxvAzh0jWs1kUpIeu14lo4KHbehHHGqgblFNEWbcuhWJH1mI30cl72GT4No1Vu1wksYUoSbf3ui/zcCo=
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr15305186edt.137.1626447611907;
 Fri, 16 Jul 2021 08:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626253775.git.mchehab+huawei@kernel.org>
 <1e7ec01a61916a03e7165e684d8d5b7dc58970f0.1626253775.git.mchehab+huawei@kernel.org>
 <CAL_JsqJKkLZH7GnhFh=oznFnK+j2b7VVjsfWAWZq47TkqDayOw@mail.gmail.com> <20210716164529.35d3cb0c@coco.lan>
In-Reply-To: <20210716164529.35d3cb0c@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Jul 2021 08:59:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLDysRNS0YLa2qet09Y3c9ytVkQVtVxxyjr6xdt3_mF0g@mail.gmail.com>
Message-ID: <CAL_JsqLDysRNS0YLa2qet09Y3c9ytVkQVtVxxyjr6xdt3_mF0g@mail.gmail.com>
Subject: Re: [PATCH v13 1/9] staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 8:45 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Wed, 14 Jul 2021 07:36:43 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
> > On Wed, Jul 14, 2021 at 3:13 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Instead of using the standard name ("gpios"), use "interrupts".
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c              | 2 +-
> > >  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 4 ++--
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > > index 35ef3d4c760b..9a7e095246f7 100644
> > > --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > > +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > > @@ -233,7 +233,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
> > >
> > >         ddata->dev = dev;
> > >
> > > -       ddata->gpio = of_get_gpio(np, 0);
> > > +       ddata->gpio = of_get_named_gpio_flags(np, "interrupts", 0, NULL);
> >
> > It's an interrupt, you should be using platform_get_irq() and
> > devm_request_irq().
> >
> > In general, you should not be using of_get_* for any resources, but
> > use the firmware agnostic flavors.
>
> I've no idea how to convert to use platform_get_irq().
>
> I tried to replace the logic:
>
>         priv->gpio = of_get_gpio(np, 0);
>         if (priv->gpio < 0)
>                 return priv->gpio;
>
>         if (!gpio_is_valid(priv->gpio))
>                 return -EINVAL;
>
>         ret = devm_gpio_request_one(dev, priv->gpio, GPIOF_IN, "pmic");
>         if (ret < 0) {
>                 dev_err(dev, "Failed to request gpio%d\n", priv->gpio);
>                 return ret;
>         }
>
> Into:
>
>         priv->irq = platform_get_irq(pdev, 0);
>
> But it didn't work (I also tried the platform_get_irq_byname):
>
>         [    1.109586] hi6421v600-irq hi6421v600-irq: hi6421v600_irq_probe:
>         [    1.115676] hi6421v600-irq hi6421v600-irq: IRQ index 0 not found
>         [    1.121751] hi6421v600-irq hi6421v600-irq: Error -6 when getting IRQs
>
> The original DT schema as:
>
>         gpios = <&gpio28 0 0>;
>
> Based on your past review, this was replaced by:
>
>         interrupts = <&gpio28 0 0>;
>
>
> What am I missing?

'interrupts' doesn't take a phandle. You need:

interrupts = <0 0>;
interrupt-parent = <&gpio28>;

You should have been getting dtc warnings that this was wrong.

Rob
