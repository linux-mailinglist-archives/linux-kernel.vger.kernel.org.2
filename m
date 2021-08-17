Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751533EEB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhHQLA3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Aug 2021 07:00:29 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43443 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:00:27 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AF36B60008;
        Tue, 17 Aug 2021 10:59:50 +0000 (UTC)
Date:   Tue, 17 Aug 2021 12:59:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>,
        ycllin@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: mxic: Enable and prepare clocks in probe
Message-ID: <20210817125949.5bde9715@xps13>
In-Reply-To: <20210817125521.487979b9@xps13>
References: <20210812113800.12466-1-novikov@ispras.ru>
        <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
        <20210816100114.384f01b9@xps13>
        <246f2094-e294-73f8-8a5f-3467e987f788@ispras.ru>
        <20210817125521.487979b9@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue, 17 Aug 2021
12:55:21 +0200:

> Hi Evgeny,
> 
> +Mason from Macronix

Mason's e-mail bounced, including YouChing in the discussion who may
also have an answer or perhaps knows who to include in the discussion
(see below for the context and question).

> 
> Evgeny Novikov <novikov@ispras.ru> wrote on Tue, 17 Aug 2021 13:36:03
> +0300:
> 
> > Hi Miquel,
> > 
> > On 16.08.2021 11:01, Miquel Raynal wrote:
> > > Hi Andy,
> > >
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Thu, 12 Aug 2021
> > > 15:13:10 +0300:
> > >  
> > >> On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru> wrote:
> > >>  
> > >>> It seems that mxic_nfc_probe() missed invocation of
> > >>> mxic_nfc_clk_enable(). The patch fixed that. In addition, error handling
> > >>> was refined appropriately.  
> > >>
> > >> NAK. Until you provide a deeper analysis, like how this works before your
> > >> change.
> > >>
> > >>
> > >> Please, don’t blindly generate patches, this can even your bot do, just
> > >> think about each change and preferable test on the real hardware.
> > >>
> > >> The above is to all your lovely contributions.
> > >>
> > >>  
> > >>> Found by Linux Driver Verification project (linuxtesting.org).
> > >>>
> > >>> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> > >>> Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> > >>> Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> > >>> ---
> > >>>   drivers/mtd/nand/raw/mxic_nand.c | 16 ++++++++++++----
> > >>>   1 file changed, 12 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_
> > >>> nand.c
> > >>> index da1070993994..37e75bf60ee5 100644
> > >>> --- a/drivers/mtd/nand/raw/mxic_nand.c
> > >>> +++ b/drivers/mtd/nand/raw/mxic_nand.c
> > >>> @@ -509,9 +509,15 @@ static int mxic_nfc_probe(struct platform_device
> > >>> *pdev)
> > >>>          if (IS_ERR(nfc->send_dly_clk))
> > >>>                  return PTR_ERR(nfc->send_dly_clk);
> > >>>
> > >>> +       err = mxic_nfc_clk_enable(nfc);
> > >>> +       if (err)
> > >>> +               return err;  
> > > As Andy said, this is not needed.
> > >  
> > >>> +
> > >>>          nfc->regs = devm_platform_ioremap_resource(pdev, 0);
> > >>> -       if (IS_ERR(nfc->regs))
> > >>> -               return PTR_ERR(nfc->regs);
> > >>> +       if (IS_ERR(nfc->regs)) {
> > >>> +               err = PTR_ERR(nfc->regs);
> > >>> +               goto fail;
> > >>> +       }
> > >>>
> > >>>          nand_chip = &nfc->chip;
> > >>>          mtd = nand_to_mtd(nand_chip);
> > >>> @@ -527,8 +533,10 @@ static int mxic_nfc_probe(struct platform_device
> > >>> *pdev)
> > >>>          nand_chip->controller = &nfc->controller;
> > >>>
> > >>>          irq = platform_get_irq(pdev, 0);
> > >>> -       if (irq < 0)
> > >>> -               return irq;
> > >>> +       if (irq < 0) {
> > >>> +               err = irq;
> > >>> +               goto fail;  
> > > However some reworking is needed in the error path.
> > >
> > > That goto statement should be renamed and devm_request_irq() should not
> > > jump to it.
> > >  
> > 
> > We still need some help and clarification from those who are very familiar with this sort of drivers or/and can test this particular driver. mxic_nfc_clk_enable() is the complementary function for mxic_nfc_clk_disable(). No other functions invoke clk_prepare_enable()/clk_disable_unprepare() in the driver. Unlikely somebody in its environment does that since driver specific clocks are dealt with. At the moment the driver invokes mxic_nfc_clk_disable() on error handling paths in probe, in remove and in mxic_nfc_set_freq(). mxic_nfc_clk_enable() is called just by mxic_nfc_set_freq() that moreover does this after calling mxic_nfc_clk_disable() first. So, we did not find any place in the driver that invokes mxic_nfc_clk_enable() prior to mxic_nfc_clk_disable(). Basing on this we added mxic_nfc_clk_enable() just after getting clocks. As I explained in the previous large e-mail, we may be wrong in our understanding of the driver environment or/and at specification of requirements being checked. It would be great if you will point out on our mistakes.
> 
> Enabling the clocks seems to only be needed to access the NAND device
> and not the registers of the controller. Mason, is this statement
> right? If this statement is wrong, then your proposal is not entirely
> wrong in the sense that we must enable the missing clock *before*
> accessing any register.
> 
> Otherwise for the two other clocks, we don't really care to enable them
> before setting the actual frequency in ->setup_interface() (called by
> nand_scan()) because at this point we don't yet know what timing mode
> is best. Disabling the clock is not an issue even though it was not
> enabled in the fist place anyway.
> 
> In all cases, the error path is wrong.
> 
> Thanks,
> Miquèl
