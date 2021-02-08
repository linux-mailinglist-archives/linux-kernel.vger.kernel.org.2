Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058CF313BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhBHRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBHPdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:33:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D260764E30;
        Mon,  8 Feb 2021 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612798119;
        bh=E7hU2wEwkcreSsMPj7hBL43uJ3QeTlwgc/mdeP/tNz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwKpXfWlnBjmXoMGfiMTArXWSorGJf4lwq5D3KZk1oYvtxD0whPof+fZ+0UDKbCht
         2EgEmF+2LB0GHQseKAPlSvUA/u19Scd2N9QHBNVQqw8yoV5EPFBXfETnfbj2LMpwYT
         TvsQjvB/AA8mo2RNMpLYrxa4zuUJA5l4DzSweJwRs9Wse47/0KwfZapIIGqZp9eSD0
         2EGdXir1RCmNksgEb/uGw3UNfvp8fdOWYht14dMtE4dUNsDrRkTB/TATWXlkSq0FWq
         6/posQ67uzYk5Y5EC0WCSDS/TomEIP5IwmaBm6zdn1gMMfEmc0vOQKZu04FxRvYIFu
         JBMYvCbIf4m9Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l98T8-0003zs-1b; Mon, 08 Feb 2021 16:28:54 +0100
Date:   Mon, 8 Feb 2021 16:28:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] USB: serial: Drop if with an always false
 condition
Message-ID: <YCFYtv/yC124CTaR@hovoldconsulting.com>
References: <20210208143149.963644-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208143149.963644-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:31:48PM +0100, Uwe Kleine-König wrote:
> In a bus remove function the passed device is always valid, so there is
> no need to check for it being NULL.
> 
> (Side note: The check for port being non-NULL is broken anyhow, because
> to_usb_serial_port() is a wrapper around container_of() for a member that is
> not the first one. So port can hardly become NULL.)

Right, this check was just broken. I don't think it was even intended to
catch a NULL struct device pointer. Note that there's two more in
match() and probe() that I'll remove in a follow up.

> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  drivers/usb/serial/bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
> index eb0195cf37dd..d862ed656414 100644
> --- a/drivers/usb/serial/bus.c
> +++ b/drivers/usb/serial/bus.c
> @@ -87,15 +87,11 @@ static int usb_serial_device_probe(struct device *dev)
>  static int usb_serial_device_remove(struct device *dev)
>  {
>  	struct usb_serial_driver *driver;
> -	struct usb_serial_port *port;
> +	struct usb_serial_port *port = to_usb_serial_port(dev);
>  	int retval = 0;
>  	int minor;
>  	int autopm_err;
>  
> -	port = to_usb_serial_port(dev);
> -	if (!port)
> -		return -ENODEV;
> -
>  	/*
>  	 * Make sure suspend/resume doesn't race against port_remove.
>  	 *
> 
> base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e

Both patches now applied, thanks.

Johan
