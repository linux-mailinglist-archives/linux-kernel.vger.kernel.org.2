Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510873F779F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhHYOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:46:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38049 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229553AbhHYOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:46:32 -0400
Received: (qmail 193245 invoked by uid 1000); 25 Aug 2021 10:45:46 -0400
Date:   Wed, 25 Aug 2021 10:45:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
Subject: Re: [PATCH 1/3] usb: core: hcd: Modularize HCD stop configuration in
 usb_stop_hcd()
Message-ID: <20210825144546.GA192480@rowland.harvard.edu>
References: <20210825105132.10420-1-kishon@ti.com>
 <20210825105132.10420-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825105132.10420-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:21:30PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Since configuration to stop HCD is invoked from
> multiple places, group all of them in usb_stop_hcd().
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/core/hcd.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 0f8b7c93310e..775f0456f0ad 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2760,6 +2760,26 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
>  	usb_put_dev(rhdev);
>  }
>  
> +/**
> + * usb_stop_hcd - Halt the HCD
> + * @hcd: the usb_hcd that has to be halted
> + *
> + * Stop the timer and invoke ->stop() callback on the HCD

This comment is now somewhat out of context.  It should be rephrased 
to say "Stop the root-hub polling timer and invoke the HCD's ->stop 
callback."

Apart from that,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

> + */
> +static void usb_stop_hcd(struct usb_hcd *hcd)
> +{
> +	hcd->rh_pollable = 0;
> +	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> +	del_timer_sync(&hcd->rh_timer);
> +
> +	hcd->driver->stop(hcd);
> +	hcd->state = HC_STATE_HALT;
> +
> +	/* In case the HCD restarted the timer, stop it again. */
> +	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> +	del_timer_sync(&hcd->rh_timer);
> +}
> +
>  /**
>   * usb_add_hcd - finish generic HCD structure initialization and register
>   * @hcd: the usb_hcd structure to initialize
> @@ -2946,13 +2966,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	return retval;
>  
>  err_register_root_hub:
> -	hcd->rh_pollable = 0;
> -	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> -	del_timer_sync(&hcd->rh_timer);
> -	hcd->driver->stop(hcd);
> -	hcd->state = HC_STATE_HALT;
> -	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> -	del_timer_sync(&hcd->rh_timer);
> +	usb_stop_hcd(hcd);
>  err_hcd_driver_start:
>  	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
>  		free_irq(irqnum, hcd);
> @@ -3022,16 +3036,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>  	 * interrupt occurs), but usb_hcd_poll_rh_status() won't invoke
>  	 * the hub_status_data() callback.
>  	 */
> -	hcd->rh_pollable = 0;
> -	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> -	del_timer_sync(&hcd->rh_timer);
> -
> -	hcd->driver->stop(hcd);
> -	hcd->state = HC_STATE_HALT;
> -
> -	/* In case the HCD restarted the timer, stop it again. */
> -	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> -	del_timer_sync(&hcd->rh_timer);
> +	usb_stop_hcd(hcd);
>  
>  	if (usb_hcd_is_primary_hcd(hcd)) {
>  		if (hcd->irq > 0)
> -- 
> 2.17.1
> 
