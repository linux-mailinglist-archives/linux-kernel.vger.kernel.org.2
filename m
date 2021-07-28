Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366A53D87D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhG1GZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhG1GZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:25:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11DAF60F58;
        Wed, 28 Jul 2021 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627453525;
        bh=4hAIdzttwWWApX+xj/vZnnLd1lxQdez71wJ2QJgxjs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqC5SZvEo9xsqURYjSdJ7DXZJwM9oEd8fBGgvGsv/AcS18s7xtdIwNQ67hTV4cAia
         F0SOTdL6NeaAN6bNdyOaCM8JUts7cFQpsE8iSVCBw/QuAIpQoS0ngNfhOTeeFVJ/31
         p3KW7Q4fWrB98Hw4uCkBL/UnWl+6bdLKqOKaZc+0=
Date:   Wed, 28 Jul 2021 08:25:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, sandeen@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: idle uses the highest byte for
 duration
Message-ID: <YQD4U67wFqtXBGu1@kroah.com>
References: <20210727185800.43796-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727185800.43796-1-mdevaev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 09:58:00PM +0300, Maxim Devaev wrote:
> SET_IDLE value must be shifted 8 bits to the right to get duration.
> This confirmed by USBCV test.
> 
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 8d50c8b12..bb476e121 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -573,7 +573,7 @@ static int hidg_setup(struct usb_function *f,
>  		  | HID_REQ_SET_IDLE):
>  		VDBG(cdev, "set_idle\n");
>  		length = 0;
> -		hidg->idle = value;
> +		hidg->idle = value >> 8;
>  		goto respond;
>  		break;
>  
> -- 
> 2.32.0
> 

You forgot to mention what commit this fixes up:

Fixes: afcff6dc690e ("usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers")

I've added it to the patch now, but try to remember it next time.

thanks,

greg k-h
