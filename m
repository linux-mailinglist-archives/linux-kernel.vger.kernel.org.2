Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DCA325FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBZJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:24:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:37764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhBZJWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:22:30 -0500
IronPort-SDR: FGXnfl+abVmNIaHcyeluOHsy3yzqiBwNmVZf9Pd8q6PG3Ufu5xj5kx/xv9vJMJrEEDS6E0c7DI
 WryFfFxZ2WSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="185947733"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="185947733"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 01:20:39 -0800
IronPort-SDR: wk7QSclMzciY10VZTW4vDwedwKowZg+/+2MVga6bXexSYVj569JOJoXhUy786929Vz2Bfl22tQ
 iqoDMtjLO5MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="365787886"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2021 01:20:37 -0800
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
To:     Longfang Liu <liulongfang@huawei.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        linux-kernel@vger.kernel.org
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <127e3e5c-f485-64dd-235c-1971d6cd9a4a@linux.intel.com>
Date:   Fri, 26 Feb 2021 11:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.2.2021 10.21, Longfang Liu wrote:
> Our current XHCI hardware controller has been customized to only
> support USB 2.0 ports. When using the current xhci driver, an xhci
> controller device and an ehci controller device will be created
> automatically. We want the driver to create only one ehci controller.
> After modifying the driver as follows, an error will occur.
> Is there any other modification method?

The xhci driver relies on the existence of both a main and a shared hcd.
One hcd for handing USB 2 (and slower) and the other for USB 3 devices.

As one example xhci_run(hcd) needs to be called for both hcds, first call
sets up things, second one calls xhci_start() that makes the controller run.

It's probably possible to modify the driver to support xHCI hosts with only
USB 2 ports, but requires a lot more work.

> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/xhci-pci.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index ef513c2..7296aad 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -364,26 +364,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	/* USB 2.0 roothub is stored in the PCI device now. */
>  	hcd = dev_get_drvdata(&dev->dev);
>  	xhci = hcd_to_xhci(hcd);
> -	xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
> -						 pci_name(dev), hcd);
> -	if (!xhci->shared_hcd) {
> -		retval = -ENOMEM;
> -		goto dealloc_usb2_hcd;
> -	}
> -
> +	xhci->shared_hcd = NULL;
>  	retval = xhci_ext_cap_init(xhci);
>  	if (retval)
>  		goto put_usb3_hcd;
>  
> -	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
> +	retval = usb_add_hcd(xhci->main_hcd, dev->irq,
>  			IRQF_SHARED);
>  	if (retval)
>  		goto put_usb3_hcd;
> -	/* Roothub already marked as USB 3.0 speed */
> -
> -	if (!(xhci->quirks & XHCI_BROKEN_STREAMS) &&
> -			HCC_MAX_PSA(xhci->hcc_params) >= 4)
> -		xhci->shared_hcd->can_do_streams = 1;
>  
>  	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
>  	pm_runtime_put_noidle(&dev->dev);
> 

Something like the above could of course not be accepted upstream. We can't break existing
functionality to support one modified xHCI.

Thanks
Mathias
