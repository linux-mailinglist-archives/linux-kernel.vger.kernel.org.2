Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A123F9690
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbhH0I75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232757AbhH0I7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:59:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF9EB60FDA;
        Fri, 27 Aug 2021 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630054745;
        bh=MCi/iLwDS2lKNvQHC6owLIj+45AM4PBViJAXy7zxvd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kogy+aRcFo00z5sZSqNR/2BF8GGrGago3CiX3fVplZ6QJQoQDlRqjoEHb1YZMC5KM
         Q7DB+W3+gfJtj9ERzajJnEuj1ZICuuF2cceznbf3Ti2E7brQKUMPk5Ta9k9pEbmpWV
         fp6At5m1YCWiDhIio8Rec2WNLipR8jwRY+0M8M5Y=
Date:   Fri, 27 Aug 2021 10:59:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yang.yang29@zte.com.cn
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        xu.xin16@zte.com.cn
Subject: Re: [PATCH] dio: add missing iounmap() after ioremap()
Message-ID: <YSipVhlwqaWarFTt@kroah.com>
References: <202108232045471583580@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108232045471583580@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:45:47PM +0800, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> If kzalloc() fails, the 'va' needs to be unmapped before returning -ENOMEM.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  drivers/dio/dio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
> index 4c06c93..7d19250 100644
> --- a/drivers/dio/dio.c
> +++ b/drivers/dio/dio.c
> @@ -218,9 +218,11 @@ static int __init dio_init(void)
> 
>         /* Found a board, allocate it an entry in the list */
>         dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
> -       if (!dev)
> +       if (!dev) {
> +           if (scode >= DIOII_SCBASE)
> +               iounmap(va);
>             return -ENOMEM;
> +       }
>         dev->bus = &dio_bus;
>         dev->dev.parent = &dio_bus.dev;
>         dev->dev.bus = &dio_bus_type;
> -- 
> 2.15.2


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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
