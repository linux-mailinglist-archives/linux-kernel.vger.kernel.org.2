Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2142077E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhJDInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJDInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:43:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE6C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 01:41:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2C20F1F422CA;
        Mon,  4 Oct 2021 09:41:52 +0100 (BST)
Date:   Mon, 4 Oct 2021 10:41:47 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211004104147.579f3b01@collabora.com>
In-Reply-To: <20211004065608.3190348-1-sean@geanix.com>
References: <20211004065608.3190348-1-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Oct 2021 08:56:09 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This will prevent nand_get_device() from returning -EBUSY.
> It will force mtd_write()/mtd_read() to wait for the nand_resume() to unlock
> access to the mtd device.
> 
> Then we avoid -EBUSY is returned to ubifsi via mtd_write()/mtd_read(),
> that will in turn hard error on every error returened.
> We have seen during ubifs tries to call mtd_write before the mtd device
> is resumed.

I think the problem is here. Why would UBIFS/UBI try to write something
to a device that's not resumed yet (or has been suspended already, if
you hit this in the suspend path).

> 
> Exec_op[0] speed things up, so we see this race when the device is
> resuming. But it's actually "mtd: rawnand: Simplify the locking" that
> allows it to return -EBUSY, before that commit it would have waited for
> the mtd device to resume.

Uh, wait. If nand_resume() was called before any writes/reads this
wouldn't happen. IMHO, the problem is not that we return -EBUSY without
blocking, the problem is that someone issues a write/read before calling
mtd_resume().

> 
> Tested on a iMX6ULL.
> 
> [0]:
> ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> I did this a RFC as we probably will need to remove the suspended
> variable as it's kinda made obsolute by this change.
> Should we introduce a new mutex? Or maybe a spin_lock?
> 
>  drivers/mtd/nand/raw/nand_base.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 3d6c6e880520..0ea343404cac 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4567,7 +4567,6 @@ static int nand_suspend(struct mtd_info *mtd)
>  		ret = chip->ops.suspend(chip);
>  	if (!ret)
>  		chip->suspended = 1;
> -	mutex_unlock(&chip->lock);

Hm, I'm not sure keeping the lock when you're in a suspended state
is a good idea. It just papers over another bug IMO (see above).

>  
>  	return ret;
>  }
> @@ -4580,7 +4579,6 @@ static void nand_resume(struct mtd_info *mtd)
>  {
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
> -	mutex_lock(&chip->lock);
>  	if (chip->suspended) {
>  		if (chip->ops.resume)
>  			chip->ops.resume(chip);

