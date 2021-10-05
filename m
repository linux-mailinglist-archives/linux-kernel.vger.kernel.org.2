Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C824422CB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhJEPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235510AbhJEPkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:40:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65FCB60F9D;
        Tue,  5 Oct 2021 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633448335;
        bh=pBSidePIZmv7cMKM71ZiKSTLg+cBESHQ6KdxPlo5gw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPfYcbO1PGWwXe7yY2YM48mc/C0B5n1e7SHbjLCYUxlTn3/d1A9PS0W9hqJlED0Tk
         z0qldShdGSj7bFaK19dpf2M3EXZln+GxvSElqYce0aqB14M4xan9gk0x1GpsJAolhG
         DsK7UGKrSwOvyLGsgM6gKDKJb3peOUTbxGjzMqGw=
Date:   Tue, 5 Oct 2021 17:38:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: hub: improve port over-current alert msg
Message-ID: <YVxxjUZDh8abDNjc@kroah.com>
References: <20211005151644.288932-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005151644.288932-1-f.suligoi@asem.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 05:16:44PM +0200, Flavio Suligoi wrote:
> At the moment the port over-current message is
> displayed only if the over-current condition is permanent.
> 
> But in case of permanent short-circuit or
> over-current, some USB power-distribution switches
> (such as the TPS20xx, etc.), after the over-current
> detection and the consequent shutdown, return
> in the normal state.

Please use the full 72 columns of the changelog text.


> 
> So, in these cases, the over-current error message
> never appears.
> 
> To overcome this problem, the "over-current condition"
> message is displayed even after some over-current events.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  arch/arm64/boot/dts/Makefile | 1 +
>  drivers/usb/core/hub.c       | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 639e01a4d855..bf26ce60d78a 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -8,6 +8,7 @@ subdir-y += amlogic
>  subdir-y += apm
>  subdir-y += apple
>  subdir-y += arm
> +subdir-y += asem
>  subdir-y += bitmain
>  subdir-y += broadcom
>  subdir-y += cavium

I do not think this change is part of this :(

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 86658a81d284..ff6c8e0e2673 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5577,7 +5577,8 @@ static void port_event(struct usb_hub *hub, int port1)
>  		msleep(100);	/* Cool down */
>  		hub_power_on(hub, true);
>  		hub_port_status(hub, port1, &status, &unused);
> -		if (status & USB_PORT_STAT_OVERCURRENT)
> +		if ((status & USB_PORT_STAT_OVERCURRENT) ||
> +		    !(port_dev->over_current_count % 15))

What is 15?

>  			dev_err(&port_dev->dev, "over-current condition\n");
>  	}
>  
> @@ -5738,7 +5739,7 @@ static void hub_event(struct work_struct *work)
>  			u16 status = 0;
>  			u16 unused;
>  
> -			dev_dbg(hub_dev, "over-current change\n");
> +			dev_info(hub_dev, "over-current change\n");

This is just going to be noisy, what can a user do with this?

thanks,

greg k-h
