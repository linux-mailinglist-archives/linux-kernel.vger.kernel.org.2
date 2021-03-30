Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9655434EBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhC3PPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhC3POi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CF0861957;
        Tue, 30 Mar 2021 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617117278;
        bh=SBGYztar3ZQgp7YKPFAjZyq0aWSb5ADN6p6bSuCJ6Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Txr05xLZeb+g5xt2SkyIvuWpiQ7FXVXwg6Yfg9/gPegfu9SoOmlqroesrn0WdOfhm
         xrPUmxtqzr4gN9cS7coRScOUhVxySxa9FCwfvvSPfLFCOXdjNm3KeMpF6yog5VZdPd
         BWeNYwd+Efgutx2XvYhclG9zq3doqzXr1rHeJqUahDkKv8caavBqGEUjvkn4B2K1v8
         e+Z3s6liKrgsaxh0knlvjz4C+yQiz7wVRMfI4d0Avv5AuUl/j95CvROGC/+rcD5VI7
         hEwcpJUfFG71aeqqWSQHRaxfsw/Xthj0ZdnsLWeCMK3fDzXfxDF18oEW6Iu7uApQWs
         YEk3VoqNmDc2Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRG55-0002Wn-32; Tue, 30 Mar 2021 17:14:59 +0200
Date:   Tue, 30 Mar 2021 17:14:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 7/7] USB: cdc-acm: add other non-standard xr_serial
 models to ignore list
Message-ID: <YGNAc/FhUefX7yTZ@hovoldconsulting.com>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
 <5155887a764cbc11f8da0217fe08a24a77d120b4.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5155887a764cbc11f8da0217fe08a24a77d120b4.1616571453.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:41:11AM +0100, Mauro Carvalho Chehab wrote:
> Now that the xr_serial got support for other models, add their
> USB IDs as well, as those devices won't work with the standard
> CDC driver.

As far as I understand these devices should work also with the standard
class driver, but the problem is that your development board is broken
in that CTS isn't wired up properly so that TX is stalled (I even
verified that in the schematics).

Sure, there are other features available in custom-driver mode, but
still funny (sad?) if all that would really have been needed was a tiny
bit of led. :)

I kept this commit but updated the commit message and cleaned up the
entries below somewhat.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/usb/class/cdc-acm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 39ddb5585ded..839b80093478 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1902,9 +1902,20 @@ static const struct usb_device_id acm_ids[] = {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_USB_SERIAL_XR)
> -	{ USB_DEVICE(0x04e2, 0x1410),   /* Ignore XR21V141X USB to Serial converter */
> -	.driver_info = IGNORE_DEVICE,
> -	},
> +	/* Ignore MaxLinear/Exar USB UARTs and USB UART bridges */
> +	{ USB_DEVICE(0x04e2, 0x1400), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1401), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1402), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1403), .driver_info = IGNORE_DEVICE,},
> +
> +	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1411), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = IGNORE_DEVICE,},
> +
> +	{ USB_DEVICE(0x04e2, 0x1420), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1422), .driver_info = IGNORE_DEVICE,},
> +	{ USB_DEVICE(0x04e2, 0x1424), .driver_info = IGNORE_DEVICE,},
>  #endif
>  
>  	/*Samsung phone in firmware update mode */

Johan
