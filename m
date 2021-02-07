Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F50312339
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGJfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:35:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D72364E2A;
        Sun,  7 Feb 2021 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612690462;
        bh=vHdplIXe2RStxmKLVaI73uahI+H48WMD9Z6xwvPREOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GA/UugZBRdxo19A6s+kxnmLYt1SAraTqqy+qtZGDoDGBadsBnv9WRNv/5kN2nKcNH
         ZG6VqjBDUysIN8Z+S7aj6UwU7ES0p+Icio6RJ/+5COw0I6i8uTq+s2Njpe6vtvY1QN
         G9dHiZBV26PMMg8Nv6cmeNwIrGuQdj7mjAQNhL20=
Date:   Sun, 7 Feb 2021 10:34:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fix ignoring return value warning
Message-ID: <YB+0GmywKAQVBIjG@kroah.com>
References: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 05:23:28PM +0800, Youling Tang wrote:
> Fix the below ignoring return value warning for device_reset.
> 
> drivers/staging/mt7621-dma/mtk-hsdma.c:685:2: warning: ignoring return value
> of function declared with 'warn_unused_result' attribute [-Wunused-result]
>         device_reset(&pdev->dev);
>         ^~~~~~~~~~~~ ~~~~~~~~~~
> drivers/staging/ralink-gdma/ralink-gdma.c:836:2: warning: ignoring return value
> of function declared with 'warn_unused_result' attribute [-Wunused-result]
>         device_reset(&pdev->dev);
>         ^~~~~~~~~~~~ ~~~~~~~~~~
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  drivers/staging/mt7621-dma/mtk-hsdma.c    | 6 +++++-
>  drivers/staging/ralink-gdma/ralink-gdma.c | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> index bc4bb43..d4ffa52 100644
> --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> @@ -682,7 +682,11 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	device_reset(&pdev->dev);
> +	ret = device_reset(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to reset device\n");
> +		return ret;
> +	}
>  
>  	dd = &hsdma->ddev;
>  	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
> index 655df31..df99c47 100644
> --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> @@ -833,7 +833,11 @@ static int gdma_dma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	device_reset(&pdev->dev);
> +	ret = device_reset(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to reset device\n");
> +		return ret;
> +	}
>  
>  	dd = &dma_dev->ddev;
>  	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
> -- 
> 2.1.0
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
