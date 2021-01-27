Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2408D305E21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhA0OWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhA0OWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:22:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0075F206C2;
        Wed, 27 Jan 2021 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611757299;
        bh=h4KlcOqVpt+f7NayTo74/7IODdEHC+WplK/87YEXFY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+BAR4Z2Pu7DB0HXkvxM8DQQPBVAvjYbjZNjN0spoa7Ztki/hQ424j+lXdArN+uEw
         BhQ1CNUU3mfWmpwfcUOBE712yPuI85fwfJI5KKgsCtLkRS/e/b2egGbOGR/l2/mCyt
         Z9SeVCTp7hhFFuFz0IEEbva52Udw6SZkDNeYB+pYsBXFUhaVbPsb3CbPcxTd1aOWJE
         PKMPVG4hwpC0AI78K8KvRW5DL3WJwMNEykMtAY8Nx3WwpaGejWeQlsrHDJj8kCjGaK
         C9yOw7ik0PeNrT18U0pg35wBODeNkkyCM2wDOr4x2NsJvNZxxj39MYZQPOXjvgaM3V
         42+xI7VxayVEQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4lhe-0001py-TN; Wed, 27 Jan 2021 15:21:50 +0100
Date:   Wed, 27 Jan 2021 15:21:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/12] usb: misc: cytherm: update to use
 usb_control_msg_recv()
Message-ID: <YBF2/qHqa7+s9+5d@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-4-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126183403.911653-4-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:54AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_recv().
> 
> The return value checking enforced by callers of the updated function have
> also been appropriately updated.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/cytherm.c | 128 +++++++++++++------------------------
>  1 file changed, 43 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/usb/misc/cytherm.c b/drivers/usb/misc/cytherm.c
> index 3e3802aaefa3..2ca36ea5b76a 100644
> --- a/drivers/usb/misc/cytherm.c
> +++ b/drivers/usb/misc/cytherm.c
> @@ -51,12 +51,12 @@ static int vendor_command(struct usb_device *dev, unsigned char request,
>  			  unsigned char value, unsigned char index,
>  			  void *buf, int size)
>  {
> -	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -			       request, 
> -			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> -			       value, 
> -			       index, buf, size,
> -			       USB_CTRL_GET_TIMEOUT);
> +	return usb_control_msg_recv(dev, 0,
> +				    request,
> +				    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> +				    value,
> +				    index, buf, size,
> +				    USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
>  }
>  
>  
> @@ -78,33 +78,27 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *att
>  	struct usb_interface *intf = to_usb_interface(dev);
>  	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
>  
> -	unsigned char *buffer;
> +	unsigned char buffer[8];
>  	int retval;
> -   
> -	buffer = kmalloc(8, GFP_KERNEL);
> -	if (!buffer)
> -		return 0;
>  
>  	cytherm->brightness = simple_strtoul(buf, NULL, 10);
> -   
> +
>  	if (cytherm->brightness > 0xFF)
>  		cytherm->brightness = 0xFF;
>  	else if (cytherm->brightness < 0)
>  		cytherm->brightness = 0;
> -   
> +
>  	/* Set brightness */
>  	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS, 
> -				cytherm->brightness, buffer, 8);
> -	if (retval)
> -		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
> +				cytherm->brightness, &buffer, 8);
> +	if (!retval)
> +		dev_dbg(&cytherm->udev->dev, "brightness set correctly\n");
>  	/* Inform µC that we have changed the brightness setting */
>  	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS_SEM,
> -				0x01, buffer, 8);
> -	if (retval)
> -		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
> -   
> -	kfree(buffer);
> -   
> +				0x01, &buffer, 8);
> +	if (!retval)
> +		dev_dbg(&cytherm->udev->dev, "µC informed of change in brightness setting\n");
> +
>  	return count;
>  }

This driver looks like it could have the same origin as the one touched
by the previous patch, and likewise this patch suffers from a similar
problem in that the driver always provides an 8-byte buffer but appears
to expect short reads (which would no be treated as errors).

You could consider adding the missing short read sanity checks, but
I'm afraid the new helpers are not a good fit here either.

Johan
