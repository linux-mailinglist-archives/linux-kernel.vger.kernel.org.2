Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165534345E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhJTHc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:32:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:32:25 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 559111F421E2;
        Wed, 20 Oct 2021 08:30:10 +0100 (BST)
Date:   Wed, 20 Oct 2021 09:30:07 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mtd: core: protect access to mtd devices while in
 suspend
Message-ID: <20211020093007.0edb4ee4@collabora.com>
In-Reply-To: <20211020071235.in3omswo2jqrahrd@skn-laptop>
References: <20211011115253.38497-1-sean@geanix.com>
        <20211011160546.707b737b@collabora.com>
        <20211015082206.244a2316@xps13>
        <20211019180800.3v7emokse6lkpjvk@skn-laptop>
        <20211020085250.030ef244@collabora.com>
        <20211020090058.58af1087@collabora.com>
        <20211020071235.in3omswo2jqrahrd@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 09:12:35 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Wed, Oct 20, 2021 at 09:00:58AM +0200, Boris Brezillon wrote:
> > On Wed, 20 Oct 2021 08:52:50 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >   
> 
> [ ... ]
> > > > 
> > > > Hi Boris and Miquel,
> > > > 
> > > > gpmi-nand.c sets NAND_SKIP_BBTSCAN so we won't get there and populate
> > > > suspend resume hooks :(
> > > > Guess there is other drivers that does the same thing...    
> > 
> > Actually, this version is even cleaner:
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 3d6c6e880520..98c39b7f6279 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -6222,8 +6222,6 @@ static int nand_scan_tail(struct nand_chip *chip)
> >         mtd->_sync = nand_sync;
> >         mtd->_lock = nand_lock;
> >         mtd->_unlock = nand_unlock;
> > -       mtd->_suspend = nand_suspend;
> > -       mtd->_resume = nand_resume;
> >         mtd->_reboot = nand_shutdown;
> >         mtd->_block_isreserved = nand_block_isreserved;
> >         mtd->_block_isbad = nand_block_isbad;
> > @@ -6261,14 +6259,20 @@ static int nand_scan_tail(struct nand_chip *chip)
> >                 goto err_free_interface_config;
> >  
> >         /* Check, if we should skip the bad block table scan */
> > -       if (chip->options & NAND_SKIP_BBTSCAN)
> > -               return 0;
> > -
> > -       /* Build bad block table */
> > -       ret = nand_create_bbt(chip);
> > -       if (ret)
> > -               goto err_free_secure_regions;
> > +       if (chip->options & NAND_SKIP_BBTSCAN) {
> > +               /* Build bad block table */
> > +               ret = nand_create_bbt(chip);
> > +               if (ret)
> > +                       goto err_free_secure_regions;
> > +       }
> >  
> > +       /*
> > +        * Populate the suspend/resume hooks after the BBT has been scanned to
> > +        * avoid using the suspend lock and resume waitqueue which are only
> > +        * initialized when mtd_device_register() is called.
> > +        */
> > +       mtd->_suspend = nand_suspend;
> > +       mtd->_resume = nand_resume;
> >         return 0;
> >  
> >  err_free_secure_regions:  
> 
> Why is the gpmi-nand.c and other drivers set NAND_SKIP_BBTSCAN and then
> call nand_create_bbt() directly?

Dunno, but there's a nand_boot_init() call between the nand_scan() and
nand_create_bbt() calls, so I guess it has to do with something done in
this function...

> 
> To me it looks like legacy leftover...

If I were you, I wouldn't take the risk to change that in the same
patch series. The suspend/resume changes are already quite invasive,
so let's try to keep it as small/simple as possible.
