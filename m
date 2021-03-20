Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259ED342C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCTLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhCTLxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C119861923;
        Sat, 20 Mar 2021 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616231357;
        bh=6lwMsLbAVQSafHY2R3faKJ0q8xXkIOaYQG7JHAFHknc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5o+i6Thk8j+LuxOCALsgJA8pz7jP2BTTJWofJMegxkFYo2TZ1Md0Jj9ceN8P+ze/
         bw+FsFbLz4lnKAbrJviA6P3RWo8VMqRSPDslBmvyQmd7DBlnU81GhMOyStqGTGf4PR
         uBzAwIuUw9HK1z75gaonrLm+gku1llQY0JR+USsbhIHYFnS4yLiPyAxrOSn92Bdmkp
         Zrao6lm3R9mg3MC20VR5LMU8PiyhMibuOG27bZrZsk3fADUsHN40dY60GNH7+s6KGz
         MmRMsAnrJKVYPyktXyHEVEm23hDtOBsj0g8eHdtCqyAwip9DcQE2hlMNUhF+wQ51Z2
         pu+pFGRg6afKA==
Date:   Sat, 20 Mar 2021 17:08:59 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     pawell@cadence.com, a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        gregkh@linuxfoundation.org, kishon@ti.com, hch@infradead.org
Subject: Re: [PATCH v2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210320090858.GB28364@b29397-desktop>
References: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-17 20:13:59, Sanket Parmar wrote:
> dma_alloc_coherent() might fail on the platform with a small
> DMA region.
> 
> To avoid such failure in cdns3_prepare_aligned_request_buf(),
> dma_alloc_coherent() is replaced with dma_alloc_noncoherent()
> to allocate aligned request buffer of dynamic length.
> 
> Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---
> 
> Changelog:
> v2:
> - used dma_*_noncoherent() APIs
> - changed the commit log
> 
>  drivers/usb/cdns3/cdns3-gadget.c | 30 ++++++++++++++++++++++++------
>  drivers/usb/cdns3/cdns3-gadget.h |  2 ++
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 0b892a2..126087b 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -819,9 +819,15 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
>  					priv_ep->dir);
>  
>  	if ((priv_req->flags & REQUEST_UNALIGNED) &&
> -	    priv_ep->dir == USB_DIR_OUT && !request->status)
> +	    priv_ep->dir == USB_DIR_OUT && !request->status) {
> +		/* Make DMA buffer CPU accessible */
> +		dma_sync_single_for_cpu(priv_dev->sysdev,
> +			priv_req->aligned_buf->dma,
> +			priv_req->aligned_buf->size,
> +			priv_req->aligned_buf->dir);
>  		memcpy(request->buf, priv_req->aligned_buf->buf,
>  		       request->length);
> +	}
>  
>  	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
>  	/* All TRBs have finished, clear the counter */
> @@ -883,8 +889,8 @@ static void cdns3_free_aligned_request_buf(struct work_struct *work)
>  			 * interrupts.
>  			 */
>  			spin_unlock_irqrestore(&priv_dev->lock, flags);
> -			dma_free_coherent(priv_dev->sysdev, buf->size,
> -					  buf->buf, buf->dma);
> +			dma_free_noncoherent(priv_dev->sysdev, buf->size,
> +					  buf->buf, buf->dma, buf->dir);
>  			kfree(buf);
>  			spin_lock_irqsave(&priv_dev->lock, flags);
>  		}
> @@ -911,10 +917,13 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>  			return -ENOMEM;
>  
>  		buf->size = priv_req->request.length;
> +		buf->dir = usb_endpoint_dir_in(priv_ep->endpoint.desc) ?
> +			DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  
> -		buf->buf = dma_alloc_coherent(priv_dev->sysdev,
> +		buf->buf = dma_alloc_noncoherent(priv_dev->sysdev,
>  					      buf->size,
>  					      &buf->dma,
> +					      buf->dir,
>  					      GFP_ATOMIC);
>  		if (!buf->buf) {
>  			kfree(buf);
> @@ -936,10 +945,18 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>  	}
>  
>  	if (priv_ep->dir == USB_DIR_IN) {
> +		/* Make DMA buffer CPU accessible */
> +		dma_sync_single_for_cpu(priv_dev->sysdev,
> +			buf->dma, buf->size, buf->dir);
>  		memcpy(buf->buf, priv_req->request.buf,
>  		       priv_req->request.length);
>  	}
>  
> +	/* Transfer DMA buffer ownership back to device */
> +	dma_sync_single_for_device(priv_dev->sysdev,
> +			buf->dma, buf->size, buf->dir);
> +
> +

One more blank line.

Otherwise, it seems OK for me.

>  	priv_req->flags |= REQUEST_UNALIGNED;
>  	trace_cdns3_prepare_aligned_request(priv_req);
>  
> @@ -3088,9 +3105,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
>  		struct cdns3_aligned_buf *buf;
>  
>  		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> -		dma_free_coherent(priv_dev->sysdev, buf->size,
> +		dma_free_noncoherent(priv_dev->sysdev, buf->size,
>  				  buf->buf,
> -				  buf->dma);
> +				  buf->dma,
> +				  buf->dir);
>  
>  		list_del(&buf->list);
>  		kfree(buf);
> diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
> index ecf9b91..c5660f2 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.h
> +++ b/drivers/usb/cdns3/cdns3-gadget.h
> @@ -12,6 +12,7 @@
>  #ifndef __LINUX_CDNS3_GADGET
>  #define __LINUX_CDNS3_GADGET
>  #include <linux/usb/gadget.h>
> +#include <linux/dma-direction.h>
>  
>  /*
>   * USBSS-DEV register interface.
> @@ -1205,6 +1206,7 @@ struct cdns3_aligned_buf {
>  	void			*buf;
>  	dma_addr_t		dma;
>  	u32			size;
> +	enum dma_data_direction dir;
>  	unsigned		in_use:1;
>  	struct list_head	list;
>  };
> -- 
> 2.4.5
> 

-- 

Thanks,
Peter Chen

