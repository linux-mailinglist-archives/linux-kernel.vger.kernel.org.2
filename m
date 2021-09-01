Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189003FE034
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbhIAQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:42:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52511 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S245557AbhIAQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:42:06 -0400
Received: (qmail 406198 invoked by uid 1000); 1 Sep 2021 12:41:07 -0400
Date:   Wed, 1 Sep 2021 12:41:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     neal_liu <neal_liu@aspeedtech.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Message-ID: <20210901164107.GD404634@rowland.harvard.edu>
References: <20210901035041.10810-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901035041.10810-1-neal_liu@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:50:41AM +0800, neal_liu wrote:
> Retitle.
> 
> For Aspeed, HCHalted status depends on not only Run/Stop but also
> ASS/PSS status.
> Handshake CMD_RUN on startup instead.
> 
> Signed-off-by: neal_liu <neal_liu@aspeedtech.com>

I'm still a little doubtful about doing this, but if you guys say it works 
for your hardware then I guess it's okay.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
>  drivers/usb/host/ehci-platform.c |  6 ++++++
>  drivers/usb/host/ehci.h          |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 10b0365f3439..01c022e46aa2 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
>  	/* Wait until HC become operational */
>  	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
>  	msleep(5);
> -	rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 * 1000);
> +
> +	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
> +	 * Skip this check on startup.
> +	 */
> +	if (ehci->is_aspeed)
> +		rc = ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> +				    1, 100 * 1000);
> +	else
> +		rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> +				    0, 100 * 1000);
>  
>  	up_write(&ehci_cf_port_reset_rwsem);
>  
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index c70f2d0b4aaf..c3dc906274d9 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -297,6 +297,12 @@ static int ehci_platform_probe(struct platform_device *dev)
>  					  "has-transaction-translator"))
>  			hcd->has_tt = 1;
>  
> +		if (of_device_is_compatible(dev->dev.of_node,
> +					    "aspeed,ast2500-ehci") ||
> +		    of_device_is_compatible(dev->dev.of_node,
> +					    "aspeed,ast2600-ehci"))
> +			ehci->is_aspeed = 1;
> +
>  		if (soc_device_match(quirk_poll_match))
>  			priv->quirk_poll = true;
>  
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index 80bb823aa9fe..fdd073cc053b 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -219,6 +219,7 @@ struct ehci_hcd {			/* one per controller */
>  	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
>  	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
>  	unsigned		spurious_oc:1;
> +	unsigned		is_aspeed:1;
>  
>  	/* required for usb32 quirk */
>  	#define OHCI_CTRL_HCFS          (3 << 6)
> -- 
> 2.17.1
> 
