Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0275040FAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhIQOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhIQOve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF81760F9C;
        Fri, 17 Sep 2021 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631890212;
        bh=zubLP971iOX8gWb78yB2Doy9I5T1kA3TTj/1cuEVvXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlfdwRXobGJ+BuW0K12yOOYHR9W/Y1s4t6j3vc4T42jO20PJw7GOQHNPvV2ncvvj+
         8isMWbH3FTBDlq17bm/146GEV0VqZIFzxWCrZdUZwRKgBfUew96pNyOI6bGafbvHmq
         VMnwsUgfbxld0yOk9bMefA6ZeVW6+T+Gko/68hSg=
Date:   Fri, 17 Sep 2021 16:50:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 17/19] staging: r8188eu: shorten calls chain of
 rtw_read{8,16,32}()
Message-ID: <YUSrIqW5WSYuoa14@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-18-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210917071837.10926-18-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:18:35AM +0200, Fabio M. De Francesco wrote:
> Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> For this purpose unify the three usb_read8/16/32 into the new
> usb_read(); make the latter parameterizable with 'size'; embed most of
> the code of usbctrl_vendorreq() into usb_read() and use in it the new
> usb_control_msg_recv() API of USB Core.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 59 +++++++++++++++++++--
>  1 file changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 2d5e9b3ba538..ef35358cf2d3 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -89,6 +89,59 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  	return status;
>  }
>  
> +static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
> +{
> +	struct adapter *adapt = intfhdl->padapter;
> +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> +	struct usb_device *udev = dvobjpriv->pusbdev;
> +	int status;
> +	u8 *io_buf; /* Pointer to I/O buffer */

As you "know" size is not going to be larger than 4 (hint, you should
prboably check it), just use bytes off of the stack here, and you can
ignore this buffer entirely.  That will hopefully allow you in the
future to get rid of that buffer as odds are it will not be needed
anymore.

> +
> +	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
> +		return -EPERM;

How is it ok to check this outside of the lock?  What happens if these
values change right _after_ you check them?

Why check them at all, is this something that we even care about?

I know you are trying to make this just the same logic at is there
today, but why not just do it right the first time?

> +
> +	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> +
> +	io_buf = dvobjpriv->usb_vendor_req_buf;
> +
> +	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> +				      REALTEK_USB_VENQT_READ, addr,
> +				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
> +				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
> +				      GFP_KERNEL);
> +
> +	if (status == -ESHUTDOWN ||
> +	    status == -ENODEV ||
> +	    status == -ENOENT) {
> +		/*
> +		 * device or controller has been disabled due to
> +		 * some problem that could not be worked around,
> +		 * device or bus doesn’t exist, endpoint does not
> +		 * exist or is not enabled.
> +		 */
> +		adapt->bSurpriseRemoved = true;
> +		goto mutex_unlock;
> +	}
> +
> +	if (status < 0) {
> +		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =
> +			USB_VEN_REQ_CMD_FAIL;
> +
> +		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
> +			adapt->bSurpriseRemoved = true;
> +
> +		goto mutex_unlock;
> +	}
> +
> +	rtw_reset_continual_urb_error(dvobjpriv);
> +	memcpy(data, io_buf, size);
> +
> +mutex_unlock:
> +	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
> +
> +	return status;

No one cares about this value, is that ok?

thanks,

greg k-h
