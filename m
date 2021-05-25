Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9256B38FB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhEYHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhEYHE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:04:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4355D611C9;
        Tue, 25 May 2021 07:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621926210;
        bh=LHxAXrQM3bs4mMPMgzLbnfYyqzVG9guiJIh9pDIPMGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnDS0E8KEpCRsaoGC/T2YzIoUYdhoTr03vmSn81KzVC6ve2JFSguA1U+1fRwMnjJY
         iRxWMHQMAqw7MQAWI2+XGVEkIhdzsFcSm8y4gAXSjQEvDr5/H1T2As3eMin6pFWF/5
         wgdwJaBeSUCSlN4S32TRH+MiKTTZ6tPS7/LnF9RmlT92OQw4cLpi7nWkv6DNZsJ5MU
         aq7KqnX5U+Qwxx0dEZ2+6WLRHN7KHCOpG+Q/gm79nOH8fb5b9QIHfTLhNgNhPFrxVx
         ucAn5CUmxrpvR+eClSDZ+gVh+Gtl3ZflAvWLUEVMxb0wAuwNZ4ExDKJuqVvHZjSHI9
         AgRDK8Ww82Tmg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1llR66-0000Gc-E2; Tue, 25 May 2021 09:03:26 +0200
Date:   Tue, 25 May 2021 09:03:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] USB: serial: omninet: Renaming driver to
 Zyxel omni.net
Message-ID: <YKyhPtVUwdGdXAoq@hovoldconsulting.com>
References: <20210523163522.1690-1-agriveaux@deutnet.info>
 <20210523163522.1690-2-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523163522.1690-2-agriveaux@deutnet.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 06:35:22PM +0200, Alexandre GRIVEAUX wrote:
> With the inclusion of Omni 56K Plus, this driver seem to be more common
> among the family of Zyxel omni modem.

I amended the commit message to make it more clear that you're updating
the driver and module descriptions and not really renaming the driver.

> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> ---
>  drivers/usb/serial/omninet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
> index 8be91f5a4dd7..79c0dab46ae8 100644
> --- a/drivers/usb/serial/omninet.c
> +++ b/drivers/usb/serial/omninet.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * USB ZyXEL omni.net LCD PLUS driver
> + * USB ZyXEL omni.net driver
>   *
>   * Copyright (C) 2013,2017 Johan Hovold <johan@kernel.org>
>   *
> @@ -22,7 +22,7 @@
>  #include <linux/usb/serial.h>
>  
>  #define DRIVER_AUTHOR "Alessandro Zummo"
> -#define DRIVER_DESC "USB ZyXEL omni.net LCD PLUS Driver"
> +#define DRIVER_DESC "USB ZyXEL omni.net Driver"
>  
>  #define ZYXEL_VENDOR_ID		0x0586
>  #define ZYXEL_OMNINET_ID	0x1000
> @@ -52,7 +52,7 @@ static struct usb_serial_driver zyxel_omninet_device = {
>  		.owner =	THIS_MODULE,
>  		.name =		"omninet",
>  	},
> -	.description =		"ZyXEL - omni.net lcd plus usb",
> +	.description =		"ZyXEL - omni.net usb",
>  	.id_table =		id_table,
>  	.num_bulk_out =		2,
>  	.calc_num_ports =	omninet_calc_num_ports,

Now applied.

Johan
