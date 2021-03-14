Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110E133A26E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 03:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhCNCud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 21:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCNCuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 21:50:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2290D64EA4;
        Sun, 14 Mar 2021 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615690200;
        bh=xFNOm/zWXuQkVZyp3Fl+8i6zYBx8/FW9ZekoS1N5zqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNP+CHvmkms1GOXgax9NXWMVxmJkzoVjB+D9Hx/OjsOeGd93FMnGUM61AzMwMcEqD
         RcQl4EIPQaLnOryZumH/l72eFO2G+vF9OLhQI/qjWvBkgLTiBvGGUMX+r/EkUZq/iC
         ZLBe6EFioYCQCo2IIyVjMDP19u7ctfJPDNQB4GHJtqokUsXSotLg/LjZi1drJmIUs8
         rD9DFOq1I1TjBCLO4Er9jUFEfBktZ5PJ3/DqWArxpBKivGrWpFRqwLphUawhtSVJGf
         NO+iQxueXFrFWWJO1UZiuIug+Au6GPWdTkhcILYfoSyVdipE16fq0UUvILPlFj3nwU
         eW4v5CLRBcgKg==
Date:   Sun, 14 Mar 2021 10:49:51 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     pawell@cadence.com, a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        gregkh@linuxfoundation.org, kishon@ti.com
Subject: Re: [PATCH 1/2] usb: cdns3: Use dma_pool_* api to alloc trb pool
Message-ID: <20210314024951.GD17526@b29397-desktop>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-09 06:19:39, Sanket Parmar wrote:
> Allocation of DMA coherent memory in atomic context using
> dma_alloc_coherent() might fail on platforms with smaller
> DMA region.
> 
> To fix it, dma_alloc_coherent() is replaced with dma_pool
> API to allocate a smaller chunk of DMA coherent memory for
> TRB rings.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

The patch is ok, but I don't think it is a bug-fix, it is an
improvement for smaller DMA region use case.

I will apply it with deletion of above Fixes tag if you have no
more opinion.

Peter
> Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c |   42 +++++++++++++++++--------------------
>  drivers/usb/cdns3/cdns3-gadget.h |    1 +
>  2 files changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 582bfec..5f51215 100644
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
> +			      priv_ep->trb_pool, priv_ep->trb_pool_dma);
>  		priv_ep->trb_pool = NULL;
>  	}
>  }
> @@ -226,7 +211,7 @@ static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
>  int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
>  {
>  	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> -	int ring_size = cdns3_ring_size(priv_ep);
> +	int ring_size = TRB_RING_SIZE;
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
> +						   GFP_DMA32 | GFP_ATOMIC,
> +						   &priv_ep->trb_pool_dma);
> +
>  		if (!priv_ep->trb_pool)
>  			return -ENOMEM;
>  
> @@ -3113,6 +3098,7 @@ static void cdns3_gadget_exit(struct cdns *cdns)
>  
>  	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>  			  priv_dev->setup_dma);
> +	dma_pool_destroy(priv_dev->eps_dma_pool);
>  
>  	kfree(priv_dev->zlp_buf);
>  	usb_put_gadget(&priv_dev->gadget);
> @@ -3185,6 +3171,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
>  	/* initialize endpoint container */
>  	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>  	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
> +	priv_dev->eps_dma_pool = dma_pool_create("cdns3_eps_dma_pool",
> +						 priv_dev->sysdev,
> +						 TRB_RING_SIZE, 8, 0);
> +	if (!priv_dev->eps_dma_pool) {
> +		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
> +		ret = -ENOMEM;
> +		goto err1;
> +	}
>  
>  	ret = cdns3_init_eps(priv_dev);
>  	if (ret) {
> @@ -3235,6 +3229,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
>  err2:
>  	cdns3_free_all_eps(priv_dev);
>  err1:
> +	dma_pool_destroy(priv_dev->eps_dma_pool);
> +
>  	usb_put_gadget(&priv_dev->gadget);
>  	cdns->gadget_dev = NULL;
>  	return ret;
> diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
> index 21fa461..ecf9b91 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.h
> +++ b/drivers/usb/cdns3/cdns3-gadget.h
> @@ -1298,6 +1298,7 @@ struct cdns3_device {
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

-- 

Thanks,
Peter Chen

