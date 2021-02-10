Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E249D31662B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBJMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBJMIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:08:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A39564E2A;
        Wed, 10 Feb 2021 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612958841;
        bh=/KLTm1jFc8aXXde0ovdili+Cy21fYSRVYi8DZDefxl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ZVEWowsT/o+KOg1boDtZd+gXVOUPIu+5U/1tGH7wSUGLdldOVmsFgxovlD/d4vc8
         tNStQQPTWniAm8j550IbhgiXRGB8ThTj9qXn0eKQhK5ni5snmBQPpB1kFqDSNuj29u
         96l0gpjj6ZEWv8fU/PXw5qP0m98MsrgotaFt1gjI=
Date:   Wed, 10 Feb 2021 13:07:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] staging: ralink-gdma: Fix checkpatch.pl CHECK
Message-ID: <YCPMdv1K2kcfbfZM@kroah.com>
References: <20210210120348.262328-1-aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210120348.262328-1-aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 05:33:48PM +0530, Aakash Hemadri wrote:
> Remove CHECK: Lines should not end with a '('
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
> 
>  drivers/staging/ralink-gdma/ralink-gdma.c | 28 ++++++++++++-----------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
> index 655df317d0ee..a11f915f3308 100644
> --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> @@ -135,8 +135,7 @@ struct gdma_data {
>  	int (*start_transfer)(struct gdma_dmaengine_chan *chan);
>  };
> 
> -static struct gdma_dma_dev *gdma_dma_chan_get_dev(
> -	struct gdma_dmaengine_chan *chan)
> +static struct gdma_dma_dev *gdma_dma_chan_get_dev(struct gdma_dmaengine_chan *chan)
>  {
>  	return container_of(chan->vchan.chan.device, struct gdma_dma_dev,
>  		ddev);
> @@ -510,10 +509,11 @@ static void gdma_dma_issue_pending(struct dma_chan *c)
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
> 
> -static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
> -		struct dma_chan *c, struct scatterlist *sgl,
> -		unsigned int sg_len, enum dma_transfer_direction direction,
> -		unsigned long flags, void *context)
> +static struct dma_async_tx_descriptor
> +	*gdma_dma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
> +				unsigned int sg_len,
> +				enum dma_transfer_direction direction,
> +				unsigned long flags, void *context)
>  {
>  	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
>  	struct gdma_dma_desc *desc;
> @@ -558,9 +558,10 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
>  	return NULL;
>  }
> 
> -static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
> -		struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
> -		size_t len, unsigned long flags)
> +static struct dma_async_tx_descriptor
> +	*gdma_dma_prep_dma_memcpy(struct dma_chan *c,
> +				  dma_addr_t dest, dma_addr_t src,
> +				  size_t len, unsigned long flags)
>  {
>  	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
>  	struct gdma_dma_desc *desc;
> @@ -601,10 +602,11 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
>  	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>  }
> 
> -static struct dma_async_tx_descriptor *gdma_dma_prep_dma_cyclic(
> -	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
> -	size_t period_len, enum dma_transfer_direction direction,
> -	unsigned long flags)
> +static struct dma_async_tx_descriptor
> +	*gdma_dma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
> +				  size_t buf_len, size_t period_len,
> +				  enum dma_transfer_direction direction,
> +				  unsigned long flags)
>  {
>  	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
>  	struct gdma_dma_desc *desc;
> --
> 2.30.0

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

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
