Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097493060FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbhA0Q1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:27:39 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55737 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1343556AbhA0Q1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:27:18 -0500
Received: (qmail 227324 invoked by uid 1000); 27 Jan 2021 11:26:34 -0500
Date:   Wed, 27 Jan 2021 11:26:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zqiang <qiang.zhang@windriver.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 12/12] usb: misc: usbtest: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <20210127162634.GA225622@rowland.harvard.edu>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210127121247.9938-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127121247.9938-1-anant.thazhemadam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

The benefits of these changes are rather minimal.  In some cases they 
actually make the code worse (doing an unnecessary allocation in order 
to copy a buffer that doesn't need to be copied).

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

Here dev->buf is aleady DMA-able; there's no need to copy it.  The only 
advantage is avoiding the short-read check.

> +
> +	if (retval < 0)
>  		return retval;
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

Here again, the advantage is minimal at best.

>  		}
>  	}
>  
> @@ -1683,10 +1680,10 @@ static int test_halt(struct usbtest_dev *tdev, int ep, struct urb *urb)
>  		return retval;
>  
>  	/* set halt (protocol test only), verify it worked */
> -	retval = usb_control_msg(urb->dev, usb_sndctrlpipe(urb->dev, 0),
> -			USB_REQ_SET_FEATURE, USB_RECIP_ENDPOINT,
> -			USB_ENDPOINT_HALT, ep,
> -			NULL, 0, USB_CTRL_SET_TIMEOUT);
> +	retval = usb_control_msg_send(urb->dev, 0, USB_REQ_SET_FEATURE,
> +				      USB_RECIP_ENDPOINT, USB_ENDPOINT_HALT,
> +				      ep, NULL, 0, USB_CTRL_SET_TIMEOUT,
> +				      GFP_KERNEL);

Here there is no advantage at all.  There is no buffer to copy and no 
possibility of a short write.

>  	if (retval < 0) {
>  		ERROR(tdev, "ep %02x couldn't set halt, %d\n", ep, retval);
>  		return retval;
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
> +		if (retval < 0) {
>  			what = "write";
> -			if (retval >= 0) {
> -				ERROR(dev, "ctrl_out, wlen %d (expected %d)\n",
> -						retval, len);
> -				retval = -EBADMSG;
> -			}
>  			break;
>  		}

Here buf doesn't need to be copied, and a short write will return an 
error code anyway.

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

Similar to one of the cases above.

Alan Stern

>  			break;
>  		}
>  
> -- 
> 2.25.1
> 
