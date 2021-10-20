Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97D84345B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTHOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:14:55 -0400
Received: from first.geanix.com ([116.203.34.67]:37380 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhJTHOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:14:53 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 16648C7E51;
        Wed, 20 Oct 2021 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1634713957; bh=7RKzYEKUzqJxN+fJSiMpNqB5gjIFZdyRqNN4Bv+4fwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iFwKrzXu/BKR0++MdzRg3GQKEoToCQbpY5xMsOnExv9bWYKIzxnDL5XqdeBnm3Bfs
         0+44H87Vb0VB9SkExkVlC6YtjdD7cLkL5qMpBqh8/04a/uo8pmJLW/16gqs/sjjit+
         i4F5FqZ0AAjHgOHKa9OlS/GJZmZFvf81hXnUGy7th6oGqMnvgBG9hZo+swaKt1tRCn
         QEwFDKwq/XhJ+qAs4vw4zz0M/E5pW/RGLZeHFDQu97CCSNKpDCJ8PnG1Z8okFG1sC7
         2gvKNCljbn35bdNgVNHSndZUi44TR2mfKH4oLKNoa70VZPSeGEl/9Y53upTNuW7eC1
         974DJtjWXJX3Q==
Date:   Wed, 20 Oct 2021 09:12:35 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mtd: core: protect access to mtd devices while in
 suspend
Message-ID: <20211020071235.in3omswo2jqrahrd@skn-laptop>
References: <20211011115253.38497-1-sean@geanix.com>
 <20211011160546.707b737b@collabora.com>
 <20211015082206.244a2316@xps13>
 <20211019180800.3v7emokse6lkpjvk@skn-laptop>
 <20211020085250.030ef244@collabora.com>
 <20211020090058.58af1087@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020090058.58af1087@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:00:58AM +0200, Boris Brezillon wrote:
> On Wed, 20 Oct 2021 08:52:50 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 

[ ... ]
> > > 
> > > Hi Boris and Miquel,
> > > 
> > > gpmi-nand.c sets NAND_SKIP_BBTSCAN so we won't get there and populate
> > > suspend resume hooks :(
> > > Guess there is other drivers that does the same thing...  
> 
> Actually, this version is even cleaner:
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 3d6c6e880520..98c39b7f6279 100644
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
> @@ -6261,14 +6259,20 @@ static int nand_scan_tail(struct nand_chip *chip)
>                 goto err_free_interface_config;
>  
>         /* Check, if we should skip the bad block table scan */
> -       if (chip->options & NAND_SKIP_BBTSCAN)
> -               return 0;
> -
> -       /* Build bad block table */
> -       ret = nand_create_bbt(chip);
> -       if (ret)
> -               goto err_free_secure_regions;
> +       if (chip->options & NAND_SKIP_BBTSCAN) {
> +               /* Build bad block table */
> +               ret = nand_create_bbt(chip);
> +               if (ret)
> +                       goto err_free_secure_regions;
> +       }
>  
> +       /*
> +        * Populate the suspend/resume hooks after the BBT has been scanned to
> +        * avoid using the suspend lock and resume waitqueue which are only
> +        * initialized when mtd_device_register() is called.
> +        */
> +       mtd->_suspend = nand_suspend;
> +       mtd->_resume = nand_resume;
>         return 0;
>  
>  err_free_secure_regions:

Why is the gpmi-nand.c and other drivers set NAND_SKIP_BBTSCAN and then
call nand_create_bbt() directly?

To me it looks like legacy leftover...

/Sean
