Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C523321C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCIJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:17:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40968 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:17:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1299HYWH061197;
        Tue, 9 Mar 2021 03:17:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615281454;
        bh=ri6GPSt4mmQWm7TGh/T7MXdNDUgcqYlk7scLcgwdeIs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lawQJXtihiom2rQS50FDIVYWAARPnZBWyWE777sPqJNJO4Vln36RUDXDsLJHKhUHt
         7mgZKA9gz5zF4VGT1wlVTcPd+GcN3d2WFno94cUgLKrS6r9JmjGuL0BYisWTTjMS+I
         pVVEfkT5ApoHDyKMOHg13HvvKViGEgWwV5rZKs9Q=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1299HY5t032825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 03:17:34 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 03:17:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 03:17:34 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1299HU6W082905;
        Tue, 9 Mar 2021 03:17:31 -0600
Subject: Re: [PATCH] usb: cdns3: Coherent memory allocation optimization
To:     Sanket Parmar <sparmar@cadence.com>,
        Peter Chen <peter.chen@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "frank.li@nxp.com" <frank.li@nxp.com>
References: <1614960071-30367-1-git-send-email-sparmar@cadence.com>
 <20210306013808.GA2399@b29397-desktop>
 <BY5PR07MB8119BDCC597D72B64FCD3A3EB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <423224bc-9700-22d3-0a72-59e821c2ebff@ti.com>
Date:   Tue, 9 Mar 2021 14:47:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR07MB8119BDCC597D72B64FCD3A3EB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 09/03/21 11:09 am, Sanket Parmar wrote:
> Hi Peter,
> 
>> On 21-03-05 17:01:11, Sanket Parmar wrote:
>>> Allocation of DMA coherent memory in atomic context using
>>> dma_alloc_coherent() might fail on some platform. To fix it,
>>> Replaced dma_alloc_coherent() with dma_pool API to allocate a
>>> smaller chunk of DMA coherent memory for TRB rings.
>>>
>>> Also in cdns3_prepare_aligned_request_buf(), replaced
>>> dma_alloc_coherent() with kmalloc and dma_map API to allocate
>>> aligned request buffer of dynamic length.
>>>
>>
>> You do two changes in one commit, would you please split this one as
>> two patches?
>>
>>> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>>
>> "commit" is not needed
>>
>>> Reported by: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Reported-by:
>>
> I have split the change into two patches.
> New patch series has been posted already.
>  
>>> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
>>> ---
>>>  drivers/usb/cdns3/cdns3-gadget.c |  115 ++++++++++++++++++++++------------
>> ---
>>>  drivers/usb/cdns3/cdns3-gadget.h |    3 +
>>>  2 files changed, 71 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-
>> gadget.c
>>> index 582bfec..5fd6993 100644
>>> --- a/drivers/usb/cdns3/cdns3-gadget.c
>>> +++ b/drivers/usb/cdns3/cdns3-gadget.c
>>> @@ -59,6 +59,7 @@
>>>  #include <linux/dma-mapping.h>
>>>  #include <linux/usb/gadget.h>
>>>  #include <linux/module.h>
>>> +#include <linux/dmapool.h>
>>>  #include <linux/iopoll.h>
>>>
>>>  #include "core.h"
>>> @@ -190,29 +191,13 @@ dma_addr_t cdns3_trb_virt_to_dma(struct
>> cdns3_endpoint *priv_ep,
>>>  	return priv_ep->trb_pool_dma + offset;
>>>  }
>>>
>>> -static int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
>>> -{
>>> -	switch (priv_ep->type) {
>>> -	case USB_ENDPOINT_XFER_ISOC:
>>> -		return TRB_ISO_RING_SIZE;
>>> -	case USB_ENDPOINT_XFER_CONTROL:
>>> -		return TRB_CTRL_RING_SIZE;
>>> -	default:
>>> -		if (priv_ep->use_streams)
>>> -			return TRB_STREAM_RING_SIZE;
>>> -		else
>>> -			return TRB_RING_SIZE;
>>> -	}
>>> -}
>>> -
>>>  static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
>>>  {
>>>  	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
>>>
>>>  	if (priv_ep->trb_pool) {
>>> -		dma_free_coherent(priv_dev->sysdev,
>>> -				  cdns3_ring_size(priv_ep),
>>> -				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
>>> +		dma_pool_free(priv_dev->eps_dma_pool,
>>> +				priv_ep->trb_pool, priv_ep->trb_pool_dma);
>>>  		priv_ep->trb_pool = NULL;
>>>  	}
>>>  }
>>> @@ -226,7 +211,7 @@ static void cdns3_free_trb_pool(struct
>> cdns3_endpoint *priv_ep)
>>>  int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
>>>  {
>>>  	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
>>> -	int ring_size = cdns3_ring_size(priv_ep);
>>> +	int ring_size = TRB_RING_SIZE;
>>
>> You will use the same size for TRB ring region for control/bulk/isoc
>> endpoint.
>>
> As single DMA pool is used to allocate the ring buffer, different TRB ring
> size is not possible for different EP. Hence, TRB_RING_SIZE(600 * 12 B) which fits
> for all type of EPs is used.
> 
>>>  	int num_trbs = ring_size / TRB_SIZE;
>>>  	struct cdns3_trb *link_trb;
>>>
>>> @@ -234,10 +219,10 @@ int cdns3_allocate_trb_pool(struct
>> cdns3_endpoint *priv_ep)
>>>  		cdns3_free_trb_pool(priv_ep);
>>>
>>>  	if (!priv_ep->trb_pool) {
>>> -		priv_ep->trb_pool = dma_alloc_coherent(priv_dev->sysdev,
>>> -						       ring_size,
>>> -						       &priv_ep->trb_pool_dma,
>>> -						       GFP_DMA32 |
>> GFP_ATOMIC);
>>> +		priv_ep->trb_pool = dma_pool_alloc(priv_dev-
>>> eps_dma_pool,
>>> +						GFP_DMA32 | GFP_ATOMIC,
>>> +						&priv_ep->trb_pool_dma);
>>
>> dma_pool_alloc also allocates the whole thunk of TRB region. See the
>> kernel-doc for dma_pool_create.
>>
>>  * Given one of these pools, dma_pool_alloc()
>>  * may be used to allocate memory.  Such memory will all have "consistent"
> 
> Yes,  dma_pool_alloc allocates the whole chunk of TRB region for enabled EPs from the 
> pool. Currently the block size of the DMA pool is 7.2KB. So dma_pool_alloc allocates at least
> 7.2KB for TRB region per enabled EP.
> 
>>> +
>>>  		if (!priv_ep->trb_pool)
>>>  			return -ENOMEM;
>>>
>>> @@ -833,10 +818,26 @@ void cdns3_gadget_giveback(struct
>> cdns3_endpoint *priv_ep,
>>>  	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
>>>  					priv_ep->dir);
>>>
>>> -	if ((priv_req->flags & REQUEST_UNALIGNED) &&
>>> -	    priv_ep->dir == USB_DIR_OUT && !request->status)
>>> -		memcpy(request->buf, priv_req->aligned_buf->buf,
>>> -		       request->length);
>>> +	if ((priv_req->flags & REQUEST_UNALIGNED) && priv_req-
>>> aligned_buf) {
>>> +		struct cdns3_aligned_buf *buf;
>>> +
>>> +		buf = priv_req->aligned_buf;
>>> +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
>>> +			buf->dir);
>>> +		priv_req->flags &= ~REQUEST_UNALIGNED;
>>> +
>>> +		if (priv_ep->dir == USB_DIR_OUT && !request->status) {
>>> +			memcpy(request->buf, priv_req->aligned_buf->buf,
>>> +			       request->length);
>>> +		}
>>> +
>>> +		trace_cdns3_free_aligned_request(priv_req);
>>> +		priv_req->aligned_buf->in_use = 0;
>>> +		queue_work(system_freezable_wq,
>>> +			   &priv_dev->aligned_buf_wq);
>>> +		priv_req->aligned_buf = NULL;
>>> +
>>> +	}
>>>
>>>  	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
>>>  	/* All TRBs have finished, clear the counter */
>>> @@ -898,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct
>> work_struct *work)
>>>  			 * interrupts.
>>>  			 */
>>>  			spin_unlock_irqrestore(&priv_dev->lock, flags);
>>> -			dma_free_coherent(priv_dev->sysdev, buf->size,
>>> -					  buf->buf, buf->dma);
>>> +			kfree(buf->buf);
>>>  			kfree(buf);
>>>  			spin_lock_irqsave(&priv_dev->lock, flags);
>>>  		}
>>> @@ -925,27 +925,16 @@ static int
>> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>>>  		if (!buf)
>>>  			return -ENOMEM;
>>>
>>> -		buf->size = priv_req->request.length;
>>> +		buf->size = usb_endpoint_dir_out(priv_ep->endpoint.desc) ?
>>> +				usb_ep_align(&(priv_ep->endpoint), priv_req-
>>> request.length)
>>> +				: priv_req->request.length;
>>>
>>> -		buf->buf = dma_alloc_coherent(priv_dev->sysdev,
>>> -					      buf->size,
>>> -					      &buf->dma,
>>> -					      GFP_ATOMIC);
>>> +		buf->buf = kmalloc(buf->size, GFP_ATOMIC);
>>>  		if (!buf->buf) {
>>>  			kfree(buf);
>>>  			return -ENOMEM;
>>>  		}
>>>
>>> -		if (priv_req->aligned_buf) {
>>> -			trace_cdns3_free_aligned_request(priv_req);
>>> -			priv_req->aligned_buf->in_use = 0;
>>> -			queue_work(system_freezable_wq,
>>> -				   &priv_dev->aligned_buf_wq);
>>> -		}
>>> -
>>> -		buf->in_use = 1;
>>> -		priv_req->aligned_buf = buf;
>>> -
>>>  		list_add_tail(&buf->list,
>>>  			      &priv_dev->aligned_buf_list);
>>>  	}
>>> @@ -955,6 +944,27 @@ static int
>> cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
>>>  		       priv_req->request.length);
>>>  	}
>>>
>>> +	if (priv_req->aligned_buf) {
>>> +		trace_cdns3_free_aligned_request(priv_req);
>>> +		priv_req->aligned_buf->in_use = 0;
>>> +		queue_work(system_freezable_wq,
>>> +			   &priv_dev->aligned_buf_wq);
>>> +	}
>>> +
>>> +	buf->dir =  priv_ep->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>>> +	buf->in_use = 1;
>>> +	priv_req->aligned_buf = buf;
>>> +
>>> +	buf->dma = dma_map_single(priv_dev->sysdev, buf->buf, buf->size,
>>> +				buf->dir);
>>> +
>>> +	if (dma_mapping_error(priv_dev->sysdev, buf->dma)) {
>>> +		dev_err(priv_dev->dev, "Failed to map buffer\n");
>>> +		kfree(buf->buf);
>>> +		kfree(buf);
>>> +		return -EFAULT;
>>> +	}
>>> +
>>>  	priv_req->flags |= REQUEST_UNALIGNED;
>>>  	trace_cdns3_prepare_aligned_request(priv_req);
>>>
>>> @@ -3103,16 +3113,17 @@ static void cdns3_gadget_exit(struct cdns
>> *cdns)
>>>  		struct cdns3_aligned_buf *buf;
>>>
>>>  		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
>>> -		dma_free_coherent(priv_dev->sysdev, buf->size,
>>> -				  buf->buf,
>>> -				  buf->dma);
>>> +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
>>> +			buf->dir);
>>>
>>>  		list_del(&buf->list);
>>> +		kfree(buf->buf);
>>>  		kfree(buf);
>>>  	}
>>>
>>>  	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>>>  			  priv_dev->setup_dma);
>>> +	dma_pool_destroy(priv_dev->eps_dma_pool);
>>>
>>>  	kfree(priv_dev->zlp_buf);
>>>  	usb_put_gadget(&priv_dev->gadget);
>>> @@ -3185,6 +3196,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
>>>  	/* initialize endpoint container */
>>>  	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>>>  	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
>>> +	priv_dev->eps_dma_pool = dma_pool_create("cdns3_eps_dma_pool",
>>> +						priv_dev->sysdev,
>>> +						TRB_RING_SIZE, 8, 0);
>>> +	if (!priv_dev->eps_dma_pool) {
>>> +		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
>>> +		ret = -ENOMEM;
>>> +		goto err1;
>>> +	}
>>>
>>>  	ret = cdns3_init_eps(priv_dev);
>>>  	if (ret) {
>>> @@ -3235,6 +3254,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
>>>  err2:
>>>  	cdns3_free_all_eps(priv_dev);
>>>  err1:
>>> +	dma_pool_destroy(priv_dev->eps_dma_pool);
>>> +
>>>  	usb_put_gadget(&priv_dev->gadget);
>>>  	cdns->gadget_dev = NULL;
>>>  	return ret;
>>> diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-
>> gadget.h
>>> index 21fa461..c5660f2 100644
>>> --- a/drivers/usb/cdns3/cdns3-gadget.h
>>> +++ b/drivers/usb/cdns3/cdns3-gadget.h
>>> @@ -12,6 +12,7 @@
>>>  #ifndef __LINUX_CDNS3_GADGET
>>>  #define __LINUX_CDNS3_GADGET
>>>  #include <linux/usb/gadget.h>
>>> +#include <linux/dma-direction.h>
>>>
>>>  /*
>>>   * USBSS-DEV register interface.
>>> @@ -1205,6 +1206,7 @@ struct cdns3_aligned_buf {
>>>  	void			*buf;
>>>  	dma_addr_t		dma;
>>>  	u32			size;
>>> +	enum dma_data_direction dir;
>>>  	unsigned		in_use:1;
>>>  	struct list_head	list;
>>>  };
>>> @@ -1298,6 +1300,7 @@ struct cdns3_device {
>>>
>>>  	struct cdns3_usb_regs		__iomem *regs;
>>>
>>> +	struct dma_pool			*eps_dma_pool;
>>>  	struct usb_ctrlrequest		*setup_buf;
>>>  	dma_addr_t			setup_dma;
>>>  	void				*zlp_buf;
>>> --
>>> 1.7.1
>>>
>>
>> I guess this issue may due to the size for DMA region is too small,
>> try to enlarge the it (eg, CMA size).
>>

It is true that the issue is because there is limited amount of memory
available for DMA allocations but only increasing the size will not be
the correct solution for this issue. As a lot memory will be unsed, for
every dma_alloc_coherent(), 64KB(page size) of memory is allocated
whereas the maximum requirement around 7.2KB.

Also as the number of interfaces supported by the device increases which
leads the increases in number endpoints used, and this in turn increases
required memory pool.

So, I feel that increasing the CMA size would rather be a workaround and
not a solution for this issue.


Thanks,
Aswath



>> --
>>
>> Thanks,
>> Peter Chen
> 
> --
> Thanks,
> Sanket Parmar
> 

