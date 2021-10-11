Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822EF4291B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhJKO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbhJKO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:26:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6AC028C22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:58:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F04FC1F42D7B;
        Mon, 11 Oct 2021 14:58:08 +0100 (BST)
Date:   Mon, 11 Oct 2021 15:58:05 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: mtdconcat: add suspend lock handling
Message-ID: <20211011155805.7793ad21@collabora.com>
In-Reply-To: <20211011115253.38497-4-sean@geanix.com>
References: <20211011115253.38497-1-sean@geanix.com>
        <20211011115253.38497-4-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 13:52:53 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Use new suspend lock handling for this special case for concatenated
> MTD devices.
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/mtd/mtdconcat.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index f685a581df48..c497c851481f 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -561,25 +561,32 @@ static void concat_sync(struct mtd_info *mtd)
>  
>  static int concat_suspend(struct mtd_info *mtd)
>  {
> +	struct mtd_info *master = mtd_get_master(mtd);
>  	struct mtd_concat *concat = CONCAT(mtd);
>  	int i, rc = 0;
>  
>  	for (i = 0; i < concat->num_subdev; i++) {
>  		struct mtd_info *subdev = concat->subdev[i];
> -		if ((rc = mtd_suspend(subdev)) < 0)
> +
> +		down_write(&master->master.suspend_lock);

You should definitely not take the concat lock here, the framework does
it for you, so all you'll get is a deadlock.

> +		if ((rc = __mtd_suspend(subdev)) < 0)
>  			return rc;

You're returning with the lock held => DEADLOCK next time you try to
acquire it.

Anyway, as mentioned in my review of patch 1, I'd go for this ad-hoc
solution:


	for (i = 0; i < concat->num_subdev; i++) {
		rc = subdev->_suspend ? subdev->_suspend(subdev) : 0;
		if (rc < 0)
			return rc;
	}

	return 0;

> +		up_write(&master->master.suspend_lock);
>  	}
>  	return rc;
>  }
>  
>  static void concat_resume(struct mtd_info *mtd)
>  {
> +	struct mtd_info *master = mtd_get_master(mtd);
>  	struct mtd_concat *concat = CONCAT(mtd);
>  	int i;
>  
>  	for (i = 0; i < concat->num_subdev; i++) {
>  		struct mtd_info *subdev = concat->subdev[i];
> -		mtd_resume(subdev);
> +		down_write(&master->master.suspend_lock);
> +		__mtd_resume(subdev);
> +		up_write(&master->master.suspend_lock);
>  	}

No down/up_write() needed:

  	for (i = 0; i < concat->num_subdev; i++) {
  		struct mtd_info *subdev = concat->subdev[i];
		if (subdev->_resume)
			subdev->_resume(subdev);

	}
>  }
>  

