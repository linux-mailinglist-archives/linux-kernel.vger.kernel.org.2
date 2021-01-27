Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE36306180
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhA0RDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233891AbhA0RAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:00:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E23064DA0;
        Wed, 27 Jan 2021 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611766811;
        bh=Vi5931jgHl0pUGXwWf3I6M5RK/7qI17nxHEVLDjqim0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRRwpxWOXjmWkMQTbp5Ch+qHZdzTD+KTiyOsL6Ok3KP5nLAvnw3M5AhkcIPKrQ0bQ
         ztcKe23b4zePUy7WJy6ljZ2AHIXFwNxTnTTKbDsJgcyoXC/6w6+879LvqRN+z4gHtb
         6oAXW0DwA1oPAGS3qCuFMa+3t4xyIyCW9Dft800g8SGqqi56xKjIgOug7RXdeZ6nQB
         cLNYJ/F5g00os/M2qrnDkWrsYvpnHHcI97cT7BwJ3enfxIPOfKKNUcmxncOrpXLQen
         Aj+UZY2RTgMJpG4sMIFcLj+ij5XeMK98EqX9xKp7ABFWTi5jvxPmEkSdrmeOO7dS9I
         U1CAotBB2Wcsg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4oB3-0002HX-SQ; Wed, 27 Jan 2021 18:00:22 +0100
Date:   Wed, 27 Jan 2021 18:00:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bixuan Cui <cuibixuan@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zqiang <qiang.zhang@windriver.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 12/12] usb: misc: usbtest: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <YBGcJb5YtCtGjPtW@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210127121247.9938-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127121247.9938-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:42:47PM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_{recv|send}() and the return value checking conditions have
> also been modified appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> Resending this patch since the subject line for the initial submission 
> (sent as a part of the patch series) wasn't set correctly.
> 
>  drivers/usb/misc/usbtest.c | 69 ++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
> index 150090ee4ec1..4337eff2a749 100644
> --- a/drivers/usb/misc/usbtest.c
> +++ b/drivers/usb/misc/usbtest.c
> @@ -672,19 +672,15 @@ static int get_altsetting(struct usbtest_dev *dev)
>  	struct usb_device	*udev = interface_to_usbdev(iface);
>  	int			retval;
>  
> -	retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> -			USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
> -			0, iface->altsetting[0].desc.bInterfaceNumber,
> -			dev->buf, 1, USB_CTRL_GET_TIMEOUT);
> -	switch (retval) {
> -	case 1:
> -		return dev->buf[0];
> -	case 0:
> -		retval = -ERANGE;
> -		fallthrough;
> -	default:
> +	retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_INTERFACE,
> +				      USB_DIR_IN|USB_RECIP_INTERFACE,
> +				      0, iface->altsetting[0].desc.bInterfaceNumber,
> +				      dev->buf, 1, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
> +
> +	if (retval < 0)
>  		return retval;

This changes the return value for short reads. Maybe not an issue, but
since this a test driver and the value is propagated to user space it is
not clear cut.

> -	}
> +
> +	return dev->buf[0];
>  }
>  
>  static int set_altsetting(struct usbtest_dev *dev, int alternate)
> @@ -872,14 +868,15 @@ static int ch9_postconfig(struct usbtest_dev *dev)
>  		 * ... although some cheap devices (like one TI Hub I've got)
>  		 * won't return config descriptors except before set_config.
>  		 */
> -		retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> -				USB_REQ_GET_CONFIGURATION,
> -				USB_DIR_IN | USB_RECIP_DEVICE,
> -				0, 0, dev->buf, 1, USB_CTRL_GET_TIMEOUT);
> -		if (retval != 1 || dev->buf[0] != expected) {
> +		retval = usb_control_msg_recv(udev, 0, USB_REQ_GET_CONFIGURATION,
> +					      USB_DIR_IN | USB_RECIP_DEVICE,  0,
> +					      0, dev->buf, 1, USB_CTRL_GET_TIMEOUT,
> +					      GFP_KERNEL);
> +
> +		if (retval != 0 || dev->buf[0] != expected) {
>  			dev_err(&iface->dev, "get config --> %d %d (1 %d)\n",
>  				retval, dev->buf[0], expected);
> -			return (retval < 0) ? retval : -EDOM;
> +			return retval;

Same here (but different error, so probably not an issue in either
place).

> @@ -1845,30 +1842,22 @@ static int ctrl_out(struct usbtest_dev *dev,
>  		/* write patterned data */
>  		for (j = 0; j < len; j++)
>  			buf[j] = (u8)(i + j);
> -		retval = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -				0x5b, USB_DIR_OUT|USB_TYPE_VENDOR,
> -				0, 0, buf, len, USB_CTRL_SET_TIMEOUT);
> -		if (retval != len) {
> +		retval = usb_control_msg_send(udev, 0, 0x5b,
> +					      USB_DIR_OUT | USB_TYPE_VENDOR, 0,
> +					      0, buf, len, USB_CTRL_SET_TIMEOUT,
> +					      GFP_KERNEL);

This introduces a redundant allocation and memcpy() for every iteration
for the buffer which is already DMA-able. So this looks like a bad fit
for the new helper.

> +		if (retval < 0) {
>  			what = "write";
> -			if (retval >= 0) {
> -				ERROR(dev, "ctrl_out, wlen %d (expected %d)\n",
> -						retval, len);
> -				retval = -EBADMSG;
> -			}

You could drop this redundant short write test though if you want.

>  			break;
>  		}
>  
>  		/* read it back -- assuming nothing intervened!!  */
> -		retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> -				0x5c, USB_DIR_IN|USB_TYPE_VENDOR,
> -				0, 0, buf, len, USB_CTRL_GET_TIMEOUT);
> -		if (retval != len) {
> +		retval = usb_control_msg_recv(udev, 0,
> +					      0x5c, USB_DIR_IN|USB_TYPE_VENDOR,
> +					      0, 0, buf, len, USB_CTRL_GET_TIMEOUT,
> +					      GFP_KERNEL);
> +		if (retval < 0) {
>  			what = "read";
> -			if (retval >= 0) {
> -				ERROR(dev, "ctrl_out, rlen %d (expected %d)\n",
> -						retval, len);
> -				retval = -EBADMSG;
> -			}

Same here; the buffer is already DMA-able and you remove the error
message, which someone using a test driver like this may want to see.

Probably better left as is.

>  			break;
>  		}

Johan
