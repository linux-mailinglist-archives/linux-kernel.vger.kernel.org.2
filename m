Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A04403BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351863AbhIHOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:52:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33573 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1349052AbhIHOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:52:55 -0400
Received: (qmail 605560 invoked by uid 1000); 8 Sep 2021 10:51:46 -0400
Date:   Wed, 8 Sep 2021 10:51:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
Subject: Re: [PATCH v3 1/3] usb: core: hcd: Add support for deferring roothub
 registration
Message-ID: <20210908145146.GB603644@rowland.harvard.edu>
References: <20210908095312.985-1-kishon@ti.com>
 <20210908095312.985-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908095312.985-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 03:23:10PM +0530, Kishon Vijay Abraham I wrote:
> It has been observed with certain PCIe USB cards (like Inateck connected
> to AM64 EVM or J7200 EVM) that as soon as the primary roothub is
> registered, port status change is handled even before xHC is running
> leading to cold plug USB devices not detected. For such cases, registering
> both the root hubs along with the second HCD is required. Add support for
> deferring roothub registration in usb_add_hcd(), so that both primary and
> secondary roothubs are registered along with the second HCD.
> 
> CC: stable@vger.kernel.org # 5.4+
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Tested-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  drivers/usb/core/hcd.c  | 30 ++++++++++++++++++++++++------
>  include/linux/usb/hcd.h |  2 ++
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 0f8b7c93310e..30bbf4ac4284 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2775,6 +2775,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  {
>  	int retval;
>  	struct usb_device *rhdev;
> +	struct usb_hcd *shared_hcd;
>  
>  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> @@ -2935,13 +2936,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  		goto err_hcd_driver_start;
>  	}
>  
> +	/* starting here, usbcore will pay attention to the shared HCD roothub */
> +	shared_hcd = hcd->shared_hcd;
> +	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && HCD_DEFER_RH_REGISTER(shared_hcd)) {
> +		retval = register_root_hub(shared_hcd);
> +		if (retval != 0)
> +			goto err_register_root_hub;
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
> @@ -2985,6 +2999,7 @@ EXPORT_SYMBOL_GPL(usb_add_hcd);
>  void usb_remove_hcd(struct usb_hcd *hcd)
>  {
>  	struct usb_device *rhdev = hcd->self.root_hub;
> +	unsigned rh_registered;

This really should be a bool, not an unsigned.  (Relatively unimportant.)

>  	dev_info(hcd->self.controller, "remove, state %x\n", hcd->state);
>  
> @@ -2995,6 +3010,8 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>  
>  	dev_dbg(hcd->self.controller, "roothub graceful disconnect\n");
>  	spin_lock_irq (&hcd_root_hub_lock);
> +	if (hcd->rh_registered == 1)
> +		rh_registered = 1;

Just say: rh_registered = hcd->rh_registered

>  	hcd->rh_registered = 0;
>  	spin_unlock_irq (&hcd_root_hub_lock);
>  
> @@ -3004,7 +3021,8 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>  	cancel_work_sync(&hcd->died_work);
>  
>  	mutex_lock(&usb_bus_idr_lock);
> -	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
> +	if (rh_registered == 1)

Just say: if (rh_registered)

> +		usb_disconnect(&rhdev);		/* Sets rhdev to NULL */

Didn't the compiler warn about using a possibly uninitialized variable?

The overall logic looks okay, apart from this one point.

Alan Stern

>  	mutex_unlock(&usb_bus_idr_lock);
>  
>  	/*
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
