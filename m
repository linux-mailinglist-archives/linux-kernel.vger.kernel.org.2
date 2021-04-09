Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2A35A1AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhDIPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:08:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37493 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234072AbhDIPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:07:58 -0400
Received: (qmail 1334309 invoked by uid 1000); 9 Apr 2021 11:07:44 -0400
Date:   Fri, 9 Apr 2021 11:07:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH v2] USB:ohci:fix ohci interruption problem
Message-ID: <20210409150744.GB1333284@rowland.harvard.edu>
References: <1617954422-36617-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617954422-36617-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:47:02PM +0800, Longfang Liu wrote:
> The operating method of the system entering S4 sleep mode:
> echo reboot > /sys/power/disk
> echo disk > /sys/power/state
> 
> When OHCI enters the S4 sleep state, check the log and find that
> the USB sleep process will call check_root_hub_suspend() and
> ohci_bus_suspend() instead ohci_suspend() and ohci_bus_suspend(),
> which will cause the OHCI interrupt to not be closed.
> 
> At this time, if just one device interrupt is reported. the
> driver will not process and close this device interrupt. It will cause
> the entire system to be stuck during sleep, causing the device to
> fail to respond.
> 
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
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
> 
> Changes in V2:
> 	- Modify comment and patch version information.

Please, instead of sending the same incorrect patch over and over again, 
spend some time figuring out what is really going wrong.  I have already 
explained why this patch is not the right thing to do.

You have to determine why the poweroff callback in hcd-pci.c (which 
points to hcd_pci_suspend) isn't getting called.  That's the real 
explanation for your problem.

Alan Stern

> Changes in V1:
> 	- Call suspend_common by adding the hcd_pci_freeze function turn off
> 	the interrupt instead of adding a shutdown operation in ohci_bus_suspend
> 	to turn off the interrupt.
> 
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
