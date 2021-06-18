Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6E3AC253
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhFREbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhFREbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3E0A611AC;
        Fri, 18 Jun 2021 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623990543;
        bh=GcjTCRWTboisr1b8JnfN85SVwl2t5zLnxICksmRL0fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oseMYqahegpv9k1iANTv2WC0lMY7/D5ovoUB5q5EKuCONmLiXiqps1Xkgi+a3djFr
         5hb8kJaP/TD5lz6wH6bUgYTEokP+dh/U5Yw6fr0G1UIuzpOLyNn+gOYFmsT/k4MHG5
         Ncsloli6CUvAbM+tU/Fc78afDNKwEtwm2YNUtjn4=
Date:   Fri, 18 Jun 2021 06:28:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        balbi@kernel.org
Subject: Re: [PATCH -next resend] usb: gadget: hid: fix error return code in
 hid_bind()
Message-ID: <YMwhChr6LiuTvXum@kroah.com>
References: <20210617140005.2161443-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617140005.2161443-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:00:05PM +0800, Yang Yingliang wrote:
> Fix to return a negative error code from the error handling
> case instead of 0.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/usb/gadget/legacy/hid.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
> index c4eda7fe7ab4..5b27d289443f 100644
> --- a/drivers/usb/gadget/legacy/hid.c
> +++ b/drivers/usb/gadget/legacy/hid.c
> @@ -171,8 +171,10 @@ static int hid_bind(struct usb_composite_dev *cdev)
>  		struct usb_descriptor_header *usb_desc;
>  
>  		usb_desc = usb_otg_descriptor_alloc(gadget);
> -		if (!usb_desc)
> +		if (!usb_desc) {
> +			status = -ENOMEM;
>  			goto put;
> +		}
>  		usb_otg_descriptor_init(gadget, usb_desc);
>  		otg_desc[0] = usb_desc;
>  		otg_desc[1] = NULL;
> -- 
> 2.25.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
