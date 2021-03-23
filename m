Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA52345D84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCWL6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhCWL6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07BE26191A;
        Tue, 23 Mar 2021 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616500726;
        bh=Qx2dRVMJSoSWHEiu78M1VLfpaeZ8A6p8qVkoPZlsck8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRJZeOYSCt3yRyYIRfcFxNFZTtD3wftIgc9qdVlffOAxpITLQEjsY8b2HeDQyhgyD
         06ZS2LD8CbXiOrJGCnuckcKzTenE/AnHHyXcz5MTl/ERnNtuhqkw4DXwgISXk7rLNH
         odaHihERo5ppZyL1xQIpk3Sbr4aMLkxUYXKMA++Q=
Date:   Tue, 23 Mar 2021 12:58:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/6] usb: gadget: pch_udc: Drop unneeded cpu_to_le32()
 call
Message-ID: <YFnX9H+JeK1SVKuY@kroah.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:11:44PM +0200, Andy Shevchenko wrote:
> Either way ~0 will be in the correct byte order,
> hence drop unneeded cpu_to_le32() call. Moreover,
> it makes sparse happy, otherwise it complains:
> 
> pch_udc.c:1813:27: warning: incorrect type in assignment (different base types)
> pch_udc.c:1813:27:    expected unsigned int [usertype] dataptr
> pch_udc.c:1813:27:    got restricted __le32 [usertype]
> 
> Fixes: f646cf94520e ("USB device driver of Topcliff PCH")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/gadget/udc/pch_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
> index a3c1fc924268..2e2dca391007 100644
> --- a/drivers/usb/gadget/udc/pch_udc.c
> +++ b/drivers/usb/gadget/udc/pch_udc.c
> @@ -1756,7 +1756,7 @@ static struct usb_request *pch_udc_alloc_request(struct usb_ep *usbep,
>  	}
>  	/* prevent from using desc. - set HOST BUSY */
>  	dma_desc->status |= PCH_UDC_BS_HST_BSY;
> -	dma_desc->dataptr = cpu_to_le32(DMA_ADDR_INVALID);
> +	dma_desc->dataptr = DMA_ADDR_INVALID;
>  	req->td_data = dma_desc;
>  	req->td_data_last = dma_desc;
>  	req->chain_len = 1;

With this series applied, I get the following build warning:

drivers/usb/gadget/udc/pch_udc.c: In function ‘pch_udc_alloc_request’:
drivers/usb/gadget/udc/pch_udc.c:208:26: warning: conversion from ‘long long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘18446744073709551615’ to ‘4294967295’ [-Woverflow]
  208 | #define DMA_ADDR_INVALID (~(dma_addr_t)0)
      |                          ^
drivers/usb/gadget/udc/pch_udc.c:1813:22: note: in expansion of macro ‘DMA_ADDR_INVALID’
 1813 |  dma_desc->dataptr = DMA_ADDR_INVALID;
      |                      ^~~~~~~~~~~~~~~~


Please fix up and resend a new version of this series.

thanks,

greg k-h
