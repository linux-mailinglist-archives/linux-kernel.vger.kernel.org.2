Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9234AB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:28:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51895 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230252AbhCZP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:28:23 -0400
Received: (qmail 833569 invoked by uid 1000); 26 Mar 2021 11:28:21 -0400
Date:   Fri, 26 Mar 2021 11:28:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        tanxiaofei@huawei.com, liudongdong3@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:ohci:fix ohci interruption problem
Message-ID: <20210326152821.GA832251@rowland.harvard.edu>
References: <1616748896-9415-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616748896-9415-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:54:56PM +0800, Longfang Liu wrote:
> When OHCI enters the S4 sleep state, the USB sleep process will call
> check_root_hub_suspend() and ohci_bus_suspend() instead of
> ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
> to not be closed.

What on earth are you talking about?  This isn't true at all.

Can you provide more information about your system?  Are you using a 
PCI-based OHCI controller or a platform device (and if so, which one)?  
Can you post system logs to back up your statements?

The proper order of calls is ohci_bus_suspend, then 
check_root_hub_suspended, then ohci_suspend.  Often the first one is 
called some time before the other two.

> At this time, if just one device interrupt is reported. Since rh_state
> has been changed to OHCI_RH_SUSPENDED after ohci_bus_suspend(), the
> driver will not process and close this device interrupt. It will cause
> the entire system to be stuck during sleep, causing the device to
> fail to respond.
> 
> When the abnormal interruption reaches 100,000 times, the system will
> forcibly close the interruption and make the device unusable.
> 
> Since the problem is that the interrupt is not closed, we copied the
> interrupt shutdown operation of ohci_suspend() into ohci_bus_suspend()
> during the S4 sleep period. We found that this method can solve this
> problem.
> 
> At present, we hope to be able to call ohci_suspend() directly during
> the sleep process of S4. Do you have any suggestions for this
> modification?
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/ohci-hub.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
> index 634f3c7..d468cef 100644
> --- a/drivers/usb/host/ohci-hub.c
> +++ b/drivers/usb/host/ohci-hub.c
> @@ -315,6 +315,14 @@ static int ohci_bus_suspend (struct usb_hcd *hcd)
>  		del_timer_sync(&ohci->io_watchdog);
>  		ohci->prev_frame_no = IO_WATCHDOG_OFF;
>  	}
> +
> +	spin_lock_irqsave(&ohci->lock, flags);
> +	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> +	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
> +
> +	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> +	spin_unlock_irqrestore(&ohci->lock, flags);

This is completely wrong.  The hardware certainly remains accessible 
when the root hub stops running.  The HW_ACCESSIBLE flag should not be 
cleared here.

And if the Master Interrupt Enable bit is cleared, how will the driver 
ever learn if a remote wakeup request (such as a plug or unplug event) 
occurs?

Alan Stern

> +
>  	return rc;
>  }
>  
> @@ -326,7 +334,10 @@ static int ohci_bus_resume (struct usb_hcd *hcd)
>  	if (time_before (jiffies, ohci->next_statechange))
>  		msleep(5);
>  
> -	spin_lock_irq (&ohci->lock);
> +	spin_lock_irq(&ohci->lock);
> +	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> +	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
> +	ohci_readl(ohci, &ohci->regs->intrenable);
>  
>  	if (unlikely(!HCD_HW_ACCESSIBLE(hcd)))
>  		rc = -ESHUTDOWN;
> -- 
> 2.8.1
> 
