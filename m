Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15943458A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:55:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:55:08 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 30E6E1F43E3A;
        Wed, 20 Oct 2021 07:52:53 +0100 (BST)
Date:   Wed, 20 Oct 2021 08:52:50 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mtd: core: protect access to mtd devices while in
 suspend
Message-ID: <20211020085250.030ef244@collabora.com>
In-Reply-To: <20211019180800.3v7emokse6lkpjvk@skn-laptop>
References: <20211011115253.38497-1-sean@geanix.com>
        <20211011160546.707b737b@collabora.com>
        <20211015082206.244a2316@xps13>
        <20211019180800.3v7emokse6lkpjvk@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 20:08:00 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Fri, Oct 15, 2021 at 08:22:06AM +0200, Miquel Raynal wrote:
> > Hi Sean,
> > 
> > boris.brezillon@collabora.com wrote on Mon, 11 Oct 2021 16:05:46 +0200:
> >   
> > > On Mon, 11 Oct 2021 13:52:50 +0200  
> 
> [ ... ]
> 
> >   
> > > > One (small) issue still present. gpmi_nand.c uses the rwsem before it's
> > > > initialized. Seems cumbersome to have every mtd/nand driver to call
> > > > init_waitqueue_head() and init_rwsem(). Could we somehow move the call
> > > > to mtd_set_dev_defaults() before nand_create_bbt()?    
> > > 
> > > I have a nasty trick for that one, but I'm not sure Miquel will like it
> > > (actually, I don't like it either, but it's so simple compared to the
> > > other options we have that I'm tempted to go for this approach until
> > > someone has time to invest in a cleaner solution :-)):
> > > 
> > > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > > index 3d6c6e880520..a9ac2d528a4d 100644
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
> > > @@ -6269,6 +6267,13 @@ static int nand_scan_tail(struct nand_chip *chip)
> > >         if (ret)
> > >                 goto err_free_secure_regions;
> > >  
> > > +       /*
> > > +        * Populate the suspend/resume hooks after the BBT has been scanned to
> > > +        * avoid using the suspend lock and resume waitqueue which are only
> > > +        * initialized when mtd_device_register() is called.
> > > +        */
> > > +       mtd->_suspend = nand_suspend;
> > > +       mtd->_resume = nand_resume;
> > >         return 0;  
> > 
> > I'm fine with this as long as it is documented for now.
> >   
> 
> Hi Boris and Miquel,
> 
> gpmi-nand.c sets NAND_SKIP_BBTSCAN so we won't get there and populate
> suspend resume hooks :(
> Guess there is other drivers that does the same thing...

This should fix the issue:

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3d6c6e880520..c92b17f66994 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6222,8 +6222,6 @@ static int nand_scan_tail(struct nand_chip *chip)
        mtd->_sync = nand_sync;
        mtd->_lock = nand_lock;
        mtd->_unlock = nand_unlock;
-       mtd->_suspend = nand_suspend;
-       mtd->_resume = nand_resume;
        mtd->_reboot = nand_shutdown;
        mtd->_block_isreserved = nand_block_isreserved;
        mtd->_block_isbad = nand_block_isbad;
@@ -6262,13 +6260,21 @@ static int nand_scan_tail(struct nand_chip *chip)
 
        /* Check, if we should skip the bad block table scan */
        if (chip->options & NAND_SKIP_BBTSCAN)
-               return 0;
+               goto out;
 
        /* Build bad block table */
        ret = nand_create_bbt(chip);
        if (ret)
                goto err_free_secure_regions;
 
+out:
+       /*
+        * Populate the suspend/resume hooks after the BBT has been scanned to
+        * avoid using the suspend lock and resume waitqueue which are only
+        * initialized when mtd_device_register() is called.
+        */
+       mtd->_suspend = nand_suspend;
+       mtd->_resume = nand_resume;
        return 0;
 
 err_free_secure_regions:
