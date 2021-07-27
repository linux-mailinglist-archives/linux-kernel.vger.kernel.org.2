Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB63D7DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhG0SpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0SpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:45:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E543960F9E;
        Tue, 27 Jul 2021 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627411519;
        bh=iIiLg76+hZ5NitrT9awb6iZiGZn9ijdC4XVZD/1+Zus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP0/CgYhwOq0+P8pAKIFo4SzS5AahbdFDkv1iQVUZNy40O0pGza+s4JqUdR+2r6NG
         D3nrfDQRbObuSDkinVqKbMyZV3m0hwUbmguwe48iM+R0mo98GnzejJ+CSnoWBPezpq
         JB09Ys7SuYWl3NUXXGbOCPfXymxtGmGidXkvAGE0=
Date:   Tue, 27 Jul 2021 20:45:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, sandeen@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_hid: added GET_IDLE and SET_IDLE
 handlers
Message-ID: <YQBUPWrDKlar6BR1@kroah.com>
References: <20210727183140.42330-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727183140.42330-1-mdevaev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 09:31:41PM +0300, Maxim Devaev wrote:
> The USB HID standard declares mandatory support for GET_IDLE and SET_IDLE
> requests for Boot Keyboard. Most hosts can handle their absence, but others
> like some old/strange UEFIs and BIOSes consider this a critical error
> and refuse to work with f_hid.
> 
> This primitive implementation of saving and returning idle is sufficient
> to meet the requirements of the standard and these devices.
> 
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 02683ac07..1010f0a3e 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -41,6 +41,7 @@ struct f_hidg {
>  	unsigned char			bInterfaceSubClass;
>  	unsigned char			bInterfaceProtocol;
>  	unsigned char			protocol;
> +	unsigned char			idle;
>  	unsigned short			report_desc_length;
>  	char				*report_desc;
>  	unsigned short			report_length;
> @@ -523,6 +524,14 @@ static int hidg_setup(struct usb_function *f,
>  		goto respond;
>  		break;
>  
> +	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
> +		  | HID_REQ_GET_IDLE):
> +		VDBG(cdev, "get_idle\n");
> +		length = min_t(unsigned int, length, 1);
> +		((u8 *) req->buf)[0] = hidg->idle;
> +		goto respond;
> +		break;
> +
>  	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
>  		  | HID_REQ_SET_REPORT):
>  		VDBG(cdev, "set_report | wLength=%d\n", ctrl->wLength);
> @@ -546,6 +555,14 @@ static int hidg_setup(struct usb_function *f,
>  		goto stall;
>  		break;
>  
> +	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
> +		  | HID_REQ_SET_IDLE):
> +		VDBG(cdev, "set_idle\n");
> +		length = 0;
> +		hidg->idle = value >> 8;
> +		goto respond;
> +		break;
> +
>  	case ((USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE) << 8
>  		  | USB_REQ_GET_DESCRIPTOR):
>  		switch (value >> 8) {
> @@ -773,6 +790,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>  	hidg_interface_desc.bInterfaceSubClass = hidg->bInterfaceSubClass;
>  	hidg_interface_desc.bInterfaceProtocol = hidg->bInterfaceProtocol;
>  	hidg->protocol = HID_REPORT_PROTOCOL;
> +	hidg->idle = 1;
>  	hidg_ss_in_ep_desc.wMaxPacketSize = cpu_to_le16(hidg->report_length);
>  	hidg_ss_in_comp_desc.wBytesPerInterval =
>  				cpu_to_le16(hidg->report_length);
> -- 
> 2.32.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent a patch that has been sent multiple times in the past few
  days, and is identical to ones that has been recently rejected.
  Please always look at the mailing list traffic to determine if you are
  duplicating other people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
