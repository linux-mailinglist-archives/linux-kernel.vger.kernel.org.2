Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772AA3FF047
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345866AbhIBPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:34:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:14598 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhIBPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630596835; x=1662132835;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JgfkoEk3Oz6MBOFRBUywRBWEVqLOfJf+ZwZeo5Ek0e4=;
  b=b09ppBHVaKA6QtyGvz5q0a48aZXL7hzJ37IsJA7bKr10lgIPaSS40mk+
   QWrV3tEOlYIWpej0sJpTtEeGOZ02LIOm83cZeP+q0tmWL1M1J20VcP7Nx
   lB/Im6DR0lDM0vLqrXX/T7GksWUyMwq09BZ0/mLQ+s3MZ+qHCTXaXPty4
   EaV0BgeOltMGpQJoDD9hE3VgTbV12kvjNXMlCBfEwa5n0epaSe+OR2gAL
   80nJCitXl+b7hWJUuOQ5JoUQbc1BfZ7hOUX/mJ0MPmmcdu1hv0NtfjXD+
   kwwoegSbQMNQKHwKCy36rDIR0j8Pa/pesn2Q34mthLcOQq6g3hFPqe7Gg
   A==;
IronPort-SDR: uBNR4d0uI22mXVpRuiFV8FuOxkLrawOgjTw7WzE5wy1aedemhj4n6evph02MxbpLsDgEakiAsz
 qTBV502NWvCUDS6lauJQv+fkM1ZgG1j2VxAC2L2zhgxbaab0yyDTByRl3W30e1r8fOVde5yrn3
 n/L8eChOvKD35dmrSIPctv4qfLXlBA11Ip789tusDRE16Ed4PGl18aD52zCCSqlIOwoC76huf8
 Zh55nakHpog4s8fpjNjurR57GT9wVMb9e8aKVk0DS+r+WezeD03Q2TrOdwIujfyJS6pOIOgfIY
 lwPdCZcY8l/ZjnQo1CHSHqUX
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="130512848"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2021 08:33:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Sep 2021 08:33:53 -0700
Received: from [10.12.72.121] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 2 Sep 2021 08:33:51 -0700
Subject: Re: [RFC PATCH] USB: host: ehci-atmel: Allow enabling HSIC on SAMA5D2
To:     Alexander Dahl <ada@thorsis.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>,
        Cristian Birsan <Cristian.Birsan@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>
References: <20210823140052.GA120849@rowland.harvard.edu>
 <20210824063702.24586-1-ada@thorsis.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <7c3d1248-b708-68f9-a76a-712e345b8218@microchip.com>
Date:   Thu, 2 Sep 2021 17:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824063702.24586-1-ada@thorsis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 24/08/2021 at 08:37, Alexander Dahl wrote:
> Unlike other SoC series featuring the 'atmel,at91sam9g45-ehci' USB EHCI
> controller, which have embedded USB high-speed transceivers for each
> port, the third port on the SAMA5D2 series is HSIC only.  That HSIC
> interface is not enabled after a power-on reset, but can be enabled by
> setting a flag in a vendor specific EHCI register.
> 
> The register offsets added to the new header file were compared with
> those for the SAM9G45, SAM9X25, SAMA5D3, SAMA5D4, and SAM9X60 series and
> there are no differences in the offsets or contents of those registers.
> Which of those additional vendor specific registers are supported,
> differs by SoC family.  So while the HSIC enable feature is currently
> only present for SAMA5D2, it probably does not hurt to set it on the
> other families, hence no additional check for SoC family here.
> 
> Tested on a custom board featuring a SAMA5D27C-D5M SiP connected to an
> USB3503 hub with an upstream HSIC interface.
> 
> Link: https://community.atmel.com/forum/sama5d2-using-hsic-under-linux
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Sorry for not having coming back to you earlier, summertime...

What you are looking for is what Cristian developed in our "vendor tree" 
and that needs to be "Mainlined":
https://github.com/linux4sam/linux-at91/commit/ca368f544899c14b03df9ce7510684f03acf1bf9

It allows us to have a gigabit Ethernet HSIC connected on our sama5d2 
ICP board. It works well for some time.

For DT, we rely on the standard "phy_type" property set to "hsic" as 
highlighted in this DT node on the ICP board precisely:
https://github.com/linux4sam/linux-at91/blob/master/arch/arm/boot/dts/at91-sama5d2_icp.dts#L766

This way we can use the of_usb_get_phy_mode() standard function:
https://github.com/linux4sam/linux-at91/blob/master/drivers/usb/phy/of.c#L28

All this tells me that I would prefer Cristi's approach. If agreed, 
we'll make sure to make progress on the mainlining part soon.

Hope that it helps. Best regards,
   Nicolas

> ---
> 
> Notes:
>      - for introducing new dt binding, would be nice to convert old one
>        first, probably needs split up and multiple iteration review?
>      - name of that new dt property?
>      - register definitions put to a separate file, like
>        'drivers/usb/host/ehci-fsl.h'
>      - unsure where exactly in the probe process that register write should
>        happen, datasheet gives no hint
>      - should suspend/resume be considered?
> 
>   drivers/usb/host/ehci-atmel.c | 17 +++++++++++++++++
>   drivers/usb/host/ehci-atmel.h | 19 +++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100644 drivers/usb/host/ehci-atmel.h
> 
> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index e893467d659c..f8d9e686c082 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -20,6 +20,7 @@
>   #include <linux/usb/hcd.h>
> 
>   #include "ehci.h"
> +#include "ehci-atmel.h"
> 
>   #define DRIVER_DESC "EHCI Atmel driver"
> 
> @@ -85,6 +86,7 @@ static void atmel_stop_ehci(struct platform_device *pdev)
> 
>   static int ehci_atmel_drv_probe(struct platform_device *pdev)
>   {
> +       struct device_node *np = pdev->dev.of_node;
>          struct usb_hcd *hcd;
>          const struct hc_driver *driver = &ehci_atmel_hc_driver;
>          struct resource *res;
> @@ -149,6 +151,14 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
> 
>          atmel_start_ehci(pdev);
> 
> +       if (of_property_read_bool(np, "atmel,enable-hsic")) {
> +               u32 tmp;
> +
> +               tmp = ehci_readl(ehci, hcd->regs + AT91_UHPHS_INSNREG08);
> +               tmp |= AT91_UHPHS_HSIC_EN;
> +               ehci_writel(ehci, tmp, hcd->regs + AT91_UHPHS_INSNREG08);
> +       }
> +
>          retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
>          if (retval)
>                  goto fail_add_hcd;
> @@ -170,10 +180,17 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
>   static int ehci_atmel_drv_remove(struct platform_device *pdev)
>   {
>          struct usb_hcd *hcd = platform_get_drvdata(pdev);
> +       struct ehci_hcd *ehci;
> +       u32 tmp;
> 
>          usb_remove_hcd(hcd);
>          usb_put_hcd(hcd);
> 
> +       ehci = hcd_to_ehci(hcd);
> +       tmp = ehci_readl(ehci, hcd->regs + AT91_UHPHS_INSNREG08);
> +       tmp &= ~AT91_UHPHS_HSIC_EN;
> +       ehci_writel(ehci, tmp, hcd->regs + AT91_UHPHS_INSNREG08);
> +
>          atmel_stop_ehci(pdev);
> 
>          return 0;
> diff --git a/drivers/usb/host/ehci-atmel.h b/drivers/usb/host/ehci-atmel.h
> new file mode 100644
> index 000000000000..4c4998c2a6dd
> --- /dev/null
> +++ b/drivers/usb/host/ehci-atmel.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Vendor specific definitions for EHCI on Atmel/Microchip SoCs.
> + *
> + * © 2021 Alexander Dahl <ada@thorsis.com>
> + */
> +#ifndef EHCI_ATMEL_H
> +#define EHCI_ATMEL_H
> +
> +/* device specific register offsets, taken from SAMA5D2 datasheet */
> +
> +#define AT91_UHPHS_INSNREG06    0xA8        /* AHB Error Status Register */
> +
> +#define AT91_UHPHS_INSNREG07    0xAC        /* AHB Master Error Address Register */
> +
> +#define AT91_UHPHS_INSNREG08    0xB0        /* HSIC Enable/Disable Register */
> +#define AT91_UHPHS_HSIC_EN      (1 << 2)    /* HSIC Enable/Disable */
> +
> +#endif /* ECHI_ATMEL_H */
> 
> base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
> --
> 2.30.2
> 


-- 
Nicolas Ferre
