Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AFC4207A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhJDI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:57:03 -0400
Received: from first.geanix.com ([116.203.34.67]:37330 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhJDI5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:57:02 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 4AFDAB42F1;
        Mon,  4 Oct 2021 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633337711; bh=sOyzdYHDj4ghiyZr/0ilGGXA7moAY6qAFtH09e2W4oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VGgEnq+fZA7uK9AK/O+vMbIK4PG4hi/vzPzwqkFIVaj+18/gOk199Fsrjc2WLB1Z5
         ibP061jSX8xezrFXuUVPIq9y/TFwCrp4ge21V8kyk/E16EfrilJKbC91hQ3fgfki0M
         UPX32uW/caehIgMlU5rHJR6LIYq2fGWuqylygm+qpHptALF/bXRfGYCoU0UlELr8Ol
         Q6lKHuCKBw7m5FQR9GjZp0fFTk5+jYQZel930Icl+xMh887UhZeUQlPi2B38OFT4/S
         N5FXJtwTZwxgMJJpKXigl9u7h/srTC8ORN7Ig2TEQoYslseJAy95ddIAen3ZnhLkLl
         Oix9Iyw5gzxqQ==
Date:   Mon, 4 Oct 2021 10:55:09 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
References: <20211004065608.3190348-1-sean@geanix.com>
 <20211004104147.579f3b01@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211004104147.579f3b01@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 10:41:47AM +0200, Boris Brezillon wrote:
> On Mon,  4 Oct 2021 08:56:09 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > This will prevent nand_get_device() from returning -EBUSY.
> > It will force mtd_write()/mtd_read() to wait for the nand_resume() to unlock
> > access to the mtd device.
> > 
> > Then we avoid -EBUSY is returned to ubifsi via mtd_write()/mtd_read(),
> > that will in turn hard error on every error returened.
> > We have seen during ubifs tries to call mtd_write before the mtd device
> > is resumed.
> 
> I think the problem is here. Why would UBIFS/UBI try to write something
> to a device that's not resumed yet (or has been suspended already, if
> you hit this in the suspend path).
> 
> > 
> > Exec_op[0] speed things up, so we see this race when the device is
> > resuming. But it's actually "mtd: rawnand: Simplify the locking" that
> > allows it to return -EBUSY, before that commit it would have waited for
> > the mtd device to resume.
> 
> Uh, wait. If nand_resume() was called before any writes/reads this
> wouldn't happen. IMHO, the problem is not that we return -EBUSY without
> blocking, the problem is that someone issues a write/read before calling
> mtd_resume().
> 

The commit msg from "mtd: rawnand: Simplify the locking" states this clearly.

"""
Last important change to mention: we now return -EBUSY when someone
tries to access a device that as been suspended, and propagate this
error to the upper layer.
"""

IMHO "mtd: rawnand: Simplify the locking" should never had been merged
before the upper layers was fixed to handle -EBUSY. ;)
Which they still not are...

Yes, guess there is data in the ubifs queue when going into suspend,
then the ubifs kthread is starting writing when the cpu resumes.
Before mtd_resume() and other pm_resume() handles are called.

How would you have ubifs to wait for mtd_resume()? If you don't like
this mutex solution?

> > 
> > Tested on a iMX6ULL.
> > 
> > [0]:
> > ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> > 
> > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > 
> > I did this a RFC as we probably will need to remove the suspended
> > variable as it's kinda made obsolute by this change.
> > Should we introduce a new mutex? Or maybe a spin_lock?
> > 
> >  drivers/mtd/nand/raw/nand_base.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 3d6c6e880520..0ea343404cac 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -4567,7 +4567,6 @@ static int nand_suspend(struct mtd_info *mtd)
> >  		ret = chip->ops.suspend(chip);
> >  	if (!ret)
> >  		chip->suspended = 1;
> > -	mutex_unlock(&chip->lock);
> 
> Hm, I'm not sure keeping the lock when you're in a suspended state
> is a good idea. It just papers over another bug IMO (see above).
> 
> >  
> >  	return ret;
> >  }
> > @@ -4580,7 +4579,6 @@ static void nand_resume(struct mtd_info *mtd)
> >  {
> >  	struct nand_chip *chip = mtd_to_nand(mtd);
> >  
> > -	mutex_lock(&chip->lock);
> >  	if (chip->suspended) {
> >  		if (chip->ops.resume)
> >  			chip->ops.resume(chip);
> 
