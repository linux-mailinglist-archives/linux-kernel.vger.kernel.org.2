Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241B640FADA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhIQO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhIQO5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:57:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF3A1611C3;
        Fri, 17 Sep 2021 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631890542;
        bh=yQjwV5l7XrRDfQ9d6R5cRqtrBL6wf3UbBx+EQSAVJGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdCAb8qWo5h99CtMzg4WGTOOYWymsO/2eFVigVRoOt8kW7cPsfc5pZTWA81RInXiD
         7BnboAV9ekw5wNBHc3T9YUHSEYYhrEP85uvmrDja3umU64bAphhR27JNbAPPUZafp1
         XbWNB6u2yqkUJgDiCHU2eIy0fD3ssqo7k3nDFJ+0=
Date:   Fri, 17 Sep 2021 16:55:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 19/19] staging: r8188eu: remove shared buffer for usb
 requests
Message-ID: <YUSsa+3NjQVGD9gb@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-20-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917071837.10926-20-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:18:37AM +0200, Fabio M. De Francesco wrote:
> From: Pavel Skripkin <paskripkin@gmail.com>
> 
> This driver used shared buffer for usb requests. It led to using
> mutexes, i.e no usb requests can be done in parallel.
> 
> USB requests can be fired in parallel since USB Core allows it. In
> order to allow them, remove usb_vendor_req_buf from dvobj_priv (since
> USB I/O is the only user of it) and remove also usb_vendor_req_mutex
> (since there is nothing to protect).

Ah, you are removing this buffer, nice!

But, just because the USB core allows multiple messages to be sent to a
device at the same time, does NOT mean that the device itself can handle
that sort of a thing.

Keeping that lock might be a good idea, until you can prove otherwise.
You never know, maybe there's never any contention at all for it because
these accesses are all done in a serial fashion and the lock
grab/release is instant.  But if that is not the case, you might really
get a device confused here by throwing multiple control messages at it
in ways that it is not set up to handle at all.

So please do not drop the lock.

More comments below.


> 
> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 29 ++++++++-------
>  drivers/staging/r8188eu/include/drv_types.h |  5 ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c   | 40 ++-------------------
>  3 files changed, 16 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 656f3a774e48..0ed4e6c8b1f5 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -19,9 +19,9 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
>  	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
>  		return -EPERM;
>  
> -	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> -
> -	io_buf = dvobjpriv->usb_vendor_req_buf;
> +	io_buf = kmalloc(size, GFP_KERNEL);
> +	if (!io_buf)
> +		return -ENOMEM;

Please read the docs for usb_control_msg_recv().  It can allow data off
of the stack, so no need to allocate/free the buffer like this all the
time.

Note, the usb_control_msg() call does require the data to be allocated
dynamically, like the code does today.  Which is why you probably got
confused here.

Same for usb_control_msg_send(), it can take data off of the stack.


>  
>  	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
>  				      REALTEK_USB_VENQT_READ, addr,
> @@ -39,7 +39,7 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
>  		 * exist or is not enabled.
>  		 */
>  		adapt->bSurpriseRemoved = true;
> -		goto mutex_unlock;
> +		goto end;
>  	}
>  
>  	if (status < 0) {
> @@ -49,15 +49,14 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
>  		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
>  			adapt->bSurpriseRemoved = true;
>  
> -		goto mutex_unlock;
> +		goto end;
>  	}
>  
>  	rtw_reset_continual_urb_error(dvobjpriv);
>  	memcpy(data, io_buf, size);
>  
> -mutex_unlock:
> -	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
> -
> +end:
> +	kfree(io_buf);
>  	return status;
>  }
>  
> @@ -72,9 +71,10 @@ static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
>  	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
>  		return -EPERM;
>  
> -	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> +	io_buf = kmalloc(size, GFP_KERNEL);
> +	if (!io_buf)
> +		return -ENOMEM;
>  
> -	io_buf = dvobjpriv->usb_vendor_req_buf;
>  	memcpy(io_buf, data, size);
>  
>  	status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> @@ -93,7 +93,7 @@ static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
>  		 * exist or is not enabled.
>  		 */
>  		adapt->bSurpriseRemoved = true;
> -		goto mutex_unlock;
> +		goto end;
>  	}
>  
>  	if (status < 0) {
> @@ -103,14 +103,13 @@ static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
>  		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
>  			adapt->bSurpriseRemoved = true;
>  
> -		goto mutex_unlock;
> +		goto end;
>  	}
>  
>  	rtw_reset_continual_urb_error(dvobjpriv);
>  
> -mutex_unlock:
> -	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
> -
> +end:
> +	kfree(io_buf);
>  	return status;
>  }
>  
> diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
> index 626c6273be6f..499b2bce8cbe 100644
> --- a/drivers/staging/r8188eu/include/drv_types.h
> +++ b/drivers/staging/r8188eu/include/drv_types.h
> @@ -168,11 +168,6 @@ struct dvobj_priv {
>  	int	ep_num[5]; /* endpoint number */
>  	int	RegUsbSS;
>  	struct semaphore usb_suspend_sema;
> -	struct mutex  usb_vendor_req_mutex;
> -
> -	u8 *usb_alloc_vendor_req_buf;
> -	u8 *usb_vendor_req_buf;

I do like removing these buffers, and I think that is all that this
change should be doing.

thanks,

greg k-h
