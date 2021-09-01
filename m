Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F73FD3AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbhIAGIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242085AbhIAGIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1356601FF;
        Wed,  1 Sep 2021 06:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630476476;
        bh=No6ncwSGz8o2JhsYuJWAErOYKNB3kmd3bp4xzS8BY1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNEx/JfF2ABQ/F/3v60AiG0nGk9i76q3ZRQ2YknnYz8ks4krQqhvnIqTSsLoQ0Zsd
         S8RVoWeDn9TsA4VJJmJbJXnKiT/+QMlW+zY2Q3QMlylhjhzjihcG3k2Lvu2X0fuzap
         3oGQEH0v//D72aLY1XCbXPpxZ02x/XtMtCIDd5cs=
Date:   Wed, 1 Sep 2021 08:07:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     neal_liu <neal_liu@aspeedtech.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Message-ID: <YS8YuX9laah5d/NY@kroah.com>
References: <20210901035041.10810-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901035041.10810-1-neal_liu@aspeedtech.com>
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

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
