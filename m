Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6A434770
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJTI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:58:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJTI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:58:05 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 88FAC1F43D73;
        Wed, 20 Oct 2021 09:55:50 +0100 (BST)
Date:   Wed, 20 Oct 2021 10:55:47 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mtd: mtdconcat: add suspend lock handling
Message-ID: <20211020105547.23ed9324@collabora.com>
In-Reply-To: <20211020084534.2472305-5-sean@geanix.com>
References: <20211020084534.2472305-1-sean@geanix.com>
        <20211020084534.2472305-5-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 10:45:34 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Use MTD hooks to control suspend/resume of MTD devices.

Please explain in great details why this is needed.

> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

This patch should be moved earlier (before 'mtd: core: protect access to
MTD devices while in suspend') in the series.

> ---
>  drivers/mtd/mtdconcat.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index f685a581df48..1ec36890118f 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -566,9 +566,11 @@ static int concat_suspend(struct mtd_info *mtd)
>  
>  	for (i = 0; i < concat->num_subdev; i++) {
>  		struct mtd_info *subdev = concat->subdev[i];
> -		if ((rc = mtd_suspend(subdev)) < 0)
> +		rc = subdev->_suspend ? subdev->_suspend(subdev) : 0;
> +		if (rc < 0)
>  			return rc;

Same here, you need a fat comment explaining why mtd_suspend() is not
used.

>  	}
> +
>  	return rc;
>  }
>  
> @@ -579,7 +581,8 @@ static void concat_resume(struct mtd_info *mtd)
>  
>  	for (i = 0; i < concat->num_subdev; i++) {
>  		struct mtd_info *subdev = concat->subdev[i];
> -		mtd_resume(subdev);
> +		if (subdev->_resume)
> +			subdev->_resume(subdev);

Ditto.

>  	}
>  }
>  

