Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CE43997F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhJYPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:02:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhJYPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:02:25 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7B2BE1F41E71;
        Mon, 25 Oct 2021 16:00:02 +0100 (BST)
Date:   Mon, 25 Oct 2021 16:59:57 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mtd: mtdconcat: add suspend lock handling
Message-ID: <20211025165957.349a6580@collabora.com>
In-Reply-To: <20211025092752.2824678-3-sean@geanix.com>
References: <20211025092752.2824678-1-sean@geanix.com>
        <20211025092752.2824678-3-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sean,

On Mon, 25 Oct 2021 11:27:50 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

The subject is misleading, how about 'mtd: mtdconcat: Don't use
mtd_{suspend,resume}()'

> Use MTD hooks to control suspend/resume of MTD devices.
> concat_{suspend,resume} will be called from mtd_{suspend,resume},
> which already have taken the suspend/resume lock.
> It's safe to proceed with calling MTD device hooks directly from here.

"
The MTD suspend logic will soon be adjusted to automatically wait for
device wake-up before issuing IOs. In order to do that a new read-write
lock will be added and taken in write-mode in the
mtd_{suspend,resume}() path. Since mtdconcat.c itself is an MTD device,
calling mtd_suspend/resume() on subdevices from the mtdconcat
->_{suspend,resume}() hook will lead to a nested lock, which lockdep
will complain about if we don't add a proper annotation. Let's keep
things simple and replace those mtd_{suspend,resume}(subdev) calls by
subdev->_{suspend,resume}() ones to avoid this situation.
"

> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")

Again, this commit doesn't fix anything.

> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/mtd/mtdconcat.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index f685a581df48..37532f529820 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -566,9 +566,15 @@ static int concat_suspend(struct mtd_info *mtd)
>  
>  	for (i = 0; i < concat->num_subdev; i++) {
>  		struct mtd_info *subdev = concat->subdev[i];
> -		if ((rc = mtd_suspend(subdev)) < 0)
> +		/*
> +		 * Call MTD hook directly from here,
> +		 * mtd_suspend() have the suspend/resume lock.

		/*
		 * Call the MTD hook directly to avoid a nested lock
		 * on ->suspend_lock.
		 */

> +		 */
> +		rc = subdev->_suspend ? subdev->_suspend(subdev) : 0;
> +		if (rc < 0)
>  			return rc;
>  	}
> +
>  	return rc;
>  }
>  
> @@ -579,7 +585,12 @@ static void concat_resume(struct mtd_info *mtd)
>  
>  	for (i = 0; i < concat->num_subdev; i++) {
>  		struct mtd_info *subdev = concat->subdev[i];
> -		mtd_resume(subdev);
> +		/*
> +		 * Call MTD hook directly from here,
> +		 * mtd_resume() have the suspend/resume lock.
> +		 */

Ditto.

> +		if (subdev->_resume)
> +			subdev->_resume(subdev);
>  	}
>  }
>  

