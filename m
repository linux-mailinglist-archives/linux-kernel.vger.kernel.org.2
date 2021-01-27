Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F36305ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhA0O4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234780AbhA0Ow7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:52:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8F2721534;
        Wed, 27 Jan 2021 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759125;
        bh=AmG3QuKIvtBdDVckr6NO8VRq4/4ePsd3kUGMTgQiX/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekaOUi1CrmD4jzYW6KYfVFaIc3721Y2NuVuS0RZOOQpanaX82efcz8vEVGQmvNboP
         Mk5T0iN7TwiGFEhCN29jfJGpPOleb+9YVsh8AcRt4T7AjnM87vSqAIYQGFu20phBe1
         6pwltJN4vOgi2SCWVCsj+nBMLDN6Kc3bz1hibTZkpAckfpDfdlLvs8euF93fIGcaHL
         20FRDCVlBvT/zWlTxxspmyKgFLHtDSO5eaqdHXz/rFg1aOyf/Ub7bzLxb+rsXlXb+3
         ZMfgxBAga13d5w4O8WzF1i9pJQMqQRZr7p1TkSNJcKhWF0uyf3nsAeok1TeanVrUbj
         c8fsal88I8X+A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4mB6-0001ve-Sw; Wed, 27 Jan 2021 15:52:16 +0100
Date:   Wed, 27 Jan 2021 15:52:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/12] usb: misc: ezusb: update to use
 usb_control_msg_send()
Message-ID: <YBF+IFTNn4KMMVAw@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-6-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-6-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:56AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_send() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/ezusb.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/misc/ezusb.c b/drivers/usb/misc/ezusb.c
> index f058d8029761..78aaee56c2b7 100644
> --- a/drivers/usb/misc/ezusb.c
> +++ b/drivers/usb/misc/ezusb.c
> @@ -31,24 +31,12 @@ static const struct ezusb_fx_type ezusb_fx1 = {
>  static int ezusb_writememory(struct usb_device *dev, int address,
>  				unsigned char *data, int length, __u8 request)
>  {
> -	int result;
> -	unsigned char *transfer_buffer;
> -
>  	if (!dev)
>  		return -ENODEV;
>  
> -	transfer_buffer = kmemdup(data, length, GFP_KERNEL);
> -	if (!transfer_buffer) {
> -		dev_err(&dev->dev, "%s - kmalloc(%d) failed.\n",
> -							__func__, length);
> -		return -ENOMEM;
> -	}
> -	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
> +	return usb_control_msg_send(dev, 0, request,
>  				 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> -				 address, 0, transfer_buffer, length, 3000);
> -
> -	kfree(transfer_buffer);
> -	return result;
> +				 address, 0, data, length, 3000, GFP_KERNEL);
>  }
>  
>  static int ezusb_set_reset(struct usb_device *dev, unsigned short cpucs_reg,

This is a prime example of how the new helpers should be used. 

With the short-write bit dropped from the commit message:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
