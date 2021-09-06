Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE0401CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbhIFOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242760AbhIFOId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:08:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DC1F60295;
        Mon,  6 Sep 2021 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630937248;
        bh=suG3xSGw5ooBqY20FWEKzQb3ctJT1m9GA/CIcKz/Ka8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=km2jDDMe2Jas52qfgtRwyar9kVE0ajhbnXR3CQFeesC88meBCz+GlDxxrgcyxgwo4
         N7DGnP2/p9MtrOMTjhX8sCiFsk22mVvNKyrI+F/+TFNY87NDvFeLgp3cvwad5cVs0H
         fRdTesrWh2Qg51JfNOkLdfkUiwicrK5lHLrrOsVQ=
Date:   Mon, 6 Sep 2021 16:07:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: r8188eu: Shorten calls chain of
 rtw_read8/16/32()
Message-ID: <YTYgnrvwxNt4+CvR@kroah.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904220048.12822-3-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 12:00:47AM +0200, Fabio M. De Francesco wrote:
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
> 
> v2->v3: No changes.
> 
> v1->v2: No changes.
> 
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 92 +++++++++++++++++----
>  1 file changed, 78 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a87b0d2e87d0..f9c4fd5a2c53 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -97,38 +97,102 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>  	return status;
>  }
>  
> +static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
> +{
> +	u16 value = (u16)(addr & 0x0000ffff);

Why not just pass in the address as a 16bit value?


> +	struct adapter *adapt = intfhdl->padapter;
> +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> +	struct usb_device *udev = dvobjpriv->pusbdev;
> +	int status;
> +	u8 *io_buf;
> +	int vendorreq_times = 0;
> +
> +	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
> +		status = -EPERM;
> +		goto exit;

This is "interesting" to see if it's really even working as they think
it does, but let's leave it alone for now...

> +	}
> +
> +	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> +
> +	/*  Acquire IO memory for vendorreq */
> +	io_buf = dvobjpriv->usb_vendor_req_buf;
> +
> +	if (!io_buf) {
> +		DBG_88E("[%s] io_buf == NULL\n", __func__);

How can this buffer ever be NULL?

> +		status = -ENOMEM;
> +		goto release_mutex;
> +	}

Why share a buffer at all anyway?

> +	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> +		status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> +					      REALTEK_USB_VENQT_READ, value,
> +					      REALTEK_USB_VENQT_CMD_IDX, io_buf,
> +					      size, RTW_USB_CONTROL_MSG_TIMEOUT,
> +					      GFP_KERNEL);
> +		if (!status) {   /*  Success this control transfer. */

Comments go on the next line.

> +			rtw_reset_continual_urb_error(dvobjpriv);
> +			memcpy(data, io_buf, size);
> +		} else { /*  error cases */

Again, next line for the comment.

> +			DBG_88E("reg 0x%x, usb %s %u fail, status:%d vendorreq_times:%d\n",
> +				value, "read", size, status, vendorreq_times);

These should be removed eventually...

> +
> +			if (status == (-ESHUTDOWN) || status == -ENODEV) {
> +				adapt->bSurpriseRemoved = true;

Odd, but ok...

> +			} else {
> +				struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
> +
> +				haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;

Why are we not saying the command failed even if the device was removed?

But if we do say an error happened, why are we trying to send this out
again?  What would happen to make it work the second time?

> +			}
> +
> +			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
> +				adapt->bSurpriseRemoved = true;

So we try to see if the device was removed again?

> +				break;
> +			}
> +		}
> +
> +		/*  firmware download is checksummed, don't retry */
> +		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || !status)
> +			break;

Nothing like a special case for firmware magic.

Those calls should just use a different write function entirely,
eventually, to remove this...

Ok, I know you are just moving code around, this is fine, just pointing
out things that should be fixed up eventually...

thanks,

greg k-h
