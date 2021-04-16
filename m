Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593D36192B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhDPFRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234886AbhDPFQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9A5B610FB;
        Fri, 16 Apr 2021 05:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618550195;
        bh=BBtGGf3ANCNgEB8oOFtBzS4am3atW0oPfW8UZjM5cxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNRg/Tl/ID0HMReqzdPW9xRBTtbebfW9yMyetgLpzRh7rgXzdmWifsGQ5r4vHcfxH
         MX7X6eacpB2y8/qA/J4zzbFNtIuKwyJowLH97tBq62yjsWqV1oS8rszoOM/OzBojNI
         ogUR1xvlHEzm0qPmjozIz8ylygQDTt9sZHboJAmo=
Date:   Fri, 16 Apr 2021 07:16:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [RFC PATCH] USB:XHCI:skip hub registration
Message-ID: <YHkdsMR7E2Dr7QTc@kroah.com>
References: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
 <YHgy0jqLE0WAxA+2@kroah.com>
 <973a4759-4464-e59e-f84b-15672503e290@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <973a4759-4464-e59e-f84b-15672503e290@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:43:34AM +0800, liulongfang wrote:
> On 2021/4/15 20:34, Greg KH wrote:
> > On Thu, Apr 15, 2021 at 08:22:38PM +0800, Longfang Liu wrote:
> >> When the number of ports on the USB hub is 0, skip the registration
> >> operation of the USB hub.
> > 
> > That's crazy.  Why not fix the hardware?  How has this hub passed the
> > USB certification process?
> > 
> >> The current Kunpeng930's XHCI hardware controller is defective. The number
> >> of ports on its USB3.0 bus controller is 0, and the number of ports on
> >> the USB2.0 bus controller is 1.
> >>
> >> In order to solve this problem that the USB3.0 controller does not have
> >> a port which causes the registration of the hub to fail, this patch passes
> >> the defect information by adding flags in the quirks of xhci and usb_hcd,
> >> and finally skips the registration process of the hub directly according
> >> to the results of these flags when the hub is initialized.
> >>
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  drivers/usb/core/hub.c      | 6 ++++++
> >>  drivers/usb/host/xhci-pci.c | 4 ++++
> >>  drivers/usb/host/xhci.c     | 5 +++++
> >>  drivers/usb/host/xhci.h     | 1 +
> >>  include/linux/usb/hcd.h     | 1 +
> >>  5 files changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> >> index b1e14be..2d6869d 100644
> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -1769,9 +1769,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
> >>  	struct usb_host_interface *desc;
> >>  	struct usb_device *hdev;
> >>  	struct usb_hub *hub;
> >> +	struct usb_hcd *hcd;
> >>  
> >>  	desc = intf->cur_altsetting;
> >>  	hdev = interface_to_usbdev(intf);
> >> +	hcd = bus_to_hcd(hdev->bus);
> >> +	if (hcd->usb3_no_port) {
> >> +		dev_warn(&intf->dev, "USB hub has no port\n");
> >> +		return -ENODEV;
> >> +	}
> >>  
> >>  	/*
> >>  	 * Set default autosuspend delay as 0 to speedup bus suspend,
> >> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> >> index ef513c2..63b89a4 100644
> >> --- a/drivers/usb/host/xhci-pci.c
> >> +++ b/drivers/usb/host/xhci-pci.c
> >> @@ -281,6 +281,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
> >>  	if (xhci->quirks & XHCI_RESET_ON_RESUME)
> >>  		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
> >>  				"QUIRK: Resetting on resume");
> >> +
> >> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
> >> +	    pdev->device == 0xa23c)
> >> +		xhci->quirks |= XHCI_USB3_NOPORT;
> > 
> > Can't we just detect this normally that there are no ports for this
> > device?  Why is the device lying about how many ports it has such that
> > we have to "override" this?
> > 
> 
> The hub driver will check the port number in prob(). If there is no port,
> the driver will report an error log. But we hope this defective device
> does not print error log.

Defective devices deserve to have errors sent to the error log,
otherwise how will people know to tell the companies to fix them?

Again, this device can not pass USB certification, so there's not much
we should do to work around that, right?

thanks,

greg k-h
