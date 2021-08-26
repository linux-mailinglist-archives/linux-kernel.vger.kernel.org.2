Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E63F8AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbhHZPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:17:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44115 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232291AbhHZPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:17:16 -0400
Received: (qmail 230172 invoked by uid 1000); 26 Aug 2021 11:16:23 -0400
Date:   Thu, 26 Aug 2021 11:16:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
Subject: Re: [PATCH v2 2/3] usb: core: hcd: Add support for deferring roothub
 registration
Message-ID: <20210826151623.GA228824@rowland.harvard.edu>
References: <20210826111426.751-1-kishon@ti.com>
 <20210826111426.751-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826111426.751-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 04:44:25PM +0530, Kishon Vijay Abraham I wrote:
> It has been observed with certain PCIe USB cards (like Inateck connected
> to AM64 EVM or J7200 EVM) that as soon as the primary roothub is
> registered, port status change is handled even before xHC is running
> leading to cold plug USB devices not detected. For such cases, registering
> both the root hubs along with the second HCD is required. Add support for
> deferring roothub registration in usb_add_hcd(), so that both primary and
> secondary roothubs are registered along with the second HCD.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Tested-by: Chris Chiu <chris.chiu@canonical.com>
> ---

I should have noticed this problem before...

>  drivers/usb/core/hcd.c  | 27 ++++++++++++++++++++++-----
>  include/linux/usb/hcd.h |  2 ++
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 00d35fe1fef0..64fdfc6692c2 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2795,6 +2795,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  {
>  	int retval;
>  	struct usb_device *rhdev;
> +	struct usb_hcd *shared_hcd;
>  
>  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> @@ -2955,18 +2956,34 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  		goto err_hcd_driver_start;
>  	}
>  
> +	/* starting here, usbcore will pay attention to the shared HCD roothub */
> +	shared_hcd = hcd->shared_hcd;
> +	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && HCD_DEFER_RH_REGISTER(shared_hcd)) {
> +		retval = register_root_hub(shared_hcd);
> +		if (retval != 0)
> +			goto err_register_shared_root_hub;
> +
> +		if (shared_hcd->uses_new_polling && HCD_POLL_RH(shared_hcd))
> +			usb_hcd_poll_rh_status(shared_hcd);
> +	}
> +
>  	/* starting here, usbcore will pay attention to this root hub */
> -	retval = register_root_hub(hcd);
> -	if (retval != 0)
> -		goto err_register_root_hub;
> +	if (!HCD_DEFER_RH_REGISTER(hcd)) {
> +		retval = register_root_hub(hcd);
> +		if (retval != 0)
> +			goto err_register_root_hub;
>  
> -	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
> -		usb_hcd_poll_rh_status(hcd);
> +		if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
> +			usb_hcd_poll_rh_status(hcd);
> +	}
>  
>  	return retval;
>  
>  err_register_root_hub:
>  	usb_stop_hcd(hcd);
> +err_register_shared_root_hub:
> +	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && HCD_DEFER_RH_REGISTER(shared_hcd))
> +		usb_stop_hcd(shared_hcd);

This was added in the wrong place.  It needs to come before the 
usb_stop_hcd(hcd) call, because usb_start_hcd(hcd) was run before we failed to 
register the shared hcd's root hub.

Furthermore, I don't think we need to stop the shared hcd at all.  At this 
point, the usb_add_hcd() call for the shared hcd has already returned 
successfully.  The usb_stop_hcd(shared_hcd) callback will be made automatically 
when the shared hcd is unregistered later on, after this function returns an 
error.

Come to think of it, don't we also need to modify the usb_disconnect(&rhdev) 
call in usb_remove_hcd() to handle the case where the root hub wasn't 
registered in the first place because it was deferred?  At the very least, we 
should test the hcd's rh_registered flag before trying to unregister the root 
hub.

Alan Stern

>  err_hcd_driver_start:
>  	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
>  		free_irq(irqnum, hcd);
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 548a028f2dab..2c1fc9212cf2 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -124,6 +124,7 @@ struct usb_hcd {
>  #define HCD_FLAG_RH_RUNNING		5	/* root hub is running? */
>  #define HCD_FLAG_DEAD			6	/* controller has died? */
>  #define HCD_FLAG_INTF_AUTHORIZED	7	/* authorize interfaces? */
> +#define HCD_FLAG_DEFER_RH_REGISTER	8	/* Defer roothub registration */
>  
>  	/* The flags can be tested using these macros; they are likely to
>  	 * be slightly faster than test_bit().
> @@ -134,6 +135,7 @@ struct usb_hcd {
>  #define HCD_WAKEUP_PENDING(hcd)	((hcd)->flags & (1U << HCD_FLAG_WAKEUP_PENDING))
>  #define HCD_RH_RUNNING(hcd)	((hcd)->flags & (1U << HCD_FLAG_RH_RUNNING))
>  #define HCD_DEAD(hcd)		((hcd)->flags & (1U << HCD_FLAG_DEAD))
> +#define HCD_DEFER_RH_REGISTER(hcd) ((hcd)->flags & (1U << HCD_FLAG_DEFER_RH_REGISTER))
>  
>  	/*
>  	 * Specifies if interfaces are authorized by default
> -- 
> 2.17.1
> 
