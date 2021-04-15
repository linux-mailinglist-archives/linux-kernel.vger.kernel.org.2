Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB3360984
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhDOMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhDOMex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA6AC610EA;
        Thu, 15 Apr 2021 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618490069;
        bh=G1s8L5+q54/YswEGOQ2T/r9yYdpOXdbKZRSfkJEPY/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAST1oXRPvO5TUJbvZOjbGl1mIDVN5FNIsN32tVFiwnk29jZZQKeNkpi0E98fbdJt
         XXNteUQr5pOUmC9zl6RAcywt4cEXLXcbJPUL4K7ZXpmX5NxRweMvuzBkpBGPOLyL1Y
         Yun4/mT5NwdDUBMTwRUDOcXTpASCFv1d0npx5lb8=
Date:   Thu, 15 Apr 2021 14:34:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [RFC PATCH] USB:XHCI:skip hub registration
Message-ID: <YHgy0jqLE0WAxA+2@kroah.com>
References: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 08:22:38PM +0800, Longfang Liu wrote:
> When the number of ports on the USB hub is 0, skip the registration
> operation of the USB hub.

That's crazy.  Why not fix the hardware?  How has this hub passed the
USB certification process?

> The current Kunpeng930's XHCI hardware controller is defective. The number
> of ports on its USB3.0 bus controller is 0, and the number of ports on
> the USB2.0 bus controller is 1.
> 
> In order to solve this problem that the USB3.0 controller does not have
> a port which causes the registration of the hub to fail, this patch passes
> the defect information by adding flags in the quirks of xhci and usb_hcd,
> and finally skips the registration process of the hub directly according
> to the results of these flags when the hub is initialized.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/core/hub.c      | 6 ++++++
>  drivers/usb/host/xhci-pci.c | 4 ++++
>  drivers/usb/host/xhci.c     | 5 +++++
>  drivers/usb/host/xhci.h     | 1 +
>  include/linux/usb/hcd.h     | 1 +
>  5 files changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b1e14be..2d6869d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1769,9 +1769,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	struct usb_host_interface *desc;
>  	struct usb_device *hdev;
>  	struct usb_hub *hub;
> +	struct usb_hcd *hcd;
>  
>  	desc = intf->cur_altsetting;
>  	hdev = interface_to_usbdev(intf);
> +	hcd = bus_to_hcd(hdev->bus);
> +	if (hcd->usb3_no_port) {
> +		dev_warn(&intf->dev, "USB hub has no port\n");
> +		return -ENODEV;
> +	}
>  
>  	/*
>  	 * Set default autosuspend delay as 0 to speedup bus suspend,
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index ef513c2..63b89a4 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -281,6 +281,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>  		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>  				"QUIRK: Resetting on resume");
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
> +	    pdev->device == 0xa23c)
> +		xhci->quirks |= XHCI_USB3_NOPORT;

Can't we just detect this normally that there are no ports for this
device?  Why is the device lying about how many ports it has such that
we have to "override" this?

And again, why not fix this broken hardware?

thanks,

greg k-h
