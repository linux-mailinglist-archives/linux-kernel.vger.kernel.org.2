Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6532F78B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 02:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhCFBia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCFBiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:38:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EF7264FE9;
        Sat,  6 Mar 2021 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614994694;
        bh=sFDEO1LYihkB6mzVxkDKvbynBX2LeeDe9NGyVLeNyYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiwgFMlTkrtPSrSX2RwJZa2SYnETGG7ok9hNA7uQfagJQWrIpWCGsIji3YrW4ePNI
         QkuVgMigf9vXjMHbG6zYpzgo10fsOvUhtAoXtX0RHQhjoQaMGl7/QHGtABpZiCzGcp
         9EXgOhiOZgrksFKQ01K+veqqwTUG6pbB95W9i4bdodBPON38RA1Wvali7uaAQL23uU
         y+hmLSQ/DXCPJwfqCBSgbqYNOXsLes97HqW0MbTFSe1I/SFQBMzRbVLj5uih8GcAz3
         DL+FGDKVGit1uX72Y+t0OCsWfWiolDfUCzfSwVxGHYZFDh2/Q0FfQ7TT55N/tYNLkY
         Qspkq5VNVZK2A==
Date:   Sat, 6 Mar 2021 09:38:08 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     pawell@cadence.com, a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        gregkh@linuxfoundation.org, frank.li@nxp.com
Subject: Re: [PATCH] usb: cdns3: Coherent memory allocation optimization
Message-ID: <20210306013808.GA2399@b29397-desktop>
References: <1614960071-30367-1-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614960071-30367-1-git-send-email-sparmar@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-05 17:01:11, Sanket Parmar wrote:
> Allocation of DMA coherent memory in atomic context using
> dma_alloc_coherent() might fail on some platform. To fix it,
> Replaced dma_alloc_coherent() with dma_pool API to allocate a
> smaller chunk of DMA coherent memory for TRB rings.
> 
> Also in cdns3_prepare_aligned_request_buf(), replaced
> dma_alloc_coherent() with kmalloc and dma_map API to allocate
> aligned request buffer of dynamic length.
> 

You do two changes in one commit, would you please split this one as
two patches?

> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

"commit" is not needed

> Reported by: Aswath Govindraju <a-govindraju@ti.com>

Reported-by:

> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c |  115 ++++++++++++++++++++++---------------
>  drivers/usb/cdns3/cdns3-gadget.h |    3 +
>  2 files changed, 71 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 582bfec..5fd6993 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -59,6 +59,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/module.h>
> +#include <linux/dmapool.h>
>  #include <linux/iopoll.h>
>  
>  #include "core.h"
> @@ -190,29 +191,13 @@ dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
>  	return priv_ep->trb_pool_dma + offset;
>  }
>  
> -static int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
> -{
> -	switch (priv_ep->type) {
> -	case USB_ENDPOINT_XFER_ISOC:
> -		return TRB_ISO_RING_SIZE;
> -	case USB_ENDPOINT_XFER_CONTROL:
> -		return TRB_CTRL_RING_SIZE;
> -	default:
> -		if (priv_ep->use_streams)
> -			return TRB_STREAM_RING_SIZE;
> -		else
> -			return TRB_RING_SIZE;
> -	}
> -}
> -
>  static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
>  {
>  	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
>  
>  	if (priv_ep->trb_pool) {
> -		dma_free_coherent(priv_dev->sysdev,
> -				  cdns3_ring_size(priv_ep),
> -				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
> +		dma_pool_free(priv_dev->eps_dma_pool,
> +				priv_ep->trb_pool, priv_ep->trb_pool_dma);
>  		priv_ep->trb_pool = NULL;
>  	}
>  }
> @@ -226,7 +211,7 @@ static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
>  int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
>  {
>  	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> -	int ring_size = cdns3_ring_size(priv_ep);
> +	int ring_size = TRB_RING_SIZE;

You will use the same size for TRB ring region for control/bulk/isoc
endpoint.

>  	int num_trbs = ring_size / TRB_SIZE;
>  	struct cdns3_trb *link_trb;
>  
> @@ -234,10 +219,10 @@ int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
>  		cdns3_free_trb_pool(priv_ep);
>  
>  	if (!priv_ep->trb_pool) {
> -		priv_ep->trb_pool = dma_alloc_coherent(priv_dev->sysdev,
> -						       ring_size,
> -						       &priv_ep->trb_pool_dma,
> -						       GFP_DMA32 | GFP_ATOMIC);
> +		priv_ep->trb_pool = dma_pool_alloc(priv_dev->eps_dma_pool,
> +						GFP_DMA32 | GFP_ATOMIC,
> +						&priv_ep->trb_pool_dma);

dma_pool_alloc also allocates the whole thunk of TRB region. See the
kernel-doc for dma_pool_create.

 * Given one of these pools, dma_pool_alloc()
 * may be used to allocate memory.  Such memory will all have "consistent"
> +
>  		if (!priv_ep->trb_pool)
>  			return -ENOMEM;
>  
> @@ -833,10 +818,26 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
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
> @@ -898,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct work_struct *work)
>  			 * interrupts.
>  			 */
>  			spin_unlock_irqrestore(&priv_dev->lock, flags);
> -			dma_free_coherent(priv_dev->sysdev, buf->size,
> -					  buf->buf, buf->dma);
> +			kfree(buf->buf);
>  			kfree(buf);
>  			spin_lock_irqsave(&priv_dev->lock, flags);
>  		}
> @@ -925,27 +925,16 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
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
> @@ -955,6 +944,27 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>  		       priv_req->request.length);
>  	}
>  
> +	if (priv_req->aligned_buf) {
> +		trace_cdns3_free_aligned_request(priv_req);
> +		priv_req->aligned_buf->in_use = 0;
> +		queue_work(system_freezable_wq,
> +			   &priv_dev->aligned_buf_wq);
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
> @@ -3103,16 +3113,17 @@ static void cdns3_gadget_exit(struct cdns *cdns)
>  		struct cdns3_aligned_buf *buf;
>  
>  		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> -		dma_free_coherent(priv_dev->sysdev, buf->size,
> -				  buf->buf,
> -				  buf->dma);
> +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> +			buf->dir);
>  
>  		list_del(&buf->list);
> +		kfree(buf->buf);
>  		kfree(buf);
>  	}
>  
>  	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>  			  priv_dev->setup_dma);
> +	dma_pool_destroy(priv_dev->eps_dma_pool);
>  
>  	kfree(priv_dev->zlp_buf);
>  	usb_put_gadget(&priv_dev->gadget);
> @@ -3185,6 +3196,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
>  	/* initialize endpoint container */
>  	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>  	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
> +	priv_dev->eps_dma_pool = dma_pool_create("cdns3_eps_dma_pool",
> +						priv_dev->sysdev,
> +						TRB_RING_SIZE, 8, 0);
> +	if (!priv_dev->eps_dma_pool) {
> +		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
> +		ret = -ENOMEM;
> +		goto err1;
> +	}
>  
>  	ret = cdns3_init_eps(priv_dev);
>  	if (ret) {
> @@ -3235,6 +3254,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
>  err2:
>  	cdns3_free_all_eps(priv_dev);
>  err1:
> +	dma_pool_destroy(priv_dev->eps_dma_pool);
> +
>  	usb_put_gadget(&priv_dev->gadget);
>  	cdns->gadget_dev = NULL;
>  	return ret;
> diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
> index 21fa461..c5660f2 100644
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
> @@ -1298,6 +1300,7 @@ struct cdns3_device {
>  
>  	struct cdns3_usb_regs		__iomem *regs;
>  
> +	struct dma_pool			*eps_dma_pool;
>  	struct usb_ctrlrequest		*setup_buf;
>  	dma_addr_t			setup_dma;
>  	void				*zlp_buf;
> -- 
> 1.7.1
> 

I guess this issue may due to the size for DMA region is too small,
try to enlarge the it (eg, CMA size).

-- 

Thanks,
Peter Chen

