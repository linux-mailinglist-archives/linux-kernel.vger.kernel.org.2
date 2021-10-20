Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E76434626
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTHuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJTHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:50:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:47:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 53C191F43EA3;
        Wed, 20 Oct 2021 08:47:44 +0100 (BST)
Date:   Wed, 20 Oct 2021 09:47:41 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mtd: core: protect access to mtd devices while in
 suspend
Message-ID: <20211020094741.027a118d@collabora.com>
In-Reply-To: <20211020072352.7fnano7wm5l4bfi6@skn-laptop>
References: <20211011115253.38497-1-sean@geanix.com>
        <20211011160546.707b737b@collabora.com>
        <20211015082206.244a2316@xps13>
        <20211019180800.3v7emokse6lkpjvk@skn-laptop>
        <20211020085250.030ef244@collabora.com>
        <20211020090058.58af1087@collabora.com>
        <20211020091228.136fde6e@xps13>
        <20211020072352.7fnano7wm5l4bfi6@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 09:23:52 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Wed, Oct 20, 2021 at 09:12:28AM +0200, Miquel Raynal wrote:
> > > 
> > > Actually, this version is even cleaner:
> > > 
> > > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > > index 3d6c6e880520..98c39b7f6279 100644
> > > --- a/drivers/mtd/nand/raw/nand_base.c
> > > +++ b/drivers/mtd/nand/raw/nand_base.c
> > > @@ -6222,8 +6222,6 @@ static int nand_scan_tail(struct nand_chip *chip)
> > >         mtd->_sync = nand_sync;
> > >         mtd->_lock = nand_lock;
> > >         mtd->_unlock = nand_unlock;
> > > -       mtd->_suspend = nand_suspend;
> > > -       mtd->_resume = nand_resume;
> > >         mtd->_reboot = nand_shutdown;
> > >         mtd->_block_isreserved = nand_block_isreserved;
> > >         mtd->_block_isbad = nand_block_isbad;
> > > @@ -6261,14 +6259,20 @@ static int nand_scan_tail(struct nand_chip *chip)
> > >                 goto err_free_interface_config;
> > >  
> > >         /* Check, if we should skip the bad block table scan */
> > > -       if (chip->options & NAND_SKIP_BBTSCAN)
> > > -               return 0;
> > > -
> > > -       /* Build bad block table */
> > > -       ret = nand_create_bbt(chip);
> > > -       if (ret)
> > > -               goto err_free_secure_regions;
> > > +       if (chip->options & NAND_SKIP_BBTSCAN) {
> > > +               /* Build bad block table */
> > > +               ret = nand_create_bbt(chip);
> > > +               if (ret)
> > > +                       goto err_free_secure_regions;
> > > +       }  
> > 
> > Nice idea.
> >   
> > >  
> > > +       /*
> > > +        * Populate the suspend/resume hooks after the BBT has been scanned to
> > > +        * avoid using the suspend lock and resume waitqueue which are only
> > > +        * initialized when mtd_device_register() is called.
> > > +        */
> > > +       mtd->_suspend = nand_suspend;
> > > +       mtd->_resume = nand_resume;
> > >         return 0;
> > >  
> > >  err_free_secure_regions:  
> 
> Could be a nice idea, but it doesn't work...
> gpmi-nand.c calls nand_create_bbt() after this have run ;)

Er, indeed. Can you try with this instead:

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index b7ad030225f8..548647bd27a4 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1397,8 +1397,28 @@ static int nand_create_badblock_pattern(struct nand_chip *this)
  */
 int nand_create_bbt(struct nand_chip *this)
 {
+       struct mtd_info *mtd = nand_to_mtd(this)
+       int (*suspend) (struct mtd_info *) = mtd->_suspend;
+       int (*resume) (struct mtd_info *) = mtd->_resume;
        int ret;
 
+       /*
+        * The BBT scan logic use the MTD helpers before the MTD layer had a
+        * chance to initialize the device, and that leads to issues when
+        * accessing the uninitialized suspend lock. Let's temporarily set the
+        * suspend/resume hooks to NULL to skip the lock acquire/release step.
+        *
+        * FIXME: This is an ugly hack, so please don't copy this pattern to
+        * other MTD implementations. The proper fix would be to implement a
+        * generic BBT scan logic at the NAND level that's not using any of the
+        * MTD helpers to access pages. We also might consider doing a two
+        * step initialization at the MTD level (mtd_device_init() +
+        * mtd_device_register()) so some of the fields are initialized
+        * early.
+        */
+       mtd->_suspend = NULL;
+       mtd->_resume = NULL;
+
        /* Is a flash based bad block table requested? */
        if (this->bbt_options & NAND_BBT_USE_FLASH) {
                /* Use the default pattern descriptors */
@@ -1422,7 +1442,13 @@ int nand_create_bbt(struct nand_chip *this)
                        return ret;
        }
 
-       return nand_scan_bbt(this, this->badblock_pattern);
+       ret = nand_scan_bbt(this, this->badblock_pattern);
+
+       /* Restore the suspend/resume hooks. */
+       mtd->_suspend = suspend;
+       mtd->_resume = resume;
+
+       return ret;
 }
 EXPORT_SYMBOL(nand_create_bbt);
 
