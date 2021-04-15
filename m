Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEA360C12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhDOOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:43:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36517 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233201AbhDOOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:43:47 -0400
Received: (qmail 1532564 invoked by uid 1000); 15 Apr 2021 10:43:23 -0400
Date:   Thu, 15 Apr 2021 10:43:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [RFC PATCH] USB:XHCI:skip hub registration
Message-ID: <20210415144323.GC1530055@rowland.harvard.edu>
References: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 08:22:38PM +0800, Longfang Liu wrote:
> When the number of ports on the USB hub is 0, skip the registration
> operation of the USB hub.
> 
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

The objections that Greg raised are all good ones.

But even aside from them, this patch doesn't actually do what the 
description says.  The patch doesn't remove the call to usb_add_hcd 
for the USB-3 bus.  If you simply skipped that call (and the 
corresponding call to usb_remove_hcd) when there are no 
ports on the root hub, none of the stuff in this patch would be needed.

Alan Stern

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
>  }
>  
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index bee5dec..e3e3573 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5184,6 +5184,11 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>  		/* xHCI private pointer was set in xhci_pci_probe for the second
>  		 * registered roothub.
>  		 */
> +		if (xhci->quirks & XHCI_USB3_NOPORT) {
> +			xhci_info(xhci, "xHCI host has no port\n");
> +			hcd->usb3_no_port = 1;
> +		}
> +
>  		return 0;
>  	}
>  
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 2c6c4f8..d3c658f 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1874,6 +1874,7 @@ struct xhci_hcd {
>  #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
>  #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
>  #define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
> +#define XHCI_USB3_NOPORT	BIT_ULL(37)
>  
>  	unsigned int		num_active_eps;
>  	unsigned int		limit_active_eps;
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 3dbb42c..7df23a0f 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -172,6 +172,7 @@ struct usb_hcd {
>  	unsigned		tpl_support:1; /* OTG & EH TPL support */
>  	unsigned		cant_recv_wakeups:1;
>  			/* wakeup requests from downstream aren't received */
> +	unsigned		usb3_no_port:1; /* xHCI main_hcd has no port */
>  
>  	unsigned int		irq;		/* irq allocated */
>  	void __iomem		*regs;		/* device memory/io */
> -- 
> 2.8.1
> 
