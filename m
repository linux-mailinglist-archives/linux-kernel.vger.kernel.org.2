Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765F942E8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhJOGYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Oct 2021 02:24:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41373 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhJOGYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:24:16 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 49C9020002;
        Fri, 15 Oct 2021 06:22:08 +0000 (UTC)
Date:   Fri, 15 Oct 2021 08:22:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mtd: core: protect access to mtd devices while in
 suspend
Message-ID: <20211015082206.244a2316@xps13>
In-Reply-To: <20211011160546.707b737b@collabora.com>
References: <20211011115253.38497-1-sean@geanix.com>
        <20211011160546.707b737b@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

boris.brezillon@collabora.com wrote on Mon, 11 Oct 2021 16:05:46 +0200:

> On Mon, 11 Oct 2021 13:52:50 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > Follow-up on discussion in https://lkml.org/lkml/2021/10/4/41
> > 
> > Changes since from rfc v1/v2:
> >  - added access protection for all device access hooks in mtd_info.
> >  - added Suggested-by to [1/3] patch.
> >  - removed refereces to commit ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> >    from commit msg as commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") is 
> >    to be blamed.
> >  - tested on a kernel with LOCKDEP enabled.
> > 
> > @Miquel: I havn't covered every ioctl, to me it looks like they havn't
> > direct device access.

Yes indeed it looks like they re-use most of the mtdcore.c functions,
so it should be fine.

> > One (small) issue still present. gpmi_nand.c uses the rwsem before it's
> > initialized. Seems cumbersome to have every mtd/nand driver to call
> > init_waitqueue_head() and init_rwsem(). Could we somehow move the call
> > to mtd_set_dev_defaults() before nand_create_bbt()?  
> 
> I have a nasty trick for that one, but I'm not sure Miquel will like it
> (actually, I don't like it either, but it's so simple compared to the
> other options we have that I'm tempted to go for this approach until
> someone has time to invest in a cleaner solution :-)):
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 3d6c6e880520..a9ac2d528a4d 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -6222,8 +6222,6 @@ static int nand_scan_tail(struct nand_chip *chip)
>         mtd->_sync = nand_sync;
>         mtd->_lock = nand_lock;
>         mtd->_unlock = nand_unlock;
> -       mtd->_suspend = nand_suspend;
> -       mtd->_resume = nand_resume;
>         mtd->_reboot = nand_shutdown;
>         mtd->_block_isreserved = nand_block_isreserved;
>         mtd->_block_isbad = nand_block_isbad;
> @@ -6269,6 +6267,13 @@ static int nand_scan_tail(struct nand_chip *chip)
>         if (ret)
>                 goto err_free_secure_regions;
>  
> +       /*
> +        * Populate the suspend/resume hooks after the BBT has been scanned to
> +        * avoid using the suspend lock and resume waitqueue which are only
> +        * initialized when mtd_device_register() is called.
> +        */
> +       mtd->_suspend = nand_suspend;
> +       mtd->_resume = nand_resume;
>         return 0;

I'm fine with this as long as it is documented for now.

Thanks,
Miquèl
