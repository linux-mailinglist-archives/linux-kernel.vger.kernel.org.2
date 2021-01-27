Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB62305DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhA0OBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhA0N7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:59:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8F3F20799;
        Wed, 27 Jan 2021 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611755910;
        bh=AYnsY4A9NU7cUGzzC6sIeWsxQPYEaH9aYV5S2LGSJIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncBw+ChDvsI14iG8/6NIL7fZCtoMrWYKP/lcn4OMkmVM9wdWZF9HniQ8zGVe/EDJ6
         cdFp6DtV3FopiZlLpTa8B2de4luwq6EMQs18bpXm8CvfnxTrSpSgynna6Mg3wgNYAi
         I3tw+InaXONAQkqrBL8tG5zgFxR1jJHcWHvx59c1xRT2IUSd/nXIpK7x/rE29f63hk
         dwRAP+popk6muGfaEWKk0u8bbBKZWmn0W+fKtBYmecpTt/lujk83ULOYZzPpRIjYna
         cyVKyrryM0jN2z0ncZrUeBMm8NrlcyQiJWbLqbWttL2bwnEgp23Sn87zxkMFLmaA5K
         TiBbBSoFp+2wQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4lLF-0001lj-RZ; Wed, 27 Jan 2021 14:58:42 +0100
Date:   Wed, 27 Jan 2021 14:58:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Liu Shixin <liushixin2@huawei.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] usb: misc: appledisplay: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <YBFxkSlWPQRMuaGo@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-2-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-2-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:52AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated

As I mentioned in my comments on v2, a short write has always been
treated as an error so you shouldn't imply that it wasn't here (and in
the other commit messages).

> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_{recv|send}(), and all return value checking
> conditions have also been modified appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/appledisplay.c | 46 ++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
> index c8098e9b432e..117deb2fdc29 100644
> --- a/drivers/usb/misc/appledisplay.c
> +++ b/drivers/usb/misc/appledisplay.c
> @@ -132,21 +132,17 @@ static int appledisplay_bl_update_status(struct backlight_device *bd)
>  	pdata->msgdata[0] = 0x10;
>  	pdata->msgdata[1] = bd->props.brightness;
>  
> -	retval = usb_control_msg(
> -		pdata->udev,
> -		usb_sndctrlpipe(pdata->udev, 0),
> -		USB_REQ_SET_REPORT,
> -		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -		ACD_USB_BRIGHTNESS,
> -		0,
> -		pdata->msgdata, 2,

In this case, the buffer is already DMA-able (and is in fact only used
for this purpose) so this patch introduces an extra allocation and
memcpy for no really good reason.

> -		ACD_USB_TIMEOUT);
> +	retval = usb_control_msg_send(pdata->udev,
> +				      0,
> +				      USB_REQ_SET_REPORT,
> +				      USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +				      ACD_USB_BRIGHTNESS,
> +				      0,
> +				      pdata->msgdata, 2,
> +				      ACD_USB_TIMEOUT, GFP_KERNEL);
>  	mutex_unlock(&pdata->sysfslock);
>  
> -	if (retval < 0)
> -		return retval;
> -	else
> -		return 0;
> +	return retval;
>  }
>  
>  static int appledisplay_bl_get_brightness(struct backlight_device *bd)
> @@ -155,21 +151,17 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
>  	int retval, brightness;
>  
>  	mutex_lock(&pdata->sysfslock);
> -	retval = usb_control_msg(
> -		pdata->udev,
> -		usb_rcvctrlpipe(pdata->udev, 0),
> -		USB_REQ_GET_REPORT,
> -		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -		ACD_USB_BRIGHTNESS,
> -		0,
> -		pdata->msgdata, 2,
> -		ACD_USB_TIMEOUT);
> -	if (retval < 2) {
> -		if (retval >= 0)
> -			retval = -EMSGSIZE;
> -	} else {
> +	retval = usb_control_msg_recv(pdata->udev,
> +				      0,
> +				      USB_REQ_GET_REPORT,
> +				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +				      ACD_USB_BRIGHTNESS,
> +				      0,
> +				      pdata->msgdata, 2,
> +				      ACD_USB_TIMEOUT, GFP_KERNEL);
> +	if (retval == 0)
>  		brightness = pdata->msgdata[1];
> -	}
> +

Same here, this introduces an extra allocation and memcpy and the only
thing you gain is essentially the removal of the two lines for handling
a short read.

>  	mutex_unlock(&pdata->sysfslock);
>  
>  	if (retval < 0)

I'd consider dropping this one as well.

Johan
