Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AC305FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhA0Pfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235734AbhA0PFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:05:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9F492074D;
        Wed, 27 Jan 2021 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759862;
        bh=peBSpIGr9lJbtDzUREoran2P8gdlv2/I+XI3fRNF8AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhNF11zc0S0iEfhm5wBjbDKBbyYv4t27QZoA0w503J43HC36BFo+rurMik8tRBXAu
         v/SYmVTLpMMy6kzyAXBvNMFVfTMyql3Ku2kALLG6ad9pbqfLnvXS1GEjm6iowZev7d
         5b/vGJOLq0fEWrBWnCX7NJKcyiRZn9rajGZRBggq/VvFpwNdqZZF6F82tRqi3cdBPX
         KRehEBV056LAT/axzYsDxgAIElyszaEsk2d+UpWBktmYKMLzk7qUCufVKqbBK69V7q
         Br9BronrSq3JPFdajad2oJT6aRSFgAmSOaJIvAYVCCMcfLoq3uQQb9evgIwtCaQdEK
         Yh2PZQs9qB6sw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4mN0-0001xR-UF; Wed, 27 Jan 2021 16:04:35 +0100
Date:   Wed, 27 Jan 2021 16:04:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] usb: misc: isight_firmware: update to use
 usb_control_msg_send()
Message-ID: <YBGBAjWNepWNorBO@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-8-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-8-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:58AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instances of usb_control_msg() have been replaced with
> usb_control_msg_send(), and return value checking has also been
> appropriately enforced.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/isight_firmware.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/misc/isight_firmware.c b/drivers/usb/misc/isight_firmware.c
> index 4d30095d6ad2..1bd14a431f6c 100644
> --- a/drivers/usb/misc/isight_firmware.c
> +++ b/drivers/usb/misc/isight_firmware.c
> @@ -37,13 +37,10 @@ static int isight_firmware_load(struct usb_interface *intf,
>  	struct usb_device *dev = interface_to_usbdev(intf);
>  	int llen, len, req, ret = 0;
>  	const struct firmware *firmware;
> -	unsigned char *buf = kmalloc(50, GFP_KERNEL);
> +	unsigned char buf[50];

This buffer is probably large enough to not want to have it allocated on
the stack.

>  	unsigned char data[4];
>  	const u8 *ptr;
>  
> -	if (!buf)
> -		return -ENOMEM;
> -
>  	if (request_firmware(&firmware, "isight.fw", &dev->dev) != 0) {
>  		printk(KERN_ERR "Unable to load isight firmware\n");
>  		ret = -ENODEV;
> @@ -53,11 +50,11 @@ static int isight_firmware_load(struct usb_interface *intf,
>  	ptr = firmware->data;
>  
>  	buf[0] = 0x01;
> -	if (usb_control_msg
> -	    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, 0xe600, 0, buf, 1,
> -	     300) != 1) {
> +	ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, 0xe600,
> +				   0, &buf, 1, 300, GFP_KERNEL);
> +	if (ret != 0) {
>  		printk(KERN_ERR
> -		       "Failed to initialise isight firmware loader\n");
> +			"Failed to initialise isight firmware loader\n");
>  		ret = -ENODEV;
>  		goto out;
>  	}
> @@ -82,15 +79,15 @@ static int isight_firmware_load(struct usb_interface *intf,
>  				ret = -ENODEV;
>  				goto out;
>  			}
> -			memcpy(buf, ptr, llen);
> +			memcpy(&buf, ptr, llen);
>  
>  			ptr += llen;
>  
> -			if (usb_control_msg
> -			    (dev, usb_sndctrlpipe(dev, 0), 0xa0, 0x40, req, 0,
> -			     buf, llen, 300) != llen) {
> +			ret = usb_control_msg_send(dev, 0, 0xa0, 0x40, req, 0,
> +						   &buf, llen, 300, GFP_KERNEL);
> +			if (ret != 0) {
>  				printk(KERN_ERR
> -				       "Failed to load isight firmware\n");
> +					"Failed to load isight firmware\n");
>  				ret = -ENODEV;
>  				goto out;
>  			}

And here the same buffer is reused for each block of data, while the new
helpers would add an allocation and a redundant memcpy() of the data
(which was just copied a few lines above) for each iteration.

So I suggest you drop this one as well.

Johan
