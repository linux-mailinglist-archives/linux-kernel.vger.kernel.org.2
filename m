Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0B31857D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBKG7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhBKG7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:59:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB9864DBD;
        Thu, 11 Feb 2021 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613026706;
        bh=T6VVnDDvYITb11F5FAe5DP7RfwvRM0uYGlboSDsTbfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V++EvLxj2ltRjen3B4FrdawdfznB9NaHwJsxkkoHxonfh8Dywq1mD8Yl7ZHYgZDoA
         pE6YCvTD28KzVMXw4j1/vbObjxmSZYRZTozgz66b/Eyb/w5ekF2zsmBD5WTl5XX5h0
         8dE1vCbXHzwnwmaY4r7oCV1IieMwLwbhIKh3oNMA=
Date:   Thu, 11 Feb 2021 07:58:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v5 3/4] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <YCTVjx480BzT+saO@kroah.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:10:38AM -0800, Matthias Kaehlcke wrote:
> Check during probe() if a hub supported by the onboard_usb_hub
> driver is connected to the controller. If such a hub is found
> create the corresponding platform device. This requires the
> device tree to have a node for the hub with its vendor and
> product id (which is not common for USB devices). Further the
> platform device is only created when CONFIG_USB_ONBOARD_HUB=y/m.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v5:
> - patch added to the series
> 
>  drivers/usb/host/xhci-plat.c | 16 ++++++++++++++++
>  include/linux/usb/hcd.h      |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 4d34f6005381..e785fa109eea 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/usb/onboard_hub.h>
>  #include <linux/usb/phy.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -184,6 +185,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	int			ret;
>  	int			irq;
>  	struct xhci_plat_priv	*priv = NULL;
> +	struct device_node	*np;
>  
>  
>  	if (usb_disabled())
> @@ -356,6 +358,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	 */
>  	pm_runtime_forbid(&pdev->dev);
>  
> +	np = usb_of_get_device_node(hcd->self.root_hub, hcd->self.busnum);
> +	if (np && of_is_onboard_usb_hub(np)) {
> +		struct platform_device *pdev;
> +
> +		pdev = of_platform_device_create(np, NULL, NULL);

A platform device is a child of another platform device?  Ok, but
really, why?  What uses this device?

thanks,

greg k-h
