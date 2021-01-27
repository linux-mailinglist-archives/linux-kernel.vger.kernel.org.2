Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95340305F74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhA0PWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343777AbhA0PSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:18:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBD4B20771;
        Wed, 27 Jan 2021 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611760662;
        bh=fKQ9phEJBGCKWL5bWxHuJhsxrJRnN4eJ4TrWBGWB0c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfVLvV839/tSKovtaxiEQZDLDimk65/gYoA5RM6kHYjo7QDI8owajO8HLL+sSZO2r
         F5povjE0De1Z99ESUrIiHrFgSBuBXe3IF34QuET2GuVjgj86gZFuhGDFKG7V8L5pJA
         d+T+BY2laVfQJ0WpHYy9+fwo0cwmF8NSxJHL1L7aoH6T7d8vNbluT//6vqU8NlWBZX
         ORid54/S2A/K2sDwePkMJRebOO2wBlBeg7Q0F1LgGnAN+VTFADrL9TIWt1GklHm+tX
         OdI1BK5Jig4m4zsBZsF++FmEULZqt/FRW67bI38PEAoCM/8BwrUtGxGRkrVG0e6+kk
         vNVXtof7MI1/A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4mZu-00021f-18; Wed, 27 Jan 2021 16:17:54 +0100
Date:   Wed, 27 Jan 2021 16:17:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] usb: misc: trancevibrator: update to use
 usb_control_msg_send()
Message-ID: <YBGEIq/jeqySlfID@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126184010.914841-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126184010.914841-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:10:10AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_send() and the return value checking condition has also
> been modified appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/trancevibrator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
> index a3dfc77578ea..c50807b4f4ef 100644
> --- a/drivers/usb/misc/trancevibrator.c
> +++ b/drivers/usb/misc/trancevibrator.c
> @@ -59,11 +59,11 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
>  	dev_dbg(&tv->udev->dev, "speed = %d\n", tv->speed);
>  
>  	/* Set speed */
> -	retval = usb_control_msg(tv->udev, usb_sndctrlpipe(tv->udev, 0),
> +	retval = usb_control_msg_send(tv->udev, 0,
>  				 0x01, /* vendor request: set speed */
>  				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
>  				 tv->speed, /* speed value */
> -				 0, NULL, 0, USB_CTRL_GET_TIMEOUT);
> +				 0, NULL, 0, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
>  	if (retval) {
>  		tv->speed = old;
>  		dev_dbg(&tv->udev->dev, "retval = %d\n", retval);

While this patch looks correct, the new helpers doesn't really buy us
anything for (OUT) control transfers without a data stage.

Johan
