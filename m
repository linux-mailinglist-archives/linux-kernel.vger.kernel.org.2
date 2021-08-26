Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D033F8B07
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbhHZP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:29:20 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52701 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S242936AbhHZP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:29:13 -0400
Received: (qmail 230582 invoked by uid 1000); 26 Aug 2021 11:28:24 -0400
Date:   Thu, 26 Aug 2021 11:28:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     neal_liu <neal_liu@aspeedtech.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] usb: host: ehci: skip STS_HALT check for aspeed platform
Message-ID: <20210826152824.GC228824@rowland.harvard.edu>
References: <20210826071525.27651-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826071525.27651-1-neal_liu@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 03:15:25PM +0800, neal_liu wrote:
> STS_HALT also depends on ASS/PSS status for apseed.
> Skip this check on startup.
> 
> Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/host/ehci-hcd.c      | 10 +++++++++-
>  drivers/usb/host/ehci-platform.c |  6 ++++++
>  drivers/usb/host/ehci.h          |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 10b0365f3439..a539e11502ef 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -634,7 +634,15 @@ static int ehci_run (struct usb_hcd *hcd)
>  	/* Wait until HC become operational */
>  	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
>  	msleep(5);
> -	rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 * 1000);
> +
> +	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
> +	 * Skip this check on startup.
> +	 */
> +	if (ehci->is_aspeed)
> +		rc = 0;
> +	else
> +		rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> +				    0, 100 * 1000);

You must not do this.  You are assuming the controller will always begin 
operating within 5 ms of the time it is told to start.  What happens if you are 
wrong?

There must be some way for the aspeed controller's host computer to tell when 
the controller has started running.  Find out what it is and use it.

Alan Stern
