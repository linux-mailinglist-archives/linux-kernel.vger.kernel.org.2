Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE395305F30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhA0PMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:12:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235587AbhA0PH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:07:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57384207E2;
        Wed, 27 Jan 2021 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759991;
        bh=TWIRJM6gVAm1vQZqku9qg1fMLOchvryOpdAYf8HGPDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHXsweOIcpqgkuspQ3fcjfaTCA0kdWWEAK7WZ3nQZCBqhIXNC5bSXA+Y83TTOkjxv
         H7enIR2piMgV/sMCuZyCih2ERruJOrH8t24mGD5h29UOaGuyFhPRez+fP60Ot2yS6t
         j9NHwH2JXoyHvJm4aN5DzivxDDEVf/ZK3R0yIYXp4EA72CMJ3W98vIexPYNXOtMMm5
         zEznLnjohJ15VFkq7+7nJ+XaIWA3uN/ZrPcd9fn9mbWsmBX9Syj7942CqVvnHqSl3p
         rdYZCBKEC5SY+TnXzed9wxR8uwOOMjbtx4XogwATG2MHXkFS5SRWhu2U2PWMh9SFcq
         qbEtJ5UP4idHQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4mP5-0001xv-H6; Wed, 27 Jan 2021 16:06:43 +0100
Date:   Wed, 27 Jan 2021 16:06:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/12] usb: misc: ldusb: update to use
 usb_control_msg_send()
Message-ID: <YBGBg5ofIzUHxoYn@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-9-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-9-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:59AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg_send() has been replaced
> with usb_control_msg_send() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/ldusb.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
> index 670e4d91e9ca..259ead4edecb 100644
> --- a/drivers/usb/misc/ldusb.c
> +++ b/drivers/usb/misc/ldusb.c
> @@ -573,15 +573,13 @@ static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
>  	}
>  
>  	if (dev->interrupt_out_endpoint == NULL) {
> -		/* try HID_REQ_SET_REPORT=9 on control_endpoint instead of interrupt_out_endpoint */
> -		retval = usb_control_msg(interface_to_usbdev(dev->intf),
> -					 usb_sndctrlpipe(interface_to_usbdev(dev->intf), 0),
> -					 9,
> +		retval = usb_control_msg_send(interface_to_usbdev(dev->intf),
> +					 0, 9,
>  					 USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
>  					 1 << 8, 0,
>  					 dev->interrupt_out_buffer,
>  					 bytes_to_write,
> -					 USB_CTRL_SET_TIMEOUT);
> +					 USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
>  		if (retval < 0)
>  			dev_err(&dev->intf->dev,
>  				"Couldn't submit HID_REQ_SET_REPORT %d\n",

This would also only introduce a redundant allocation and memcpy() as
the buffer is already DMA-able and used for that purpose in other places
as well.

I suggest dropping this one too.

Johan
