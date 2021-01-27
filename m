Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD989305F18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhA0PHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235179AbhA0PAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:00:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5FE42168B;
        Wed, 27 Jan 2021 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759575;
        bh=JM2jUIXgJm/G0mRyqIdPww2k7oyM3aT7ynnTGBy/5GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7ImwHZtNvYrHEqzVN1Yj5Da81j3XEjjWtSacJTgE9jeCggYRPnLAMwKfSPVNqgW5
         OgKANGuuK+EFvNmYmBmoys7jHK/2Ier7ZHypTVwgvxxepOVKlFGgsyYs4e2pJT9oTN
         TnWtzR07vH1LKmuDT7unROFVfZNLKRc9t/7o7dGf4Dc+ajrFYPU2mYUwwvUR3GmCqA
         ezOk83NQFInlrrMHwqBvTz3FmQyx7ti0Kswu5oQaZKAb+hedFj9sVKcZMArUJiRAEG
         oPp2G1Qodd3mPxwYdUNW8MQplqfgJiTjRTzE4saLZvUhf2PjCjpuFqpZJmP4txABTQ
         myPquQLIqYfIA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4mIL-0001wh-VX; Wed, 27 Jan 2021 15:59:46 +0100
Date:   Wed, 27 Jan 2021 15:59:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Tom Rix <trix@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/12] usb: misc: iowarrior: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <YBF/4XYi854hyYhZ@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-7-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-7-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:57AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_{recv|send}() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/iowarrior.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index efbd317f2f25..9d6a7548e537 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -109,12 +109,12 @@ static int usb_get_report(struct usb_device *dev,
>  			  struct usb_host_interface *inter, unsigned char type,
>  			  unsigned char id, void *buf, int size)
>  {
> -	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -			       USB_REQ_GET_REPORT,
> -			       USB_DIR_IN | USB_TYPE_CLASS |
> -			       USB_RECIP_INTERFACE, (type << 8) + id,
> -			       inter->desc.bInterfaceNumber, buf, size,
> -			       GET_TIMEOUT*HZ);
> +	return usb_control_msg_recv(dev, 0,
> +				    USB_REQ_GET_REPORT,
> +				    USB_DIR_IN | USB_TYPE_CLASS |
> +				    USB_RECIP_INTERFACE, (type << 8) + id,
> +				    inter->desc.bInterfaceNumber, buf, size,
> +				    GET_TIMEOUT*HZ, GFP_KERNEL);
>  }
>  //#endif
>  
> @@ -123,13 +123,13 @@ static int usb_get_report(struct usb_device *dev,
>  static int usb_set_report(struct usb_interface *intf, unsigned char type,
>  			  unsigned char id, void *buf, int size)
>  {
> -	return usb_control_msg(interface_to_usbdev(intf),
> -			       usb_sndctrlpipe(interface_to_usbdev(intf), 0),
> -			       USB_REQ_SET_REPORT,
> -			       USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -			       (type << 8) + id,
> -			       intf->cur_altsetting->desc.bInterfaceNumber, buf,
> -			       size, HZ);
> +	return usb_control_msg_send(interface_to_usbdev(intf),
> +				    0,
> +				    USB_REQ_SET_REPORT,
> +				    USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +				    (type << 8) + id,
> +				    intf->cur_altsetting->desc.bInterfaceNumber, buf,
> +				    size, HZ, GFP_KERNEL);
>  }

But here the buffers are already DMA-able so that the new helpers only
add redundant allocations and memcpy's() for no real gain.

I'd just drop this one as well.

You could consider adding the missing sanity check to the IOW_READ
ioctl, which would currently return zeroed data in case of a short read
(so there are no info leaks either way). But perhaps that is done on
purpose, so perhaps better to leave that too.

Johan
