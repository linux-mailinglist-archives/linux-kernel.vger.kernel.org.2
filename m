Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794533A2C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 06:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhCNFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 00:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhCNFKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 00:10:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E111C64E33;
        Sun, 14 Mar 2021 05:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615698654;
        bh=sHT4pNllXwbmu1pa2C2GAmEhwcyj5rsbGVi7SDbrN2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGkHqWOMHfR8VzS5/F8lpqsBeEPuRLo/mBa58u4TZaBDDbUN5fTN9d0dVFIuYyU/L
         1zsLqSGzRLA8zQNshWLI6wNncn1JNy/nna26G/bCDYXANhLjBR3rxkCZ4ZGuYnN/aL
         vhW7aLuU8CtS0cMG1T7tKewAF83uzEENZVuotYkwOojpQ8g+qXiEM7KiWA0po11Zio
         DLeC2Qn+AUXcxfBGwXlVrPVjUMBpq1TuIXwXHjqAEZD/w0wEeeAQhpxFVljWHlRpCb
         voEvH8GvLHlpPM8kvx7yV+vZ/KpAXpMgqsbKz6mvEA1o5HlQYqFcGN1h9RVQDB0dcT
         RgkNrtp3gv+UA==
Date:   Sun, 14 Mar 2021 13:10:48 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     pawell@cadence.com, a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        gregkh@linuxfoundation.org, kishon@ti.com
Subject: Re: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210314051048.GA30122@b29397-desktop>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615267180-9289-2-git-send-email-sparmar@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-09 06:19:40, Sanket Parmar wrote:
> dma_alloc_coherent() might fail on the platform with a small DMA region.
> 
> To avoid such failure in cdns3_prepare_aligned_request_buf(),
> dma_alloc_coherent() is replaced with kmalloc and dma_map API to
> allocate aligned request buffer of dynamic length.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

The comment with the 1st patch, it is not a bug-fix.

> Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c |   73 +++++++++++++++++++++++++------------
>  drivers/usb/cdns3/cdns3-gadget.h |    2 +
>  2 files changed, 51 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 5f51215..b4955ce 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -818,10 +818,26 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
>  	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
>  					priv_ep->dir);
>  
> -	if ((priv_req->flags & REQUEST_UNALIGNED) &&
> -	    priv_ep->dir == USB_DIR_OUT && !request->status)
> -		memcpy(request->buf, priv_req->aligned_buf->buf,
> -		       request->length);
> +	if ((priv_req->flags & REQUEST_UNALIGNED) && priv_req->aligned_buf) {
> +		struct cdns3_aligned_buf *buf;
> +
> +		buf = priv_req->aligned_buf;
> +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> +			buf->dir);
> +		priv_req->flags &= ~REQUEST_UNALIGNED;
> +
> +		if (priv_ep->dir == USB_DIR_OUT && !request->status) {
> +			memcpy(request->buf, priv_req->aligned_buf->buf,
> +			       request->length);
> +		}
> +
> +		trace_cdns3_free_aligned_request(priv_req);
> +		priv_req->aligned_buf->in_use = 0;
> +		queue_work(system_freezable_wq,
> +			   &priv_dev->aligned_buf_wq);
> +		priv_req->aligned_buf = NULL;
> +
> +	}
>  
>  	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
>  	/* All TRBs have finished, clear the counter */
> @@ -883,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct work_struct *work)
>  			 * interrupts.
>  			 */
>  			spin_unlock_irqrestore(&priv_dev->lock, flags);
> -			dma_free_coherent(priv_dev->sysdev, buf->size,
> -					  buf->buf, buf->dma);
> +			kfree(buf->buf);
>  			kfree(buf);
>  			spin_lock_irqsave(&priv_dev->lock, flags);
>  		}
> @@ -910,27 +925,16 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>  		if (!buf)
>  			return -ENOMEM;
>  
> -		buf->size = priv_req->request.length;
> +		buf->size = usb_endpoint_dir_out(priv_ep->endpoint.desc) ?
> +				usb_ep_align(&(priv_ep->endpoint), priv_req->request.length)
> +				: priv_req->request.length;
>  
> -		buf->buf = dma_alloc_coherent(priv_dev->sysdev,
> -					      buf->size,
> -					      &buf->dma,
> -					      GFP_ATOMIC);
> +		buf->buf = kmalloc(buf->size, GFP_ATOMIC);
>  		if (!buf->buf) {
>  			kfree(buf);
>  			return -ENOMEM;
>  		}
>  
> -		if (priv_req->aligned_buf) {
> -			trace_cdns3_free_aligned_request(priv_req);
> -			priv_req->aligned_buf->in_use = 0;
> -			queue_work(system_freezable_wq,
> -				   &priv_dev->aligned_buf_wq);
> -		}
> -
> -		buf->in_use = 1;
> -		priv_req->aligned_buf = buf;
> -
>  		list_add_tail(&buf->list,
>  			      &priv_dev->aligned_buf_list);
>  	}
> @@ -940,6 +944,27 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>  		       priv_req->request.length);
>  	}
>  
> +	if (priv_req->aligned_buf) {
> +		trace_cdns3_free_aligned_request(priv_req);
> +		priv_req->aligned_buf->in_use = 0;
> +		queue_work(system_freezable_wq,
> +			   &priv_dev->aligned_buf_wq);

@Pawel, do you remember when this condition is met?

> +	}
> +
> +	buf->dir =  priv_ep->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +	buf->in_use = 1;
> +	priv_req->aligned_buf = buf;
> +
> +	buf->dma = dma_map_single(priv_dev->sysdev, buf->buf, buf->size,
> +				buf->dir);
> +
> +	if (dma_mapping_error(priv_dev->sysdev, buf->dma)) {
> +		dev_err(priv_dev->dev, "Failed to map buffer\n");
> +		kfree(buf->buf);
> +		kfree(buf);
> +		return -EFAULT;
> +	}
> +
>  	priv_req->flags |= REQUEST_UNALIGNED;
>  	trace_cdns3_prepare_aligned_request(priv_req);
>  
> @@ -3088,11 +3113,11 @@ static void cdns3_gadget_exit(struct cdns *cdns)
>  		struct cdns3_aligned_buf *buf;
>  
>  		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> -		dma_free_coherent(priv_dev->sysdev, buf->size,
> -				  buf->buf,
> -				  buf->dma);
> +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> +			buf->dir);

It only needs to DMA unmap after DMA has completed, this buf will not be
used, otherwise, the kfree below will cause issue.

>  
>  		list_del(&buf->list);
> +		kfree(buf->buf);
>  		kfree(buf);
>  	}
>  
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
> 1.7.1
> 

-- 

Thanks,
Peter Chen

