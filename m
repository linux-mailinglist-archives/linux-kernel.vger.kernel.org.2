Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C05433E18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhJSSKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:10:19 -0400
Received: from first.geanix.com ([116.203.34.67]:37378 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234798AbhJSSKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:10:17 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 206B0C7C23;
        Tue, 19 Oct 2021 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1634666882; bh=8waxH/oQcvaRnTQ2ApGJbr/EejSwOZrzxuX1qzke3+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=O1a+El+xqcnXBbE58uwmQbdGIKtkDZrkC2VcwDQaG5gYHu9jRC/CCqAMOn5L5GCB9
         n5LPIwojT+v0IxTGJffg27qQ6ylHLF9n6I395ZVLuVj85QWXbiAddoH0tDX3bhbJ7A
         CZkLFoBNLuYHNv33q4/kA2JXIYN++iKLSbEbsuWLlSmPUZ0JGgTm+OVY1Iv2IcKQtI
         6iZlNb6SI3VEEtX0cVhREiTz2+fskM8B/do2mnsTajEd9ORt+amSbpvlQCNcycHHrG
         D8v0NKaCb7dK9v7K40LxBlPcoP5XayJcDaHK6Jo7FoeIFeNFq82olHCdM0JD1hwPDF
         3Vll6d4ekoy5Q==
Date:   Tue, 19 Oct 2021 20:08:00 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mtd: core: protect access to mtd devices while in
 suspend
Message-ID: <20211019180800.3v7emokse6lkpjvk@skn-laptop>
References: <20211011115253.38497-1-sean@geanix.com>
 <20211011160546.707b737b@collabora.com>
 <20211015082206.244a2316@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211015082206.244a2316@xps13>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 08:22:06AM +0200, Miquel Raynal wrote:
> Hi Sean,
> 
> boris.brezillon@collabora.com wrote on Mon, 11 Oct 2021 16:05:46 +0200:
> 
> > On Mon, 11 Oct 2021 13:52:50 +0200

[ ... ]

> 
> > > One (small) issue still present. gpmi_nand.c uses the rwsem before it's
> > > initialized. Seems cumbersome to have every mtd/nand driver to call
> > > init_waitqueue_head() and init_rwsem(). Could we somehow move the call
> > > to mtd_set_dev_defaults() before nand_create_bbt()?  
> > 
> > I have a nasty trick for that one, but I'm not sure Miquel will like it
> > (actually, I don't like it either, but it's so simple compared to the
> > other options we have that I'm tempted to go for this approach until
> > someone has time to invest in a cleaner solution :-)):
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 3d6c6e880520..a9ac2d528a4d 100644
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
> > @@ -6269,6 +6267,13 @@ static int nand_scan_tail(struct nand_chip *chip)
> >         if (ret)
> >                 goto err_free_secure_regions;
> >  
> > +       /*
> > +        * Populate the suspend/resume hooks after the BBT has been scanned to
> > +        * avoid using the suspend lock and resume waitqueue which are only
> > +        * initialized when mtd_device_register() is called.
> > +        */
> > +       mtd->_suspend = nand_suspend;
> > +       mtd->_resume = nand_resume;
> >         return 0;
> 
> I'm fine with this as long as it is documented for now.
> 

Hi Boris and Miquel,

gpmi-nand.c sets NAND_SKIP_BBTSCAN so we won't get there and populate
suspend resume hooks :(
Guess there is other drivers that does the same thing...

I have looked in the history and tried to blame gpmi-nand.c, but I can't
see the reason to why NAND_SKIP_BBTSCAN is set.

I have tested Boris' hack with this diff (and it seems to work):

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 4d08e4ab5c1b..ec7f44d630b6 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2073,8 +2073,6 @@ static int gpmi_nand_attach_chip(struct nand_chip *chip)
 	if (ret)
 		return ret;
 
-	chip->options |= NAND_SKIP_BBTSCAN;
-
 	return 0;
 }
 
@@ -2460,9 +2459,6 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 		goto err_out;
 
 	ret = nand_boot_init(this);
-	if (ret)
-		goto err_nand_cleanup;
-	ret = nand_create_bbt(chip);
 	if (ret)
 		goto err_nand_cleanup;
 

Do I miss something?

/Sean
