Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1565D345DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCWMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:24:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:40457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhCWMYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:24:13 -0400
IronPort-SDR: qOFRZH1uOI3Q8cpYp4tmP2G6Dt32l0eshVVgq67rtlb05KjpLracWr2wl68PmBIwHyJ6hE+B26
 gZZsPB32S8Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254462169"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="254462169"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 05:24:12 -0700
IronPort-SDR: Op+97kIV1g+Tt6IfIOpnfJvgKn0rYYwz5js6VCu/J0USywDjfgZPFQAWxz9fV28V1nZ8P0ChYu
 efoB3qJPvKdw==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="441660739"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 05:24:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOg4u-00F0gx-BN; Tue, 23 Mar 2021 14:24:08 +0200
Date:   Tue, 23 Mar 2021 14:24:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/6] usb: gadget: pch_udc: Drop unneeded cpu_to_le32()
 call
Message-ID: <YFnd6NrqMAcyl9YN@smile.fi.intel.com>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
 <YFnX9H+JeK1SVKuY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFnX9H+JeK1SVKuY@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:58:44PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 22, 2021 at 11:11:44PM +0200, Andy Shevchenko wrote:
> > Either way ~0 will be in the correct byte order,
> > hence drop unneeded cpu_to_le32() call. Moreover,
> > it makes sparse happy, otherwise it complains:
> > 
> > pch_udc.c:1813:27: warning: incorrect type in assignment (different base types)
> > pch_udc.c:1813:27:    expected unsigned int [usertype] dataptr
> > pch_udc.c:1813:27:    got restricted __le32 [usertype]
> > 
> > Fixes: f646cf94520e ("USB device driver of Topcliff PCH")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/usb/gadget/udc/pch_udc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
> > index a3c1fc924268..2e2dca391007 100644
> > --- a/drivers/usb/gadget/udc/pch_udc.c
> > +++ b/drivers/usb/gadget/udc/pch_udc.c
> > @@ -1756,7 +1756,7 @@ static struct usb_request *pch_udc_alloc_request(struct usb_ep *usbep,
> >  	}
> >  	/* prevent from using desc. - set HOST BUSY */
> >  	dma_desc->status |= PCH_UDC_BS_HST_BSY;
> > -	dma_desc->dataptr = cpu_to_le32(DMA_ADDR_INVALID);
> > +	dma_desc->dataptr = DMA_ADDR_INVALID;
> >  	req->td_data = dma_desc;
> >  	req->td_data_last = dma_desc;
> >  	req->chain_len = 1;
> 
> With this series applied, I get the following build warning:
> 
> drivers/usb/gadget/udc/pch_udc.c: In function ‘pch_udc_alloc_request’:
> drivers/usb/gadget/udc/pch_udc.c:208:26: warning: conversion from ‘long long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘18446744073709551615’ to ‘4294967295’ [-Woverflow]
>   208 | #define DMA_ADDR_INVALID (~(dma_addr_t)0)
>       |                          ^
> drivers/usb/gadget/udc/pch_udc.c:1813:22: note: in expansion of macro ‘DMA_ADDR_INVALID’
>  1813 |  dma_desc->dataptr = DMA_ADDR_INVALID;
>       |                      ^~~~~~~~~~~~~~~~
> 
> 
> Please fix up and resend a new version of this series.

Oops, thanks! Now I understand how I missed this (I have another patch to test
that effectively removed that line AFAIR. In any case, I will retest and
resend.

-- 
With Best Regards,
Andy Shevchenko


