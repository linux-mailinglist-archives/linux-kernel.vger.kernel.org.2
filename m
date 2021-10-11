Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82149428E15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhJKNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:38:02 -0400
Received: from first.geanix.com ([116.203.34.67]:37366 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235759AbhJKNiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:38:00 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 766D3C3DCB;
        Mon, 11 Oct 2021 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633959358; bh=xE4X5BF6E0aIpTrV8lCehzVbxCNFk1JaXrnIGkwaPM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XylsbvZJw/MkJO9l9jUSUS4m1IjoBfgfn0MEkkKOxYSFue3IogdDPmaT+FIyeJPXa
         eZEyWlTJZofBtk9p3LHmE+JtcnbHtxDRdgUFVqgvNYi9uxPXp97Q5uYP4h+tfSfI0k
         hf9akEBZ9F/pbPj2XNAKvWZEmhNvqQGECMscUx6KTVSQF5GVimEAv1ptALdKeqdvqK
         IwjTRFDpjpHKNx5xIpST0St/rZs+dwbZuZIS7XsDIK4Drs5gLESU1k3aX6CkIDey0U
         H23cKJCg04PEyaMeTnC9fr46llxFo/N3oRw/JFgOv/TC2PX/0d6VV5yQhBAd+fXWcf
         MYX6N3vfuGNIg==
Date:   Mon, 11 Oct 2021 15:35:56 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: mtdconcat: add suspend lock handling
Message-ID: <20211011133556.probhbuowxkumpzb@skn-laptop>
References: <20211011115253.38497-1-sean@geanix.com>
 <20211011115253.38497-4-sean@geanix.com>
 <20211011151501.48cc9289@collabora.com>
 <20211011152703.0086d990@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011152703.0086d990@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:27:03PM +0200, Boris Brezillon wrote:
> On Mon, 11 Oct 2021 15:15:01 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > On Mon, 11 Oct 2021 13:52:53 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> > 
> > > Use new suspend lock handling for this special case for concatenated
> > > MTD devices.
> > > 
> > > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  drivers/mtd/mtdconcat.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> > > index f685a581df48..c497c851481f 100644
> > > --- a/drivers/mtd/mtdconcat.c
> > > +++ b/drivers/mtd/mtdconcat.c
> > > @@ -561,25 +561,32 @@ static void concat_sync(struct mtd_info *mtd)
> > >  
> > >  static int concat_suspend(struct mtd_info *mtd)
> > >  {
> > > +	struct mtd_info *master = mtd_get_master(mtd);
> > >  	struct mtd_concat *concat = CONCAT(mtd);
> > >  	int i, rc = 0;
> > >  
> > >  	for (i = 0; i < concat->num_subdev; i++) {
> > >  		struct mtd_info *subdev = concat->subdev[i];
> > > -		if ((rc = mtd_suspend(subdev)) < 0)
> > > +
> > > +		down_write(&master->master.suspend_lock);
> > > +		if ((rc = __mtd_suspend(subdev)) < 0)
> > >  			return rc;
> > > +		up_write(&master->master.suspend_lock);
> > >  	}
> > >  	return rc;
> > >  }
> > >  
> > >  static void concat_resume(struct mtd_info *mtd)
> > >  {
> > > +	struct mtd_info *master = mtd_get_master(mtd);
> > >  	struct mtd_concat *concat = CONCAT(mtd);
> > >  	int i;
> > >  
> > >  	for (i = 0; i < concat->num_subdev; i++) {
> > >  		struct mtd_info *subdev = concat->subdev[i];
> > > -		mtd_resume(subdev);
> > > +		down_write(&master->master.suspend_lock);
> > > +		__mtd_resume(subdev);
> > > +		up_write(&master->master.suspend_lock);
> > >  	}
> > >  }
> > >    
> > 
> > Why do we need to implement the _suspend/_resume() hooks here? The
> > underlying MTD devices should be suspended at some point (when the
> > class ->suspend() method is called on those device), and there's
> > nothing mtdconcat-specific to do here. Looks like implementing this
> > suspend-all-subdevs loop results in calling mtd->_suspend()/_resume()
> > twice, which is useless. The only issue I see is if the subdevices
> > haven't been registered to the device model, but that happens, I
> > believe we have bigger issues (those devices won't be suspended when
> > mtdconcat is not used).
> 
> 
> Uh, just had a look at mtd_concat_create() callers, and they indeed
> don't register the subdevices, so I guess the suspend-all-subdevs loop
> is needed. I really thought mtdconcat was something more generic
> aggregating already registered devices...

Hi Boris,

Cool, mtd_concat should be seen as mtd devices concatenated? Could be
spi-nors and rawnand. So _suspend() needs to be called for every device
layer?

From what I see here, mtd_suspend()/mtd_resume() is called for every mtd
device. Before this patch mtd_suspend() would only have effect on the
first device as master->master.suspended is set and then calls to
device specific _suspend() is skipped.

Correct?

/Sean
