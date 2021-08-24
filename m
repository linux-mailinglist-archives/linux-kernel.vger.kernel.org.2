Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9739F3F5D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhHXLxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:53:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:14598 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236903AbhHXLxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:53:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="217297640"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="217297640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 04:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="473465551"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2021 04:53:01 -0700
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com
References: <20210824105302.25382-1-kishon@ti.com>
 <20210824105302.25382-4-kishon@ti.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH 3/5] usb: core: hcd: Add support for registering
 secondary RH along with primary HCD
Message-ID: <06693934-28f2-d59e-b004-62cabd3f9e8e@linux.intel.com>
Date:   Tue, 24 Aug 2021 14:55:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824105302.25382-4-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.8.2021 13.53, Kishon Vijay Abraham I wrote:
> Add support for registering secondary roothub (RH) along with primary HCD.
> It has been observed with certain PCIe USB cards that as soon as the
> primary HCD is registered, port status change is handled leading to cold
> plug devices getting not detected. For such cases, registering both the
> root hubs along with the second HCD is useful.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  drivers/usb/core/hcd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 4d7a9f0e2caa..9c8df22a7d9a 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2799,6 +2799,7 @@ int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqfla
>  {
>  	int retval;
>  	struct usb_device *rhdev;
> +	struct usb_hcd *shared_hcd = NULL;
>  
>  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> @@ -2961,6 +2962,15 @@ int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqfla
>  
>  	/* starting here, usbcore will pay attention to this root hub */
>  	if (register_hub) {
> +		shared_hcd = hcd->shared_hcd;
> +		if (shared_hcd) {
> +			retval = register_root_hub(shared_hcd);

There is a possibility we try yo register the shared roothub before it is properly set up here.

For example the mediatek driver (xhci-mtk.c) creates both hcds before adding them,
so hcd->shared_hcd exists when usb_add_hcd() is called for the primary hcd,
causing this code to register the hcd->shared_hcd roothub which is not properly added yet.

How about skipping the new __usb_hcd_pci_probe() and __usb_add_hcd() and instead add a new
flag to hcd->flags, something like HCD_FLAG_DEFER_PRI_RH_REGISTER?

The host controller driver can set this flag in the hcd->driver->start(hcd) callback called
before roothub registration here from usb_add_hcd(). If flag is set we skip the roothub registration.

So something like:
shared_hcd = hcd->share_hcd;

if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && shared_hcd->flags & HCD_FLAG_DEFER_PRI_RH_REGISTER)
        register_root_hub(shared_hcd)
if (!(hcd->flags & HCD_FLAG_DEFER_PRI_RH_REGISTER))
        register_root_hub(hcd)

-Mathias 
