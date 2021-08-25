Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D57A3F77CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbhHYOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:53:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57063 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240395AbhHYOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:53:39 -0400
Received: (qmail 193484 invoked by uid 1000); 25 Aug 2021 10:52:52 -0400
Date:   Wed, 25 Aug 2021 10:52:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
Subject: Re: [PATCH 2/3] usb: core: hcd: Add support for deferring roothub
 registration
Message-ID: <20210825145252.GB192480@rowland.harvard.edu>
References: <20210825105132.10420-1-kishon@ti.com>
 <20210825105132.10420-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825105132.10420-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:21:31PM +0530, Kishon Vijay Abraham I wrote:
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
> ---
>  drivers/usb/core/hcd.c  | 28 +++++++++++++++++++++++-----
>  include/linux/usb/hcd.h |  2 ++
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 775f0456f0ad..ba0493d22d13 100644
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
> @@ -2956,17 +2957,34 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	}
>  
>  	/* starting here, usbcore will pay attention to this root hub */

That comment is now wrong.  This is the point in the code where 
usbcore will start paying attention to the _shared_ (primary) hcd's 
roothub (if its HCD_DEFER_PRI_RH_REGISTER flag is set).

> -	retval = register_root_hub(hcd);
> -	if (retval != 0)
> -		goto err_register_root_hub;
> +	shared_hcd = hcd->shared_hcd;
> +	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd &&
> +	    HCD_DEFER_RH_REGISTER(shared_hcd)) {
> +		retval = register_root_hub(shared_hcd);
> +		if (retval != 0)
> +			goto err_register_shared_root_hub;
>  
> -	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
> -		usb_hcd_poll_rh_status(hcd);
> +		if (shared_hcd->uses_new_polling && HCD_POLL_RH(shared_hcd))
> +			usb_hcd_poll_rh_status(shared_hcd);
> +	}
> +

_This_ is where usbcore will start paying attention to the hcd's own 
root hub (if its HCD_DEFER_PRI_RH_REGISTER flag isn't set).

> +	if (!HCD_DEFER_RH_REGISTER(hcd)) {
> +		retval = register_root_hub(hcd);
> +		if (retval != 0)
> +			goto err_register_root_hub;
> +
> +		if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
> +			usb_hcd_poll_rh_status(hcd);
> +	}
>  
>  	return retval;
>  
>  err_register_root_hub:
>  	usb_stop_hcd(hcd);
> +err_register_shared_root_hub:
> +	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd &&
> +	    shared_hcd->flags & HCD_FLAG_DEFER_PRI_RH_REGISTER)
> +		usb_stop_hcd(shared_hcd);
>  err_hcd_driver_start:
>  	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
>  		free_irq(irqnum, hcd);
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 548a028f2dab..6a357ba72f5d 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -124,6 +124,7 @@ struct usb_hcd {
>  #define HCD_FLAG_RH_RUNNING		5	/* root hub is running? */
>  #define HCD_FLAG_DEAD			6	/* controller has died? */
>  #define HCD_FLAG_INTF_AUTHORIZED	7	/* authorize interfaces? */
> +#define HCD_FLAG_DEFER_PRI_RH_REGISTER	8	/* Defer roothub registration */
>  
>  	/* The flags can be tested using these macros; they are likely to
>  	 * be slightly faster than test_bit().
> @@ -134,6 +135,7 @@ struct usb_hcd {
>  #define HCD_WAKEUP_PENDING(hcd)	((hcd)->flags & (1U << HCD_FLAG_WAKEUP_PENDING))
>  #define HCD_RH_RUNNING(hcd)	((hcd)->flags & (1U << HCD_FLAG_RH_RUNNING))
>  #define HCD_DEAD(hcd)		((hcd)->flags & (1U << HCD_FLAG_DEAD))
> +#define HCD_DEFER_RH_REGISTER(hcd) ((hcd)->flags & (1U << HCD_FLAG_DEFER_PRI_RH_REGISTER))

It's awkward to have slightly different names for the flag and the 
test.  How about getting rid of the "_PRI" part of the flag name?  It 
isn't really needed, because we obviously won't defer registering the 
secondary hcd's root hub -- there's no place to defer it to.

Alan Stern

>  	 * Specifies if interfaces are authorized by default
> -- 
> 2.17.1
> 
