Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34127408A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbhIMLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:40:49 -0400
Received: from mail.thorsis.com ([92.198.35.195]:40947 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234635AbhIMLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:40:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 1B09BEB0;
        Mon, 13 Sep 2021 13:39:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FWrQzF6qtVib; Mon, 13 Sep 2021 13:39:31 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 132561FEE; Mon, 13 Sep 2021 13:39:28 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: microchip.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
From:   Alexander Dahl <ada@thorsis.com>
To:     cristian.birsan@microchip.com
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] USB: host: ehci-atmel: Add support for HSIC phy
Date:   Mon, 13 Sep 2021 13:39:22 +0200
Message-ID: <2607416.cmL5XOGpRJ@ada>
In-Reply-To: <20210910163842.1596407-3-cristian.birsan@microchip.com>
References: <20210910163842.1596407-1-cristian.birsan@microchip.com> <20210910163842.1596407-3-cristian.birsan@microchip.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

Am Freitag, 10. September 2021, 18:38:42 CEST schrieb 
cristian.birsan@microchip.com:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Add support for USB Host High Speed Port HSIC phy.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
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
> @@ -154,6 +159,9 @@ static int ehci_atmel_drv_probe(struct platform_device
> *pdev) goto fail_add_hcd;
>  	device_wakeup_enable(hcd->self.controller);
> 
> +	if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_HSIC)
> +		writel(EHCI_INSNREG08_HSIC_EN, hcd->regs + EHCI_INSNREG(8));
> +
>  	return retval;
> 
>  fail_add_hcd:

Tested-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex



