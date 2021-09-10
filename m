Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80154072B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhIJUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:50:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46007 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233733AbhIJUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:50:14 -0400
Received: (qmail 50185 invoked by uid 1000); 10 Sep 2021 16:49:01 -0400
Date:   Fri, 10 Sep 2021 16:49:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     cristian.birsan@microchip.com
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        ada@thorsis.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] USB: host: ehci-atmel: Add support for HSIC phy
Message-ID: <20210910204901.GA50170@rowland.harvard.edu>
References: <20210910163842.1596407-1-cristian.birsan@microchip.com>
 <20210910163842.1596407-3-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910163842.1596407-3-cristian.birsan@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 07:38:42PM +0300, cristian.birsan@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Add support for USB Host High Speed Port HSIC phy.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-atmel.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index e893467d659c..05d41fd65f25 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -18,6 +18,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/phy.h>
> +#include <linux/usb/of.h>
>  
>  #include "ehci.h"
>  
> @@ -25,6 +27,9 @@
>  
>  static const char hcd_name[] = "ehci-atmel";
>  
> +#define EHCI_INSNREG(index)			((index) * 4 + 0x90)
> +#define EHCI_INSNREG08_HSIC_EN			BIT(2)
> +
>  /* interface and function clocks */
>  #define hcd_to_atmel_ehci_priv(h) \
>  	((struct atmel_ehci_priv *)hcd_to_ehci(h)->priv)
> @@ -154,6 +159,9 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
>  		goto fail_add_hcd;
>  	device_wakeup_enable(hcd->self.controller);
>  
> +	if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_HSIC)
> +		writel(EHCI_INSNREG08_HSIC_EN, hcd->regs + EHCI_INSNREG(8));
> +
>  	return retval;
>  
>  fail_add_hcd:
> -- 
> 2.25.1
> 
