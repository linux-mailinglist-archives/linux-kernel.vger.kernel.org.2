Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204AF3ECFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhHPIBv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 04:01:51 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:30995 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhHPIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:01:49 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0DD6A240004;
        Mon, 16 Aug 2021 08:01:14 +0000 (UTC)
Date:   Mon, 16 Aug 2021 10:01:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: Re: [PATCH] mtd: rawnand: mxic: Enable and prepare clocks in probe
Message-ID: <20210816100114.384f01b9@xps13>
In-Reply-To: <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
References: <20210812113800.12466-1-novikov@ispras.ru>
        <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Thu, 12 Aug 2021
15:13:10 +0300:

> On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru> wrote:
> 
> > It seems that mxic_nfc_probe() missed invocation of
> > mxic_nfc_clk_enable(). The patch fixed that. In addition, error handling
> > was refined appropriately.  
> 
> 
> NAK. Until you provide a deeper analysis, like how this works before your
> change.
> 
> 
> Please, don’t blindly generate patches, this can even your bot do, just
> think about each change and preferable test on the real hardware.
> 
> The above is to all your lovely contributions.
> 
> 
> >
> > Found by Linux Driver Verification project (linuxtesting.org).
> >
> > Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> > Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> > Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> > ---
> >  drivers/mtd/nand/raw/mxic_nand.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_
> > nand.c
> > index da1070993994..37e75bf60ee5 100644
> > --- a/drivers/mtd/nand/raw/mxic_nand.c
> > +++ b/drivers/mtd/nand/raw/mxic_nand.c
> > @@ -509,9 +509,15 @@ static int mxic_nfc_probe(struct platform_device
> > *pdev)
> >         if (IS_ERR(nfc->send_dly_clk))
> >                 return PTR_ERR(nfc->send_dly_clk);
> >
> > +       err = mxic_nfc_clk_enable(nfc);
> > +       if (err)
> > +               return err;

As Andy said, this is not needed.

> > +
> >         nfc->regs = devm_platform_ioremap_resource(pdev, 0);
> > -       if (IS_ERR(nfc->regs))
> > -               return PTR_ERR(nfc->regs);
> > +       if (IS_ERR(nfc->regs)) {
> > +               err = PTR_ERR(nfc->regs);
> > +               goto fail;
> > +       }
> >
> >         nand_chip = &nfc->chip;
> >         mtd = nand_to_mtd(nand_chip);
> > @@ -527,8 +533,10 @@ static int mxic_nfc_probe(struct platform_device
> > *pdev)
> >         nand_chip->controller = &nfc->controller;
> >
> >         irq = platform_get_irq(pdev, 0);
> > -       if (irq < 0)
> > -               return irq;
> > +       if (irq < 0) {
> > +               err = irq;
> > +               goto fail;

However some reworking is needed in the error path.

That goto statement should be renamed and devm_request_irq() should not
jump to it.

> > +       }
> >
> >         mxic_nfc_hw_init(nfc);
> >
> > --
> > 2.26.2
> >
> >  
> 

Thanks,
Miquèl
