Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CE0428D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhJKNRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:17:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhJKNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:17:07 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AACA61F424D4;
        Mon, 11 Oct 2021 14:15:06 +0100 (BST)
Date:   Mon, 11 Oct 2021 15:15:01 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: mtdconcat: add suspend lock handling
Message-ID: <20211011151501.48cc9289@collabora.com>
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
> +		if ((rc = __mtd_suspend(subdev)) < 0)
>  			return rc;
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
>  }
>  

Why do we need to implement the _suspend/_resume() hooks here? The
underlying MTD devices should be suspended at some point (when the
class ->suspend() method is called on those device), and there's
nothing mtdconcat-specific to do here. Looks like implementing this
suspend-all-subdevs loop results in calling mtd->_suspend()/_resume()
twice, which is useless. The only issue I see is if the subdevices
haven't been registered to the device model, but that happens, I
believe we have bigger issues (those devices won't be suspended when
mtdconcat is not used).
