Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC2352D61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhDBP1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:27:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39269 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234723AbhDBP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:26:57 -0400
Received: (qmail 1097185 invoked by uid 1000); 2 Apr 2021 11:26:55 -0400
Date:   Fri, 2 Apr 2021 11:26:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kong.kongxinwei@hisilicon.com, yisen.zhuang@huawei.com
Subject: Re: [PATCH] USB:ohci:fix ohci interruption problem
Message-ID: <20210402152655.GC1095271@rowland.harvard.edu>
References: <1617355679-9417-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617355679-9417-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 05:27:59PM +0800, Longfang Liu wrote:
> The operating method of the system entering S4 sleep mode:
> echo disk > /sys/power/state

This discussion is still not right.

> When OHCI enters the S4 sleep state,

To start with, you should be talking about hibernation (also known as 
suspend-to-disk), not S4.  When the system enters hibernation -- for 
example, when you write "disk" to /sys/power/state -- the controller may 
go into S4 or it may go into some other power-saving state.

>  the USB sleep process will call
> check_root_hub_suspend() and ohci_bus_suspend() instead of
> ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
> to not be closed.

This isn't true.  The procedure _does_ call ohci_suspend, through the 
.poweroff callback in hcd-pci.c.  That callback goes to the 
hcd_pci_suspend routine, which calls suspend_common and then 
ohci_suspend.

However, these calls happen after the kernel image has be written to the 
storage area on the disk.  As a result, any log messages produced during 
the calls do not get saved, so they don't get reloaded when the system 
resumes from hibernation, and they aren't present in the log after the 
system wakes up.  That's why they didn't appear in the log you included 
in an earlier email.  The only way to observe them is to use a remote 
console, such as a network console.

In fact, that's pretty much the only way to debug problems that occur 
during a hibernation transition.

> At this time, if just one device interrupt is reported. Since rh_state
> has been changed to OHCI_RH_SUSPENDED after ohci_bus_suspend(), the
> driver will not process and close this device interrupt.

That's not true either.  The ohci_irq routine does indeed process 
interrupts even when rh_state is set to OHCI_RH_SUSPENDED.  How else 
could it handle a device's wakeup request?

> It will cause
> the entire system to be stuck during sleep, causing the device to
> fail to respond.

During hibernation, the system is powered off.  Obviously the kernel is 
not capable of handling interrupts at this time.

Also, why would a device interrupt be reported at this time?  What 
causes the interrupt request?

> When the abnormal interruption reaches 100,000 times, the system will
> forcibly close the interruption and make the device unusable.
> 
> Because the root cause of the problem is that ohci_suspend is not
> called to perform normal interrupt shutdown operations when the system
> enters S4 sleep mode.
> 
> Therefore, our solution is to specify freeze interface in this mode to
> perform normal suspend_common() operations, and call ohci_suspend()
> after check_root_hub_suspend() is executed through the suspend_common()
> operation.

No.  The freeze interface does not need to power-down the controller.  
All it needs to do is make sure that no communication between the 
computer and the attached USB devices takes place, and this is handled 
by ohci_bus_suspend.

Furthermore, it is a mistake for the freeze routine to change anything 
unless the thaw routine reverses the change.  Your patch leaves the thaw 
callback pointer set to NULL.

> After using this solution, it is verified by the stress test of sleep
> wake up in S4 mode for a long time that this problem no longer occurs.

Something else must be happeneing, something you don't understand.

Alan Stern

> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/core/hcd-pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 1547aa6..c5844a3 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -509,6 +509,11 @@ static int resume_common(struct device *dev, int event)
>  
>  #ifdef	CONFIG_PM_SLEEP
>  
> +static int hcd_pci_freeze(struct device *dev)
> +{
> +	return suspend_common(dev, device_may_wakeup(dev));
> +}
> +
>  static int hcd_pci_suspend(struct device *dev)
>  {
>  	return suspend_common(dev, device_may_wakeup(dev));
> @@ -605,7 +610,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>  	.suspend_noirq	= hcd_pci_suspend_noirq,
>  	.resume_noirq	= hcd_pci_resume_noirq,
>  	.resume		= hcd_pci_resume,
> -	.freeze		= check_root_hub_suspended,
> +	.freeze		= hcd_pci_freeze,
>  	.freeze_noirq	= check_root_hub_suspended,
>  	.thaw_noirq	= NULL,
>  	.thaw		= NULL,
> -- 
> 2.8.1
> 
